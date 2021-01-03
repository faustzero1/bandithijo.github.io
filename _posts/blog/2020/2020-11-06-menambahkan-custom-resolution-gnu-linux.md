---
layout: 'post'
title: "Menambahkan Custom Resolution pada GNU/Linux"
date: 2020-11-06 13:16
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
---

# Latar Belakang Masalah

Saya memiliki external monitor berupa TV yang dihubungkan dengan ThinkPad X61 menggunakan kabel HDMI dengan bantuan konektor VGA to HDMI.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/4xzLxLY3/gambar-01.jpg" onerror="imgError(this);"}{:class="myImg"}

Eksternal monitor ini terbaca sebagai **VGA1**.

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/JhMTDNX5/gambar-02.png" onerror="imgError(this);"}{:class="myImg"}

Sayangnya, resolusi maksimal yang dapat dihasilkan adalah **1024x768**.

![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/85CtwTtF/gambar-03.png" onerror="imgError(this);"}{:class="myImg"}

Sedangkan external monitor saya memiliki resolusi maksimal sebesar **1920x1080**.

Berdasarkan pengalaman dengan laptop yang memiliki HDMI output dengan external monitor ini, saya lebih banyak menggunakan resolusi **1600x900**.

**Bagaimana saya dapat menambahkan resoulsi 1600x900?**

# Pemecahan Masalah

Menurut saya, masalah ini sangat mudah dilakukan, kalau kita menggunakan sistem operasi GNU/Linux.

Kita tinggal menggunakan tools yang bernama **cvt** dan **xrandr**

> **Cvt**  is  a  utility  for  calculating  VESA **Coordinated Video Timing** modes. Given the desired horizontal and vertical resolutions, a modeline  adhering to  the  CVT  standard  is  printed.  This modeline can be included in Xorg xorg.conf(5)

<pre class="url">
$ <b>cvt h-resolution v-resolution refresh-rate</b>
</pre>

## Menambahkan Custom Resolution

Maka, dalam kasus saya, untuk menambahkan resolusi **1600x900**,

### 1. Calculating VESA Coordinated dengan CVT

<pre>
$ <b>cvt 1600 900 60</b>
</pre>

<pre>
# 1600x900 59.95 Hz (CVT 1.44M9) hsync: 55.99 kHz; pclk: 118.25 MHz
Modeline <mark>"1600x900_60.00"  118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync</mark>
</pre>

Copy bagian yang saya markup kuning.

### 2. Membuat Modeline dengan Xrandr Newmode

Selanjutnya kita akan menambahkan mode baru dengan **xrandr** menggunakan option `--newmode`.

<pre>
$ <b>xrandr --newmode <mark>"1600x900"</mark> 118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync</b>
</pre>

Paste hasil dari perintah **cvt** yang sebelumnya sudah di copy.

**Perhatikan!** saya mengedit bagian yang saya marking kuning, agar menjadi lebih sederhana. Sebelumnya `1600x900_60.00`, nama ini terlalu panjang.

Kalau berhasil, apabila kita menjalankan **xrandr**, akan ada resolusi baru pada monitor **VIRTUAL1**.

<pre>
$ <b>xrandr</b>

...
...
VIRTUAL1 disconnected (normal left inverted right x axis y axis)
  <mark>1600x900</mark> (0x1d8) 118.250MHz -HSync +VSync
        h: width  1600 start 1696 end 1856 total 2112 skew    0 clock  55.99KHz
        v: height  900 start  903 end  908 total  934           clock  59.95Hz
</pre>

### 3. Tambahkan Custom Resolution dengan Xrandr Addmode

Kita perlu menambahkan custom resolution **1600x900** yang berada di monitor **VIRTUAL1** ke **VGA1** menggunakan **xrandr** dengan option `--addmode`.

<pre>
$ <b>xrandr --addmode VGA1 1600x900</b>
</pre>

Kalau berhasil, custom resolution 1600x900 yang berada di VIRTUAL1 akan berpindah ke VGA1.

<pre>
$ <b>xrandr</b>

...
...
VGA1 connected (normal left inverted right x axis y axis)
   1024x768      60.00
   800x600       60.32    56.25
   848x480       60.00
   640x480       59.94
   <mark>1600x900      59.95</mark>
VIRTUAL1 disconnected (normal left inverted right x axis y axis)
</pre>

Selesai!

Kalau sudah seperti ini, tinggal kita gunakan saja.

![gambar_4]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/8zmhJqNj/gambar-04.png" onerror="imgError(this);"}{:class="myImg"}

## Menghapus Custom Resolution

Sebenarnya, karena kita menambahkan custom resolution dengan cara manual, maka cukup dengan **reboot** sistem saya sudah cukup.

Namun, mungkin kalian tipikal seperti saya yang jarang sekali melakukan reboot.

Untuk menghapus custom resolution pastikan external monitor atau extended monitor sudah tidak terkoneksi atau tidak digunakan.

Setelah itu jalankan 2 proses di bawah ini.

## 1. Menghapus Custom Resolution dari VGA1

Kita perlu menghapus custom resolution 1600x900 dari **VGA1** menggunkan **xrandr** dengan option `--delmode`.

<pre>
$ <b>xrandr --delmode VGA1 1600x900</b>
</pre>

Kalau berhasil, custom resolution akan kembali ke monitor **VIRTUAL1**.

<pre>
$ <b>xrandr</b>

...
...
VGA1 connected (normal left inverted right x axis y axis)
   1024x768      60.00
   800x600       60.32    56.25
   848x480       60.00
   640x480       59.94
VIRTUAL1 disconnected (normal left inverted right x axis y axis)
  <mark>1600x900</mark> (0x1d8) 118.250MHz -HSync +VSync
        h: width  1600 start 1696 end 1856 total 2112 skew    0 clock  55.99KHz
        v: height  900 start  903 end  908 total  934           clock  59.95Hz
</pre>

## 2. Menghapus Custom Resolution dari VIRTUAL1

Setelah custom resolution kembali ke VIRTUAL1, tinggal kita hapus dengan `--rmmode`.

<pre>
$ <b>xrandr --rmmode 1600x900</b>
</pre>

Selesai!

Sekarang xrandr sudah bersih dari custom resolution yang kita tambahkan.

<pre>
$ <b>xrandr</b>

...
...
VGA1 connected (normal left inverted right x axis y axis)
   1024x768      60.00
   800x600       60.32    56.25
   848x480       60.00
   640x480       59.94
VIRTUAL1 disconnected (normal left inverted right x axis y axis)
</pre>

# Tambahan

Saya akan mencatat script sederhana yang saya buat untuk menghandle multi monitor menggunakan **dmenu**.

Workflownya, kalau monitor hanya ada 1, maka menu yang tampil adalah "dual", namun kalau kedua monitor aktif, maka menu yang tampil "single".

{% highlight_caption $HOME/.local/bin/add_custom_resolution.sh %}
{% highlight bash linenos %}
#!/bin/sh

DMENU="/usr/local/bin/dmenu"

reso_monitor_lg=$(xrandr | grep -i 'VGA1 connected' | awk 'NR%1==0 {print $3}')
if [ ! "$reso_monitor_lg" = "1600x900+0+0" ]; then
    cvt 1600 900 60
    xrandr --newmode "1600x900" \
    118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync
    xrandr --addmode VGA1 1600x900
    echo "=> Add newmode 1600x900, DONE!"
fi

monitor_lg() {
    sleep 1
    xrandr --output LVDS1 --primary --mode 1024x768 --pos 576x900 --rotate normal --output VGA1 --mode 1600x900 --pos 0x0 --rotate normal --output VIRTUAL1 --off
    sleep 1
    feh --bg-fill -Z $WALLPAPER2 --bg-fill $WALLPAPER1
}

monitor_laptop() {
    sleep 1
    xrandr --output LVDS1 --primary --mode 1024x768 --pos 0x0 --rotate normal --output VGA1 --off --output VIRTUAL1 --off
    sleep 1
    xrandr --delmode VGA1 1600x900
    xrandr --rmmode 1600x900
    sleep 1
    feh --bg-fill -Z $WALLPAPER2
}

monitors=$(xrandr --listmonitors | grep 'Monitors:' | tr -d "Monitors: ")
if [ "$monitors" = "2" ]; then
    choice=$(printf "Single" | $DMENU -p " Monitor:")
    case "$choice" in
        "Single"    ) monitor_laptop;;
    esac
elif [ "$monitors" = "1" ]; then
    choice=$(printf "Dual" | $DMENU -p " Monitor:")
    case "$choice" in
        "Dual"      ) monitor_lg;;
    esac
fi
{% endhighlight %}

**Perhatikan!** Layout monitor pada baris ke 16, saya dapatkan dengan menyusun layout monitor dengan **arandr** kemudian saya export menjadi file. Buka file hasil export tersebut dan di dalamnya akan kalian temukan layout yang sudah diracik oleh arandr. Dengan begitu, tidak perlu susah-susah lagi.






# Demonstrasi

{% include youtube_embed.html id="PnrO4rVUYHs" %}





# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)

