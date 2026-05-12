"""
Generate all iOS AppIcon sizes from the master 1024x1024 PNG.
Writes them into ios/Runner/Assets.xcassets/AppIcon.appiconset/
to exactly match the existing Contents.json filenames.

Apple requires sRGB, no alpha channel for the 1024 marketing icon.
We strip alpha on every output for safety.
"""
import os
from PIL import Image

ROOT = r"D:\hidden_objects"
SRC = os.path.join(ROOT, "assets", "app_icon.png")
DEST_DIR = os.path.join(ROOT, "ios", "Runner", "Assets.xcassets", "AppIcon.appiconset")

# (filename, pixel size)
ICONS = [
    ("Icon-App-20x20@1x.png", 20),
    ("Icon-App-20x20@2x.png", 40),
    ("Icon-App-20x20@3x.png", 60),
    ("Icon-App-29x29@1x.png", 29),
    ("Icon-App-29x29@2x.png", 58),
    ("Icon-App-29x29@3x.png", 87),
    ("Icon-App-40x40@1x.png", 40),
    ("Icon-App-40x40@2x.png", 80),
    ("Icon-App-40x40@3x.png", 120),
    ("Icon-App-50x50@1x.png", 50),
    ("Icon-App-50x50@2x.png", 100),
    ("Icon-App-57x57@1x.png", 57),
    ("Icon-App-57x57@2x.png", 114),
    ("Icon-App-60x60@2x.png", 120),
    ("Icon-App-60x60@3x.png", 180),
    ("Icon-App-72x72@1x.png", 72),
    ("Icon-App-72x72@2x.png", 144),
    ("Icon-App-76x76@1x.png", 76),
    ("Icon-App-76x76@2x.png", 152),
    ("Icon-App-83.5x83.5@2x.png", 167),
    ("Icon-App-1024x1024@1x.png", 1024),
]

src = Image.open(SRC).convert("RGB")  # flatten alpha onto whatever bg the source has
print(f"Source: {src.size}")

for filename, size in ICONS:
    img = src.resize((size, size), Image.LANCZOS)
    out_path = os.path.join(DEST_DIR, filename)
    img.save(out_path, "PNG", optimize=True)
    print(f"  {filename}: {size}x{size}")

print("\nDone. All AppIcon.appiconset images regenerated.")
