"""Generate polished USDQuest app icons (NVIDIA-green isometric cube)."""
import math
from PIL import Image, ImageDraw, ImageFilter

OUT = "C:/claude-exp/usd-quest"
S = 1024  # master render size, downscaled for crispness

def lerp(a, b, t): return tuple(int(a[i] + (b[i] - a[i]) * t) for i in range(3))

def render(master_size, padding_frac):
    img = Image.new("RGBA", (master_size, master_size), (0, 0, 0, 0))

    # --- rounded-rect background with vertical green gradient ---
    grad = Image.new("RGBA", (master_size, master_size), (0, 0, 0, 255))
    gp = grad.load()
    top, bot = (118, 185, 0), (40, 71, 0)  # NVIDIA green -> deep green
    for y in range(master_size):
        c = lerp(top, bot, y / master_size)
        for x in range(master_size):
            gp[x, y] = (c[0], c[1], c[2], 255)
    mask = Image.new("L", (master_size, master_size), 0)
    md = ImageDraw.Draw(mask)
    r = int(master_size * 0.235)  # iOS-ish squircle radius
    md.rounded_rectangle([0, 0, master_size - 1, master_size - 1], radius=r, fill=255)
    img.paste(grad, (0, 0), mask)

    # subtle top sheen
    sheen = Image.new("RGBA", (master_size, master_size), (0, 0, 0, 0))
    sd = ImageDraw.Draw(sheen)
    sd.ellipse([-master_size*0.25, -master_size*0.55, master_size*1.25, master_size*0.5],
               fill=(255, 255, 255, 38))
    img.alpha_composite(Image.composite(sheen, Image.new("RGBA", img.size, (0,0,0,0)), mask))

    # --- isometric cube ---
    cx, cy = master_size / 2, master_size / 2 + master_size * 0.01
    R = master_size * (0.5 - padding_frac) * 0.92      # vertical half-height
    W = R * math.cos(math.radians(30))                  # horizontal half-width

    A = (cx,     cy - R)        # top
    B = (cx + W, cy - R / 2)    # upper right
    C = (cx + W, cy + R / 2)    # lower right
    D = (cx,     cy + R)        # bottom
    E = (cx - W, cy + R / 2)    # lower left
    F = (cx - W, cy - R / 2)    # upper left
    M = (cx,     cy)            # center

    # soft drop shadow under the cube
    sh = Image.new("RGBA", (master_size, master_size), (0, 0, 0, 0))
    shd = ImageDraw.Draw(sh)
    shd.ellipse([cx - W*0.9, D[1] - R*0.18, cx + W*0.9, D[1] + R*0.22], fill=(0, 0, 0, 90))
    sh = sh.filter(ImageFilter.GaussianBlur(master_size * 0.02))
    img.alpha_composite(sh)

    top_face   = (255, 255, 255, 255)   # bright top
    left_face  = (214, 245, 168, 255)   # light green
    right_face = (168, 224, 96, 255)    # mid green
    edge       = (60, 90, 0, 90)

    d = ImageDraw.Draw(img)
    d.polygon([A, B, M, F], fill=top_face)     # top
    d.polygon([F, M, D, E], fill=left_face)    # left
    d.polygon([B, C, D, M], fill=right_face)   # right
    for poly in ([A, B, M, F], [F, M, D, E], [B, C, D, M]):
        d.line(poly + [poly[0]], fill=edge, width=max(2, int(master_size*0.004)))
    # inner edges for crisp cube definition
    d.line([A, M], fill=edge, width=max(2, int(master_size*0.004)))
    d.line([M, D], fill=edge, width=max(2, int(master_size*0.004)))

    return img

def save(img, size, name):
    img.resize((size, size), Image.LANCZOS).save(f"{OUT}/{name}")
    print("wrote", name, size)

# Standard icon (a little padding) for favicon / web
base = render(S, 0.16)
save(base, 512, "icon-512.png")
save(base, 192, "icon-192.png")
save(base, 32,  "favicon-32.png")

# Maskable / apple-touch icon: more padding so the cube survives circular masks
masked = render(S, 0.22)
save(masked, 512, "icon-512-maskable.png")
save(masked, 180, "apple-touch-icon.png")
print("done")
