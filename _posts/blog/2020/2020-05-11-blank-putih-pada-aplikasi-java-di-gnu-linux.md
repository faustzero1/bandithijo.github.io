---
layout: 'post'
title: "Memperbaiki Blank Putih pada Aplikasi Berbasis Java di GNU/Linux"
date: 2020-05-11 08:14
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Java']
pin:
hot:
contributors: []
description:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Permasalahan

Saya mendapati beberapa aplikasi berbasis Java, apabila dibuka, hanya menampilkan *canvas* putih dan tidak merender *asset* seperti form, menu, button, text, gambar dan lain-lain.

# Pemecahan Masalah

Misalkan, dalam kasus saya, saya ingin menjalankan binary dari aplikasi Jdownloader 2 Beta. Nama file binarynya adalah `JDownloader2`.

Coba jalankan program yang akan dijalankan di atas terminal dengan menambahkan env variable seperti ini.

{% shell_user %}
_JAVA_AWT_WM_NONREPARENTING=1 ./JDownloader2
{% endshell_user %}

Kalau berhasil dijalankan dan semua *asset* terlihat sudah berhasil dirender, tinggal tambahkan pada `.desktop` dari launcher aplikasi tersebut.

{% shell_user %}
vim ~/.local/share/applications/JDownloader2.desktop
{% endshell_user %}

{% highlight_caption $HOME/.local/share/applications/JDownloader2.desktop %}
<pre class="caption">
[Desktop Entry]
Name=JDownloader 2
<mark>Exec=_JAVA_AWT_WM_NONREPARENTING=1 $HOME/app/jdownloader2beta/JDownloader2</mark>
Icon=/home/bandithijo/app/jdownloader2beta/jd2/.install4j/JDownloader2.png
Categories=Network;Application;
Type=Application
</pre>

Selesai!

Sepertinya segini dulu yang dapat saya bagikan.

Terima kasih.

(^_^)







# Referensi

1. [bbs.archlinux.org/viewtopic.php?id=159016](https://bbs.archlinux.org/viewtopic.php?id=159016){:target="_blank"}
<br>Diakses tanggal: 2020/05/11
