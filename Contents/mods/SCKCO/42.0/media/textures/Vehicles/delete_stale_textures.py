#!/usr/bin/env python3
import os
import sys

# default target root; override by passing a path as the first argument
ROOT = r"C:\Users\sharkpc\Zomboid\Workshop\Kentucky-Car-Overhaul\Contents\mods\SCKCO\42.0\media\textures\Vehicles"

def should_delete(low):
    # numbered blood maps: removed so they can be regenerated
    if "blood1" in low or "blood2" in low:
        return True
    # legacy damage maps: keep the current damage1/damage2, drop everything else with "damage"
    if "damage" in low and "damage1" not in low and "damage2" not in low:
        return True
    return False

def main():
    args = sys.argv[1:]
    dry = "--dry-run" in args
    pos = [a for a in args if not a.startswith("-")]
    root = pos[0] if pos else ROOT

    if not os.path.isdir(root):
        sys.exit(f"not a directory: {root}")

    hits, failed = 0, 0
    for dirpath, _, files in os.walk(root):
        for fn in files:
            low = fn.lower()
            if not low.endswith(".png"):
                continue
            if not should_delete(low):
                continue
            p = os.path.join(dirpath, fn)
            if dry:
                print(f"[dry] {p}")
                hits += 1
                continue
            # let unexpected errors surface, but keep going past a single locked file
            try:
                os.remove(p)
                print(f"deleted {p}")
                hits += 1
            except OSError as e:
                print(f"FAILED {p}: {e}")
                failed += 1

    verb = "would delete" if dry else "deleted"
    print(f"\n{verb}: {hits}  failed: {failed}  root: {root}")

if __name__ == "__main__":
    main()
