"""
Generate iOS App Store screenshots for Hidden Objects.

Produces:
  * iPhone 6.7":   1290 x 2796   (4 screenshots)
  * iPad 12.9":    2048 x 2732   (4 screenshots)

Each screenshot shows a real gameplay mockup (scene background + target
strip + scattered objects + HUD) under a marketing headline. Crucially,
NO price references anywhere in the metadata (Apple guideline 2.3.7).
"""
import math
import os
import random
from PIL import Image, ImageDraw, ImageFilter, ImageFont

OUT = r"D:\hidden_objects\ios_screenshots"

FONT_BOLD = r"C:\Windows\Fonts\segoeuib.ttf"
FONT_SEMI = r"C:\Windows\Fonts\segoeuib.ttf"
FONT_REG = r"C:\Windows\Fonts\segoeui.ttf"

PALETTE = [
    (255, 215, 64),
    (244, 67, 54),
    (66, 165, 245),
    (102, 187, 106),
    (171, 71, 188),
    (255, 138, 101),
    (236, 64, 122),
    (38, 198, 218),
    (255, 167, 38),
    (126, 87, 194),
]

# ---------- gradient helpers ----------

def grad_v(img, c1, c2, y0, y1):
    px = img.load()
    w = img.size[0]
    for y in range(y0, y1):
        t = (y - y0) / max(1, (y1 - y0 - 1))
        c = tuple(int(c1[i] + (c2[i] - c1[i]) * t) for i in range(3))
        for x in range(w):
            px[x, y] = c


def grad_3v(img, c1, c2, c3, y0, y1):
    px = img.load()
    w = img.size[0]
    mid = (y0 + y1) // 2
    for y in range(y0, y1):
        if y < mid:
            t = (y - y0) / max(1, (mid - y0))
            c = tuple(int(c1[i] + (c2[i] - c1[i]) * t) for i in range(3))
        else:
            t = (y - mid) / max(1, (y1 - mid))
            c = tuple(int(c2[i] + (c3[i] - c2[i]) * t) for i in range(3))
        for x in range(w):
            px[x, y] = c


# ---------- object shapes (same vocabulary as the icon) ----------

def draw_star(d, cx, cy, s, color, outline=True):
    pts = []
    for i in range(10):
        ang = -math.pi / 2 + i * math.pi / 5
        r = s if i % 2 == 0 else s * 0.45
        pts.append((cx + math.cos(ang) * r, cy + math.sin(ang) * r))
    d.polygon(pts, fill=color)
    if outline:
        d.polygon(pts, outline=(255, 255, 255, 220), width=3)


def draw_heart(d, cx, cy, s, color):
    r = s * 0.55
    d.ellipse([cx - s, cy - r, cx, cy + r * 0.4], fill=color)
    d.ellipse([cx, cy - r, cx + s, cy + r * 0.4], fill=color)
    d.polygon([(cx - s, cy + r * 0.1), (cx + s, cy + r * 0.1), (cx, cy + s)],
              fill=color)


def draw_gem(d, cx, cy, s, color):
    pts = [(cx, cy - s), (cx + s, cy), (cx, cy + s), (cx - s, cy)]
    d.polygon(pts, fill=color)
    hi = tuple(min(255, c + 70) for c in color)
    d.polygon([(cx, cy - s), (cx + s * 0.4, cy - s * 0.2),
               (cx - s * 0.4, cy - s * 0.2)], fill=hi)
    d.polygon(pts, outline=(255, 255, 255, 220), width=3)


def draw_key(d, cx, cy, s, color):
    r = s * 0.55
    d.ellipse([cx - r, cy - r, cx + r, cy + r], fill=color)
    d.ellipse([cx - r * 0.42, cy - r * 0.42, cx + r * 0.42, cy + r * 0.42],
              fill=(255, 255, 255, 0))
    d.rectangle([cx + r * 0.55, cy - s * 0.18, cx + s * 1.7, cy + s * 0.18],
                fill=color)
    d.rectangle([cx + s * 1.20, cy + s * 0.18, cx + s * 1.40, cy + s * 0.55],
                fill=color)


def draw_leaf(d, cx, cy, s, color):
    pts = [(cx, cy - s),
           (cx + s * 0.7, cy - s * 0.2),
           (cx + s * 0.3, cy + s * 0.85),
           (cx - s * 0.3, cy + s * 0.85),
           (cx - s * 0.7, cy - s * 0.2)]
    d.polygon(pts, fill=color)
    d.line([(cx, cy - s * 0.9), (cx, cy + s * 0.75)], fill=(20, 60, 30, 220), width=4)


def draw_coin(d, cx, cy, s, color=(255, 200, 50)):
    d.ellipse([cx - s, cy - s, cx + s, cy + s], fill=color)
    hi = tuple(min(255, c + 80) for c in color)
    d.ellipse([cx - s * 0.78, cy - s * 0.78, cx + s * 0.78, cy + s * 0.78],
              outline=hi, width=5)


def draw_flower(d, cx, cy, s, color):
    for i in range(6):
        a = i * math.pi / 3
        d.ellipse([cx + math.cos(a) * s * 0.5 - s * 0.45,
                   cy + math.sin(a) * s * 0.5 - s * 0.45,
                   cx + math.cos(a) * s * 0.5 + s * 0.45,
                   cy + math.sin(a) * s * 0.5 + s * 0.45],
                  fill=color)
    d.ellipse([cx - s * 0.4, cy - s * 0.4, cx + s * 0.4, cy + s * 0.4],
              fill=(255, 235, 100))


def draw_clock(d, cx, cy, s, color):
    d.ellipse([cx - s, cy - s, cx + s, cy + s], fill=(255, 255, 255))
    d.ellipse([cx - s, cy - s, cx + s, cy + s], outline=color, width=int(s * 0.18))
    d.line([(cx, cy), (cx, cy - s * 0.6)], fill=color, width=int(s * 0.15))
    d.line([(cx, cy), (cx + s * 0.45, cy)], fill=color, width=int(s * 0.12))
    d.ellipse([cx - 5, cy - 5, cx + 5, cy + 5], fill=color)


SHAPE_FNS = [draw_star, draw_heart, draw_gem, draw_key, draw_leaf,
             draw_coin, draw_flower, draw_clock]


def draw_shape(d, cx, cy, s, kind, color):
    fn = SHAPE_FNS[kind % len(SHAPE_FNS)]
    # coin and flower don't take outline param same way; harmonized signatures use color
    if fn in (draw_star, draw_heart, draw_gem, draw_key, draw_leaf,
              draw_flower, draw_clock):
        fn(d, cx, cy, s, color)
    else:
        fn(d, cx, cy, s)


# ---------- scenes (matched to the Flutter painter aesthetic) ----------

def cloud(d, cx, cy, r):
    paint = (255, 255, 255)
    d.ellipse([cx - r * 0.5, cy - r * 0.5, cx + r * 0.5, cy + r * 0.5], fill=paint)
    d.ellipse([cx + r * 0.0, cy - r * 0.45, cx + r * 1.0, cy + r * 0.45], fill=paint)
    d.ellipse([cx - r * 0.8, cy - r * 0.40, cx + r * 0.2, cy + r * 0.40], fill=paint)
    d.ellipse([cx - r * 0.2, cy - r * 0.7, cx + r * 0.6, cy + r * 0.1], fill=paint)


def tree(d, cx, base_y, height):
    d.rectangle([cx - height * 0.06, base_y - height * 0.4,
                 cx + height * 0.06, base_y],
                fill=(93, 64, 55))
    d.ellipse([cx - height * 0.45, base_y - height * 0.95,
               cx + height * 0.45, base_y - height * 0.15],
              fill=(56, 142, 60))
    d.ellipse([cx - height * 0.30, base_y - height * 0.85,
               cx + height * 0.30, base_y - height * 0.45],
              fill=(102, 187, 106))


def palm(img, base_x, base_y, height, mirror=False):
    d = ImageDraw.Draw(img, "RGBA")
    sign = -1 if mirror else 1
    top_x = base_x + sign * 25
    top_y = base_y - height
    # trunk
    segs = 18
    last = (base_x, base_y)
    for i in range(1, segs + 1):
        t = i / segs
        cx = base_x + sign * 60
        cy = base_y - height * 0.5
        x = (1 - t) ** 2 * base_x + 2 * (1 - t) * t * cx + t ** 2 * top_x
        y = (1 - t) ** 2 * base_y + 2 * (1 - t) * t * cy + t ** 2 * top_y
        w = max(7, int(20 - i * 0.7))
        d.line([last, (x, y)], fill=(67, 39, 28), width=w)
        last = (x, y)
    # fronds
    for i in range(8):
        ang = math.pi + i * (math.pi / 7)
        length = height * 0.40
        end_x = top_x + math.cos(ang) * length
        end_y = top_y + math.sin(ang) * length - 18
        cx = (top_x + end_x) / 2 + math.cos(ang + math.pi / 2) * 25
        cy = (top_y + end_y) / 2 + math.sin(ang + math.pi / 2) * 25
        segs2 = 10
        prev = (top_x, top_y)
        for s in range(1, segs2 + 1):
            t = s / segs2
            x = (1 - t) ** 2 * top_x + 2 * (1 - t) * t * cx + t ** 2 * end_x
            y = (1 - t) ** 2 * top_y + 2 * (1 - t) * t * cy + t ** 2 * end_y
            w = max(4, int(18 * (1 - t)))
            d.line([prev, (x, y)], fill=(36, 78, 50), width=w)
            prev = (x, y)


def scene_garden(img):
    w, h = img.size
    grad_3v(img, (129, 212, 250), (179, 229, 252), (200, 230, 201), 0, int(h * 0.55))
    d = ImageDraw.Draw(img, "RGBA")
    # sun (positioned in clear sky area, below UI strip)
    d.ellipse([w * 0.78 - 60, h * 0.30 - 60, w * 0.78 + 60, h * 0.30 + 60],
              fill=(255, 238, 88))
    # clouds in clear sky area
    cloud(d, w * 0.20, h * 0.25, 80)
    cloud(d, w * 0.48, h * 0.18, 90)
    # grass
    grass = Image.new("RGB", (w, h - int(h * 0.55)))
    grad_v(grass, (102, 187, 106), (46, 125, 50), 0, grass.size[1])
    img.paste(grass, (0, int(h * 0.55)))
    # trees
    tree(ImageDraw.Draw(img, "RGBA"), w * 0.15, int(h * 0.62), 220)
    tree(ImageDraw.Draw(img, "RGBA"), w * 0.85, int(h * 0.66), 180)
    tree(ImageDraw.Draw(img, "RGBA"), w * 0.45, int(h * 0.58), 260)


def scene_forest(img):
    w, h = img.size
    grad_3v(img, (27, 94, 32), (0, 77, 64), (13, 31, 27), 0, h)
    d = ImageDraw.Draw(img, "RGBA")
    # light rays
    for i in range(4):
        path = [
            (w * (0.20 + i * 0.20), 0),
            (w * (0.23 + i * 0.20), 0),
            (w * (0.42 + i * 0.20), h),
            (w * (0.38 + i * 0.20), h),
        ]
        d.polygon(path, fill=(255, 245, 157, 38))
    rng = random.Random(7)
    for _ in range(10):
        tree(d, rng.uniform(0, w), int(h * (0.45 + rng.random() * 0.45)),
             140 + rng.uniform(0, 180))


def scene_beach_sunset(img):
    w, h = img.size
    horizon = int(h * 0.62)
    # sky
    sky = Image.new("RGB", (w, horizon))
    grad_3v(sky, (49, 27, 146), (233, 30, 99), (255, 111, 0), 0, horizon)
    img.paste(sky, (0, 0))
    d = ImageDraw.Draw(img, "RGBA")
    # sun
    d.ellipse([w * 0.42, horizon - 130, w * 0.58, horizon + 30],
              fill=(255, 215, 64))
    # sea
    sea = Image.new("RGB", (w, int(h * 0.20)))
    grad_v(sea, (255, 111, 0), (69, 39, 160), 0, sea.size[1])
    img.paste(sea, (0, horizon))
    # waves
    for i in range(6):
        d.line([(0, horizon + 6 + i * 10), (w, horizon + 6 + i * 10)],
               fill=(255, 215, 64, 90), width=2)
    # sand
    sand = Image.new("RGB", (w, h - horizon - int(h * 0.20)))
    grad_v(sand, (255, 204, 128), (161, 136, 127), 0, sand.size[1])
    img.paste(sand, (0, horizon + int(h * 0.20)))
    # palms
    palm(img, int(w * 0.10), int(h * 0.82), 250, mirror=False)
    palm(img, int(w * 0.90), int(h * 0.82), 220, mirror=True)


def scene_kitchen(img):
    w, h = img.size
    d = ImageDraw.Draw(img, "RGBA")
    # wall
    d.rectangle([0, 0, w, int(h * 0.55)], fill=(255, 224, 178))
    # tiles
    for r in range(4):
        for c in range(10):
            tx = c * w / 10
            ty = r * (h * 0.06) + int(h * 0.12)
            d.rectangle([tx, ty, tx + w / 10, ty + h * 0.06],
                        fill=(239, 83, 80, 120))
            d.rectangle([tx, ty, tx + w / 10, ty + h * 0.06],
                        outline=(255, 255, 255), width=2)
    # counter
    d.rectangle([0, int(h * 0.55), w, int(h * 0.60)], fill=(109, 76, 65))
    # cabinets
    d.rectangle([0, int(h * 0.60), w, h], fill=(255, 255, 255))
    for i in range(4):
        x = i * w / 4 + 10
        d.rectangle([x, int(h * 0.62), x + w / 4 - 20, h - 30],
                    fill=(245, 245, 245), outline=(189, 189, 189), width=4)
        d.ellipse([x + w / 4 - 60, int(h * 0.78) - 8, x + w / 4 - 44, int(h * 0.78) + 8],
                  fill=(66, 66, 66))


def scene_city_night(img):
    w, h = img.size
    grad_3v(img, (13, 13, 46), (26, 35, 126), (49, 27, 146), 0, h)
    d = ImageDraw.Draw(img, "RGBA")
    rng = random.Random(99)
    for _ in range(120):
        x = rng.uniform(0, w)
        y = rng.uniform(0, h * 0.5)
        s = rng.uniform(0.5, 2.5)
        a = int(150 + rng.uniform(0, 105))
        d.ellipse([x - s, y - s, x + s, y + s], fill=(255, 255, 255, a))
    # moon
    d.ellipse([w * 0.83 - 40, h * 0.12 - 40, w * 0.83 + 40, h * 0.12 + 40],
              fill=(238, 238, 238))
    # buildings
    x = 0
    while x < w:
        bw = rng.uniform(60, 130)
        bh = rng.uniform(140, 420)
        d.rectangle([x, h - bh, x + bw, h], fill=(26, 26, 46))
        # windows
        for wy in range(int(h - bh + 14), int(h - 20), 32):
            for wx in range(int(x + 8), int(x + bw - 8), 22):
                if rng.random() > 0.45:
                    a = int(140 + rng.random() * 115)
                    d.rectangle([wx, wy, wx + 12, wy + 16],
                                fill=(255, 235, 59, a))
        x += bw


def scene_attic(img):
    w, h = img.size
    grad_v(img, (109, 76, 65), (62, 39, 35), 0, h)
    d = ImageDraw.Draw(img, "RGBA")
    # beams
    for i in range(6):
        d.rectangle([0, i * h / 6, w, i * h / 6 + 6], fill=(78, 52, 46))
    for vx in [w * 0.20, w * 0.50, w * 0.80]:
        d.rectangle([vx, 0, vx + 6, h], fill=(78, 52, 46))
    # window
    d.rectangle([w * 0.38, h * 0.08, w * 0.62, h * 0.30],
                fill=(255, 245, 157, 200))
    # chest silhouette
    d.rounded_rectangle([w * 0.62, h * 0.62, w * 0.92, h * 0.85],
                        radius=10, fill=(62, 39, 35))


SCENES = {
    "garden": scene_garden,
    "forest": scene_forest,
    "beach_sunset": scene_beach_sunset,
    "kitchen": scene_kitchen,
    "city_night": scene_city_night,
    "attic": scene_attic,
}


def scatter_scene_objects(img, count, sizes, seed, mask_fn=None):
    rng = random.Random(seed)
    d = ImageDraw.Draw(img, "RGBA")
    placed = []
    tries = 0
    w, h = img.size
    while len(placed) < count and tries < count * 50:
        tries += 1
        x = rng.randint(80, w - 80)
        y = rng.randint(80, h - 80)
        if mask_fn and not mask_fn(x, y, w, h):
            continue
        if any((x - px) ** 2 + (y - py) ** 2 < 130 ** 2 for px, py, _ in placed):
            continue
        s = rng.randint(sizes[0], sizes[1])
        kind = rng.randint(0, len(SHAPE_FNS) - 1)
        color = PALETTE[rng.randint(0, len(PALETTE) - 1)]
        # shadow
        d.ellipse([x - s * 0.75, y + s * 0.55, x + s * 0.75, y + s * 0.75],
                  fill=(0, 0, 0, 95))
        draw_shape(d, x, y, s, kind, color)
        placed.append((x, y, s))
    return placed


# ---------- gameplay mockup ----------

def build_gameplay_mockup(width, height, scene_key, level_name, timer_text, found, total):
    """A fully rendered gameplay screen as if captured from the running app."""
    img = Image.new("RGB", (width, height), (0, 0, 0))
    # Scene background
    SCENES[scene_key](img)

    # Scatter target/decoy objects on the scene (visible gameplay)
    def in_scene(x, y, w, h):
        return 40 < x < w - 40 and 250 < y < h - 140
    scatter_scene_objects(img, count=22, sizes=(38, 62), seed=hash(scene_key) & 0xFFFF,
                          mask_fn=in_scene)

    d = ImageDraw.Draw(img, "RGBA")

    # ---- Top app bar (level name + hint button + timer) ----
    bar_h = 110
    d.rectangle([0, 0, width, bar_h], fill=(0, 0, 0, 160))
    # back arrow
    back_cx, back_cy = 50, bar_h // 2
    d.line([(back_cx + 14, back_cy - 14), (back_cx - 6, back_cy),
            (back_cx + 14, back_cy + 14)],
           fill=(255, 255, 255), width=5)
    # title
    title_font = ImageFont.truetype(FONT_BOLD, 36)
    d.text((90, bar_h // 2), level_name, font=title_font, fill=(255, 255, 255),
           anchor="lm")
    # timer (right edge)
    timer_font = ImageFont.truetype(FONT_BOLD, 34)
    d.text((width - 30, bar_h // 2), timer_text, font=timer_font,
           fill=(255, 255, 255), anchor="rm")
    # hint icon (lightbulb) — placed left of timer with safe spacing
    timer_text_w = timer_font.getlength(timer_text)
    hx = int(width - 30 - timer_text_w - 60)
    hy = bar_h // 2
    # bulb outline circle
    d.ellipse([hx - 22, hy - 26, hx + 22, hy + 18], outline=(255, 255, 255), width=3)
    # bulb base (rectangle below)
    d.rectangle([hx - 8, hy + 18, hx + 8, hy + 28], fill=(255, 255, 255))
    # filament glow
    d.ellipse([hx - 12, hy - 16, hx + 12, hy + 8], fill=(255, 235, 60))

    # ---- Target strip ----
    strip_top = bar_h
    strip_h = 110
    d.rectangle([0, strip_top, width, strip_top + strip_h], fill=(0, 0, 0, 160))
    label_font = ImageFont.truetype(FONT_BOLD, 22)
    d.text((24, strip_top + 16), f"FIND  ({found}/{total})",
           font=label_font, fill=(255, 255, 255))
    # target chips
    chip_size = 64
    chip_pad = 14
    available_w = width - 40
    chip_count = total
    total_chip_w = chip_count * chip_size + (chip_count - 1) * chip_pad
    start_x = 24
    # If chips overflow we just clip; they're decorative for the screenshot
    rng = random.Random(hash(scene_key) + 99)
    for i in range(chip_count):
        cx = start_x + i * (chip_size + chip_pad)
        cy = strip_top + 50
        if cx + chip_size > width - 24:
            break
        is_found = i < found
        bg = (102, 187, 106, 90) if is_found else (255, 255, 255, 40)
        bd = (102, 255, 102) if is_found else (255, 255, 255, 180)
        d.rounded_rectangle([cx, cy, cx + chip_size, cy + chip_size],
                            radius=12, fill=bg, outline=bd, width=2)
        # shape inside
        kind = (hash(scene_key) + i * 7) % len(SHAPE_FNS)
        color = PALETTE[(hash(scene_key) + i) % len(PALETTE)]
        if is_found:
            color = tuple(min(255, c + 30) for c in color) + (130,)
            color = color[:3]
        cs = int(chip_size * 0.32)
        draw_shape(d, cx + chip_size // 2, cy + chip_size // 2, cs, kind, color)
        if is_found:
            # check mark
            d.line([(cx + chip_size - 22, cy + chip_size // 2),
                    (cx + chip_size - 14, cy + chip_size - 12),
                    (cx + chip_size - 4, cy + 12)],
                   fill=(102, 255, 102), width=5)

    # ---- bottom: progress/score HUD (clean, no ad label) ----
    hud_h = 110
    d.rectangle([0, height - hud_h, width, height], fill=(0, 0, 0, 160))
    hud_font = ImageFont.truetype(FONT_BOLD, 30)
    # Coins display on the left
    d.ellipse([28, height - hud_h // 2 - 18, 28 + 36, height - hud_h // 2 + 18],
              fill=(255, 200, 50))
    d.ellipse([28 + 6, height - hud_h // 2 - 12, 28 + 30, height - hud_h // 2 + 12],
              outline=(255, 230, 130), width=3)
    d.text((28 + 50, height - hud_h // 2),
           "+120", font=hud_font, fill=(255, 215, 64), anchor="lm")
    # Progress bar on the right
    pb_y = height - hud_h // 2
    pb_x1, pb_x2 = width // 2, width - 30
    d.rounded_rectangle([pb_x1, pb_y - 14, pb_x2, pb_y + 14],
                        radius=14, fill=(255, 255, 255, 60))
    fill_w = int((pb_x2 - pb_x1) * (found / max(1, total)))
    d.rounded_rectangle([pb_x1, pb_y - 14, pb_x1 + fill_w, pb_y + 14],
                        radius=14, fill=(102, 187, 106))
    d.text((pb_x1 - 12, pb_y), f"{found}/{total}",
           font=hud_font, fill=(255, 255, 255), anchor="rm")

    return img


# ---------- screenshot composition ----------

def compose_screenshot(width, height, scene_key, level_name, headline, sub,
                       found, total, timer_text, out_path):
    """Compose a marketing screenshot at App Store dimensions."""
    canvas = Image.new("RGB", (width, height), (0, 0, 0))
    # Marketing background — same warm gradient family as the icon
    grad_3v(canvas, (255, 213, 137), (252, 142, 96), (140, 60, 120), 0, height)

    # Soft glow upper-left
    glow = Image.new("RGBA", (width, height), (0, 0, 0, 0))
    gd = ImageDraw.Draw(glow)
    cx, cy = int(width * 0.20), int(height * 0.14)
    for i in range(28, 0, -1):
        rr = 80 + i * 11
        gd.ellipse([cx - rr, cy - rr, cx + rr, cy + rr],
                   fill=(255, 230, 160, 4 + (28 - i) * 3))
    glow = glow.filter(ImageFilter.GaussianBlur(40))
    canvas.paste(glow, (0, 0), glow)

    # Headline area (top ~14% of height)
    head_y_center = int(height * 0.10)
    head_font_size = int(width * 0.085)
    head_font = ImageFont.truetype(FONT_BOLD, head_font_size)
    d = ImageDraw.Draw(canvas)
    # text shadow
    for dx, dy in [(0, 4), (2, 0), (-2, 0)]:
        d.text((width // 2 + dx, head_y_center + dy), headline, font=head_font,
               fill=(60, 20, 50), anchor="mm")
    d.text((width // 2, head_y_center), headline, font=head_font,
           fill=(255, 255, 255), anchor="mm")

    # Build the gameplay mockup (rendered phone-like screen)
    mock_w = int(width * 0.84)
    mock_h = int(height * 0.66)
    mock_top = int(height * 0.18)
    mock_x = (width - mock_w) // 2
    mockup = build_gameplay_mockup(mock_w, mock_h, scene_key, level_name,
                                   timer_text, found, total)
    # Rounded clip with bezel
    bezel = Image.new("RGB", (mock_w + 24, mock_h + 24), (24, 18, 28))
    bezel_mask = Image.new("L", bezel.size, 0)
    ImageDraw.Draw(bezel_mask).rounded_rectangle([0, 0, bezel.size[0], bezel.size[1]],
                                                  radius=72, fill=255)
    # Apply mask to mockup with rounded corners
    mock_mask = Image.new("L", mockup.size, 0)
    ImageDraw.Draw(mock_mask).rounded_rectangle([0, 0, mockup.size[0], mockup.size[1]],
                                                radius=60, fill=255)
    rounded_mock = Image.new("RGBA", mockup.size, (0, 0, 0, 0))
    rounded_mock.paste(mockup, (0, 0))
    rounded_mock.putalpha(mock_mask)

    # drop shadow
    shadow = Image.new("RGBA", (width, height), (0, 0, 0, 0))
    sd = ImageDraw.Draw(shadow)
    sd.rounded_rectangle([mock_x - 12 + 6, mock_top - 12 + 26,
                          mock_x - 12 + bezel.size[0] + 6,
                          mock_top - 12 + bezel.size[1] + 26],
                         radius=72, fill=(0, 0, 0, 170))
    shadow = shadow.filter(ImageFilter.GaussianBlur(24))
    canvas.paste(shadow, (0, 0), shadow)

    # bezel
    canvas.paste(bezel, (mock_x - 12, mock_top - 12), bezel_mask)
    # mockup
    canvas.paste(rounded_mock, (mock_x, mock_top), rounded_mock)

    # Subtitle below mockup
    sub_font_size = int(width * 0.038)
    sub_font = ImageFont.truetype(FONT_SEMI, sub_font_size)
    sub_y = mock_top + bezel.size[1] - 12 + int(height * 0.045)
    d = ImageDraw.Draw(canvas)
    for dx, dy in [(0, 3), (2, 0), (-2, 0)]:
        d.text((width // 2 + dx, sub_y + dy), sub, font=sub_font,
               fill=(60, 20, 50), anchor="mm")
    d.text((width // 2, sub_y), sub, font=sub_font,
           fill=(255, 255, 255), anchor="mm")

    # Footer
    foot_font = ImageFont.truetype(FONT_REG, int(width * 0.028))
    d.text((width // 2, height - int(height * 0.04)), "by Summer Smile",
           font=foot_font, fill=(255, 255, 255, 220), anchor="mm")

    canvas.save(out_path, "PNG", optimize=True)
    print(f"  saved: {out_path}")


# ---------- main ----------

PHONE_W, PHONE_H = 1290, 2796
IPAD_W, IPAD_H = 2048, 2732

SCREENSHOTS = [
    {
        "scene": "garden",
        "level_name": "Garden Magic",
        "headline": "Find Hidden Objects",
        "sub": "Discover treasures in beautiful scenes",
        "found": 3,
        "total": 8,
        "timer": "01:42",
    },
    {
        "scene": "forest",
        "level_name": "Mystery Forest",
        "headline": "8 Stunning Scenes",
        "sub": "Garden, beach, forest, attic and more",
        "found": 5,
        "total": 10,
        "timer": "02:18",
    },
    {
        "scene": "kitchen",
        "level_name": "Grandma's Kitchen",
        "headline": "Daily Challenge",
        "sub": "A new mystery every single day",
        "found": 7,
        "total": 14,
        "timer": "03:05",
    },
    {
        "scene": "city_night",
        "level_name": "Night City",
        "headline": "Train Your Eagle Eye",
        "sub": "Sharpen your observation skills",
        "found": 9,
        "total": 15,
        "timer": "04:21",
    },
]


def main():
    os.makedirs(OUT, exist_ok=True)
    print("=== iPhone 6.7\" screenshots ===")
    for i, sc in enumerate(SCREENSHOTS, start=1):
        compose_screenshot(PHONE_W, PHONE_H,
                           sc["scene"], sc["level_name"],
                           sc["headline"], sc["sub"],
                           sc["found"], sc["total"], sc["timer"],
                           os.path.join(OUT, f"iphone67_phone_{i}.png"))
    print("\n=== iPad 12.9\" screenshots ===")
    for i, sc in enumerate(SCREENSHOTS, start=1):
        compose_screenshot(IPAD_W, IPAD_H,
                           sc["scene"], sc["level_name"],
                           sc["headline"], sc["sub"],
                           sc["found"], sc["total"], sc["timer"],
                           os.path.join(OUT, f"ipad129_phone_{i}.png"))


if __name__ == "__main__":
    main()
