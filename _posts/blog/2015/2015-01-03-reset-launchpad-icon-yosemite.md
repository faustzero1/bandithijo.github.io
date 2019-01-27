---
layout: 'post'
title: 'Mereset Launchpad Icon Sesuai Abjad pada OSX Yosemite'
date: 2015-01-03
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['OSX', 'Tips']
pin:
---

<p class="notif-post">Post ini sudah tidak up to date !</p>

<img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="https://s20.postimg.cc/pm0zdqf0t/Default_Header_Template_Post_7.jpg" alt="banner">

# Latar Belakang
Sudah mengupgrade OS X anda dengan OS X Yosemite 10.10 ?

Ya, terdapat fitur untuk memudahkan pengguna mencari aplikasi yang dibutuhkan dengan menampilkan seluruh icon aplikasi secara fullscreen. Fitur ini disebut dengan "Launchpad".

Launchpad pada OS X Yosemite ini benar-benar sangat memudah kita sebagai user OS X untuk mencari aplikasi yang akan kita gunakan. Dibandingakan dengan tidak menggunakan Launchpad, kita harus membuka folder "Applications" dan mencari aplikasi yang akan kita butuhkan. Sungguh merepotkan mencari diantara banyak icon aplikasi dalam folder Applications.

Launchpad dapat dijalankan dengan menekan tombol <kbd>F4</kbd> pada keyboard Apple, atau dengan gesture pada trackpad (tentunya setelah melakukan setting pada **System Preferences  > Trackpad**). saya pribadi mengunakan gesture "**_Pinch with thumb and three fingers_**" dan tombol <kbd>F4</kbd>, tergantung kebutuhan dan posisi tangan kanan saya sedang pada mouse atau pada trackpad.

Namun, terkadang deretan aplikasi yang terdapat pada Launchpad benar-benar sangat berantakan dan tidak sesuai dengan abjad, sehingga kita pun lagi-lagi harus mencari diantar banyak icon aplikasi.

Untuk mengatasi hal ini, sampai tulisan ini dibuat, saya pribadi belum mencari kembali ada atau tidaknya pihak ketiga yang membuat aplikasi untuk mengatur susunan icon aplikasi pada Launchpad. Sedangkan Apple sendiri tidak menyediakan preferences untuk ini. Bisa dikatakan hal yang sangat konyol.

Saya akan memberikan tips, bagaimana agar susunan icon aplikasi pada Launchpad berurutan sesuai abjad.

# Step by Step
1. Buka Terminal, dan salin kode dibawah, salin perbaris dan tekan <kbd>Return</kbd>
```
$ defaults write com.apple.dock ResetLaunchPad -bool true
$ killall Dock
```
2. Dock akan ter-Refresh dan saat anda menekan <kbd>F4</kbd> atau melakukan gesture pada trackpad, Launchpad masih akan "Loading applications..."
3. Tunggu hingga Launchpad selesai merefresh aplikasi.

# Kesimpulan
Menurut saya, Apple mempunyai alasan tidak begitu mementingakan susunan icon aplikasi pada Launchpad, begitu juga programmer / developer pihak ketiga. Ini disebabkan oleh sudah  cukup powerfulnya aplikasi Spotlight yang mempunyai kemampuan seperti aplikasi Alfred.

Kemampuan dan powerful-nya Spotlight pada OS X Yosemite ini akan saya bahas lain waktu.
