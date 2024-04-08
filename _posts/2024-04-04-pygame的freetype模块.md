---
layout:     post
title:      pygame的freetype模块
subtitle:   
date:       2024-04-04
author:     Kody Black
header-img: img/post-bg-normal.jpg
catalog: true
tags:
    - cv
---

- [pygame.freetype — pygame v2.6.0 documentation](https://www.pygame.org/docs/ref/freetype.html)
- [Freetype - Pygame - W3cubDocs](https://docs.w3cub.com/pygame/ref/freetype.html#pygame.freetype.Font.rotation)

主要参考上面两篇文档，给出自己的一些理解和demo

## 基础知识

在绘制图形中，会涉及到三个变量单位：

- 字体大小：英文中的字号大小是指的点数“point”，它是一个绝对的单位，等于 1/72 英寸（inch），缩写是pt，中文翻译是“磅”
- resolution：Pixel resolution in dots per inch（即所谓的DPI，每英寸的像素数，笼统来说，DPI越大，分辨率越高）
- 图片像素：Pixel

那么一个字符的字体大小为`x(pt)`，图片DPI为`k`，则该字符的像素为：`x/72*k`

## DEMO

```
import pygame
from pygame import freetype
import random

# 初始化pygame
pygame.init()

# 验证码设置
captcha_text = "A1DTQ"

# 这里font_size的单位是pt
font_size = 200
background_color = (255, 255, 255)
font_color = (0, 0, 0)
bbs_color = (0, 255, 0)

pygame.freetype.init()
font = freetype.Font("./NotoSansSC[wght].ttf", font_size, resolution=144)
# antialiased=True表示使用抗锯齿
font.antialiased = True
# font.origin = True
# 下滑线概率
underline_prob = 0
# 粗体概率
strong_prob = 0.5
# 旋转概率
rotate_prob = 0.5
# 字符间距
spacing = font_size//4

# 计算画布大小并生成背景图层
width = sum([font.get_rect(char).width + spacing for char in captcha_text])*1.5
height = font.get_rect(captcha_text).height * 1.5
font_surf = pygame.Surface((width, height))
font_surf.fill(background_color)

# 依次绘制文本
now_x = 0
now_y = 0
bbs = []
for char in captcha_text:
    if random.random() < strong_prob:
        font.strong = True
    else:
        font.strong = False
    if random.random() < underline_prob:
        font.underline = True
    else:
        font.underline = False
    if random.random() < rotate_prob:
        rect = font.render_to(font_surf, (now_x, now_y), char, font_color, rotation=random.randint(-20, 20))
    else:
        rect = font.render_to(font_surf, (now_x, now_y), char, font_color)
    bbs.append([now_x, now_y, rect.width, rect.height])
    now_x += rect.width + spacing
# 绘制边框
for bb in bbs:
    pygame.draw.rect(font_surf, bbs_color, bb, 1)

# 裁剪图像
left = 0
top = 0
right = max([bb[0] + bb[2] for bb in bbs])
bottom = max([bb[1] + bb[3] for bb in bbs])
font_surf = font_surf.subsurface((left, top, right-left, bottom-top))

pygame.image.save(font_surf, "demo.png")
```

