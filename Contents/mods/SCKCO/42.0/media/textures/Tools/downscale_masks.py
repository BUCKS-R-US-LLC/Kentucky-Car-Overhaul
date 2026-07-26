"""Batch-downscale vehicle mask (and skin) textures to a target size, in place.
One-time helper to move a fleet to 1K. Uses NEAREST so mask zone colours stay exact.

Usage:
    python downscale_masks.py <folder> [--res 1024] [--skins] [--dry-run]

  <folder>   recurses through subfolders, finds *Mask.png / *_mask.png
  --res N    target size (default 1024)
  --skins    also downscale the matching skin textures (non-mask PNGs alongside)
  --dry-run  list what would change without writing
"""
import os, sys, glob, argparse
from PIL import Image


def is_mask(name):
    low = name.lower()
    return low.endswith('mask.png') or low.endswith('_mask.png')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('path')
    ap.add_argument('--res', type=int, default=1024)
    ap.add_argument('--skins', action='store_true')
    ap.add_argument('--dry-run', action='store_true')
    a = ap.parse_args()

    root = a.path if os.path.isdir(a.path) else os.path.dirname(a.path)
    pngs = glob.glob(os.path.join(root, '**', '*.png'), recursive=True)
    masks = [p for p in pngs if is_mask(os.path.basename(p))]

    targets = list(masks)
    if a.skins:
        # a skin is a non-mask, non-overlay PNG sitting next to a mask
        overlay_tags = ('damage', 'blood', 'burnt', 'panelmap')
        for p in pngs:
            b = os.path.basename(p).lower()
            if is_mask(b):
                continue
            if any(t in b for t in overlay_tags):
                continue
            targets.append(p)

    changed = 0
    for p in sorted(set(targets)):
        try:
            im = Image.open(p)
        except Exception as e:
            print('skip (unreadable): %s (%s)' % (p, e))
            continue
        if im.size[0] == a.res and im.size[1] == a.res:
            continue
        print('%s  %s -> %dx%d%s' % (
            os.path.relpath(p, root), im.size, a.res, a.res,
            '  [dry-run]' if a.dry_run else ''))
        if not a.dry_run:
            im.convert('RGBA' if 'A' in im.getbands() else 'RGB') \
              .resize((a.res, a.res), Image.NEAREST).save(p)
        changed += 1

    print('\n%d file(s) %s.' % (changed, 'would change' if a.dry_run else 'downscaled'))


if __name__ == '__main__':
    main()
