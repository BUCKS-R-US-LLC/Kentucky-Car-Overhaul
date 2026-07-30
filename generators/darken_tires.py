"""Darken vehicle wheel/tire textures, in the same procedural style as the wreck generator.

Uniformly darkens the whole wheel (tire + rim) with subtle grime/wear variation so the
result reads as worn dark rubber rather than a flat multiply. Preserves the alpha channel.

Usage:
    python darken_tires.py <folder-or-file> [--amount 0.55] [--out DIR] [--seed 1993]

  <folder>    recurses, finds wheel textures (*wheel*.png, *tire*.png, case-insensitive)
  --amount    darken strength 0..1 (default 0.55 = moderate dark rubber;
              lower = subtler, higher = near-black)
  --out DIR   write to DIR (mirrors subfolders); default overwrites in place
  --seed      RNG seed for the grime pattern (default 1993)

Requires: numpy, scipy, pillow
"""
import os, sys, glob, argparse
import numpy as np
from scipy import ndimage
from PIL import Image

WHEEL_TAGS = ('wheel', 'tire', 'tyre')


def is_wheel(name):
    low = os.path.splitext(name)[0].lower()
    return any(t in low for t in WHEEL_TAGS)


def darken_wheel(img, amount, rng):
    """Darken a wheel RGBA to a flat, uniformly-lit matte look: compresses the baked-in
    highlights/shadows toward an even mid-dark grey, keeping just enough structure to read
    the tread and rim. amount: 0..1, higher = darker. Returns uint8 RGBA."""
    a = np.asarray(img.convert('RGBA')).astype(np.float32)
    rgb, alpha = a[..., :3], a[..., 3:]
    H, W = rgb.shape[:2]
    L = rgb @ np.array([0.2126, 0.7152, 0.0722])

    # target flat tone: uniform matte grey the whole wheel sits around. amount sets how dark.
    target = 78 - amount * 55                     # 0.55 -> ~48, matches the flat reference
    # flatten: pull every pixel most of the way toward the target, keeping a little of the
    # original luminance variation so tread/rim still read (this is the "flat" part).
    keep_var = 0.62                               # 0 = dead flat, 1 = original contrast
    flat_L = target + (L - L.mean()) * keep_var
    # apply the flattened luminance back to the colour, desaturated toward neutral rubber
    Lsafe = np.maximum(L, 1)[..., None]
    out = rgb * (flat_L[..., None] / Lsafe)       # rescale each pixel to the flat luminance
    out = out * 0.8 + flat_L[..., None] * 0.2     # blend toward pure grey (kills colour casts)

    # subtle low-freq grime so the flat tone isn't sterile (very mild, keeps it uniform)
    grime = ndimage.gaussian_filter(rng.random((H, W)), 26)
    grime = (grime - grime.min()) / max(grime.max() - grime.min(), 1e-6)
    out *= (1 - 0.08 * grime[..., None])

    # very fine grain for matte rubber texture
    grain = ndimage.gaussian_filter(rng.random((H, W)), 0.8)
    out *= (1 + (grain[..., None] - 0.5) * 0.05)

    out = np.clip(out, 0, 255)
    return np.dstack([out, alpha]).astype(np.uint8)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('path')
    ap.add_argument('--amount', type=float, default=0.55)
    ap.add_argument('--out', default=None)
    ap.add_argument('--seed', type=int, default=1993)
    a = ap.parse_args()

    if os.path.isdir(a.path):
        pngs = glob.glob(os.path.join(a.path, '**', '*.png'), recursive=True)
        files = sorted(p for p in pngs if is_wheel(os.path.basename(p)))
        root = a.path
    else:
        files = [a.path]
        root = os.path.dirname(a.path) or '.'

    if not files:
        sys.exit('no wheel textures (name contains wheel/tire/tyre) found under %s' % a.path)
    print('found %d wheel texture(s), darkening amount %.2f\n' % (len(files), a.amount))

    for i, f in enumerate(files, 1):
        folder = os.path.dirname(f) or '.'
        if a.out:
            rel = os.path.relpath(folder, root)
            outdir = os.path.join(a.out, rel) if rel != '.' else a.out
        else:
            outdir = folder
        os.makedirs(outdir, exist_ok=True)
        # deterministic per-file seed so each wheel gets its own grime but runs are repeatable
        rng = np.random.default_rng(a.seed + i)
        print('[%d/%d] %s' % (i, len(files), os.path.basename(f)))
        try:
            im = Image.open(f)
            res = darken_wheel(im, a.amount, rng)
            Image.fromarray(res, 'RGBA').save(os.path.join(outdir, os.path.basename(f)))
        except Exception as e:
            print('   ERROR: %s' % e)

    print('\ndone.')


if __name__ == '__main__':
    main()
