"""
Professional iOS app icon generator for Hidden Objects.
Output: 1024x1024 sRGB, no alpha.

Design v4: clean sunset gradient backdrop with subtle hidden-object decoration.
A large brass magnifying glass centered reveals a treasure chest spilling gems
and coins inside the lens — the unmistakable "hidden treasure" theme.
Outside the lens: scattered small objects, softly blurred.
"""
import math
import random
from PIL import Image, ImageDraw, ImageFilter

SIZE = 1024
OUT = r"D:\hidden_objects\assets\app_icon_v2.png"

SKY_TOP = (255, 209, 130)
SKY_MID = (252, 142, 96)
SKY_BOT = (180, 75, 130)


def gradient_3stop(img, c1, c2, c3, y0, y1):
    px = img.load()
    mid = (y0 + y1) // 2
    for y in range(y0, y1):
        if y < mid:
            t = (y - y0) / max(1, (mid - y0))
            c = tuple(int(c1[i] + (c2[i] - c1[i]) * t) for i in range(3))
        else:
            t = (y - mid) / max(1, (y1 - mid))
            c = tuple(int(c2[i] + (c3[i] - c2[i]) * t) for i in range(3))
        for x in range(SIZE):
            px[x, y] = c


def paint_backdrop(img):
    gradient_3stop(img, SKY_TOP, SKY_MID, SKY_BOT, 0, SIZE)
    d = ImageDraw.Draw(img)
    # Soft sun glow upper-left
    glow = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    gd = ImageDraw.Draw(glow)
    sun_cx, sun_cy = int(SIZE * 0.22), int(SIZE * 0.20)
    for i in range(30, 0, -1):
        rr = 90 + i * 9
        gd.ellipse([sun_cx - rr, sun_cy - rr, sun_cx + rr, sun_cy + rr],
                   fill=(255, 230, 160, 4 + (30 - i) * 3))
    glow = glow.filter(ImageFilter.GaussianBlur(40))
    img.paste(glow, (0, 0), glow)
    d.ellipse([sun_cx - 90, sun_cy - 90, sun_cx + 90, sun_cy + 90],
              fill=(255, 245, 180))
    # Subtle stars / sparkles
    rng = random.Random(3)
    for _ in range(40):
        x = rng.randint(20, SIZE - 20)
        y = rng.randint(20, SIZE - 20)
        s = rng.choice([2, 3, 3, 4, 5])
        a = rng.randint(120, 220)
        d.ellipse([x - s, y - s, x + s, y + s], fill=(255, 245, 220, a))


# ---- Object shapes ----
def draw_gem(d, cx, cy, s, color, outline=True):
    """Faceted diamond: top triangle + side facets for clean look."""
    top = (cx, cy - s)
    left = (cx - s, cy)
    right = (cx + s, cy)
    bot = (cx, cy + s)
    # Main diamond
    d.polygon([top, right, bot, left], fill=color)
    # Highlight (top half, lighter)
    hi = tuple(min(255, c + 60) for c in color)
    d.polygon([top, right, (cx + s * 0.15, cy - s * 0.05), (cx - s * 0.15, cy - s * 0.05), left],
              fill=hi)
    # Bright facet top-left
    bright = tuple(min(255, c + 100) for c in color)
    d.polygon([top, (cx - s * 0.15, cy - s * 0.05), left],
              fill=bright)
    if outline:
        d.polygon([top, right, bot, left], outline=(255, 255, 255, 220), width=3)


def draw_coin(d, cx, cy, s, gold=True):
    base = (255, 200, 50) if gold else (220, 220, 230)
    hi = (255, 240, 130) if gold else (255, 255, 255)
    edge = (170, 110, 20) if gold else (140, 140, 160)
    d.ellipse([cx - s, cy - s * 0.85, cx + s, cy + s * 0.85], fill=base)
    d.ellipse([cx - s, cy - s * 0.85, cx + s, cy + s * 0.85], outline=edge, width=3)
    # Inner ring
    d.ellipse([cx - s * 0.75, cy - s * 0.62, cx + s * 0.75, cy + s * 0.62],
              outline=hi, width=3)
    # Highlight crescent
    d.arc([cx - s * 0.92, cy - s * 0.78, cx + s * 0.92, cy + s * 0.78],
          start=200, end=280, fill=hi, width=5)


def draw_star(d, cx, cy, s, color, outline=True):
    pts = []
    for i in range(10):
        ang = -math.pi / 2 + i * math.pi / 5
        r = s if i % 2 == 0 else s * 0.45
        pts.append((cx + math.cos(ang) * r, cy + math.sin(ang) * r))
    d.polygon(pts, fill=color)
    if outline:
        d.polygon(pts, outline=(255, 255, 255, 220), width=3)


def draw_key(d, cx, cy, s, color):
    r = s * 0.55
    d.ellipse([cx - r, cy - r, cx + r, cy + r], fill=color)
    d.ellipse([cx - r * 0.42, cy - r * 0.42, cx + r * 0.42, cy + r * 0.42],
              fill=(255, 255, 255, 0))
    # blade
    d.rectangle([cx + r * 0.55, cy - s * 0.18, cx + s * 1.7, cy + s * 0.18],
                fill=color)
    # teeth
    d.rectangle([cx + s * 1.20, cy + s * 0.18, cx + s * 1.40, cy + s * 0.55],
                fill=color)
    d.rectangle([cx + s * 1.55, cy + s * 0.18, cx + s * 1.70, cy + s * 0.40],
                fill=color)


def draw_leaf(d, cx, cy, s, color):
    pts = [(cx, cy - s),
           (cx + s * 0.7, cy - s * 0.2),
           (cx + s * 0.3, cy + s * 0.85),
           (cx - s * 0.3, cy + s * 0.85),
           (cx - s * 0.7, cy - s * 0.2)]
    d.polygon(pts, fill=color)
    d.line([(cx, cy - s * 0.9), (cx, cy + s * 0.75)], fill=(20, 60, 30, 220), width=4)


def draw_heart(d, cx, cy, s, color):
    r = s * 0.55
    d.ellipse([cx - s, cy - r, cx, cy + r * 0.4], fill=color)
    d.ellipse([cx, cy - r, cx + s, cy + r * 0.4], fill=color)
    d.polygon([(cx - s, cy + r * 0.1), (cx + s, cy + r * 0.1), (cx, cy + s)],
              fill=color)


def draw_clock(d, cx, cy, s, color):
    d.ellipse([cx - s, cy - s, cx + s, cy + s], fill=(255, 255, 255))
    d.ellipse([cx - s, cy - s, cx + s, cy + s], outline=color, width=int(s * 0.18))
    d.line([(cx, cy), (cx, cy - s * 0.6)], fill=color, width=int(s * 0.15))
    d.line([(cx, cy), (cx + s * 0.45, cy)], fill=color, width=int(s * 0.12))
    d.ellipse([cx - 5, cy - 5, cx + 5, cy + 5], fill=color)


def draw_treasure_chest(img, cx, cy, width, height):
    """Open treasure chest with gold spilling out (drawn on RGBA image).
    cx,cy is the body center; the lid opens upward from the rear top edge."""
    d = ImageDraw.Draw(img, "RGBA")
    w2, h2 = width // 2, height // 2
    # --- Lid: an arc-shaped (rounded-top) lid hinged at the back, tilted open ---
    # Build the lid as a separate rotated image so it tilts naturally.
    lid_w = int(width * 0.96)
    lid_h = int(height * 0.55)
    lid_img = Image.new("RGBA", (lid_w + 40, lid_h + 40), (0, 0, 0, 0))
    ld = ImageDraw.Draw(lid_img)
    # Rounded-top wooden lid
    ld.rounded_rectangle([20, 20, 20 + lid_w, 20 + lid_h],
                         radius=lid_h // 2, fill=(108, 64, 30))
    # Wood grain stripes
    for sy in [lid_h * 0.32, lid_h * 0.58, lid_h * 0.78]:
        ld.line([(28, 20 + sy), (20 + lid_w - 8, 20 + sy)],
                fill=(78, 44, 20, 180), width=2)
    # Gold rim (top arc)
    ld.rounded_rectangle([20, 20, 20 + lid_w, 20 + 18],
                         radius=lid_h // 2, fill=(220, 162, 50))
    # Gold rim (bottom edge - hinge side)
    ld.rectangle([20, 20 + lid_h - 14, 20 + lid_w, 20 + lid_h],
                 fill=(220, 162, 50))
    ld.rectangle([20, 20 + lid_h - 14, 20 + lid_w, 20 + lid_h - 10],
                 fill=(255, 220, 130))
    # Gold straps vertical
    for sx in [lid_w * 0.25, lid_w * 0.50, lid_w * 0.75]:
        ld.rectangle([20 + sx - 6, 28, 20 + sx + 6, 20 + lid_h - 4],
                     fill=(220, 162, 50))
        ld.rectangle([20 + sx - 6, 28, 20 + sx + 6, 36],
                     fill=(255, 220, 130))
    # Tilt lid back ~35 degrees
    lid_rot = lid_img.rotate(28, resample=Image.BICUBIC, expand=True)
    lr_w, lr_h = lid_rot.size
    # Anchor: lid's bottom-center (hinge) should sit at the chest body top-center back edge
    hinge_x = cx
    hinge_y = cy - h2 + 12
    # The hinge in the source image is at (20 + lid_w/2, 20 + lid_h)
    pivot_src = (20 + lid_w / 2, 20 + lid_h)
    src_cx, src_cy = lid_img.size[0] / 2, lid_img.size[1] / 2
    dx, dy = pivot_src[0] - src_cx, pivot_src[1] - src_cy
    ang = math.radians(-28)
    rdx = math.cos(ang) * dx - math.sin(ang) * dy
    rdy = math.sin(ang) * dx + math.cos(ang) * dy
    paste_x = int(hinge_x - lr_w / 2 - rdx)
    paste_y = int(hinge_y - lr_h / 2 - rdy)
    img.alpha_composite(lid_rot, (paste_x, paste_y))

    # --- Box body ---
    body_top = cy - int(h2 * 0.45)
    body_left = cx - w2
    body_right = cx + w2
    body_bot = cy + h2
    # Dark interior (open chest cavity) behind the gold pile
    d.rounded_rectangle([body_left + 10, body_top - 26, body_right - 10, body_top + 12],
                        radius=14, fill=(34, 20, 10))
    # Wood body
    d.rounded_rectangle([body_left, body_top + 8, body_right, body_bot],
                        radius=18, fill=(110, 66, 32))
    # Wood lighter front face
    d.rounded_rectangle([body_left + 14, body_top + 16, body_right - 14, body_bot - 12],
                        radius=12, fill=(146, 92, 48))
    # Gold straps vertical (only on wood body)
    for sx in [-w2 * 0.6, 0, w2 * 0.6]:
        d.rectangle([cx + sx - 8, body_top + 10, cx + sx + 8, body_bot],
                    fill=(220, 165, 55))
        d.rectangle([cx + sx - 8, body_top + 10, cx + sx + 8, body_top + 14],
                    fill=(255, 220, 130))
    # Gold rim along the open top of the body (cavity edge)
    d.rectangle([body_left, body_top, body_right, body_top + 16],
                fill=(220, 165, 55))
    d.rectangle([body_left, body_top, body_right, body_top + 5],
                fill=(255, 220, 130))
    # Lock plate sits low on the front face
    lock_w = width * 0.18
    lock_h = height * 0.30
    lock_top = body_bot - lock_h - 14
    d.rounded_rectangle([cx - lock_w / 2, lock_top, cx + lock_w / 2, lock_top + lock_h],
                        radius=8, fill=(230, 175, 60))
    d.rounded_rectangle([cx - lock_w / 2 + 4, lock_top + 4, cx + lock_w / 2 - 4, lock_top + 4 + lock_h * 0.4],
                        radius=4, fill=(255, 220, 130))
    # Keyhole
    d.ellipse([cx - 7, lock_top + lock_h * 0.45, cx + 7, lock_top + lock_h * 0.45 + 14],
              fill=(60, 36, 14))
    d.rectangle([cx - 3, lock_top + lock_h * 0.55 + 6, cx + 3, lock_top + lock_h * 0.55 + 22],
                fill=(60, 36, 14))

    # --- Gold pile inside / spilling ---
    # Soft gold glow first
    glow = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    gd = ImageDraw.Draw(glow)
    for i in range(28, 0, -1):
        rr = 80 + i * 5
        gd.ellipse([cx - rr, body_top - rr * 0.5,
                    cx + rr, body_top + rr * 0.5],
                   fill=(255, 230, 130, 6 + (28 - i) * 3))
    glow = glow.filter(ImageFilter.GaussianBlur(20))
    img.paste(glow, (0, 0), glow)

    d = ImageDraw.Draw(img, "RGBA")
    # Coins piled inside the cavity, peeking over the gold rim
    coin_positions = [
        (cx - w2 * 0.55, body_top - 10, 30),
        (cx + w2 * 0.50, body_top - 14, 32),
        (cx - w2 * 0.20, body_top - 22, 28),
        (cx + w2 * 0.18, body_top - 18, 30),
        (cx - w2 * 0.40, body_top + 2, 24),
        (cx + w2 * 0.40, body_top + 2, 24),
    ]
    for px, py, ps in coin_positions:
        d.ellipse([px - ps * 0.7, py + ps * 0.45, px + ps * 0.7, py + ps * 0.65],
                  fill=(0, 0, 0, 90))
        draw_coin(d, px, py, ps)

    # A few gems on top of the gold pile (above the coins)
    draw_gem(d, cx, body_top - 30, 40, (244, 67, 54))  # ruby center, big
    draw_gem(d, cx - 70, body_top - 16, 28, (66, 165, 245))  # sapphire
    draw_gem(d, cx + 70, body_top - 18, 30, (102, 187, 106))  # emerald

    # Sparkle particles
    for sx, sy in [(cx - 30, body_top - 60), (cx + 60, body_top - 50),
                   (cx + 110, body_top - 30), (cx - 95, body_top - 38)]:
        d.line([(sx, sy - 9), (sx, sy + 9)], fill=(255, 255, 200, 230), width=3)
        d.line([(sx - 9, sy), (sx + 9, sy)], fill=(255, 255, 200, 230), width=3)


def scatter_background(target, mask_fn, count, sizes, seed):
    rng = random.Random(seed)
    d = ImageDraw.Draw(target, "RGBA")
    placed = []
    tries = 0
    drawers = [
        lambda dd, x, y, s: draw_star(dd, x, y, s, (255, 215, 64)),
        lambda dd, x, y, s: draw_heart(dd, x, y, s, (236, 64, 122)),
        lambda dd, x, y, s: draw_gem(dd, x, y, s, (66, 165, 245)),
        lambda dd, x, y, s: draw_key(dd, x, y, s, (171, 71, 188)),
        lambda dd, x, y, s: draw_leaf(dd, x, y, s, (102, 187, 106)),
        lambda dd, x, y, s: draw_coin(dd, x, y, s, gold=True),
        lambda dd, x, y, s: draw_clock(dd, x, y, s, (244, 67, 54)),
    ]
    while len(placed) < count and tries < count * 50:
        tries += 1
        x = rng.randint(70, SIZE - 70)
        y = rng.randint(70, SIZE - 70)
        if not mask_fn(x, y):
            continue
        if any((x - px) ** 2 + (y - py) ** 2 < 130 ** 2 for px, py, _ in placed):
            continue
        s = rng.randint(sizes[0], sizes[1])
        # shadow
        d.ellipse([x - s * 0.75, y + s * 0.55, x + s * 0.75, y + s * 0.75],
                  fill=(0, 0, 0, 70))
        drawers[rng.randint(0, len(drawers) - 1)](d, x, y, s)
        placed.append((x, y, s))


def draw_magnifier(target, cx, cy, lens_r, rim_w):
    handle_angle = math.radians(48)
    handle_len = lens_r * 1.05
    handle_w = rim_w * 1.6

    # ---- Shadow (under everything) ----
    shadow = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    sd = ImageDraw.Draw(shadow)
    sd.ellipse([cx - lens_r - rim_w + 26, cy - lens_r - rim_w + 38,
                cx + lens_r + rim_w + 26, cy + lens_r + rim_w + 38],
               fill=(0, 0, 0, 130))
    hx1 = cx + math.cos(handle_angle) * (lens_r + rim_w * 0.2)
    hy1 = cy + math.sin(handle_angle) * (lens_r + rim_w * 0.2)
    hx2 = cx + math.cos(handle_angle) * (lens_r + rim_w + handle_len)
    hy2 = cy + math.sin(handle_angle) * (lens_r + rim_w + handle_len)
    sd.line([(hx1 + 22, hy1 + 36), (hx2 + 22, hy2 + 36)],
            fill=(0, 0, 0, 130), width=int(handle_w))
    shadow = shadow.filter(ImageFilter.GaussianBlur(26))
    target.alpha_composite(shadow)

    # ---- Handle (drawn separately, rotated, pasted) ----
    handle_w_px = int(handle_w)
    handle_len_total = int(handle_len + rim_w)
    pad = 40
    handle_img = Image.new("RGBA", (handle_len_total + pad, handle_w_px + pad),
                          (0, 0, 0, 0))
    hd = ImageDraw.Draw(handle_img)
    hi_w, hi_h = handle_img.size
    pad_y = (hi_h - handle_w_px) // 2
    # Wood body
    hd.rounded_rectangle([20, pad_y, hi_w - 8, pad_y + handle_w_px],
                         radius=handle_w_px // 2, fill=(115, 64, 32))
    # Wood top highlight
    hd.rounded_rectangle([20, pad_y + 5, hi_w - 8, pad_y + handle_w_px // 2 - 3],
                         radius=handle_w_px // 3, fill=(165, 100, 55))
    # Gold ferrule near lens
    fer_w = 80
    hd.rounded_rectangle([20, pad_y - 4, 20 + fer_w, pad_y + handle_w_px + 4],
                         radius=handle_w_px // 2, fill=(220, 158, 50))
    hd.rounded_rectangle([24, pad_y, 20 + fer_w - 4, pad_y + handle_w_px // 3],
                         radius=8, fill=(255, 222, 130))
    # Gold end cap
    hd.rounded_rectangle([hi_w - 70, pad_y - 2, hi_w - 10, pad_y + handle_w_px + 2],
                         radius=handle_w_px // 2, fill=(220, 158, 50))
    hd.rounded_rectangle([hi_w - 66, pad_y, hi_w - 14, pad_y + handle_w_px // 3],
                         radius=8, fill=(255, 222, 130))
    # Grip rings
    for ring_x in range(int(hi_w * 0.30), int(hi_w * 0.82), 28):
        hd.line([(ring_x, pad_y + 4), (ring_x, pad_y + handle_w_px - 4)],
                fill=(50, 28, 12, 230), width=4)

    handle_rot = handle_img.rotate(-math.degrees(handle_angle),
                                   resample=Image.BICUBIC, expand=True)
    hr_w, hr_h = handle_rot.size
    # Anchor source pivot at the lens edge (point at (20, hi_h/2) in source)
    pivot_src = (20, hi_h / 2)
    src_cx, src_cy = hi_w / 2, hi_h / 2
    dx, dy = pivot_src[0] - src_cx, pivot_src[1] - src_cy
    ang = -handle_angle
    rdx = math.cos(ang) * dx - math.sin(ang) * dy
    rdy = math.sin(ang) * dx + math.cos(ang) * dy
    start_x = cx + math.cos(handle_angle) * (lens_r + rim_w - 4)
    start_y = cy + math.sin(handle_angle) * (lens_r + rim_w - 4)
    paste_x = int(start_x - hr_w / 2 - rdx)
    paste_y = int(start_y - hr_h / 2 - rdy)
    target.alpha_composite(handle_rot, (paste_x, paste_y))

    # ---- Brass rim (concentric bands) ----
    rim_layer = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    rd = ImageDraw.Draw(rim_layer)
    outer = lens_r + rim_w
    bands = [
        (outer, (118, 76, 26)),
        (outer - rim_w * 0.16, (188, 132, 38)),
        (outer - rim_w * 0.34, (250, 200, 90)),
        (outer - rim_w * 0.54, (255, 230, 145)),
        (outer - rim_w * 0.74, (215, 152, 50)),
        (outer - rim_w * 0.92, (132, 86, 30)),
    ]
    for r_band, color in bands:
        rd.ellipse([cx - r_band, cy - r_band, cx + r_band, cy + r_band],
                   fill=color + (255,))
    rd.ellipse([cx - lens_r, cy - lens_r, cx + lens_r, cy + lens_r], fill=(0, 0, 0, 0))
    target.alpha_composite(rim_layer)

    # ---- Lens reflections on top ----
    hl = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    hd2 = ImageDraw.Draw(hl)
    # Soft sheen sweep upper-left
    hd2.pieslice([cx - lens_r + 25, cy - lens_r + 25, cx + lens_r - 90, cy + lens_r - 90],
                 start=200, end=290, fill=(255, 255, 255, 70))
    # Specular bright dot
    hd2.ellipse([cx - lens_r * 0.6, cy - lens_r * 0.6,
                 cx - lens_r * 0.30, cy - lens_r * 0.30],
                fill=(255, 255, 255, 170))
    hd2.ellipse([cx - lens_r * 0.43, cy - lens_r * 0.43,
                 cx - lens_r * 0.33, cy - lens_r * 0.33],
                fill=(255, 255, 255, 255))
    hl = hl.filter(ImageFilter.GaussianBlur(2))
    target.alpha_composite(hl)

    # ---- Inner rim shadow ring ----
    shade = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    sd2 = ImageDraw.Draw(shade)
    for i in range(8):
        a = 90 - i * 10
        sd2.ellipse([cx - lens_r + i, cy - lens_r + i,
                     cx + lens_r - i, cy + lens_r - i],
                    outline=(0, 0, 0, max(0, a)), width=2)
    target.alpha_composite(shade)


def build_icon():
    random.seed(11)
    base = Image.new("RGB", (SIZE, SIZE), (0, 0, 0))
    paint_backdrop(base)
    base_rgba = base.convert("RGBA")

    # Scatter small objects (decorative)
    def whole(x, y):
        # avoid edges
        return 60 < x < SIZE - 60 and 60 < y < SIZE - 60
    scatter_layer = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    scatter_background(scatter_layer, whole, count=12, sizes=(34, 48), seed=27)
    base_rgba = Image.alpha_composite(base_rgba, scatter_layer)

    # Magnifier geometry
    lens_cx, lens_cy = int(SIZE * 0.48), int(SIZE * 0.48)
    lens_r = 340
    rim_w = 60

    # ---- Build INSIDE-LENS content (clear treasure chest) on a SEPARATE clear canvas ----
    inside = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    # Discovery warm glow inside
    igd = ImageDraw.Draw(inside)
    igd.ellipse([lens_cx - lens_r, lens_cy - lens_r, lens_cx + lens_r, lens_cy + lens_r],
                fill=(255, 232, 175, 40))
    # The chest — sized to fit comfortably inside the lens
    draw_treasure_chest(inside, lens_cx, lens_cy + 60, width=380, height=220)

    # ---- Composite: outside = blurred backdrop, inside = original + chest ----
    blurred = base_rgba.filter(ImageFilter.GaussianBlur(10))

    # Outside mask (255 outside circle)
    outside_mask = Image.new("L", (SIZE, SIZE), 255)
    md = ImageDraw.Draw(outside_mask)
    md.ellipse([lens_cx - lens_r, lens_cy - lens_r, lens_cx + lens_r, lens_cy + lens_r],
               fill=0)
    outside_mask = outside_mask.filter(ImageFilter.GaussianBlur(4))

    composed = Image.composite(blurred, base_rgba, outside_mask)
    composed = Image.alpha_composite(composed, inside)

    # Magnifier on top
    draw_magnifier(composed, lens_cx, lens_cy, lens_r, rim_w)

    # Final flatten to RGB (no alpha for App Store)
    final = Image.new("RGB", (SIZE, SIZE), (0, 0, 0))
    final.paste(composed, (0, 0), composed)
    final.save(OUT, "PNG", optimize=True)
    print(f"Saved: {OUT}")


if __name__ == "__main__":
    build_icon()
