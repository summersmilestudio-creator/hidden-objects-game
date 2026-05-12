"""Quick scale preview to verify icon legibility at small iOS sizes."""
from PIL import Image

src = Image.open(r"D:\hidden_objects\assets\app_icon_v2.png")
sizes = [180, 120, 87, 60, 40]
out = Image.new("RGB", (sum(sizes) + 60, max(sizes) + 60), (245, 245, 245))
x = 30
for s in sizes:
    thumb = src.resize((s, s), Image.LANCZOS)
    out.paste(thumb, (x, 30 + (max(sizes) - s) // 2))
    x += s + 10
out.save(r"D:\hidden_objects\assets\app_icon_preview.png")
print("preview saved")
