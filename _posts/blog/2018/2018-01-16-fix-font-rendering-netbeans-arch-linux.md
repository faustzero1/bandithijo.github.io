---
layout: 'post'
title: 'Memperbaiki Font Rendering Netbeans pada Arch Linux'
date: 2018-01-16
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Arch Linux', 'Tips']
pin:
hot:
contributors: []
resume: "Netbeans merupakan aplikasi yang dibangun dengan bahasa Java. Java GUI Toolkit biasanya belum terkonfigurasi dengan baik agar memiliki tampilan yang mulus. Maka kita perlu untuk mengkonfigurasi agar tampilan Netbeans kita terlihat mulus."
---

<img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="https://4.bp.blogspot.com/-t8rFinLgSyM/WmCaNEg1ffI/AAAAAAAAG5Y/MteYia1GKyg3j6SGVMOAxT7slgPeX84YwCLcBGAs/s1600/Default%2BHeader%2BTemplate%2BPost%2B2X.png" onerror="imgError(this);" alt="banner">

# Latar Belakang
_Font rendering_ yang buruk pada beberapa aplikasi GUI tentu sangat mengganggu _mood_ kita dalam menggunakan aplikasi tersebut. Apalagi kalau aplikasi yang kita gunakan adalah aplikasi yang sehari-harinya kita gunakan.  Netbeans adalah salah satu aplikasi yang memiliki _font rendering_ yang buruk pada [i3wm](https://wiki.archlinux.org/index.php/I3) saya.

Bagaimana cara saya memperbaiki ini ?


# Caranya
Kita perlu mengetahui terlebih dahulu direktori tempat file `netbeans.conf` disimpan. Atau secara umum, direktori Netbeans tersimpan pada sistem. Dalam kasus saya, Arch Linux, menempatkan direktori Netbeans pada `/usr/share/netbeans`. Penempatan direktori ini dapat berbeda-beda tergantung distribusi GNU/Linux maupun proses instalasi local user atau wide system.

Kemudian, kita akan mengedit file `netbeans.conf`,

{% shell_cmd $ %}
sudo nano /usr/share/netbeans/etc/netbeans.conf
{% endshell_cmd %}

{% highlight_caption /usr/share/netbeans/etc/netbeans.conf %}
{% highlight sh linenos %}
# ...
# ...
netbeans_default_options="-J-client ..."
# ...
{% endhighlight %}

\*Cari baris dengan isi seperti di atas.

Pada akhir dari baris tersebut, kita akan menambahkan 2 _properties_ lain,

```
-J-Dswing.aatext=true -J-Dawt.useSystemAAFontSettings=on
```

\*Tambahkan baris di atas, masih di dalam tanda petik dari `netbeans_default_options=`.

Maka akan berbentuk seperti ini,

**Sebelum**,

{% highlight_caption /usr/share/netbeans/etc/netbeans.conf %}
{% highlight sh linenos %}
# ...
# ...
netbeans_default_options="-J-client -J-Xss2m -J-Xms32m -J-Dapple.laf.useScreenMenuBar=true -J-Dapple.awt.graphics.UseQuartz=true -J-Dsun.java2d.noddraw=true -J-Dsun.java2d.dpiaware=true -J-Dsun.zip.disableMemoryMapping=true"
# ...
{% endhighlight %}

**Sesudah**,

{% highlight_caption /usr/share/netbeans/etc/netbeans.conf %}
{% highlight sh linenos %}
# ...
# ...
netbeans_default_options="-J-client -J-Xss2m -J-Xms32m -J-Dapple.laf.useScreenMenuBar=true -J-Dapple.awt.graphics.UseQuartz=true -J-Dsun.java2d.noddraw=true -J-Dsun.java2d.dpiaware=true -J-Dsun.zip.disableMemoryMapping=true -J-Dswing.aatext=true -J-Dawt.useSystemAAFontSettings=on"
# ...
{% endhighlight %}

Sekarang, coba buka kembali, atau _restart_ Netbeans.
Apakah _font rendering_ sudah lebih bagus dan _smooth_ ?

# Video Dokumentasi

{% youtube Bw1RYFkCXYs %}

# Referensi
1. [thomashunter.name/blog/enabling-anti-aliasing-in-the-netbeans-editor/](https://thomashunter.name/blog/enabling-anti-aliasing-in-the-netbeans-editor/)
<br>Diakses tanggal: 2018/01/16

