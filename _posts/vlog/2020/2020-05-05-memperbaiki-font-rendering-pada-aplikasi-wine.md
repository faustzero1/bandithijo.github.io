---
layout: 'post'
title: 'Memperbaiki Font Rendering yang Jelek pada Aplikasi di dalam Wine'
date: 2020-05-05
permalink: '/vlog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'vlog'
tags: ['Tips', 'Ulasan']
pin:
voice: true
---

<div style="margin-top:30px;"></div>

{% include youtube_embed.html id="bxM07O3Glvs" %}

# Deskripsi

Pada video dokumentasi kali ini saya bercerita tentang bagaimana saya dalam memperbaiki font rendering yang jelek (ugly) pada aplikasi yang ada di dalam Wine container.


**FontSmooth.reg**

```
REGEDIT4

[HKEY_CURRENT_USER\Control Panel\Desktop]
"FontSmoothing"="2"
"FontSmoothingType"=dword:00000002
"FontSmoothingGamma"=dword:00000578
"FontSmoothingOrientation"=dword:00000001
```
