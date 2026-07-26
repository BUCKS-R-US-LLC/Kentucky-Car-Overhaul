#!/usr/bin/env python3
"""Generate PZ vehicle _scratch and _blood overlays from a _mask texture.

  python gen_damage.py Vehicle_Foo_mask.png
  python gen_damage.py textures/            # every *_mask.png in the folder
  python gen_damage.py Vehicle_M35_mask.png --glass 127,0,0 0,127,0

Skin (for glass auto-detection) is found by looking for a sibling texture with
the same Vehicle_<Name> prefix. Override with --skin.
"""
import argparse, glob, os, sys
import numpy as np
from PIL import Image, ImageDraw
from scipy import ndimage, signal
from scipy.spatial import Delaunay
from collections import defaultdict

REF        = 1024.0     # all SCKCO masks are 1024; scaling kept for safety
SCUFF_RGB  = 208.0
CRACK_RGB  = 240.0
HOLE_RGB   = 24.0
BLOOD_WET  = (74, 6, 6)       # fresh but dark, desaturated
BLOOD_DRY  = (48, 12, 9)      # oxidised edges / old smears, near-brown
BLOOD_HI   = (98, 16, 13)     # thin highlights, still dark
EDGE_BIAS  = 55.0
CELL_TGT   = 11.0
ANISO      = 0.55
FALLOFF    = 1.55
JAG        = 0.34     # sharper kinks -> shattered not veiny
BREAK_P    = 0.10
GLASS_BLUR = 0.38
SS_REF     = 4        # supersample at REF resolution; scales inverse to k
W_MAJOR    = 0.65     # texture px
W_MINOR    = 0.375    # texture px
GLASS_AMP  = 1.90
MIN_REGION = 4000       # at REF resolution
# ---- SCKCO / B42 official vehicle-mask zone colours (exact) ----
# Source: the mod's own zone->colour table. This is authoritative; do not heuristically
# guess glass vs body. Any colour not in a set below is treated as generic body paint.
GLASS_COLOURS = {
    (127, 0, 0),    # Windshield
    (0, 127, 0),    # Rear glass
    (0, 127, 127),  # Front right window
    (127, 127, 0),  # Rear right window
    (127, 0, 127),  # Front left window
    (0, 0, 127),    # Rear left window
}
DOOR_COLOURS = {
    (0, 255, 255),  # Front right door
    (255, 255, 0),  # Rear right door
    (255, 0, 255),  # Front left door
    (0, 0, 255),    # Rear left door
}
# lights / beacons / trim: never take blood, and get no crazing; light body wear only
LIGHT_COLOURS = {
    (64, 0, 0), (192, 0, 0),        # headlights R/L
    (0, 192, 0), (0, 64, 0),        # tail lights R/L
    (127, 64, 0), (127, 192, 0),    # brake lights R/L
    (192, 192, 192), (64, 64, 64),  # beacons R/L
}
ROOF_COLOUR = (0, 0, 0)
BUMPER_COLOURS = {                  # "guards" = bumpers
    (192, 0, 192), (0, 0, 192),     # front/rear right guard
    (0, 192, 192), (192, 192, 0),   # front/rear left guard
}
HOOD_COLOUR  = (255, 0, 127)
TRUNK_COLOUR = (0, 255, 127)
BODY_HEAD    = (255, 0, 0)
BODY_TAIL    = (0, 255, 0)


# output suffixes. game loads whatever the vehicle script references; match your files.
# {stem} is the vehicle name, {sep} preserves the mask's own separator style.
SCRATCH_SUFFIX = 'Damage'   # your files use Vehicle_<Name>Damage
BLOOD_SUFFIX   = 'Blood'
WRECK_SUFFIX   = 'Burnt'   # burned-out wreck skin
MASK_SUFFIXES  = ('Mask', '_mask', '_Mask')   # accepted mask spellings, tried in order
W709 = np.array([0.2126, 0.7152, 0.0722])



# named zone groups -> colour sets, so config can say "doors"/"hood" not raw RGB
ZONE_GROUPS = {
    'glass':   GLASS_COLOURS,
    'doors':   DOOR_COLOURS,
    'lights':  LIGHT_COLOURS,
    'bumpers': BUMPER_COLOURS,
    'guards':  BUMPER_COLOURS,
    'roof':    {ROOF_COLOUR},
    'hood':    {HOOD_COLOUR},
    'trunk':   {TRUNK_COLOUR},
    'body':    {BODY_HEAD, BODY_TAIL, HOOD_COLOUR, TRUNK_COLOUR},
}


def resolve_zones(items):
    '''Accept a mix of zone names ("doors") and raw "r,g,b" strings; return colour set.'''
    out = set()
    for it in items or []:
        if isinstance(it, str) and it.lower() in ZONE_GROUPS:
            out |= ZONE_GROUPS[it.lower()]
        elif isinstance(it, str) and ',' in it:
            out.add(tuple(int(x) for x in it.split(',')))
        elif isinstance(it, (list, tuple)):
            out.add(tuple(int(x) for x in it))
    return out

def regions_of(mask, skin, force_glass, min_px, named=None):
    named = named or set()
    cols, cnt = np.unique(mask.reshape(-1, 3), axis=0, return_counts=True)
    out = []
    for i in np.argsort(-cnt):
        c = tuple(int(x) for x in cols[i])
        # a colour the user named in config (glass/blood/exclude) is always kept,
        # regardless of size — naming it is the signal it matters
        floor = min(min_px, 1500) if c in GLASS_COLOURS else min_px
        if (cnt[i] < floor and c not in named) or c == (255, 255, 255):
            continue
        if force_glass is not None:
            g = c in force_glass          # explicit config override
        else:
            g = c in GLASS_COLOURS        # authoritative zone spec, skin not needed
        out.append((c, int(cnt[i]), g))
    return out


def jagged(d, p, q, val, wid_ss, rng, cell, ss):
    v = q - p
    L = float(np.hypot(*v))
    if L < 1e-6:
        return
    n = int(np.clip(L/(cell*ss*0.40), 2, 4))   # fewer, straighter segments
    nx, ny = -v[1]/L, v[0]/L
    node = []
    for k in range(n+1):
        b = p + v*(k/n)
        off = 0.0 if k in (0, n) else rng.normal(0, L*JAG)
        node.append((b[0] + nx*off, b[1] + ny*off))
    for k in range(n):
        if rng.random() < BREAK_P:
            continue
        d.line([node[k], node[k+1]],
               fill=float(min(val*rng.uniform(0.48, 1.30), 1.0)),
               width=wid_ss + (1 if rng.random() < 0.14 else 0))


def fracture_island(sub, rng, cell, hole, ss, kk):
    h, w = sub.shape
    SS = ss
    W2, H2 = w*SS, h*SS
    img = Image.new('F', (W2, H2), 0.0)
    hol = Image.new('F', (W2, H2), 0.0)
    d, hd = ImageDraw.Draw(img), ImageDraw.Draw(hol)
    ys, xs = np.nonzero(sub)
    i = rng.integers(len(xs))
    ox, oy = (float(xs[i])+0.5)*SS, (float(ys[i])+0.5)*SS
    tgt = cell*SS*rng.uniform(0.92, 1.08)
    R = float(np.hypot(xs*SS-ox, ys*SS-oy).max()) + tgt

    pts = []
    r = tgt*0.45
    while r < R:
        n_ang = max(10, int(round(2*np.pi*r/(tgt*ANISO))))
        base = rng.random()*2*np.pi
        for a in range(n_ang):
            th = base + (a + rng.normal(0, 0.22))/n_ang*2*np.pi
            rj = r*(1.0 + rng.normal(0, 0.030))
            px, py = ox + rj*np.cos(th), oy + rj*np.sin(th)
            if 0 <= px < W2 and 0 <= py < H2 and sub[int(py/SS), int(px/SS)]:
                pts.append((px, py))
        r += tgt*(0.55 + 0.60*min(r/max(R, 1.0), 1.0))

    bnd = sub & ~ndimage.binary_erosion(sub, np.ones((3, 3)))
    byy, bxx = np.nonzero(bnd)
    for k in range(0, len(bxx), max(1, int(max(tgt/SS, 1)))):
        pts.append(((bxx[k]+0.5)*SS + rng.normal(0, 0.6),
                    (byy[k]+0.5)*SS + rng.normal(0, 0.6)))

    pts = np.array(pts)
    if len(pts) < 24:
        return np.zeros((h, w), np.float32), np.zeros((h, w), np.float32)

    c = np.array([ox, oy])
    tri = Delaunay(pts)
    nbr = defaultdict(set); edges = set()
    for smp in tri.simplices:
        for a, b in ((0, 1), (1, 2), (2, 0)):
            u, v = int(smp[a]), int(smp[b])
            edges.add((min(u, v), max(u, v)))
            nbr[u].add(v); nbr[v].add(u)

    major = set()
    start = int(np.argmin(np.hypot(*(pts-c).T)))
    for _ in range(int(rng.integers(16, 26))):
        th = rng.random()*2*np.pi
        dv = np.array([np.cos(th), np.sin(th)])
        cur = start
        for _ in range(400):
            best, bs = None, 0.45
            for nb in nbr[cur]:
                vv = pts[nb] - pts[cur]
                L = np.hypot(*vv)
                if L < 1e-6:
                    continue
                sc = float(vv @ dv)/L
                if sc > bs:
                    best, bs, bv = nb, sc, vv/L
            if best is None:
                break
            major.add((min(cur, best), max(cur, best)))
            dv = 0.92*dv + 0.08*bv; dv /= np.hypot(*dv)   # straighter -> angular shatter
            cur = best

    maxlen = tgt*4.5
    for u, v in edges:
        p, q = pts[u], pts[v]
        L = float(np.hypot(*(q-p)))
        if L > maxlen:
            continue
        mid = (p+q)/2
        if not sub[int(np.clip(mid[1]/SS, 0, h-1)), int(np.clip(mid[0]/SS, 0, w-1))]:
            continue
        maj = (u, v) in major
        if not maj and rng.random() > 0.94:
            continue
        fade = float(np.clip(1.15 - float(np.hypot(*(mid-c)))/(R*1.10), 0.42, 1.0))
        val = (1.0 if maj else rng.uniform(0.58, 0.88)) * fade
        jagged(d, p, q, val, max(1, int(round((W_MAJOR if maj else W_MINOR)*ss*kk))), rng, cell, ss)

    cz = rng.uniform(2.5, 4.5)*SS*kk
    for _ in range(int(rng.integers(30, 55))):
        a1, a2 = rng.random()*2*np.pi, rng.random()*2*np.pi
        r1, r2 = rng.uniform(0, cz), rng.uniform(0, cz)
        d.line([ox+r1*np.cos(a1), oy+r1*np.sin(a1), ox+r2*np.cos(a2), oy+r2*np.sin(a2)],
               fill=1.0, width=max(1, int(round(W_MINOR*ss*kk))))

    if hole:
        n = 30
        a = np.linspace(0, 2*np.pi, n, endpoint=False)
        rad = rng.uniform(1.4, 2.4)*SS*kk*(1 + 0.60*(rng.random(n)-0.5)*2)
        hd.polygon([(ox+rad[k]*np.cos(a[k]), oy+rad[k]*np.sin(a[k])) for k in range(n)], fill=1.0)

    A = np.asarray(img, np.float32).reshape(h, SS, w, SS).mean((1, 3))
    Hh = np.asarray(hol, np.float32).reshape(h, SS, w, SS).mean((1, 3))
    return A*sub, Hh*sub


def gen_scratch(mask, regions, rng, k, hole):
    H, W = mask.shape[:2]
    edge_bias = EDGE_BIAS*k
    cell = CELL_TGT*k
    ss = max(1, min(SS_REF, int(round(8192 / max(H, 1)))))   # cap supersample canvas

    # event-based body damage (dents + abrasions), placed like blood: discrete,
    # interior-weighted, clustered - not an allover grime field.
    body_img = Image.new('F', (W, H), 0.0)      # scuff/abrasion mass (lightens paint)
    dent_img = Image.new('F', (W, H), 0.0)      # dent shading (darkens = depth)
    scr_img  = Image.new('F', (W, H), 0.0)      # scratch cores (light lines)
    chip_img = Image.new('F', (W, H), 0.0)      # paint chips (small dull flecks)
    bd, dt_d = ImageDraw.Draw(body_img), ImageDraw.Draw(dent_img)
    scd = ImageDraw.Draw(scr_img)
    chip = ImageDraw.Draw(chip_img)

    def keyscratch(cx, cy, ang, length):
        """A keyed scrape: long, thin, mostly-straight line cut to the base coat.
        Bright metal/primer core with a fine dark edge - the classic 'keyed car' mark."""
        ca, sa = np.cos(ang), np.sin(ang)
        px, py = float(cx), float(cy)
        curve = rng.normal(0, 0.01)            # short, slight curve
        d0 = ang
        for i in range(int(length)):
            t = i/max(length, 1)
            d0 += curve + rng.normal(0, 0.03)  # short scrape, minor wander
            px += np.cos(d0); py += np.sin(d0)
            end = min(t, 1-t)*3
            fade = np.clip(0.5 + 0.5*end, 0, 1)
            r = max(0.5*k, 0.4)
            # bright base-coat core
            scd.ellipse([px-r, py-r, px+r, py+r], fill=float(fade*rng.uniform(0.85, 1.0)))
            # fine dark groove edge alongside
            o = 0.9*k
            dt_d.ellipse([px-sa*o-r*0.7, py+ca*o-r*0.7, px-sa*o+r*0.7, py+ca*o+r*0.7],
                         fill=float(fade*rng.uniform(0.35, 0.6)))

    def abrasion(cx, cy, ang, length, wdt):
        """A scuff: stippled directional scrape, like a blood smear but paint-toned."""
        ca, sa = np.cos(ang), np.sin(ang)
        px, py = float(cx), float(cy)
        for i in range(int(length)):
            t = i/max(length, 1)
            w = wdt*(1-t*0.6) + 0.4*k
            px += ca + rng.normal(0, 0.4); py += sa + rng.normal(0, 0.4)
            for _ in range(int(max(w, 2))):
                off = rng.normal(0, w*0.7)
                dx, dy = px - sa*off, py + ca*off
                if rng.random() > 0.45: continue
                r = max(rng.uniform(0.3, 0.8)*k, 0.35)
                scd.ellipse([dx-r, dy-r, dx+r, dy+r], fill=float(rng.uniform(0.35, 0.7)))

    def dent(cx, cy, rr, depth):
        """A dent of variable depth (0..1). Shallow = faint broad dish; deep = darker,
        tighter core with a hard shadow. Reads as impacts of varying severity."""
        steps = int(rr*1.6)
        spread = rr*(0.65 - 0.25*depth)       # deep dents concentrate toward centre
        peak = 0.30 + 0.65*depth              # deep dents are much darker
        for _ in range(int(steps*4*(0.7+0.6*depth))):
            a = rng.random()*2*np.pi; d = abs(rng.normal(0, spread))
            dx, dy = cx+d*np.cos(a), cy+d*np.sin(a)
            r = max(rng.uniform(0.8, 1.8)*k, 0.6)
            falloff = max(1 - d/(rr+1), 0.0)**(1.0 + 1.5*depth)
            dt_d.ellipse([dx-r, dy-r, dx+r, dy+r], fill=float(peak*falloff))
        # deep dents get a sharp dark pit at the impact point
        if depth > 0.65:
            for _ in range(int(steps)):
                a = rng.random()*2*np.pi; d = abs(rng.normal(0, rr*0.18))
                dx, dy = cx+d*np.cos(a), cy+d*np.sin(a)
                r = max(rng.uniform(0.5, 1.1)*k, 0.4)
                dt_d.ellipse([dx-r, dy-r, dx+r, dy+r], fill=float(rng.uniform(0.7, 1.0)))

    alpha = np.zeros((H, W), np.float32)
    bright = np.zeros((H, W), np.float32)
    holes = np.zeros((H, W), np.float32)

    for col, _, is_glass in regions:
        reg = (mask == np.array(col)).all(-1)
        if not reg.any():
            continue
        sev = 0.40 + 0.60*rng.random()
        ys, xs = np.nonzero(reg)
        if is_glass:
            y0, y1, x0, x1 = ys.min(), ys.max()+1, xs.min(), xs.max()+1
            cr, hl = fracture_island(reg[y0:y1, x0:x1], rng, cell, hole, ss, k)
            a = np.zeros((H, W), np.float32); a[y0:y1, x0:x1] = ndimage.gaussian_filter(cr, GLASS_BLUR)
            hh = np.zeros((H, W), np.float32); hh[y0:y1, x0:x1] = hl
            a = np.clip(a*GLASS_AMP, 0, 1)   # uniform across all windows, no per-panel variance
            alpha = np.maximum(alpha, np.maximum(a, hh))
            bright = np.maximum(bright, a)
            holes = np.maximum(holes, hh)
        else:
            # discrete dents & abrasions, interior-weighted like blood
            edt = ndimage.distance_transform_edt(reg)
            core = (edt**1.4)[ys, xs]
            pp = core / max(core.sum(), 1e-9)
            # bump-zones (doors, bumpers, trunk) get abrasions + chips from bumping into
            # things; other panels get only sparse dents and the odd scrape.
            bump_zone = tuple(col) in (DOOR_COLOURS | BUMPER_COLOURS | {TRUNK_COLOUR})
            # hit-zones (hood, bumpers, trunk) also take scattered impact hits
            hit_zone = tuple(col) in (BUMPER_COLOURS | {HOOD_COLOUR, TRUNK_COLOUR})
            div = 1600 if bump_zone else 5400          # slightly denser everywhere
            n_ev = int(np.clip(reg.sum()/(div*k*k), 2, 15))
            for _ in range(n_ev):
                j = rng.choice(len(xs), p=pp); ox, oy = int(xs[j]), int(ys[j])
                room = float(edt[oy, ox])
                roll = rng.random()
                if bump_zone:
                    # doors / trunk / bumpers: abrasion + chip wear, occasional scrape
                    if roll < 0.36:                 # short scrapes (more, not drowning)
                        grp = rng.uniform(0, 2*np.pi)
                        for _ in range(rng.integers(2, 4)):
                            ka = grp + rng.normal(0, 0.5)
                            kl = min(rng.uniform(6, 20)*k, room*0.7 + 5, 24*k)
                            ko = rng.uniform(0, 9)*k
                            keyscratch(ox+ko*np.cos(ka+1.4), oy+ko*np.sin(ka+1.4), ka, kl)
                    elif roll < 0.64:               # micro-abrasions (dominant here)
                        for _ in range(rng.integers(2, 5)):
                            ang = rng.uniform(0, 2*np.pi)
                            ln = min(rng.uniform(6, 22)*k, room*1.1 + 4)
                            abrasion(ox+rng.uniform(-8,8)*k, oy+rng.uniform(-8,8)*k, ang, ln, rng.uniform(1.0, 2.4)*k)
                    elif roll < 0.90:               # paint chips
                        for _ in range(rng.integers(3, 9)):
                            a2 = rng.random()*2*np.pi; dd2 = rng.uniform(0, 9)*k
                            cxx, cyy = ox+dd2*np.cos(a2), oy+dd2*np.sin(a2)
                            rr2 = max(rng.uniform(0.5, 1.7)*k, 0.5)
                            chip.ellipse([cxx-rr2, cyy-rr2, cxx+rr2, cyy+rr2], fill=float(rng.uniform(0.4, 0.8)))
                    else:                           # occasional small dent
                        dent(ox, oy, min(rng.uniform(5, 13)*k, room*0.9 + 4), rng.uniform(0.2, 0.55))
                else:
                    # roof / hood / body sides: sparse dents only, no scrapes/abrasions/chips
                    sr = rng.random()
                    if sr < 0.7:
                        depth = rng.uniform(0.12, 0.4); size = rng.uniform(4, 11)
                    else:
                        depth = rng.uniform(0.4, 0.7); size = rng.uniform(9, 18)
                    dent(ox, oy, min(size*k, room*0.95 + 5), depth)

            # extra impact hits scattered on hood / bumper / trunk (took a beating)
            if hit_zone:
                n_hit = int(np.clip(reg.sum()/(2200*k*k), 3, 15))
                for _ in range(n_hit):
                    j = rng.choice(len(xs), p=pp); ox, oy = int(xs[j]), int(ys[j])
                    room = float(edt[oy, ox])
                    sr = rng.random()
                    if sr < 0.5:                    # medium impact ding
                        depth = rng.uniform(0.35, 0.62); size = rng.uniform(7, 15)
                    elif sr < 0.85:                 # deeper hit
                        depth = rng.uniform(0.6, 0.85); size = rng.uniform(12, 22)
                    else:                           # hard hit with chip scatter
                        depth = rng.uniform(0.8, 1.0); size = rng.uniform(16, 28)
                        for _ in range(rng.integers(3, 8)):
                            a2 = rng.random()*2*np.pi; dd2 = rng.uniform(0, size*0.7)*k
                            cxx, cyy = ox+dd2*np.cos(a2), oy+dd2*np.sin(a2)
                            rr2 = max(rng.uniform(0.5, 1.6)*k, 0.5)
                            chip.ellipse([cxx-rr2, cyy-rr2, cxx+rr2, cyy+rr2], fill=float(rng.uniform(0.4, 0.75)))
                    dent(ox, oy, min(size*k, room*0.95 + 5), depth)

                # dedicated paint chipping scattered across hood / bumper / trunk
                n_chip = int(np.clip(reg.sum()/(2700*k*k), 3, 13))
                for _ in range(n_chip):
                    j = rng.choice(len(xs), p=pp); cox, coy = int(xs[j]), int(ys[j])
                    # a patch of chipped paint - irregular flecks of varied size
                    for _ in range(rng.integers(4, 10)):
                        a2 = rng.random()*2*np.pi; dd2 = abs(rng.normal(0, 7))*k
                        cxx, cyy = cox+dd2*np.cos(a2), coy+dd2*np.sin(a2)
                        rr2 = max(rng.uniform(0.5, 2.0)*k, 0.5)
                        chip.ellipse([cxx-rr2, cyy-rr2, cxx+rr2, cyy+rr2], fill=float(rng.uniform(0.4, 0.8)))

    # merge event-based body damage: abrasions lighten (scuffed paint/primer),
    # dents darken (depression shadow). Both constrained to body (non-glass) regions.
    bodymask = np.zeros((H, W), bool)
    for col, _, is_glass in regions:
        if not is_glass:
            bodymask |= (mask == np.array(col)).all(-1)
    body_mass = ndimage.gaussian_filter(np.asarray(body_img, np.float32), 0.5*max(k, 0.5)) * bodymask
    dent_mass = ndimage.gaussian_filter(np.asarray(dent_img, np.float32), 1.2*max(k, 0.5)) * bodymask
    scr_mass = ndimage.gaussian_filter(np.asarray(scr_img, np.float32), 0.35*max(k, 0.5)) * bodymask
    chip_mass = ndimage.gaussian_filter(np.asarray(chip_img, np.float32), 0.4*max(k, 0.5)) * bodymask

    alpha = np.clip(ndimage.gaussian_filter(alpha, 0.5*max(k, 0.5)), 0, 1)
    # fold body damage into the alpha/colour: scuffs add light marks, dents add dark
    scuff_a = np.clip(body_mass, 0, 1) * 0.28   # very faint, occasional
    dent_a = np.clip(dent_mass, 0, 1)
    scr_a = np.clip(scr_mass, 0, 1)
    chip_a = np.clip(chip_mass, 0, 1)
    alpha = np.maximum(alpha, np.maximum(np.maximum(scuff_a*0.7, dent_a), np.maximum(scr_a, chip_a)))
    alpha[alpha < 0.03] = 0.0

    # glass crazing uses the light crack tone; body damage uses dark dent tones
    grey = SCUFF_RGB + (CRACK_RGB-SCUFF_RGB)*np.clip(bright, 0, 1)   # glass only region
    grey = grey*(1-holes) + HOLE_RGB*holes
    # body: dents = dark depression, scuffs = faint. base body-damage tone is DARK,
    # so a mark never shows as a pale patch. 128 = neutral shadow that darkens paint.
    DENT_TONE = 96.0
    body_any = (dent_a > 0.03) | (scuff_a > 0.03)
    body_dark = np.clip(np.maximum(dent_a, scuff_a*0.5), 0, 1)
    grey = np.where(body_any & ~ (bright > 0.05),
                    DENT_TONE + (170.0 - DENT_TONE)*(1 - body_dark),  # 96(deep)..170(faint)
                    grey)
    # scratches: crisp light exposed-metal lines, sit on top of dents (they stick out)
    chip_lit = (chip_a > 0.06) & (bright <= 0.05)
    grey = np.where(chip_lit, 122.0 + 30.0*np.clip(chip_a, 0, 1), grey)   # 122-152 dull primer
    scr_lit = (scr_a > 0.06) & (bright <= 0.05)
    grey = np.where(scr_lit, 148.0 + 24.0*np.clip(scr_a, 0, 1), grey)   # 148-172 dull, not white
    return np.dstack([grey, grey, grey, alpha*255]).astype(np.uint8), alpha


def gen_wreck(mask, regions, skin, rng, k):
    """Burned-out wreck skin: chars the paint to soot-black, adds heat-bloom rust and
    ash gradients, melts/blackens glass. Produces a full replacement skin (opaque),
    not an overlay. First-pass - tune BURN_* constants.

    Approach: desaturate + crush the skin toward black, strongest on upper/horizontal
    panels (where fire pools), with rusty heat-tint at the transition and soot streaks."""
    H, W = mask.shape[:2]
    base = skin[..., :3].astype(np.float32)
    L = base @ np.array([0.2126, 0.7152, 0.0722])

    # per-panel char intensity: roof/hood/trunk burn hardest, lower panels less
    char = np.full((H, W), 0.72, np.float32)
    HOT = {ROOF_COLOUR, HOOD_COLOUR, TRUNK_COLOUR, BODY_HEAD, BODY_TAIL}
    for col, _, is_glass in regions:
        reg = (mask == np.array(col)).all(-1)
        if not reg.any():
            continue
        if is_glass:
            char[reg] = 0.9              # glass blackens/melts
        elif tuple(col) in HOT:
            char[reg] = rng.uniform(0.80, 0.92)
        else:
            char[reg] = rng.uniform(0.62, 0.80)

    # blotchy soot: low-freq noise modulates how black each area goes
    soot = ndimage.gaussian_filter(rng.random((H, W)), 40*k)
    soot = (soot - soot.min())/max(soot.max()-soot.min(), 1e-6)
    char = np.clip(char * (0.8 + 0.35*soot), 0, 0.95)

    # charred colour: crush luminance toward near-black, kill saturation
    charred_L = L * (1 - char) * 0.4 + 6
    out = np.dstack([charred_L, charred_L*0.98, charred_L*0.95])   # very slightly warm black

    # rust / heat-bloom tint at medium char (metal oxidised orange-brown, not fully sooted)
    rustband = np.clip(1 - np.abs(char - 0.68)/0.12, 0, 1) * soot
    rust = np.array([90, 45, 22]) * rustband[..., None]
    out = out*(1 - 0.5*rustband[..., None]) + rust*0.5

    # ash streaks running down from upper edges (soot washed by extinguishing/rain)
    streak = ndimage.gaussian_filter(rng.random((H, W)), (14*k, 1.5*k))
    streak = np.clip((streak - 0.55)*6, 0, 1)
    out *= (1 - 0.35*streak[..., None])

    # bare-metal scorch highlights: rare bright spots where paint burned off to steel
    metal = (ndimage.gaussian_filter(rng.random((H, W)), 3*k) > 0.82) & (char < 0.8)
    out[metal] = np.array([60, 58, 55])

    out = np.clip(out, 0, 255)
    alpha = np.full((H, W), 255, np.uint8)          # full replacement skin
    return np.dstack([out, alpha]).astype(np.uint8)


def gen_blood(mask, targets, rng, k, down):
    """Layered blood: contact smears (hand drags), impact spatter (fine droplets
    with directional throw), and gravity drips. Colour varies per-pixel between
    wet, dried and highlight rather than a flat fill, and edges dry darker."""
    H, W = mask.shape[:2]
    dens = Image.new('F', (W, H), 0.0)   # blood mass -> alpha
    wet  = Image.new('F', (W, H), 0.0)   # 1 where fresh, biases colour toward WET/HI
    dd, dw = ImageDraw.Draw(dens), ImageDraw.Draw(wet)

    def smear(cx, cy, ang, length, width0):
        """A wiped drag: irregular stippled deposits that thin and break up along
        the stroke, with soft dissolving edges - reads as smeared blood, not a decal."""
        n = int(length)
        ca, sa = np.cos(ang), np.sin(ang)
        px, py = float(cx), float(cy)
        base_w = width0 * rng.uniform(0.8, 1.2)
        for i in range(n):
            t = i / max(n, 1)
            # width tapers unevenly; the stroke wanders
            w = base_w * (1 - t) ** rng.uniform(0.5, 0.9) + 0.5 * k
            px += ca + rng.normal(0, 0.5)
            py += sa + rng.normal(0, 0.5)
            # deposit a scatter of small dabs across the stroke width, not solid ridges
            dabs = int(max(w * 1.3, 2))
            for _ in range(dabs):
                off = rng.normal(0, w * 0.7)                 # gaussian across width -> soft edge
                jx = rng.normal(0, w * 0.25)
                dx = px - sa * off + ca * jx
                dy = py + ca * off + sa * jx
                # blood breaks up as it's wiped: skip deposits stochastically, more toward the tail
                if rng.random() > (0.72 - 0.45 * t):
                    continue
                r = max(rng.uniform(0.4, 1.1) * k, 0.4)
                op = rng.uniform(0.24, 0.62) * (1 - 0.45 * t)  # a bit stronger, still layered
                dd.ellipse([dx - r, dy - r, dx + r, dy + r], fill=float(op))
                dw.ellipse([dx - r, dy - r, dx + r, dy + r], fill=float(rng.uniform(0.3, 0.7)))

    def handprint(cx, cy, ang):
        """Palm blob plus four short finger streaks - a push-off contact mark."""
        pr = rng.uniform(5, 9)*k
        for _ in range(int(pr*pr*0.5)):        # stippled palm, soft edge
            a = rng.random()*2*np.pi; rr = abs(rng.normal(0, pr*0.6))
            dx, dy = cx+rr*np.cos(a), cy+rr*np.sin(a)*1.2
            r = max(rng.uniform(0.5,1.2)*k,0.4)
            dd.ellipse([dx-r,dy-r,dx+r,dy+r], fill=float(rng.uniform(0.25,0.55)))
            dw.ellipse([dx-r,dy-r,dx+r,dy+r], fill=0.6)
        for f in range(4):
            fa = ang + (f-1.5)*0.28 + rng.normal(0, 0.06)
            fl = rng.uniform(10, 20)*k
            smear(cx + pr*np.cos(fa), cy + pr*np.sin(fa)*1.2, fa, fl, rng.uniform(2, 3.5)*k)

    def spatter(cx, cy, throw):
        """Impact spray: many fine droplets scattered wide to cover the panel with dots.
        Mix of tiny specks and a few larger drops, crisp and opaque so they read."""
        ta = np.arctan2(*throw[::-1]) if np.hypot(*throw) > 0 else rng.random()*2*np.pi
        spread = rng.uniform(0.9, 1.8)                 # wider angular spread
        reach = rng.uniform(55, 130)*k                 # farther throw -> covers more area
        for _ in range(int(rng.integers(55, 120))):    # many more droplets
            a = ta + rng.normal(0, spread)
            d = abs(rng.normal(0, 1)) * reach
            x, y = cx + d*np.cos(a), cy + d*np.sin(a)
            # mostly tiny dots, occasional bigger splat
            big = rng.random() < 0.14
            r = (rng.uniform(1.4, 3.0) if big else rng.uniform(0.4, 1.2))*k
            r = max(r * max(1 - d/(reach+1), 0.25)**0.4, 0.4)
            dd.ellipse([x-r, y-r, x+r, y+r], fill=float(rng.uniform(0.7, 1.0)))
            dw.ellipse([x-r, y-r, x+r, y+r], fill=float(rng.uniform(0.5, 0.85)))
            if big and rng.random() < 0.4:              # tail on larger drops
                tl = r*rng.uniform(2, 4)
                dd.line([x, y, x+tl*np.cos(a), y+tl*np.sin(a)], fill=0.8, width=1)

    def drip(x, y, length, w0):
        px, py, w = float(x), float(y), float(w0)
        for i in range(int(length)):
            w = w0*(1-i/max(length, 1))**0.55 + 0.5*k
            px += down[0] + rng.normal(0, 0.35); py += down[1]
            dd.ellipse([px-w, py-w, px+w, py+w], fill=0.85)
            dw.ellipse([px-w, py-w, px+w, py+w], fill=0.55)
            if rng.random() < 0.02:
                b = w*rng.uniform(1.6, 2.6)
                dd.ellipse([px-b, py-b, px+b, py+b], fill=0.9)
        b = w*rng.uniform(1.8, 3.0)
        dd.ellipse([px-b, py-b, px+b, py+b], fill=0.95)

    keep = np.zeros((H, W), bool)
    for col in targets:
        reg = (mask == np.array(col)).all(-1)
        if not reg.any():
            continue
        keep |= reg
        ys, xs = np.nonzero(reg)
        x0, x1, y0, y1 = xs.min(), xs.max(), ys.min(), ys.max()
        wide = (x1-x0) > (y1-y0)*1.3        # hood-like vs vertical panel
        area = reg.sum()
        # bias placement to island interior: distance transform as a probability map
        edt = ndimage.distance_transform_edt(reg)
        core = edt**1.3                       # cluster centrally, but spread a bit more
        core_flat = core[ys, xs]
        pick_p = core_flat / core_flat.sum()
        inset = float(edt.max())              # island 'radius' for smear-length capping
        n_events = int(np.clip(area/(2400*k*k), 4, 17))

        for _ in range(n_events):
            i = rng.choice(len(xs), p=pick_p); ox, oy = int(xs[i]), int(ys[i])
            roll = rng.random()
            # unit vector toward the island's deep interior (max-distance point)
            dy, dx = np.unravel_index(edt.argmax(), edt.shape)
            inward = np.array([dx-ox, dy-oy], float)
            inward = inward/max(np.hypot(*inward), 1e-6)
            in_ang = np.arctan2(inward[1], inward[0])
            room = float(edt[oy, ox])         # how far to the nearest edge here
            if roll < 0.30:                  # contact smear (occasional)
                ang = in_ang + rng.normal(0, 0.5)
                length = min(rng.uniform(40, 100)*k, room*1.4 + 8)
                smear(ox, oy, ang, length, rng.uniform(2.5, 4.5)*k)
            elif roll < 0.94:                # impact spatter (dominant - covers with dots)
                thr = np.array([rng.normal(0, 1), rng.normal(0, 1)])   # any direction
                spatter(ox, oy, thr)
            else:                            # pooling + drips (verticals drip more)
                pr = rng.uniform(3, 6)*k            # smaller contact point, not a puddle
                dd.ellipse([ox-pr, oy-pr, ox+pr, oy+pr], fill=0.9)
                dw.ellipse([ox-pr, oy-pr, ox+pr, oy+pr], fill=0.6)
                # drag off the contact point instead of pooling
                smear(ox, oy, rng.uniform(0, 2*np.pi), rng.uniform(40, 100)*k, pr*0.9)
                for _ in range(rng.integers(1, 3) if not wide else rng.integers(0, 2)):
                    drip(ox + rng.uniform(-pr, pr), oy + pr*0.6,
                         rng.uniform(30, 90)*k, rng.uniform(1.2, 2.2)*k)

    mass = np.asarray(dens, np.float32)
    fresh = np.asarray(wet, np.float32)
    # merge stipple into continuous smears, keep soft dissolving edges
    mass = np.maximum(mass*0.85, ndimage.gaussian_filter(mass, 1.1*k)*0.9)
    mass = ndimage.gaussian_filter(mass, 0.6*k)
    n = ndimage.gaussian_filter(rng.random((H, W)), 1.4*k)
    n = (n-n.min())/max(n.max()-n.min(), 1e-6)
    core = np.clip(mass*1.35*(0.85+0.3*n), 0, 1)
    # dissolving halo: soft translucent bleed past the mark edges into the paint
    halo = ndimage.gaussian_filter(core, 3.0*k) * 0.55
    halo *= (ndimage.gaussian_filter(rng.random((H, W)), 1.0) > 0.4)  # broken, not uniform
    alpha = np.clip(np.maximum(core, halo), 0, 1) * keep
    alpha[alpha < 0.006] = 0.0

    # colour: interpolate DRY(low freshness/thin) -> WET -> HI(thin fresh) per pixel
    fr = np.clip(ndimage.gaussian_filter(fresh, 0.8*k), 0, 1)
    thin = 1.0 - np.clip(mass, 0, 1)                     # thin blood shows highlight
    wetc = np.array(BLOOD_WET); dryc = np.array(BLOOD_DRY); hic = np.array(BLOOD_HI)
    base = dryc[None,None,:]*(1-fr[...,None]) + wetc[None,None,:]*fr[...,None]
    rgb = base*(1-0.5*thin[...,None]*fr[...,None]) + hic[None,None,:]*(0.5*thin[...,None]*fr[...,None])
    rgb += rng.normal(0, 4, rgb.shape)                   # break up flatness
    rgb = np.clip(rgb, 0, 255)
    out = np.dstack([rgb, (alpha*255)[...,None]]).astype(np.uint8)
    return out, alpha



def load_config(folder):
    """Optional damage.json in the mask folder. Maps vehicle prefix -> overrides:
       { "Vehicle_FordTaurus86": {"blood": ["255,0,0"], "exclude": [], "glass": [...],
                                   "down": [0,1], "no_blood": false, "no_hole": false},
         "_default": { ... applied to every vehicle unless overridden ... } }
    Any field may be omitted; CLI flags still win over the file."""
    import json
    path = os.path.join(folder, 'damage.json')
    if not os.path.isfile(path):
        return {}
    try:
        with open(path) as f:
            return json.load(f)
    except Exception as e:
        print('  ! damage.json ignored (%s)' % e)
        return {}


def cfg_get(cfg, prefix, key, default):
    if prefix in cfg and key in cfg[prefix]:
        return cfg[prefix][key]
    if '_default' in cfg and key in cfg['_default']:
        return cfg['_default'][key]
    return default


def mask_stem(maskpath):
    '''Strip whichever mask suffix the file uses, return (stem, sep_style).
    sep_style is '' for CamelCase (Vehicle_FooMask) or '_' for Vehicle_Foo_mask.'''
    name = os.path.basename(maskpath)[:-4]   # drop .png
    for suf in MASK_SUFFIXES:
        if name.endswith(suf):
            sep = '_' if suf.startswith('_') else ''
            return name[:-len(suf)], sep
    return name, ''


def out_name(stem, sep, suffix):
    return '%s%s%s.png' % (stem, sep, suffix if sep else suffix)


def find_skin(maskpath, stem):
    known = ('mask', 'damage', 'blood', 'rust', 'lights', 'scratch', 'panelmap',
             'shell', 'overlay')
    cands = []
    for p in sorted(glob.glob(os.path.join(os.path.dirname(maskpath) or '.', stem + '*.png'))):
        tail = os.path.basename(p)[len(stem):-4].lstrip('_').lower()
        if tail and not any(tail == k or tail.endswith(k) for k in known):
            cands.append(p)
    return cands[0] if cands else None


def process(maskpath, args, cfg=None):
    cfg = cfg or {}
    mask = np.asarray(Image.open(maskpath).convert('RGB')).astype(np.uint8)
    res = mask.shape[0]
    k = res/REF
    stem, sep = mask_stem(maskpath)
    base = stem

    # resolve settings: CLI flag > damage.json > built-in default
    def rgblist(v):
        return [tuple(int(x) for x in (c.split(',') if isinstance(c, str) else c)) for c in v]
    g_glass = set(args.glass) if args.glass else (resolve_zones(cfg_get(cfg, base, 'glass', [])) or None)
    # blood/exclude may contain zone names ("doors") or "r,g,b" strings; resolve_zones handles both
    g_blood = ([','.join(map(str, t)) for t in args.blood] if args.blood
               else cfg_get(cfg, base, 'blood', []))
    g_excl  = ([','.join(map(str, t)) for t in args.exclude] if args.exclude
               else cfg_get(cfg, base, 'exclude', []))
    g_down  = tuple(args.down) if args.down != (0, 1) else tuple(cfg_get(cfg, base, 'down', (0, 1)))
    g_noblood = args.no_blood or cfg_get(cfg, base, 'no_blood', False)
    g_nohole  = args.no_hole or cfg_get(cfg, base, 'no_hole', False)

    skinpath = args.skin or find_skin(maskpath, stem)
    skin = np.asarray(Image.open(skinpath).convert('RGB')).astype(np.float32) if skinpath else None
    if skin is not None and skin.shape[:2] != mask.shape[:2]:
        skin = np.asarray(Image.open(skinpath).convert('RGB').resize(
            (mask.shape[1], mask.shape[0]), Image.NEAREST)).astype(np.float32)

    named = set(g_glass or []) | set(g_blood) | set(g_excl)
    regions = regions_of(mask, skin, g_glass, int(MIN_REGION * min(k, 2)**2), named)
    rng = np.random.default_rng(args.seed)

    if args.map:
        from PIL import ImageDraw, ImageFont
        from scipy import ndimage as ndi
        bg = skin if skin is not None else np.full_like(mask, 90, np.float32)
        out = Image.fromarray((bg*0.5).astype(np.uint8)).convert('RGB')
        d = ImageDraw.Draw(out)
        try:
            font = ImageFont.truetype('/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf', max(12, int(16*k)))
        except Exception:
            font = ImageFont.load_default()
        # overlay fills, then outline each region so boundaries are crisp
        ov = np.array(out)
        for col, n, g in regions:
            r = (mask == np.array(col)).all(-1)
            ov[r] = (ov[r]*0.35 + np.array(col)*0.65).astype(np.uint8)
        out = Image.fromarray(ov); d = ImageDraw.Draw(out)
        placed = []
        for col, n, g in sorted(regions, key=lambda x: -x[1]):
            r = (mask == np.array(col)).all(-1)
            edge = r & ~ndi.binary_erosion(r, np.ones((3, 3)))
            ey, ex = np.nonzero(edge)
            for k2 in range(0, len(ex), 3):
                out.putpixel((int(ex[k2]), int(ey[k2])), (255, 255, 255))
            ys, xs = np.nonzero(r)
            # place label at the region's widest interior point, nudged off collisions
            dt = ndi.distance_transform_edt(r)
            cy, cx = np.unravel_index(dt.argmax(), dt.shape)
            lbl = '%d,%d,%d%s' % (col[0], col[1], col[2], ' G' if g else '')
            lw = len(lbl) * 8
            for _ in range(8):
                clash = any(abs(cx-px) < lw and abs(cy-py) < 20 for px, py in placed)
                if not clash:
                    break
                cy += 22
            placed.append((cx, cy))
            d = ImageDraw.Draw(out)
            d.rectangle([cx-3, cy-9, cx+lw, cy+9], fill=(0, 0, 0))
            d.text((cx, cy-8), lbl, fill=(255, 255, 255), font=font)
        p = os.path.join(args.out, out_name(stem, sep, 'PanelMap'))
        out.save(p)
        print('   wrote %s  (body panels unlabelled-G = paintable; find bumper colours here)' % os.path.basename(p))
        return

    if not (0.5 <= k <= 4.2):
        print('    ! mask %dpx outside tested 512-4096 range; check output' % res)
    print('\n%s  (%dx%d, scale %.2f)  skin: %s' % (base, res, res, k,
          os.path.basename(skinpath) if skinpath else 'NONE - glass not auto-detectable'))
    for col, n, g in regions:
        print('    %-16s %7d px   %s' % (str(col), n, 'GLASS' if g else 'body'))
    if not any(g for _, _, g in regions):
        print('    !! no glass regions identified - pass --glass R,G,B ...')

    want = args.only or {'damage', 'blood'}   # default: damage + blood, not wreck

    line = ''
    if 'damage' in want:
        sc, sa = gen_scratch(mask, regions, rng, k, not g_nohole)
        Image.fromarray(sc, 'RGBA').save(os.path.join(args.out, out_name(stem, sep, SCRATCH_SUFFIX)))
        line += ' damage: fill %.3f' % (sa > 0.03).mean()

    if 'blood' in want and not g_noblood:
        excl = set(g_excl)
        blood_set = resolve_zones(g_blood)
        excl_set = resolve_zones(g_excl)
        if blood_set:
            tg = list(blood_set)                    # explicit allow-list (zones or colours)
        else:
            # default: paintable bodywork only - never glass, lights, beacons, roof
            never = GLASS_COLOURS | LIGHT_COLOURS | {ROOF_COLOUR}
            tg = [c for c, _, g in regions if not g and tuple(c) not in never]
        tg = [c for c in tg if tuple(c) not in excl_set]
        bl, ba = gen_blood(mask, tg, rng, k, g_down)
        Image.fromarray(bl, 'RGBA').save(os.path.join(args.out, out_name(stem, sep, BLOOD_SUFFIX)))
        src = 'blood' if g_blood else 'exclude' if g_excl else 'all-body'
        line += '   blood[%s]: %d panels fill %.3f' % (src, len(tg), (ba > 0.03).mean())

    if 'wreck' in want:
        if skin is None:
            line += '   wreck: SKIPPED (needs a skin texture)'
        else:
            wr = gen_wreck(mask, regions, skin, rng, k)
            Image.fromarray(wr, 'RGBA').save(os.path.join(args.out, out_name(stem, sep, WRECK_SUFFIX)))
            line += '   wreck: written'
    print('   ' + line)


def rgb(s):
    return tuple(int(x) for x in s.split(','))


def main():
    ap = argparse.ArgumentParser(
        description='Generate PZ vehicle _scratch and _blood overlays from _mask textures.',
        epilog='Simplest use: gen_damage.py <folder>   (finds masks, writes overlays beside them). '
               'Per-vehicle rules (e.g. blood only on bumpers) live in damage.json in the mask folder.')
    ap.add_argument('path', nargs='?', default='.',
                    help='a _mask.png, or a folder to scan (recursively). default: current dir')
    ap.add_argument('--skin')
    ap.add_argument('--out', help='output folder (default: beside each mask)')
    ap.add_argument('--seed', type=int, default=1993)
    ap.add_argument('--glass', type=rgb, nargs='*')
    ap.add_argument('--blood', type=rgb, nargs='*', help='allow-list: blood ONLY on these mask colours')
    ap.add_argument('--exclude', type=rgb, nargs='*', help='block-list: blood on all body panels EXCEPT these')
    ap.add_argument('--map', action='store_true', help='write <prefix>_panelmap.png and exit')
    ap.add_argument('--down', type=rgb, default=(0, 1))
    ap.add_argument('--no-blood', action='store_true')
    ap.add_argument('--no-hole', action='store_true')
    ap.add_argument('--only', nargs='*', choices=['damage', 'blood', 'wreck'],
                    help='generate only these outputs (default: damage + blood)')
    ap.add_argument('--init', action='store_true',
                    help='write a damage.json template listing every vehicle found, then exit')
    a = ap.parse_args()
    a.down = (float(a.down[0]), float(a.down[1]))
    a.only = set(a.only) if a.only else None

    if os.path.isdir(a.path):
        masks = []
        for suf in ('*Mask.png', '*_mask.png', '*_Mask.png'):
            masks += glob.glob(os.path.join(a.path, '**', suf), recursive=True)
        files = sorted(set(masks))
        root = a.path
    else:
        files = [a.path]
        root = os.path.dirname(a.path) or '.'
    if not files:
        sys.exit('no mask textures (*Mask.png / *_mask.png) found under %s' % a.path)

    if a.init:
        import json
        tmpl = {'_default': {'blood': [], 'exclude': [], 'down': [0, 1]}}
        for f in files:
            tmpl[mask_stem(f)[0]] = {}
        p = os.path.join(root, 'damage.json')
        with open(p, 'w') as fh:
            json.dump(tmpl, fh, indent=2)
        print('wrote %s with %d vehicles. Fill in blood/exclude per vehicle and re-run.' % (p, len(files)))
        return

    # config is loaded per mask folder so a nested tree can hold several
    cfg_cache = {}
    for f in files:
        folder = os.path.dirname(f) or '.'
        if folder not in cfg_cache:
            cfg_cache[folder] = load_config(folder)
        a.out = a.out or None
        out = a.out or folder
        os.makedirs(out, exist_ok=True)
        a_run = argparse.Namespace(**{**vars(a), 'out': out})
        process(f, a_run, cfg_cache[folder])


if __name__ == '__main__':
    main()
