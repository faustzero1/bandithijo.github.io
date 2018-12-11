---
layout: 'post'
title: 'Testing Flickering Screen'
date: 2018-11-27
permalink: '/vlog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'vlog'
tags:
pin:
---

<div style="margin-top:30px;"></div>

{% youtube SEkwoLCFXNI %}

# Deskripsi

Karena mengganti backend compton menjadi "glx" sehingga menyebabkan saya kembali menikmati flickering screen. nyoba2 kembali ke DRI "2" dengan accelmethod "uxa" dan tearfree "true".

Konfigurasi yang saya gunakan adalah.

```
$ sudo vim /etc/X11/xorg.conf.d/20-intel.conf
```
```
Section "Device"
  Identifier  "Intel Graphics"
  Driver      "intel"
  Option      "DRI"           "2"
  Option      "AccelMethod"   "uxa" # fallback
  Option      "TearFree"      "true"
EndSection
```
Berikut saya tampilkan keterangan dari laptop yang saya gunakan.

```
OS: Arch Linux 
Kernel: x86_64 Linux 4.19.4-arch1-1-ARCH
Uptime: 2d 14h 53m
Packages: 2328
Shell: zsh 5.6.2
Resolution: 1366x768
WM: i3
GTK Theme: NumixSolarizedDarkYellow [GTK2/3]
Icon Theme: DarK-Dark
Font: Hack 9
CPU: Intel Core i5-6300U @ 4x 3GHz [51.0°C]
GPU: Mesa DRI Intel(R) HD Graphics 520 (Skylake GT2) 
RAM: 3437MiB / 7831MiB
```

Biar objektif, coba bantu lihatin, masih ada flickering screen ndak?
