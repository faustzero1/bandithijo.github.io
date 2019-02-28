---
layout: 'post'
title: 'SLiM, Display Manager yang Sudah Lama Ditinggalkan'
date: 2019-02-28 17:47
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Ulasan', 'Tips']
pin:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Mungkin sebagian dari teman-teman ada yang sudah pernah mencicipi distribusi sistem operasi GNU/Linux yang menggunakan SLiM display manager.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/JzS4m67p/gambar-01.png"}
<p class="img-caption">Gambar 1 - SLiM display manager dengan default theme</p>

Dari informasi yang saya baca pada halaman [Arch Wiki/SLiM](https://wiki.archlinux.org/index.php/SLiM#Match_SLiM_and_Desktop_Wallpaper){:target="_blank"}. Proyek ini sudah ditinggalkan. Rilis paling akhir pada tahun 2013. Website dari proyek inipun sudah tidak ada lagi.

Pada halamn Arch Wiki tersebut juga kita disarankan untuk mempertimbangkan menggunakan Display Manager yang lain. Karena SLiM tidak secara penuh *support* dengan systemd, termasuk logind sessions.

# Mengapa Tertarik dengan SLiM?

Sebenarnya sudah lama mencari-cari pengganti dari LightDM display manager. Saya merasa kurang fleksibel dalam mengkostumisasi sesuai preferensi sendiri. Belum lagi transisi antara verbose mode dari journalctl ke tampilan LightDM tidak begitu *smooth*.

Sampai beberapa waktu lalu, menemukan halaman pada Slant.co yang membahas [What is the best Linux Display Manager?](https://www.slant.co/topics/2053/~best-linux-display-manager){:target="_blank"}.

Saya agak heran, karena bukan LightDM yang menduduki peringkat no. 1 saat ini (2019/02/28), melainkan SLiM dengan perolehan point sebanyak 92, disusul LightDM sebesar 83.


# Referensi

1. [wiki.archlinux.org/index.php/SLiM](https://wiki.archlinux.org/index.php/SLiM){:target="_blank"}
<br>Diakses tanggal: 2019/02/28

2. [github.com/data-modul/slim](https://github.com/data-modul/slim){:target="_blank"}
<br>Diakses tanggal: 2019/02/28

3. [](){:target="_blank"}
<br>Diakses tanggal: 2019/02/28
