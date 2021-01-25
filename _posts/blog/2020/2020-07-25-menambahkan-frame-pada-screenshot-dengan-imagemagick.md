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
tags: ['Tips', 'Ruby']
pin:
hot:
contributors: []
resume: "Ide untuk memberikan framing ini muncul saat saya ingin membuat thumbnails di YouTube untuk video dengan resolusi layar saya yang berukuran 4:3, sedangkan thumbnail setidaknya memiliki resolusi berukuran 16:9."
---

# Sekenario Masalah

Saya baru-baru saja menyeragamkan semua produksi video yang saya jadikan [vlog di YouTube]({{ site.url }}/youtube/){:target="_blank"}.

Dalam video tersebut, saya menggunakan frame seperti ini:

{% image https://i.postimg.cc/kg4MKtmK/obs-frame.png | obs-frame %}

Nah, permasalahannya adalah:

**Saya ingin membuat hasil screenshot pada laptop ThinkPad X61 dengan resolusi layar 1024x768 ini langsung otomatis memiliki frame tersebut**.

Saat ini, hasil screenshot yang diambil langsung dari laptop ThinkPad X61 saya, seperti ini:

{% image https://i.postimg.cc/9FXcHqzK/thinkpad-x61-1024x768.png | thinkpad-x61-1024x768 %}

Nah, hasil screenshot di atas memiliki resolusi 1024x768.

Saya ingin menggabungkan hasil screenshot dengan frame.

{% image https://i.postimg.cc/rmLLnDvh/mockup-imagemagick.png | mockup-imagemagick %}

# Pemecahan Masalah

Solusinya sangat mudah untuk ditemukan.

Saya langsung terpikir menggunakan ImageMagick, tapi saya tidak pernah benar-benar mencoba dan mengulik banyak hal dengan tools ini. Biasanya, saya hanya membaca manual, kalau saya perlukan. Saya seperti sekarang. Hehe.

Kita akan menggunakan Image Sequence Operator yang bernama `-composite`.

Bentuk commandnya seperti ini

{% pre_url %}
convert frame.png target.png -geometry WxH^ -composite hasil.png
{% endpre_url %}

**frame.png** adalah gambar yang akan dijadikan frame.

**target.png** adalah gambar hasil screenshot.

**-geometry WxH^** adalah ukuran/resolusi dari gambar **target.png**.

Nah, kemudian tinggal digabungkan dengan aplikasi pembuat screenshot.

Dalam hal ini, saya menggunakan **scrot**.

Maka seperti inilah yang saya gunakan.

{% shell_user %}
scrot "Screenshot_%Y-%m-%d_%H-%M-%S.png" -e "convert ~/pic/ScreenShots/obs-frame.png *.png -geometry 1024x768^ -composite *.png; mv *.png ~/pic/ScreenShots/"
{% endshell_user %}

Dibagian akhir dari proses tersebut, saya memindahkan hasil screenshot ke direktori `~/pic/ScreenShots/` menggunakan command `mv`. Teman-teman dapat menyesuaikan dengan direktori screenshot yang teman-teman miliki.

Kalau mau ditambahkan di keybind Window Manager juga bisa. Tinggal tambahkan di konfigurasi Window Manager masing-masing.

Misal, seperti saya, sedang menggunakan BSPWM.

{% highlight_caption $HOME/.config/sxhkd/sxhkdrc %}
{% highlight bash linenos %}
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

{% image https://i.postimg.cc/yNGTs9VP/hasil-screenshot-frame-imagemagick.png | hasil-screenshot-frame-imagemagick %}

# Tambahan

Terkadang saya tidak ingin setiap hasil screenshot langsung diframing. Namun, saya malas menulis command ImageMagick yang panjang. Maka sayapun membuat Ruby script untuk menghandle hal tersebut.

{% highlight_caption $HOME/.local/bin/scrot-imgck %}
{% highlight ruby linenos %}
#!/usr/bin/env ruby

# Please write your screenshot dir with full path. Later, I'll improve this.
ss_dir = "/home/bandithijo/pic/ScreenShots"
ss_frame = "/home/bandithijo/pic/ScreenShots/obs-frame.png"
Dir.chdir(ss_dir)
list_file = %x(ls -p | grep -v /)
files = list_file.split(" ")
target_file = files.last
target_file_mod = files.last.split("").insert(-5, 'X').join

%x(convert #{ss_frame} #{target_file} -geometry 1024x768^ \
-set gamma 2.2 -composite #{target_file_mod})

puts "SS_DIR: #{ss_dir}"
puts "SOURCE: #{target_file}
TARGET: #{target_file_mod}
FRAMING SUCCESS!"
{% endhighlight %}

Mantap!!!

Saya rasa hanya ini yang dapat saya tuliskan saat ini.

Mudah-mudahan dapat bermanfaat untuk teman-teman.

Terima kasih.

(^_^)








# Referensi


1. [imagemagick.org/script/command-line-processing.php#geometry](https://imagemagick.org/script/command-line-processing.php#geometry){:target="_blank"}
<br>Diakses tanggal: 2020/07/25

2. [PNG image becomes too bright](https://www.imagemagick.org/discourse-server/viewtopic.php?t=27131){:target="_blank"}
<br>Diakses tanggal: 2020/08/03
