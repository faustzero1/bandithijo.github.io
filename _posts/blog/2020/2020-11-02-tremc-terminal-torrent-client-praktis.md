---
layout: 'post'
title: "Tremc, Terminal Torrent Client yang Praktis dan Mudah Digunakan"
date: 2020-11-02 19:00
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Ulasan']
pin:
hot:
contributors: []
description: "Sebelumnya, saya sering menggunakan torrent client favorit saya sejak masih menggunakan OSX, yaitu Transmission. Namun, ternyata transmission memiliki daemon yang berjalan di background, lantas saya terpikir, kenapa tidak menggunakan user interface yang lebih sederhana, bukan dengan GUI melainkan dengan TUI. Tremc adalah salah satu user interface alternatif untuk transmission daemon yang dapat kita operasikan cukup menggunakan Terminal."
---

# Latar Belakang

**Tremc**, adalah TUI client untuk BitTorrent client Transmission.

Sejak masih menggunakan macOS --dulu disebut OSX--, saya sudah menggunakan Transmission sebagai torrent client.

Hingga migrasi ke GNU/Linux pada Desember 2014 sampai hari ini, saya masih menjadikan Transmission sebagai torrent client.

Sudah hampir dua pekan ini saya mecoba beralih menggunakan curses interface untuk Transmission yang disebut dengan Tremc.

Tremc ini merupakan fork dari **transmission-remote-cli** (sudah tidak lagi dimaintain, last commit Jan 16, 2017) yang dibangun dengan Python 3.


# Instalasi

Karena Tremc ini hanya TUI interface, tentunya kita perlu memasang program utamanya terlebih dahulu, yaitu **transmission-cli**.

Untuk Arch Linux, pasang paket **extra/transmission-cli**.

<pre>
$ <b>sudo pacman -S transmission-cli</b>
</pre>

Kemudian, pasang paket **aur/tremc-git**.

<pre>
$ <b>yay -S tremc-git</b>
</pre>

# Eksekusi

**NOTE!** Sebelum dapat membuka **tremc**, kita harus menjalankan **transmission-daemon** terlebih dahulu.

<pre>
$ <b>transmission-daemon</b>
</pre>

Secara otomatis, akan berjalan di background process.

Kalau tidak, tremc akan gagal dibuka, atau tidak akan berjalan sebagaimana mestinya.

# Konfigurasi

Tremc sudah menyediakan command untuk mengenerate file config.

<pre>
$ <b>tremc --create-config</b>
</pre>

Maka, file config akan tergenerate dan berada di lokasi.

<pre class="url">
$HOME/.config/tremc/settings.cfg
</pre>

Berikut ini adalah file **settings.cfg** milik saya.

Tidak banyak yang perlu diubah, hanya blok [Colors] saja yang saya modifikasi sesuai preferensi saya.

{% highlight_caption $HOME/.config/tremc/settings.cfg %}
{% highlight conf linenos %}
[Connection]
host                       = localhost
port                       = 9091
path                       = /transmission/rpc
username                   =
password                   =

[Sorting]
order                      = name

[Filtering]
filter                     =
invert                     = False

[Misc]
lines_per_torrent          = 2
torrentname_is_progressbar = True
file_viewer                = xdg-open %%s
file_open_in_terminal      = True

[Colors]
title_seed                 = bg:green,fg:black
title_download             = bg:blue,fg:black
title_idle                 = bg:yellow,fg:black
title_verify               = bg:magenta,fg:black
title_paused               = bg:default,fg:default
title_error                = bg:red,fg:default
download_rate              = bg:white,fg:black
upload_rate                = bg:white,fg:black
eta+ratio                  = bg:white,fg:black
filter_status              = bg:default,fg:default
multi_filter_status        = bg:default,fg:black
dialog                     = bg:default,fg:default
dialog_important           = bg:default,fg:red
file_prio_high             = fg:red,bg:default
file_prio_normal           = fg:default,bg:default
file_prio_low              = fg:yellow,bg:default
file_prio_off              = fg:blue,bg:default
{% endhighlight %}

{% image https://i.postimg.cc/3xrDRmTm/gambar-01.png | 1 %}

# Keyboard Mapping

Tremc, sudah membundle keybind help info yang sangat mudah dipahami dan mudah diakses.

## Keymap Help

Tekan <kbd>F1</kbd> atau <kbd>?</kbd>.

{% image https://i.postimg.cc/XvmZQPyk/gambar-02.png | 2 %}

Apabila terdapat keterangan **More...**, kita dapat scroll ke bawah dengan <kbd>Page Down</kbd>.

Untuk melihat detail dari torrent, tekan <kbd>Enter</kbd>.

{% image https://i.postimg.cc/6Qy2VKTQ/gambar-03.png | 4 %}

Kemudian, pindah ke tab selanjutnya dengan <kbd>Tab</kbd> atau <kbd>-></kbd>.

{% image https://i.postimg.cc/nzmX514b/gambar-04.png | 4 %}

{% image https://i.postimg.cc/t4rnVJqf/gambar-05.png | 5 %}

## Add Torrent

Kita dapat menambahkan torrent dengan menekan tombol <kbd>a</kbd>.

{% image https://i.postimg.cc/7hxqV1XN/gambar-06.png | 6 %}

Saya lebih sering memasukkan alamat Magnet Link, seperti ini contohnya.

{% pre_url %}
magnet:?xt=urn:btih:ba7a8d78a535a9bf22dbb4482b9174ea8fd70891&dn=archlinux-2020.11.01-x86_64.iso
{% endpre_url %}

## Move Torrent File

Secara default, file torrent akan diletakkan di direktori Downloads.

Kita dapat memindahkan ke direktori yang kita mau, dengan menekan tombol <kbd>m</kbd>, kemudian arahkan manual path direktori. Kita dapat menggunakan tombol <kbd>Tab</kbd> untuk auto complete.



# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Untuk panduan lebih lengkap, teman-teman dapat mengunjungi halaman GitHub Readme dari Tremc.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)


# Referensi

1. [github.com/tremc/tremc](https://github.com/tremc/tremc){:target="_blank"}
<br>Diakses tanggal: 2020/11/02
