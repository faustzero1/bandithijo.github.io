---
layout: 'post'
title: "Membuat Hasil ScreenShot pada GNU/Linux seperti Milik macOS"
date: 2020-07-28 18:57
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips',]
pin:
hot:
contributors: []
---

# Sekenario Masalah

**Seperti apa sih bang, hasil screenshot seperti yang ada pada macOS itu?**

Kebetulan sejak 2009 sampai 2014 akhir, saya menggunakan macOS (dulu namanya OSX).

Saya juga beberapa menulis konten blog menggunakan macOS dan cukup sering mengambil gambar screenshot. Seperti yang ada di blog post yang ini:

1. [Aplikasi Download Alternatif untuk OSX dengan JDownloader](/blog/download-client-osx-with-jdownloader){:target="_blank"}

2. [Memperbaiki Trash OSX](/blog/memperbaiki-trash-osx){:target="_blank"}

3. [Memory Cleaner untuk OSX](/blog/memory-cleaner-osx){:target="_blank"}

Kira-kira seperti ini hasil screenshot window aplikasi pada macOS.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/sXwSKwyj/ss-macos.png" onerror="imgError(this);"}{:class="myImg"}

# Pemecahan Masalah

Pastinya tools yang diperlukan adalah **ImageMagick**.

Kira-kira begini command formula nya.

<pre>
$ <b>convert source.png \( +clone -background black -shadow 50x10+0+0 \) \
+swap -background none -layers merge +repage tmp.png; \
convert tmp.png -bordercolor none -border 30 source.png; \
rm tmp.png</b>
</pre>

Misal, saya punya gambar hasil screenshot seperti ini:

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/XJzqph4C/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}{:style="border-radius:0!important"}

Kemudian, saya jalankan command dari ImageMagick di atas.

Hasilnya akan seperti ini:

![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/rz6p9rdy/gambar-02.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Menggunakan -shadow 50x10+0+10</p>

![gambar_4]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/tJnTP54m/gambar-03.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Menggunakan -shadow 50x20+0+20</p>

Tinggal teman-teman sesuaikan dengan preferensi untuk attribute `-shadow` nya.

Kalau saya lebih suka yang `50x10+0+10`, karena shadownya tidak terlalu beleber keluar.


# Tambahan

Saya malas menuliskan command ImageMagick tersebut berulang-ulang.

Jadi, saya putuskan untuk membuat Ruby script dimana targetnya adalah file terakhir yang ada pada direktori screenshot saya.

Karena setiap sehabis membuat screenshot, gambar akan berada pada paling akhir dari direktori screenshot.

File inilah yang akan ditangkap oleh Ruby script dan dipermak.

{% highlight ruby linenos %}
#!/usr/bin/env ruby

# Please write your screenshot dir with full path. Later, I'll improve this.
screenshot_dir = "/home/bandithijo/pic/ScreenShots"
Dir.chdir(screenshot_dir)
ss_dir = Dir.pwd
list_file = %w(ls -p | grep -v /)
files = list_file.split(" ")
target_file = files.last
target_file_mod = files.last.split("").insert(-5, 'X').join

%x(convert #{target_file} \\( +clone -background black -shadow 50x10+0+10 \\) \
+swap -background none -layers merge +repage tmp.png; \
convert tmp.png -bordercolor none -border 30 #{target_file_mod}; \
rm tmp.png)

puts "SS_DIR: #{ss_dir}"
puts "SOURCE: #{target_file}
TARGET: #{target_file_mod}
FRAMING SUCCESS!"
{% endhighlight %}

Perhatikan pada baris ke 13, attribute `-shadow` inilah yang teman-teman perlu ubah, apabila ingin menyesuaikan bentuk dari shadow.

Kalau berhasil dijalankan, outputnya akan seperti ini:

```
SS_DIR: /home/bandithijo/pic/ScreenShots
SOURCE: Screenshot_2020-07-28_19-3-51.png
TARGET: Screenshot_2020-07-28_19-3-51X.png
FRAMING SUCCESS!
```

Ruby script tersebut akan membuat file baru dengan akhiran `X` yang ada dibelakang nama dari file screenshot target.



<br>
Mantap!!!

Saya rasa hanya ini yang dapat saya tuliskan saat ini.

Mudah-mudahan dapat bermanfaat untuk teman-teman.

Terima kasih.

(^_^)








# Referensi


1. [Create MacOS style screenshots with drop shadow using Imagemagick](https://apple.stackexchange.com/questions/384323/create-macos-style-screenshots-with-drop-shadow-using-imagemagick){:target="_blank"}
<br>Diakses tanggal: 2020/07/28

2. [imagemagick.org/script/command-line-options.php#shadow](https://imagemagick.org/script/command-line-options.php#shadow){:target="_blank"}
<br>Diakses tanggal: 2020/07/28
