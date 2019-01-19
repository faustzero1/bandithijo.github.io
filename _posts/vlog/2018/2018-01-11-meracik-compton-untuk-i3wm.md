---
layout: 'post'
title: 'Mencoba Meracik Compton pada i3 Window Manager'
date: 2018-01-11
permalink: '/vlog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'vlog'
tags: ['I3WM', 'Tips']
pin:
---

<div style="margin-top:30px;"></div>

{% youtube K2YnH-hsRRQ %}

# Deskripsi

Mencoba meracik Compton pada i3 window manager.

Sejauh saya menggunakan Window Manager yang bernama i3wm, saya baru mencoba menggunakan dua window compositor yang bernama Xcompmgr & Compton.

Sebelumnya, saya menggunakan Xcompmgr, menurut saya lebih praktis saja, tanpa harus banyak melakukan knfigurasi sana sini, sudah dapat menikmati efek transparant. Hanya saja saya tidak paham apakah pada Xcompmgr dapat membuat shadow pada floating window atau tidak. Karena, lama-lama kangen juga lihat efek shadow di bawah floating window, lantas saya mencoba beralih menggunakan Compton window compositor.

Permasalahan lain adalah, terkadang konfigurasi window compositor yang tidak pas dengan hardware dapat menyebabkan flickering pada hasil screencasting.

Berikut hasil testing screencasting setelah dipasang Compton window compositor.

Final result :
```
backend = xrender
fade = off
```

Background music:

[ISYANA SARASVATI - Adventure Of A Lifetime (COLDPLAY COVER LIVE) at Ruang Tengah Prambors](https://youtu.be/fmJ3wv9Eyy8){:target="_blank"}
