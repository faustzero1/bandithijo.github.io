---
layout: 'post'
title: "Menghandle Pengarsipan pada FreeBSD dengan 7-Zip"
date: 2020-03-09 16:41
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'FreeBSD']
pin:
hot:
contributors: []
resume: "Selama ini, saya selalu menggunkan tools pengarsipan GUI. Ternyata dengan 7zip, pengarsipan di Terminal juga jadi lebih mudah. Ada banyak sekali option dan parameter yang dapat kita gunakan. Tapi saya hanya mencatat sebagian kecil yang saya perlukan."
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Pendahuluan

Oke!

Sistem sudah siap untuk dipakai menulis kembali.

Mungkin sebagian dari teman-teman sudah mengetahui kalau saya baru saja bermigrasi dari Arch Linux ke FreeBSD. Kira-kira akhir Februari 2020, saya memulai proses migrasi. Berarti saat ini sudah hampir dua pekan lebih.

# Permasalahan

Dalam proses migrasi dari Arch Linux ke FreeBSD, meski sama-sama sistem operasi UNIX like (mirip UNIX), namun keduanya tidak benar-benar sama. Saya mendapati beberapa aplikasi baik GUI, TUI, bahkan script sekalipun, tidak semuanya dapat saya gunakan kembali di FreeBSD.

Berpindah ke FreeBSD merupakah hal yang berbeda. Bukan seperti berpindah antara distribusi sistem operasi Linux, dari Fedora Linux ke Arch Linux.

Bahkan pada FreeBSD ports, terdapat pemaketan aplikasi yang dependensinya "menyebalkan" (menurut saya).

Misalnya, saya memerlukan program tools pengarsipan GUI. Diantara yang saya tahu adalah **file-roller**, **Xarchiver**, **ark**. Yang biasa saya pergunakan adalah file-roller dan xarchiver. Biasanya saya memasang kedua archiver ini. Namun, saat akan memasang file-roller, saya dihadapkan pada dependensi yang jug amembawa nautilus, gnome-desktop, tracker, dll. Ahahaha.

**Kenapa tidak menggunakan Xarchiver saja?**

Xarchiver tidak dapat membuat dan membuka arsip `.zip` yang terenkripsi (berpassword). Namun, dapat dilakukan dengan mudah oleh file-roller. Maka dari itu saya biasanya menggunakan file-roller.

# Pemecahan Masalah

Karena hal tersebut di atas, saya tidak jadi memasang file-roller dan mencari alternatif lain.

Teringatlah dengan 7-Zip.

Kebetulan saya menginginkan workflow seperti ini.

1. Membuka dan melihat isi dari file archive menggunakan GUI
2. Membuat dan mengekstrak (baik dengan atau tanpa enkripsi) menggunakan command terminal.

Untuk poin nomor satu, saya memilih menggunakan Xarchiver.

Untuk poin nomor dua, saya memilih menggunakan 7-Zip.

Nah, karena proses membuat dan mengekstrak file archive dengan 7-Zip ini menggunakan perintah-perintah terminal, maka saya pun memutuskan untuk membuat catatan. Tentu saja agar dapat saya lihat kembali pada kesempatan yang lain. Karena tidak setiap waktu saya menggunakan perintah pengarsipan 7-Zip, tentu saja hal ini akan mengakibatkan lupa di kemudian hari.

Sejujurnya, saya agak menyesal, "Mengapa baru menggunakan 7-Zip sekarang."

Padahal selalu terpasang di setiap distro GNU/Linux yang saya gunakan. Hahaha.


# Penggunaan

Sebagai catatan untuk teman-teman, saya hanya akan mencatat perintah-perintah dasar.

Perlu diketahui, bahwa 7-Zip adalah program aplikasi pengarsipan yang luar keren.

Maksudnya keren di sini adalah, selain free dan open-source, 7-Zip juga memiliki fitur-fitur yang mumpuni, diantaranya:

1. High compression ratio (7z format) dengan LZMA dan LZMA2 compression
2. Format dukungan yang banyak
   - Packing / Unpacking: 7z, XZ, BZIP2, GZIP, TAR, ZIP dan WIM
   - Unpacking only: RAR, DMG, EXT, GPT, MBR, ISO, UEFI, UDF, VDI, VHD, VMDK, dll
3. Untuk ZIP dan GZIP format, 7-Zip menyediak compression ratio hingga 2-10%
4. Enkripsi AES-256 pada 7z dan ZIP format
5. Memiliki command line yang powerful
6. [dst.](https://www.7-zip.org/){:target="_blank"}

## Batasan Penggunaan

Karena 7-Zip memiliki perintah-perintah command line yang powerful dan banyak, maka pada catatan ini saya hanya membatasi pada:

1. Membuat ZIP format dengan enkripsi
2. Mengekstrak ZIP format yang terenkripsi

## Membuat Arsip Berformat ZIP yang Terenkripsi

Untuk membuat ZIP archive dengan enkripsi, caranya sangat mudah.

**Membuat file ZIP dari beberapa file (file1, file2, file3)**

{% shell_user %}
7z a -p arsip.zip file1.doc file2.xls file3.ppt
{% endshell_user %}

Keterangan:

1. **7z**: adalah program 7-Zip
2. **a**: penambahan, merupakan insial dari kata *add*
3. **-p**: mengeset password, merupakan inisial dari kata *password*
4. **arsip.zip**: output file yang diinginkan
5. **file1.doc, file2.xls, file3.ppt**: file-file yang akan diarsipkan

Setelah menekan tombol <kbd>Enter</kbd>, akan diminta untuk memasukkan password.

```
7-Zip [64] 16.02 : Copyright (c) 1999-2016 Igor Pavlov : 2016-05-21
p7zip Version 16.02 (locale=en_US.UTF-8,Utf16=on,HugeFiles=on,64 bits,2 CPUs x64)

Scanning the drive:
3 files, 0 bytes

Creating archive: arsip.zip

Items to compress: 3


Enter password (will not be echoed):
Verify password (will not be echoed) :

Files read from disk: 3
Archive size: 448 bytes (1 KiB)
Everything is Ok
```

Kalau berhasil, file arsip berformat ZIP yang terenkripsi telah berhasil dibuat.

<pre>
<mark>-rw-r--r--  1 bandithijo  bandithijo  448 Mar  9 18:54 arsip.zip</mark>
-rw-r--r--  1 bandithijo  bandithijo    0 Mar  9 18:51 file1.doc
-rw-r--r--  1 bandithijo  bandithijo    0 Mar  9 18:51 file2.xls
-rw-r--r--  1 bandithijo  bandithijo    0 Mar  9 18:51 file3.ppt
</pre>

Ilustrasinya kira-kira seperti ini.

{% image https://i.postimg.cc/Y9W5f9Xs/gambar-01.gif | 1 %}

{% box_info %}
<p>Selain membuat arsip berformat ZIP dari beberapa file, dapat pula langsung membuat file pada direktori.
<br>
Misalkan, saya memiliki direktori bernama <b>arsip/</b>.

<pre>
$ <b>7z a -p arsip.zip arsip</b>
</pre>
</p>
{% endbox_info %}

## Mengekstrak Arsip Berformat ZIP yang Terenkripsi

Untuk mengkestrak ZIP archive yang terenkripsi, caranya sangat mudah sekali.

Cukup menggunakan *function letter* yang sama seperti untuk mengekstrak arsip biasa, yaitu `x`.

{% shell_user %}
7z x arsip.zip
{% endshell_user %}


Kemudian, akan diminta memasukkan password untuk proses dekripsi.

```
7-Zip [64] 16.02 : Copyright (c) 1999-2016 Igor Pavlov : 2016-05-21
p7zip Version 16.02 (locale=en_US.UTF-8,Utf16=on,HugeFiles=on,64 bits,2 CPUs x64)

Scanning the drive for archives:
1 file, 448 bytes (1 KiB)

Extracting archive: arsip.zip
--
Path = arsip.zip
Type = zip
Physical Size = 448


Enter password (will not be echoed):
Everything is Ok

Files: 3
Size:       0
Compressed: 448
```

Nah kalau berhasil,

<pre>
-rw-r--r--  1 bandithijo  bandithijo  448 Mar  9 19:24 arsip.zip
<mark>-rw-r--r--  1 bandithijo  bandithijo    0 Mar  9 18:51 file1.doc</mark>
<mark>-rw-r--r--  1 bandithijo  bandithijo    0 Mar  9 18:51 file2.xls</mark>
<mark>-rw-r--r--  1 bandithijo  bandithijo    0 Mar  9 18:51 file3.ppt</mark>
</pre>

Ilustrasinya kira-kira seperti ini.

{% image https://i.postimg.cc/SRGtDzcD/gambar-02.gif | 2 %}

# Pesan Penulis

Sepertinya, hanya ini saja yang saat ini dapat saya catat.

Mungkin pada kesempatan yang lain, akan ada penambahan untuk *ultra compression* yang dimiliki oleh 7-Zip.

Apabila terdapat kesalahan pada catatan ini, saya sangat merekomendasikan untuk merujuk pada 7-Zip manual.

Sekian, mudah-mudahan catatan yang sederhana ini juga dapat bermanfaat untuk teman-teman yang memerlukan.

Terima kasih.

(^_^)







# Referensi

1. [www.2daygeek.com/zip-7zip-encrypt-decrypt-password-protect-files-folders-linux/](https://www.2daygeek.com/zip-7zip-encrypt-decrypt-password-protect-files-folders-linux/){:target="_blank"}
<br>Diakses tanggal: 2020/03/09

2. [www.7-zip.org/](https://www.7-zip.org/){:target="_blank"}
<br>Diakses tanggal: 2020/03/09
