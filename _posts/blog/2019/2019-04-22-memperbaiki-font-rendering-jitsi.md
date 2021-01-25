---
layout: 'post'
title: 'Memperbaiki Font Rendering pada Jitsi - VoIP dan IM Client pada GNU/Linux'
date: 2019-04-22 14:11
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
resume:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Masalah

Bagi teman-teman yang menggunakan Jitsi pada distribusi Arch Linux, mungkin mengalami hal yang sama seperti yang saya alami.

Jitsi, VoIP dan IM client yang menggunakan backend Java ini memiliki tampilan antar muka terkhusus font rendering yang sangat buruk.

Persis seperti font rendering yang ada pada aplikasi yang menggunakan Java pada umumnya apabila belum di konfigurasi.

Mungkin beberapa distribusi seperti Ubuntu atau Fedora tidak mengalami hal semacam ini. Tapi bagi saya pengguna Arch Linux dan beberapa distribusi untuk pengguna tingkat mahir, kami harus mengkonfigurasi beberapa bagian terlebih dahulu untuk dapat membuat font rendering pada aplikasi yang menggunkan Java dapat terlihat mulus.

# Pemecahan Masalah

Tambahkan pada file `~/.profile`,

{% shell_user %}
vim ~/.profile
{% endshell_user %}

Copy dan paste baris di bawah ini ke dalam `~/.profile`.

{% highlight_caption $HOME/.profile %}
{% highlight sh linenos %}
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
{% endhighlight %}

Letakkan di mana saja.

Selanjutnya, **logout** dan **login** kembali.

{% box_perhatian %}
<p>Logout diperlukan setiap kita ingin melihat dampak dari perubahan yang kita lakukan pada isi dari file <code>~/.profile</code>.</p>
<p>Sebelum kita logout, perubahan yang kita lakukan tidak akan dijalankan.</p>
{% endbox_perhatian %}

Selanjutnya, buka Jitsi dan lihat perbedannya.

{% image https://i.postimg.cc/0QLRVrZ2/gambar-01.png | 1 | Setelah ditambahkan JAVA_OPTIONS %}

Sekian, mudah-mudahan bermanfaat.

# Referensi

1. [lists.jitsi.org/pipermail/dev/2013-November/018919.html](http://lists.jitsi.org/pipermail/dev/2013-November/018919.html){:target="_blank"}
<br>Diakses tanggal: 2019/04/22
