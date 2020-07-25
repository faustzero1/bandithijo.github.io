---
layout: 'post'
title: "Menambahkan Frame pada Hasil ScreenShot dengan ImageMagick"
date: 2020-07-25 11:45
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips']
pin:
hot:
contributors: []
---

# Sekenario Masalah

Saya baru-baru saja menyeragamkan semua produksi video yang saya jadikan [vlog di YouTube]({{ site.url }}/youtube/){:target="_blank"}.

Dalam video tersebut, saya menggunakan frame seperti ini:

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/kg4MKtmK/obs-frame.png" onerror="imgError(this);"}{:class="myImg"}

Nah, permasalahannya adalah:

**Saya ingin membuat hasil screenshot pada laptop ThinkPad X61 dengan resolusi layar 1024x768 ini langsung otomatis memiliki frame tersebut**.

Saat ini, hasil screenshot yang diambil langsung dari laptop ThinkPad X61 saya, seperti ini:

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/9FXcHqzK/thinkpad-x61-1024x768.png" onerror="imgError(this);"}{:class="myImg"}

Nah, hasil screenshot di atas memiliki resolusi 1024x768.

Saya ingin menggabungkan hasil screenshot dengan frame.

![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/rmLLnDvh/mockup-imagemagick.png" onerror="imgError(this);"}{:class="myImg"}

# Pemecahan Masalah

Solusinya sangat mudah untuk ditemukan.

Saya langsung terpikir menggunakan ImageMagick, tapi saya tidak pernah benar-benar mencoba dan mengulik banyak hal dengan tools ini. Biasanya, saya hanya membaca manual, kalau saya perlukan. Saya seperti sekarang. Hehe.

Kita akan menggunakan Image Sequence Operator yang bernama `-composite`.

Bentuk commandnya seperti ini

<pre class="url">
$ <b>convert frame.png target.png -geometry WxH^ -composite hasil.png</b>
</pre>

**frame.png** adalah gambar yang akan dijadikan frame.

**target.png** adalah gambar hasil screenshot.

**-geometry WxH^** adalah ukuran/resolusi dari gambar **target.png**.

Nah, kemudian tinggal digabungkan dengan aplikasi pembuat screenshot.

Dalam hal ini, saya menggunakan **scrot**.

Maka seperti inilah yang saya gunakan.

<pre>
$ <b>scrot "Screenshot_%Y-%m-%d_%H-%M-%S.png" -e "convert ~/pic/ScreenShots/obs-frame.png *.png -geometry 1024x768^ -composite *.png; mv *.png ~/pic/ScreenShots/"</b>
</pre>

Dibagian akhir dari proses tersebut, saya memindahkan hasil screenshot ke direktori `~/pic/ScreenShots/` menggunakan command `mv`. Teman-teman dapat menyesuaikan dengan direktori screenshot yang teman-teman miliki.

Kalau mau ditambahkan di keybind Window Manager juga bisa. Tinggal tambahkan di konfigurasi Window Manager masing-masing.

Misal, seperti saya, sedang menggunakan BSPWM.

{% highlight bash linenos %}
# ~/.config/sxhkd/sxhkdrc

# ...
# ...

# screenshot
super + Print
    scrot "Screenshot_%Y-%m-%d_%H-%M-%S.png" \
    -e "convert ~/pic/ScreenShots/obs-frame.png *.png -geometry 1024x768^ \
    -composite *.png; mv *.png ~/pic/ScreenShots/" \
    ; notify-send "Scrot" "Screen has been captured!"
{% endhighlight %}

Hasilnya seperti ini.

![gambar_4]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/yNGTs9VP/hasil-screenshot-frame-imagemagick.png" onerror="imgError(this);"}{:class="myImg"}

Mantap!!!

Saya rasa hanya ini yang dapat saya tuliskan saat ini.

Mudah-mudahan dapat bermanfaat untuk teman-teman.

Terima kasih.

(^_^)








# Referensi


1. [imagemagick.org/script/command-line-processing.php#geometry](https://imagemagick.org/script/command-line-processing.php#geometry){:target="_blank"}
<br>Diakses tanggal: 2020/07/25
