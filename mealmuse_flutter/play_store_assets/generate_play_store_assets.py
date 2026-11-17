#!/usr/bin/env python3
"""
Meal Muse - Google Play Store Asset Generator
Generates:
1. App Icon: 512x512 px (32-bit PNG)
2. Feature Graphic: 1024x500 px (24-bit PNG, no alpha)
3. Phone Screenshots: 1080x1920 px (9:16 aspect ratio, 4 screens)
4. 7-inch Tablet Screenshots: 1200x1920 px (10:16 aspect ratio, 4 screens)
5. 10-inch Tablet Screenshots: 2560x1600 px (16:10 landscape, 4 screens)
"""

import sys
import os
import shutil
from PyQt5.QtWidgets import QApplication
from PyQt5.QtGui import (
    QImage, QPainter, QColor, QFont, QPen, QBrush,
    QLinearGradient, QRadialGradient, QPainterPath, QFontMetrics
)
from PyQt5.QtCore import Qt, QRectF, QPointF

# Initialize headless Qt Application
app = QApplication(['play_store_gen', '-platform', 'offscreen'])

ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
FLUTTER_DIR = os.path.join(ROOT_DIR, 'mealmuse_flutter')
ASSETS_DIR = os.path.join(FLUTTER_DIR, 'assets')
OUTPUT_DIR = os.path.join(ROOT_DIR, 'play_store_assets')

ICON_SRC = os.path.join(ASSETS_DIR, 'icons8-food-100.png')
SCREEN_SRCS = [
    os.path.join(FLUTTER_DIR, f'flutter_0{i}.png') for i in range(1, 5)
]

DIRS = {
    'icon': os.path.join(OUTPUT_DIR, 'icon'),
    'feature': os.path.join(OUTPUT_DIR, 'feature_graphic'),
    'phone': os.path.join(OUTPUT_DIR, 'phone'),
    'tablet_7': os.path.join(OUTPUT_DIR, 'tablet_7inch'),
    'tablet_10': os.path.join(OUTPUT_DIR, 'tablet_10inch'),
}
for d in DIRS.values():
    os.makedirs(d, exist_ok=True)

# Brand Color Palette
COLOR_PRIMARY = QColor(229, 57, 53)       # #E53935 Vibrant Food Red
COLOR_PRIMARY_DARK = QColor(198, 40, 40)  # #C62828 Deep Red
COLOR_CORAL = QColor(255, 107, 107)       # #FF6B6B Soft Coral
COLOR_PEACH_LIGHT = QColor(255, 245, 242) # #FFF5F2 Soft Peach Tint
COLOR_BG_TOP = QColor(255, 253, 252)      # #FFFDFC
COLOR_BG_BOTTOM = QColor(255, 237, 233)   # #FFEDE9
COLOR_TEXT_TITLE = QColor(26, 29, 32)     # #1A1D20 Dark Slate
COLOR_TEXT_SUB = QColor(95, 100, 108)     # #5F646C Neutral Grey
COLOR_PILL_BG = QColor(255, 236, 234)     # #FFECE9 Soft Tint
COLOR_PILL_BORDER = QColor(255, 205, 210) # #FFCDD2
COLOR_PILL_TEXT = QColor(211, 47, 47)     # #D32F2F Accent
COLOR_PHONE_BEZEL = QColor(22, 23, 28)    # Sleek dark phone body
COLOR_PHONE_BORDER = QColor(58, 60, 72)   # Subtle outer highlight


def crop_screen(screen_img):
    """
    Crops out the Android notification/status bar (top ~105px)
    and the Android 3-button navigation bar (bottom from y=2210).
    Preserves the full app UI including bottom navigation bar.
    """
    crop_top = 105
    crop_bottom = 2210
    w = screen_img.width()
    h = crop_bottom - crop_top
    return screen_img.copy(0, crop_top, w, h)


def draw_clean_status_bar(painter, rect, is_dark_mode=False):
    """Draws a crisp minimalist status bar (12:00, Wi-Fi, 5G, Battery)."""
    text_color = QColor(255, 255, 255) if is_dark_mode else QColor(35, 35, 35)
    painter.save()
    painter.setPen(text_color)
    
    # Time "12:00"
    font = QFont('Open Sans', int(rect.height() * 0.38))
    font.setBold(True)
    painter.setFont(font)
    painter.drawText(QRectF(rect.x() + 26, rect.y() + 4, 100, rect.height() - 4), Qt.AlignVCenter | Qt.AlignLeft, "12:00")
    
    # Icons on the right
    rx = rect.x() + rect.width() - 115
    cy = rect.y() + rect.height() / 2 + 2
    
    # 5G text
    font_sm = QFont('Open Sans', int(rect.height() * 0.28))
    font_sm.setBold(True)
    painter.setFont(font_sm)
    painter.drawText(QRectF(rx, rect.y() + 4, 34, rect.height() - 4), Qt.AlignVCenter | Qt.AlignCenter, "5G")
    
    # Wi-Fi icon
    painter.setRenderHint(QPainter.Antialiasing, True)
    pen = QPen(text_color, 1.8)
    pen.setCapStyle(Qt.RoundCap)
    painter.setPen(pen)
    painter.setBrush(Qt.NoBrush)
    
    wifi_x = rx + 40
    painter.drawArc(QRectF(wifi_x, cy - 8, 16, 16), 45 * 16, 90 * 16)
    painter.drawArc(QRectF(wifi_x + 3, cy - 5, 10, 10), 45 * 16, 90 * 16)
    painter.drawPoint(QPointF(wifi_x + 8, cy + 3))
    
    # Battery icon
    bat_x = wifi_x + 24
    painter.setPen(QPen(text_color, 1.5))
    painter.drawRoundedRect(QRectF(bat_x, cy - 6, 22, 12), 2.5, 2.5)
    painter.fillRect(QRectF(bat_x + 22, cy - 3, 2.5, 6), text_color)
    painter.fillRect(QRectF(bat_x + 2.5, cy - 3.5, 17, 7), text_color)
    
    painter.restore()


def draw_device_mockup(painter, screen_img, dest_rect, corner_radius=38, bezel=12, punch_hole=True):
    """
    Renders a realistic modern smartphone/tablet frame with ambient shadow,
    sleek bezel, punch-hole camera, clean status bar, and fitted app screen.
    """
    painter.save()
    painter.setRenderHint(QPainter.Antialiasing, True)
    painter.setRenderHint(QPainter.SmoothPixmapTransform, True)
    
    # 1. Multi-layer ambient drop shadow
    for i in range(1, 8):
        shadow_path = QPainterPath()
        offset_y = i * 4.5
        spread = i * 3.5
        shadow_rect = QRectF(
            dest_rect.x() - spread,
            dest_rect.y() - spread + offset_y,
            dest_rect.width() + spread * 2,
            dest_rect.height() + spread * 2
        )
        shadow_path.addRoundedRect(shadow_rect, corner_radius + spread * 0.8, corner_radius + spread * 0.8)
        alpha = int(24 - i * 2.8)
        painter.fillPath(shadow_path, QColor(0, 0, 0, max(alpha, 2)))
    
    # 2. Outer phone frame / chassis
    chassis_path = QPainterPath()
    chassis_path.addRoundedRect(dest_rect, corner_radius, corner_radius)
    painter.fillPath(chassis_path, COLOR_PHONE_BEZEL)
    
    # Chassis subtle highlight border
    painter.setPen(QPen(COLOR_PHONE_BORDER, 2))
    painter.drawPath(chassis_path)
    
    # 3. Inner Screen Area
    screen_rect = QRectF(
        dest_rect.x() + bezel,
        dest_rect.y() + bezel,
        dest_rect.width() - bezel * 2,
        dest_rect.height() - bezel * 2
    )
    screen_radius = max(corner_radius - bezel * 0.8, 14)
    
    screen_clip = QPainterPath()
    screen_clip.addRoundedRect(screen_rect, screen_radius, screen_radius)
    
    painter.save()
    painter.setClipPath(screen_clip)
    
    # Fill screen base white
    painter.fillRect(screen_rect, QColor(255, 255, 255))
    
    # Status bar area
    status_h = 42
    status_rect = QRectF(screen_rect.x(), screen_rect.y(), screen_rect.width(), status_h)
    
    # Draw screen content below status bar
    content_rect = QRectF(
        screen_rect.x(),
        screen_rect.y() + status_h,
        screen_rect.width(),
        screen_rect.height() - status_h
    )
    
    cropped = crop_screen(screen_img)
    painter.drawImage(content_rect, cropped)
    
    # Draw clean status bar over screen
    draw_clean_status_bar(painter, status_rect)
    
    # 4. Punch hole front camera
    if punch_hole:
        cam_size = 13
        cam_x = screen_rect.x() + screen_rect.width() / 2 - cam_size / 2
        cam_y = screen_rect.y() + status_h / 2 - cam_size / 2 + 1
        painter.setPen(Qt.NoPen)
        painter.setBrush(QColor(10, 10, 15))
        painter.drawEllipse(QRectF(cam_x, cam_y, cam_size, cam_size))
        painter.setBrush(QColor(30, 45, 75))
        painter.drawEllipse(QRectF(cam_x + 3.5, cam_y + 3.5, 4.5, 4.5))
    
    painter.restore() # restore screen clip
    painter.restore() # restore device painter


def draw_marketing_header(painter, width, badge_text, title_text, sub_text, y_start=70):
    """Draws the top marketing banner: badge, headline, and subtitle."""
    painter.save()
    painter.setRenderHint(QPainter.Antialiasing, True)
    painter.setRenderHint(QPainter.TextAntialiasing, True)
    
    # 1. Badge Pill with automatic text measurement
    badge_font = QFont('Open Sans', 18)
    badge_font.setBold(True)
    painter.setFont(badge_font)
    fm_badge = QFontMetrics(badge_font)
    text_w = fm_badge.horizontalAdvance(badge_text)
    
    badge_w = text_w + 44
    badge_h = 44
    badge_x = (width - badge_w) / 2
    badge_y = y_start
    badge_rect = QRectF(badge_x, badge_y, badge_w, badge_h)
    
    painter.setPen(QPen(COLOR_PILL_BORDER, 1.5))
    painter.setBrush(COLOR_PILL_BG)
    painter.drawRoundedRect(badge_rect, 22, 22)
    
    painter.setPen(COLOR_PILL_TEXT)
    painter.drawText(badge_rect, Qt.AlignCenter, badge_text)
    
    # 2. Headline Title
    title_font = QFont('Open Sans', 44)
    title_font.setBold(True)
    painter.setFont(title_font)
    painter.setPen(COLOR_TEXT_TITLE)
    
    title_rect = QRectF(40, badge_y + 54, width - 80, 68)
    painter.drawText(title_rect, Qt.AlignCenter, title_text)
    
    # 3. Subtitle
    sub_font = QFont('Open Sans', 22)
    painter.setFont(sub_font)
    painter.setPen(COLOR_TEXT_SUB)
    
    sub_rect = QRectF(50, badge_y + 126, width - 100, 58)
    painter.drawText(sub_rect, Qt.AlignCenter | Qt.TextWordWrap, sub_text)
    
    painter.restore()


# ==============================================================================
# 1. APP ICON (512 x 512 px)
# ==============================================================================
def generate_app_icons():
    print("Generating App Icons...")
    icon_src = QImage(ICON_SRC)
    
    # 1A. Transparent 512x512 PNG
    img_trans = QImage(512, 512, QImage.Format_ARGB32_Premultiplied)
    img_trans.fill(QColor(0, 0, 0, 0))
    p = QPainter(img_trans)
    p.setRenderHint(QPainter.Antialiasing, True)
    p.setRenderHint(QPainter.SmoothPixmapTransform, True)
    
    target_rect = QRectF(61, 61, 390, 390)
    p.drawImage(target_rect, icon_src)
    p.end()
    
    trans_path = os.path.join(DIRS['icon'], 'app_icon_512x512.png')
    img_trans.save(trans_path, 'PNG')
    print(f"Saved: {trans_path}")
    
    # 1B. Full-bleed Branded 512x512 PNG
    img_branded = QImage(512, 512, QImage.Format_ARGB32)
    p = QPainter(img_branded)
    p.setRenderHint(QPainter.Antialiasing, True)
    p.setRenderHint(QPainter.SmoothPixmapTransform, True)
    
    bg_grad = QRadialGradient(256, 256, 320)
    bg_grad.setColorAt(0.0, QColor(255, 255, 255))
    bg_grad.setColorAt(0.7, QColor(255, 246, 243))
    bg_grad.setColorAt(1.0, QColor(255, 234, 229))
    p.fillRect(QRectF(0, 0, 512, 512), bg_grad)
    
    p.setPen(QPen(QColor(229, 57, 53, 30), 2))
    p.setBrush(Qt.NoBrush)
    p.drawEllipse(QPointF(256, 256), 238, 238)
    
    p.drawImage(target_rect, icon_src)
    p.end()
    
    branded_path = os.path.join(DIRS['icon'], 'app_icon_branded_512x512.png')
    img_branded.save(branded_path, 'PNG')
    print(f"Saved: {branded_path}")


# ==============================================================================
# 2. FEATURE GRAPHIC (1024 x 500 px)
# ==============================================================================
def generate_feature_graphic():
    print("Generating Feature Graphic (1024 x 500)...")
    width, height = 1024, 500
    
    img = QImage(width, height, QImage.Format_RGB32)
    p = QPainter(img)
    p.setRenderHint(QPainter.Antialiasing, True)
    p.setRenderHint(QPainter.SmoothPixmapTransform, True)
    p.setRenderHint(QPainter.TextAntialiasing, True)
    
    # 1. Warm Appetizing Gradient
    bg_grad = QLinearGradient(0, 0, width, height)
    bg_grad.setColorAt(0.0, QColor(229, 57, 53))    # #E53935
    bg_grad.setColorAt(0.55, QColor(211, 47, 47))  # #D32F2F
    bg_grad.setColorAt(1.0, QColor(183, 28, 28))   # #B71C1C
    p.fillRect(QRectF(0, 0, width, height), bg_grad)
    
    # 2. Subtle background circles
    p.setPen(Qt.NoPen)
    p.setBrush(QColor(255, 255, 255, 12))
    p.drawEllipse(QPointF(150, 480), 260, 260)
    p.drawEllipse(QPointF(850, 50), 220, 220)
    p.drawEllipse(QPointF(520, -40), 180, 180)
    
    # 3. Left Section: Branding & Copy (x = 60 to 480)
    left_x = 60
    
    # App Icon Squircle Badge
    icon_badge_rect = QRectF(left_x, 50, 68, 68)
    badge_path = QPainterPath()
    badge_path.addRoundedRect(icon_badge_rect, 17, 17)
    p.fillPath(badge_path, QColor(255, 255, 255))
    
    icon_src = QImage(ICON_SRC)
    p.drawImage(QRectF(left_x + 9, 59, 50, 50), icon_src)
    
    # App Name "Meal Muse"
    title_font = QFont('Open Sans', 36)
    title_font.setBold(True)
    p.setFont(title_font)
    p.setPen(QColor(255, 255, 255))
    p.drawText(QRectF(left_x + 82, 50, 320, 42), Qt.AlignVCenter | Qt.AlignLeft, "Meal Muse")
    
    # App Category Subheader
    cat_font = QFont('Open Sans', 11)
    cat_font.setBold(True)
    p.setFont(cat_font)
    p.setPen(QColor(255, 218, 214))
    p.drawText(QRectF(left_x + 84, 95, 320, 20), Qt.AlignVCenter | Qt.AlignLeft, "KENYAN & GLOBAL RECIPE COMPANION")
    
    # Hero Tagline with generous height to prevent any descender clipping
    hero_font = QFont('Open Sans', 23)
    hero_font.setBold(True)
    p.setFont(hero_font)
    p.setPen(QColor(255, 255, 255))
    p.drawText(QRectF(left_x, 142, 450, 105), Qt.AlignLeft | Qt.TextWordWrap, "Delicious Recipes &\nSmart Meal Planning")
    
    # Descriptive Subtitle
    body_font = QFont('Open Sans', 14)
    p.setFont(body_font)
    p.setPen(QColor(255, 235, 232))
    desc_text = "Tailored daily suggestions for breakfast, lunch, and supper with easy step-by-step instructions."
    p.drawText(QRectF(left_x, 255, 450, 65), Qt.AlignLeft | Qt.TextWordWrap, desc_text)
    
    # Feature Pill Badges (Two on first row, one on second row for perfect breathing room)
    pills_row1 = ["✦ Curated Dishes", "✦ Smart Schedule"]
    pill_font = QFont('Open Sans', 12)
    pill_font.setBold(True)
    p.setFont(pill_font)
    fm_p = QFontMetrics(pill_font)
    
    pill_x = left_x
    pill_y = 338
    for pill in pills_row1:
        pw = fm_p.horizontalAdvance(pill) + 26
        pill_rect = QRectF(pill_x, pill_y, pw, 32)
        p.setPen(QPen(QColor(255, 255, 255, 60), 1))
        p.setBrush(QColor(255, 255, 255, 35))
        p.drawRoundedRect(pill_rect, 16, 16)
        p.setPen(QColor(255, 255, 255))
        p.drawText(pill_rect, Qt.AlignCenter, pill)
        pill_x += pw + 12
        
    # Second row badge
    pill3 = "✦ Easy Step-by-Step Cooking"
    pw3 = fm_p.horizontalAdvance(pill3) + 26
    pill3_rect = QRectF(left_x, pill_y + 40, pw3, 32)
    p.setPen(QPen(QColor(255, 255, 255, 60), 1))
    p.setBrush(QColor(255, 255, 255, 35))
    p.drawRoundedRect(pill3_rect, 16, 16)
    p.setPen(QColor(255, 255, 255))
    p.drawText(pill3_rect, Qt.AlignCenter, pill3)
        
    # 4. Right Section: Overlapping Modern Phone Mockups
    # Mockup 1 (Background Phone: Schedule Screen flutter_03)
    screen_schedule = QImage(SCREEN_SRCS[2])
    draw_device_mockup(
        p, screen_schedule,
        QRectF(780, 50, 220, 440),
        corner_radius=24, bezel=7, punch_hole=True
    )
    
    # Mockup 2 (Foreground Phone: Home Screen flutter_01)
    screen_home = QImage(SCREEN_SRCS[0])
    draw_device_mockup(
        p, screen_home,
        QRectF(585, 75, 230, 455),
        corner_radius=26, bezel=8, punch_hole=True
    )
    
    # Floating highlights badge on foreground mockup
    badge_rect = QRectF(535, 375, 175, 42)
    b_path = QPainterPath()
    b_path.addRoundedRect(badge_rect, 21, 21)
    p.fillPath(b_path, QColor(255, 255, 255))
    p.setPen(QPen(QColor(229, 57, 53, 40), 1.5))
    p.drawPath(b_path)
    
    p.setPen(QColor(229, 57, 53))
    b_font = QFont('Open Sans', 13)
    b_font.setBold(True)
    p.setFont(b_font)
    p.drawText(badge_rect, Qt.AlignCenter, "★ 100% Free & Fast")
    
    p.end()
    
    fg_path = os.path.join(DIRS['feature'], 'feature_graphic_1024x500.png')
    img.save(fg_path, 'PNG')
    print(f"Saved: {fg_path}")


# ==============================================================================
# 3. REDESIGNED PHONE SCREENSHOTS (1080 x 1920 px)
# ==============================================================================
PHONE_DATA = [
    {
        'file': 'phone_01_discover_recipes.png',
        'src_idx': 0,
        'badge': 'CURATED DISHES',
        'title': 'Discover Trending Recipes',
        'sub': 'Explore mouthwatering cuisines & everyday Kenyan favorites',
    },
    {
        'file': 'phone_02_smart_search.png',
        'src_idx': 1,
        'badge': 'SMART SEARCH',
        'title': 'Find Exactly What You Crave',
        'sub': 'Filter by dietary preference, ingredients & preparation time',
    },
    {
        'file': 'phone_03_meal_schedule.png',
        'src_idx': 2,
        'badge': 'MEAL PLANNER',
        'title': 'Plan Your Weekly Meals',
        'sub': 'Easily organize breakfast, lunch & supper in advance',
    },
    {
        'file': 'phone_04_saved_recipes.png',
        'src_idx': 3,
        'badge': 'FAVORITES',
        'title': 'Save Your Go-To Recipes',
        'sub': 'Instant access to your personalized culinary collection',
    },
]

def generate_phone_screenshots():
    print("Generating Phone Screenshots (1080 x 1920)...")
    width, height = 1080, 1920
    
    for item in PHONE_DATA:
        img = QImage(width, height, QImage.Format_ARGB32)
        p = QPainter(img)
        p.setRenderHint(QPainter.Antialiasing, True)
        p.setRenderHint(QPainter.SmoothPixmapTransform, True)
        p.setRenderHint(QPainter.TextAntialiasing, True)
        
        # Soft warm vertical gradient
        bg_grad = QLinearGradient(0, 0, 0, height)
        bg_grad.setColorAt(0.0, COLOR_BG_TOP)
        bg_grad.setColorAt(0.4, COLOR_PEACH_LIGHT)
        bg_grad.setColorAt(1.0, COLOR_BG_BOTTOM)
        p.fillRect(QRectF(0, 0, width, height), bg_grad)
        
        p.setPen(Qt.NoPen)
        p.setBrush(QColor(229, 57, 53, 10))
        p.drawEllipse(QPointF(width - 50, 150), 300, 300)
        p.drawEllipse(QPointF(50, height - 200), 250, 250)
        
        # Top Marketing Copy
        draw_marketing_header(p, width, item['badge'], item['title'], item['sub'], y_start=70)
        
        # Proportioned Phone Device Mockup
        mockup_w = 716
        bezel = 12
        screen_w = mockup_w - bezel * 2       # 692
        status_h = 42
        content_h = int(screen_w * (2105.0 / 1080.0)) # 1348
        screen_h = status_h + content_h                # 1390
        mockup_h = screen_h + bezel * 2               # 1414
        
        mockup_x = (width - mockup_w) / 2             # 182
        mockup_y = 425                                # 425 + 1414 = 1839 (leaves 81px bottom margin)
        
        screen_src = QImage(SCREEN_SRCS[item['src_idx']])
        draw_device_mockup(
            p, screen_src,
            QRectF(mockup_x, mockup_y, mockup_w, mockup_h),
            corner_radius=42, bezel=bezel, punch_hole=True
        )
        
        p.end()
        out_path = os.path.join(DIRS['phone'], item['file'])
        img.save(out_path, 'PNG')
        print(f"Saved: {out_path}")


# ==============================================================================
# 4. 7-INCH TABLET SCREENSHOTS (1200 x 1920 px)
# ==============================================================================
TABLET_7_DATA = [
    {
        'file': 'tablet_7in_01_discover.png',
        'src_idx': 0,
        'badge': '7-INCH TABLET READY',
        'title': 'Discover Trending Recipes',
        'sub': 'Explore mouthwatering dishes & Kenyan favorites on tablet',
    },
    {
        'file': 'tablet_7in_02_search.png',
        'src_idx': 1,
        'badge': 'SMART RECIPE SEARCH',
        'title': 'Find Exactly What You Crave',
        'sub': 'Filter by dietary preference, quick prep & categories',
    },
    {
        'file': 'tablet_7in_03_schedule.png',
        'src_idx': 2,
        'badge': 'MEAL PLANNER',
        'title': 'Plan Your Weekly Meals',
        'sub': 'Schedule breakfast, lunch & supper effortlessly',
    },
    {
        'file': 'tablet_7in_04_saved.png',
        'src_idx': 3,
        'badge': 'SAVED FAVORITES',
        'title': 'Save Your Go-To Recipes',
        'sub': 'Instant access to your personalized recipe collection',
    },
]

def generate_tablet_7_screenshots():
    print("Generating 7-inch Tablet Screenshots (1200 x 1920)...")
    width, height = 1200, 1920
    
    for item in TABLET_7_DATA:
        img = QImage(width, height, QImage.Format_ARGB32)
        p = QPainter(img)
        p.setRenderHint(QPainter.Antialiasing, True)
        p.setRenderHint(QPainter.SmoothPixmapTransform, True)
        p.setRenderHint(QPainter.TextAntialiasing, True)
        
        bg_grad = QLinearGradient(0, 0, 0, height)
        bg_grad.setColorAt(0.0, COLOR_BG_TOP)
        bg_grad.setColorAt(0.5, COLOR_PEACH_LIGHT)
        bg_grad.setColorAt(1.0, COLOR_BG_BOTTOM)
        p.fillRect(QRectF(0, 0, width, height), bg_grad)
        
        p.setPen(Qt.NoPen)
        p.setBrush(QColor(229, 57, 53, 12))
        p.drawEllipse(QPointF(width, 200), 320, 320)
        p.drawEllipse(QPointF(0, height - 300), 280, 280)
        
        # Marketing Header
        draw_marketing_header(p, width, item['badge'], item['title'], item['sub'], y_start=75)
        
        # Tablet Device Mockup
        mockup_w = 750
        bezel = 16
        screen_w = mockup_w - bezel * 2       # 718
        status_h = 42
        content_h = int(screen_w * (2105.0 / 1080.0)) # 1399
        screen_h = status_h + content_h                # 1441
        mockup_h = screen_h + bezel * 2               # 1473
        
        mockup_x = (width - mockup_w) / 2             # 225
        mockup_y = 390                                # 390 + 1473 = 1863 (leaves 57px bottom margin)
        
        screen_src = QImage(SCREEN_SRCS[item['src_idx']])
        draw_device_mockup(
            p, screen_src,
            QRectF(mockup_x, mockup_y, mockup_w, mockup_h),
            corner_radius=36, bezel=bezel, punch_hole=True
        )
        
        p.end()
        out_path = os.path.join(DIRS['tablet_7'], item['file'])
        img.save(out_path, 'PNG')
        print(f"Saved: {out_path}")


# ==============================================================================
# 5. 10-INCH TABLET SCREENSHOTS (2560 x 1600 px Landscape)
# ==============================================================================
TABLET_10_DATA = [
    {
        'file': 'tablet_10in_01_discover.png',
        'src_idx': 0,
        'badge': '10-INCH TABLET EXPERIENCE',
        'headline': 'Discover Delicious Recipes Every Day',
        'sub': 'Tailored to Kenyan cuisine and international favorites, with easy ingredients.',
        'bullets': [
            'Locally tailored recipes with simple pantry ingredients',
            'Full nutritional insights, cook times & serving details',
            'Daily hand-picked breakfast, lunch & supper ideas',
        ]
    },
    {
        'file': 'tablet_10in_02_search.png',
        'src_idx': 1,
        'badge': 'SMART RECIPE SEARCH',
        'headline': 'Find Exactly What You Crave In Seconds',
        'sub': 'Explore curated food categories or search specific ingredients.',
        'bullets': [
            'Filter by Healthy, Vegan, Gluten-free & Italian',
            'Quick recipes prepared in under 30 minutes',
            'Instant search results with complete dish overviews',
        ]
    },
    {
        'file': 'tablet_10in_03_schedule.png',
        'src_idx': 2,
        'badge': 'WEEKLY MEAL PLANNER',
        'headline': 'Effortless Meal Planning For The Week',
        'sub': 'Never stress over what to cook again with our calendar schedule.',
        'bullets': [
            'Intuitive day-by-day meal schedule calendar',
            'Plan meals ahead for yourself and family',
            'Keep grocery prep organized and stress-free',
        ]
    },
    {
        'file': 'tablet_10in_04_saved.png',
        'src_idx': 3,
        'badge': 'PERSONAL COOKBOOK',
        'headline': 'Your Favorite Dishes Always At Hand',
        'sub': 'Bookmark the recipes you love and build your personal go-to cookbook.',
        'bullets': [
            'One-tap saving for quick recipe bookmarking',
            'Quick reference for busy weeknight cooking',
            'Build custom menus for family dinners & events',
        ]
    },
]

def generate_tablet_10_screenshots():
    print("Generating 10-inch Tablet Screenshots (2560 x 1600)...")
    width, height = 2560, 1600
    icon_src = QImage(ICON_SRC)
    
    for item in TABLET_10_DATA:
        img = QImage(width, height, QImage.Format_ARGB32)
        p = QPainter(img)
        p.setRenderHint(QPainter.Antialiasing, True)
        p.setRenderHint(QPainter.SmoothPixmapTransform, True)
        p.setRenderHint(QPainter.TextAntialiasing, True)
        
        bg_grad = QLinearGradient(0, 0, width, height)
        bg_grad.setColorAt(0.0, COLOR_BG_TOP)
        bg_grad.setColorAt(0.6, COLOR_PEACH_LIGHT)
        bg_grad.setColorAt(1.0, COLOR_BG_BOTTOM)
        p.fillRect(QRectF(0, 0, width, height), bg_grad)
        
        p.setPen(Qt.NoPen)
        p.setBrush(QColor(229, 57, 53, 10))
        p.drawEllipse(QPointF(400, 200), 450, 450)
        p.drawEllipse(QPointF(width - 200, height - 300), 500, 500)
        
        # ----------------- LEFT SECTION: Information & Value -----------------
        left_x = 140
        
        # App branding row (Icon + App Title)
        icon_rect = QRectF(left_x, 110, 68, 68)
        b_path = QPainterPath()
        b_path.addRoundedRect(icon_rect, 16, 16)
        p.fillPath(b_path, QColor(255, 255, 255))
        p.setPen(QPen(COLOR_PILL_BORDER, 1.5))
        p.drawPath(b_path)
        p.drawImage(QRectF(left_x + 8, 118, 52, 52), icon_src)
        
        brand_font = QFont('Open Sans', 30)
        brand_font.setBold(True)
        p.setFont(brand_font)
        p.setPen(COLOR_PRIMARY)
        p.drawText(QRectF(left_x + 86, 110, 300, 68), Qt.AlignVCenter | Qt.AlignLeft, "Meal Muse")
        
        # Feature Category Badge Pill
        badge_y = 210
        badge_font = QFont('Open Sans', 17)
        badge_font.setBold(True)
        p.setFont(badge_font)
        fm_badge = QFontMetrics(badge_font)
        bw = fm_badge.horizontalAdvance(item['badge']) + 48
        
        badge_rect = QRectF(left_x, badge_y, bw, 46)
        p.setPen(QPen(COLOR_PILL_BORDER, 1.5))
        p.setBrush(COLOR_PILL_BG)
        p.drawRoundedRect(badge_rect, 23, 23)
        
        p.setPen(COLOR_PILL_TEXT)
        p.drawText(badge_rect, Qt.AlignCenter, item['badge'])
        
        # Big Headline Title (Generous width & height with 42pt font)
        head_font = QFont('Open Sans', 42)
        head_font.setBold(True)
        p.setFont(head_font)
        p.setPen(COLOR_TEXT_TITLE)
        head_rect = QRectF(left_x, badge_y + 66, 1250, 110)
        p.drawText(head_rect, Qt.AlignLeft | Qt.AlignVCenter | Qt.TextWordWrap, item['headline'])
        
        # Subtitle Paragraph
        sub_font = QFont('Open Sans', 24)
        p.setFont(sub_font)
        p.setPen(COLOR_TEXT_SUB)
        sub_rect = QRectF(left_x, badge_y + 195, 1250, 75)
        p.drawText(sub_rect, Qt.AlignLeft | Qt.TextWordWrap, item['sub'])
        
        # Feature Bullet Points
        bullet_y = badge_y + 310
        bullet_font = QFont('Open Sans', 22)
        p.setFont(bullet_font)
        
        for bullet in item['bullets']:
            check_rect = QRectF(left_x, bullet_y + 3, 34, 34)
            p.setPen(Qt.NoPen)
            p.setBrush(COLOR_PRIMARY)
            p.drawEllipse(check_rect)
            
            p.setPen(QColor(255, 255, 255))
            f_check = QFont('Open Sans', 18)
            f_check.setBold(True)
            p.setFont(f_check)
            p.drawText(check_rect, Qt.AlignCenter, "✓")
            
            p.setFont(bullet_font)
            p.setPen(COLOR_TEXT_TITLE)
            p.drawText(QRectF(left_x + 50, bullet_y, 1120, 42), Qt.AlignVCenter | Qt.AlignLeft, bullet)
            
            bullet_y += 72
            
        # Bottom Guarantee/Rating Badge
        guar_text = "★ Tailored for Kenyan & Global Cuisines"
        g_font = QFont('Open Sans', 18)
        g_font.setBold(True)
        p.setFont(g_font)
        fm_g = QFontMetrics(g_font)
        gw = fm_g.horizontalAdvance(guar_text) + 52
        
        guar_rect = QRectF(left_x, bullet_y + 40, gw, 52)
        p.setPen(QPen(QColor(229, 57, 53, 50), 1.5))
        p.setBrush(QColor(255, 255, 255, 220))
        p.drawRoundedRect(guar_rect, 26, 26)
        
        p.setPen(COLOR_PRIMARY_DARK)
        p.drawText(guar_rect, Qt.AlignCenter, guar_text)
        
        # ----------------- RIGHT SECTION: Tablet Mockup -----------------
        mockup_w = 750
        bezel = 16
        screen_w = mockup_w - bezel * 2       # 718
        status_h = 42
        content_h = int(screen_w * (2105.0 / 1080.0)) # 1399
        screen_h = status_h + content_h                # 1441
        mockup_h = screen_h + bezel * 2               # 1473
        
        mockup_x = 1580
        mockup_y = (height - mockup_h) / 2            # vertically centered
        
        screen_src = QImage(SCREEN_SRCS[item['src_idx']])
        draw_device_mockup(
            p, screen_src,
            QRectF(mockup_x, mockup_y, mockup_w, mockup_h),
            corner_radius=40, bezel=bezel, punch_hole=True
        )
        
        p.end()
        out_path = os.path.join(DIRS['tablet_10'], item['file'])
        img.save(out_path, 'PNG')
        print(f"Saved: {out_path}")


def mirror_to_flutter_assets():
    """Mirrors the generated assets into mealmuse_flutter/play_store_assets for convenience."""
    target_dir = os.path.join(FLUTTER_DIR, 'play_store_assets')
    if os.path.exists(target_dir):
        shutil.rmtree(target_dir)
    shutil.copytree(OUTPUT_DIR, target_dir)
    print(f"Mirrored assets to: {target_dir}")


def main():
    print("=== Meal Muse Play Store Asset Generation Starting ===")
    generate_app_icons()
    generate_feature_graphic()
    generate_phone_screenshots()
    generate_tablet_7_screenshots()
    generate_tablet_10_screenshots()
    mirror_to_flutter_assets()
    print("=== All Assets Successfully Generated ===")

if __name__ == '__main__':
    main()
