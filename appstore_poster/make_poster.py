"""Afiș de prezentare Hidden Objects — stil 'afiș de publicitate de site'
(clonă ad_site_shown.py): fundal foto blurat+întunecat (depth), telefon realist
cu SCREENSHOT REAL al jocului, headline heavy condensat + sub auriu + CTA
portocaliu + bloc brand. Dimensiune App Store iPhone 6.7" = 1290x2796, RGB.
"""
from __future__ import annotations
import sys
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont, ImageFilter

try:
    sys.stdout.reconfigure(encoding="utf-8")
except Exception:
    pass

HERE = Path(__file__).parent
SHOT = HERE / "gameplay_plaja_raw.png"   # screenshot REAL de gameplay (1290x2796)
OUT  = HERE / "hidden_objects_poster_6.7.jpg"

W, H = 1290, 2796                 # App Store iPhone 6.7"
CROP_TOP = 84                     # taie status bar-ul Android din screenshot
CROP_BOTTOM = 300                 # taie banda de nisip goală de jos (focus pe acțiune)
F_HEAVY = "C:/Windows/Fonts/bahnschrift.ttf"
F_BOLD  = "C:/Windows/Fonts/arialbd.ttf"
F_REG   = "C:/Windows/Fonts/arial.ttf"

CREAM  = (255, 248, 230)
GOLD   = (255, 206, 110)
ORANGE = (235, 110, 60)
SHADOW = (0, 0, 0)


def load(p, s): return ImageFont.truetype(p, s)


def text_w(d, t, f):
    b = d.textbbox((0, 0), t, font=f); return b[2] - b[0]


def cover_crop(img, w, h, top_pct=0.0):
    sw, sh = img.size
    sr, tr = sw / sh, w / h
    if sr > tr:
        nw = int(sw * h / sh)
        img = img.resize((nw, h), Image.LANCZOS)
        left = (nw - w) // 2
        return img.crop((left, 0, left + w, h))
    nh = int(sh * w / sw)
    img = img.resize((w, nh), Image.LANCZOS)
    top = int(nh * top_pct)
    if top + h > nh: top = nh - h
    return img.crop((0, top, w, top + h))


def make_blurred_bg(src, w, h, blur=30, dark=0.52):
    img = Image.open(src).convert("RGB")
    img = cover_crop(img, w, h, top_pct=0.0)
    img = img.filter(ImageFilter.GaussianBlur(blur))
    img = img.convert("RGBA")
    # darken global
    img = Image.alpha_composite(img, Image.new("RGBA", (w, h), (6, 4, 20, int(255 * dark))))
    # gradient extra sus + jos pt lizibilitate text
    grad = Image.new("L", (1, h), 0)
    for y in range(h):
        t = y / h
        a = 0
        if t < 0.30:   a = int(150 * (1 - t / 0.30))           # top
        elif t > 0.62: a = int(165 * ((t - 0.62) / 0.38))      # bottom
        grad.putpixel((0, y), a)
    grad = grad.resize((w, h))
    veil = Image.new("RGBA", (w, h), (4, 2, 16, 255))
    veil.putalpha(grad)
    img = Image.alpha_composite(img, veil)
    return img


def make_phone(src, screen_w, crop_top=0, crop_bottom=0):
    ss = Image.open(src).convert("RGB")
    if crop_top or crop_bottom:
        ss = ss.crop((0, crop_top, ss.width, ss.height - crop_bottom))
    sw, sh = ss.size
    r = screen_w / sw
    screen_h = int(sh * r)
    ss = ss.resize((screen_w, screen_h), Image.LANCZOS)

    bezel = 22
    fw, fh = screen_w + bezel * 2, screen_h + bezel * 2
    phone = Image.new("RGBA", (fw, fh), (0, 0, 0, 0))
    d = ImageDraw.Draw(phone)
    body_r = 96
    # corp telefon (gradient subtil grafit)
    d.rounded_rectangle([0, 0, fw, fh], radius=body_r, fill=(18, 18, 24, 255))
    d.rounded_rectangle([0, 0, fw, fh], radius=body_r, outline=(70, 72, 86, 255), width=3)
    # ecran cu colțuri rotunjite
    scr_r = 70
    mask = Image.new("L", (screen_w, screen_h), 0)
    ImageDraw.Draw(mask).rounded_rectangle([0, 0, screen_w, screen_h], radius=scr_r, fill=255)
    phone.paste(ss, (bezel, bezel), mask)
    # dynamic island
    iw, ih = 210, 50
    ix = (fw - iw) // 2
    d.rounded_rectangle([ix, bezel + 22, ix + iw, bezel + 22 + ih], radius=25, fill=(6, 6, 10, 255))
    return phone


def add_shadow(img, offset=(0, 26), blur=44, alpha=165):
    w, h = img.size
    pad = blur * 2
    cv = Image.new("RGBA", (w + pad * 2, h + pad * 2), (0, 0, 0, 0))
    sh = Image.new("RGBA", (w, h), (0, 0, 0, alpha))
    sh.putalpha(img.split()[3].point(lambda p: alpha if p > 0 else 0))
    cv.paste(sh, (pad + offset[0], pad + offset[1]))
    cv = cv.filter(ImageFilter.GaussianBlur(blur))
    cv.paste(img, (pad, pad), img)
    return cv


def draw_text(d, xy, txt, font, fill, shadow=True, sh_off=4, sh_alpha=205):
    x, y = xy
    if shadow:
        for dx, dy in ((sh_off, sh_off), (sh_off - 2, sh_off - 2)):
            d.text((x + dx, y + dy), txt, font=font, fill=(*SHADOW, sh_alpha))
    d.text((x, y), txt, font=font, fill=fill)


def main():
    bg = make_blurred_bg(SHOT, W, H, blur=32, dark=0.50)
    d = ImageDraw.Draw(bg)

    # ---- Headline (hook puternic) ----
    hf = load(F_HEAVY, 138)
    l1, l2 = "CÂT DE ASCUȚIT", "AI OCHIUL?"
    y1 = 150
    y2 = y1 + 150
    for ln, y in ((l1, y1), (l2, y2)):
        x = (W - text_w(d, ln, hf)) // 2
        draw_text(d, (x, y), ln, hf, (*CREAM, 255), sh_off=5)

    # subtitlu auriu
    sf = load(F_BOLD, 44)
    sub = "6 scene pictate · sute de obiecte ascunse"
    sx = (W - text_w(d, sub, sf)) // 2
    draw_text(d, (sx, y2 + 178), sub, sf, (*GOLD, 255), sh_off=3, sh_alpha=180)

    # ---- Telefon cu screenshot REAL ----
    phone = make_phone(SHOT, screen_w=786, crop_top=CROP_TOP, crop_bottom=CROP_BOTTOM)
    phone = add_shadow(phone, offset=(0, 30), blur=50, alpha=170)
    pw, ph = phone.size
    px = (W - pw) // 2
    py = 588
    bg.paste(phone, (px, py), phone)

    # ---- CTA portocaliu ----
    cf = load(F_BOLD, 46)
    cta = "JOACĂ ACUM  →"
    cw = text_w(d, cta, cf) + 96
    chh = 104
    cx = (W - cw) // 2
    cy = py + ph - 92
    # umbră buton
    btn_sh = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    ImageDraw.Draw(btn_sh).rounded_rectangle([cx, cy + 8, cx + cw, cy + chh + 8], radius=chh // 2,
                                             fill=(0, 0, 0, 150))
    bg.alpha_composite(btn_sh.filter(ImageFilter.GaussianBlur(18)))
    d = ImageDraw.Draw(bg)
    d.rounded_rectangle([cx, cy, cx + cw, cy + chh], radius=chh // 2, fill=(*ORANGE, 255))
    d.rounded_rectangle([cx, cy, cx + cw, cy + chh], radius=chh // 2,
                        outline=(255, 200, 150, 120), width=2)
    tx = cx + (cw - text_w(d, cta, cf)) // 2
    d.text((tx, cy + (chh - 58) // 2), cta, font=cf, fill=(255, 255, 255, 255))

    # ---- Bloc brand jos ----
    bf = load(F_HEAVY, 72)
    brand = "OBIECTE ASCUNSE"
    bx = (W - text_w(d, brand, bf)) // 2
    by = H - 360
    # divider auriu fin deasupra brandului
    dl = 190
    dy = by - 54
    d.rectangle([(W - dl) // 2, dy, (W + dl) // 2, dy + 4], fill=(*GOLD, 150))
    draw_text(d, (bx, by), brand, bf, (*CREAM, 255), sh_off=4)
    of = load(F_REG, 40)
    own = "by Summer Smile"
    ox = (W - text_w(d, own, of)) // 2
    draw_text(d, (ox, by + 96), own, of, (222, 228, 242, 255), sh_off=2, sh_alpha=150)

    bg.convert("RGB").save(OUT, "JPEG", quality=94, optimize=True)
    print(f"OK -> {OUT}  ({OUT.stat().st_size // 1024} KB, {W}x{H})")


if __name__ == "__main__":
    main()
