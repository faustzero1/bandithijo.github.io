---
layout: 'post'
title: 'Memperbaiki GPG: Warning: Unsafe Permissions on Homedir'
date: 2018-06-22 17:58
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Security', 'Tips']
pin:
hot:
contributors: []
resume:
---

<!-- BANNER OF THE POST -->
<img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="https://s20.postimg.cc/6vuksuzgt/banner_post_17.png" onerror="imgError(this);" alt="banner">

# Pendahuluan

Sejujurnya saya belum memahami benar pengaturan dan penggunaan **GnuPG** (*GNU Privacy Guard*). Mengutip dari situs [gnupg.org<sup>1</sup>]({{ site.url }}/blog/memperbaiki-gpg-permissions-on-homedir#referensi){:target="_blank"}, GnuPG adalah implementasi yang lengkap dan berlisensi bebas pakai dari **OpenPGP standard** sebagaimana yang dijelaskan pada [RFC4880](https://www.ietf.org/rfc/rfc4880.txt){:target="_blank"} (dikenal juga dengan sebutan PGP). GnuPG memungkinkan kita untuk mengenkripsi dan memberikan *signature* pada data dan komunikasi kita. GnuPG juga dikenal sebagai **GPG**, yang merupakan aplikasi *command line* dengan fitur-fitur untuk memudahkan integrasi dengan aplikasi yang lain.

Sejak diperkenalkan pada tahun 1997, GnuPG adalah aplikasi bebas merdeka yang artinya dapat digunakan secara bebas, dimodifikasi, dan didistribusikan di bawah syarat-syarat GNU *General Public License*.

# Permasalahan

Masalah yang ingin saya angkat pada dokumentasi ini adalah adanya *warning* yang muncul setiap kali saya menjalankan perintah `gpg` di Terminal.

```
gpg: WARNING: unsafe permissions on homedir
```

*unsafe permissions* sesuatu yang menurut saya agak-agak mengerikan. Hal seperti ini saya sudah mencurigai karena adanya kesalahan konfigurasi atau konfigurasi yang belum sempurna pada direktori yang mengatur gpg (`~/.gnupg/`). Hal ini dapat memungkinkan orang yang tidak berkepentingan apabila mendapatkan akses ke dalam direktori home saya, mungkin saja dapat mengambil keuntungan dari celah seperti ini.

# Solusi

Dari *warning* yang diberikan, sudah sangat jelas bahwa yang menjadi perhatian adalah direktori `~/.gnupg/` yang berada di direktori home saya. Maka kita akan memperbaiki *permissions* dari direktori tersebut.

Berdasarkan jawaban yang dituliskan oleh Alex Stragies pada [superuser.com<sup>2</sup>]({{ site.url }}/blog/memperbaiki-gpg-permissions-on-homedir#referensi){:target="_blank"} yang juga merujuk pada [wikipedia.com - file system permission<sup>3</sup>]({{ site.url }}/blog/memperbaiki-gpg-permissions-on-homedir#referensi){:target="_blank"} diperkuat oleh jawaban dari Neil Williams pada [lists.gnupg.com<sup>4</sup>]({{ site.url }}/blog/memperbaiki-gpg-permissions-on-homedir#referensi){:target="_blank"}, untuk memperbaiki permasalahan *unsafe permissions* sebagai berikut.

1. Pastikan bahwa *permissions* dari direktori dan file-file yang terdapat pada `~/.gnupg/` adalah milik kita sendiri.

   {% shell_user %}
chown -R $(whoami) ~/.gnupg/
{% endshell_user %}

2. Selanjutnya, perbaiki hak akses dari direktori `~/.gnupg/` beserta file-file yang terdapat di dalamnya.

   {% shell_user %}
chmod 600 ~/.gnupg/*
chmod 700 ~/.gnupg
{% endshell_user %}

   Penjelasan untuk *command* di atas, *permission* `700` pada direktori `~/.gnupg/`, dimaksudkan hanya pemilik dari direktori yang dapat mengakses direktori tersebut. Sedangkan untuk *permission* `600` pada semua file (ditandai dengan tanda `*`) yang terdapat di dalam direktori tersebut, dimaksudkan hanya pemilik direktori tersebut yang dapat membaca dan menulis.

<br>
Setelah melakukan kedua langkah di atas, sangat saya rekomendasikan untuk **reboot** sistem kalian. Karena saya mengalami sendiri keanehan seperti **tidak dapat menemukan *secret key***. Apabila terjadi *error* seperti ini, saya sangat merekomendasikan untuk *restart* sistem terlebih dahulu.

Saya rasa cukup seperti ini saja.



# Referensi

1. [gnupg.org/](https://gnupg.org/){:target="_blank"}
<br>Diakses tanggal: 18/06/22

2. [superuser.com/questions/954509/what-are-the-correct-permissions-for-the-gnupg-enclosing-folder-gpg-warning](https://superuser.com/questions/954509/what-are-the-correct-permissions-for-the-gnupg-enclosing-folder-gpg-warning){:target="_blank"}
<br>Diakses tanggal: 18/06/22

3. [en.wikipedia.org/wiki/File_system_permissions#Notation_of_traditional_Unix_permissions](https://en.wikipedia.org/wiki/File_system_permissions#Notation_of_traditional_Unix_permissions){:target="_blank"}
<br>Diakses tanggal: 18/06/22

4. [lists.gnupg.org/pipermail/gnupg-users/2003-October/020342.html](https://lists.gnupg.org/pipermail/gnupg-users/2003-October/020342.html){:target="_blank"}
<br>Diakses tanggal: 18/06/22

