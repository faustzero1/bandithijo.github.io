---
layout: 'post'
title: 'Menonaktifkan WebCam di GNU/Linux'
date: 2018-06-03 13:23
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags:
pin:
---

<!-- BANNER OF THE POST -->
<img class="post-body-img" src="https://s20.postimg.cc/40nbmxl8d/banner_post_15.png" alt="banner">

# Pendahuluan

Sepintas membaca judul dari tulisan ini memang rada-rada janggal. Disaat semua pengguna GNU/Linux ingin membuat *hardware* mereka dapat berfungsi, ini malah sebaliknya. Yaa terkadang memang ada hal-hal yang belum dapat kita mengerti saat ini dengan mudah. Menonaktifkan *webcam* ini erat kaitannya dengan *privacy*.

*Privacy* adalah kata yang menjadi perhatian banyak pihak. Biasanya pengguna sistem operasi GNU/Linux juga cukup memperhatikan hal-hal seperti ini. Salah satu yang menjadi perhatian adalah informasi yang mengabarkan bahwa *malware* dapat dengan mudah mengakses penggunaan *webcam* yang terdapat di laptop kita. Kemungkinan seperti ini dapat terjadi pada laptop kita, tulisan kali ini akan mendokumentasikan bagaimana cara melakukan *disable* dan *enable* pada *webcam* pada tingkat *driver*.

# Caranya

## Identifikasi Driver

Pertama, kalian perlu mengetahui *webcam driver* menggunakan perintah di bawah ini.
```
$ sudo lsmod | grep uvcvideo
```
```
uvcvideo            114644  0
videobuf2_vmalloc    16348  1 uvcvideo
videobuf2_v4l2       28627  1 uvcvideo
videobuf2_common     53284  2 uvcvideo,videobuf2_v4l2
videodev            208869  3 uvcvideo,videobuf2_common,videobuf2_v4l2
media                45065  2 uvcvideo,videodev
usbcore             286702  5 uvcvideo,usbhid,xhci_pci,btusb,xhci_hcd
```
Dari hasil di atas dapat diketahui bahwa **uvcvideo** adalah *webcam driver* yang saya gunakan.

## Menonaktifkan Driver

Selanjutnya, tinggal menonaktifkan driver **uvcvideo** dengan memasukkannya dalam daftar *blacklist*.

Caranya, buka Terminal dan *edit* file `/etc/modprobe.d/blacklist.conf`

(apabila tidak ada, buat saja filenya).
```
$ sudo vim /etc/modprobe.d/blacklist.conf
```
Gunakan *text editor* favoritmu, seperti nano, gedit, mousepad, dll.

Lalu, tambahkan baris berikut ini.
```
blacklist uvcvideo
```
Simpan dan keluar.

Untuk melihat hasilnya, kita perlu melakukan *reboot*. Setelah itu, coba buka aplikasi *webcam* seperti **Cheese** atau **guvcview**.

Apabila berhasil, akan seperti ini jadinya.

![gambar1](https://s20.postimg.cc/tjfo069zx/gambar_01.png)
<p class="img-caption">Gambar 1 - Cheese yang sudah tidak dapat digunakan</p>

<br>
![gambar2](https://s20.postimg.cc/rrmp59ix9/gambar_02.png)
<p class="img-caption">Gambar 2 - guvcview yang sudah tidak dapat digunakan</p>

<br>
Saya sendiri belum tahu, apakah cara ini efektif dan benar dapat menangkal penyusup untuk mengakses *webcam* kita atau tidak. Setidaknya kita maish dapat menggunakan cara ini untuk tujuan yang lain.


<br>
><p class="title-quote">[ ! ] Tips dari Penulis</p>
>Tips ini hanya diperuntukkan apabila file `/etc/modprobe.d/blacklist.conf` yang kamu miliki kosong.
>
>Kita akan membuat `alias` di Terminal, untuk memudahkan dalam mengaktifkan dan menonaktifkan *webcam* apabila sewaktu-waktu kita perlukan.
>
>Selanjutnya, buka `.bashrc` atau `.zshrc` (tergantung kalian menggunakan tipe shell yang mana).
>
>```
>$ vim .zshrc
>```
>dan tambahkan baris alias berikut ini. (terserah pada baris ke berapa saja)
>
>```
># Enable & Disable WebCam
>alias webcam-disable="echo 'blacklist uvcvideo' | sudo tee /etc/modprobe.d/blacklist.conf; echo '[Disable] WebCam'"
>alias webcam-enable="echo '' | sudo tee /etc/modprobe.d/blacklist.conf; echo '[Enable] WebCam'"
>```
>
>Lalu refresh Terminal dengan menggunakna perintah.
>```
>$ exec $SHELL
>```
>Dan coba panggil `alias` yang sudah kita buat tadi.
>
>![gambar3](https://s20.postimg.cc/ty871znbh/gambar_03.gif)
>
>Mudah bukan ? ^_^

# Referensi

1. [https://www.ostechnix.com/how-to-disable-built-in-webcam-in-ubuntu/](https://www.ostechnix.com/how-to-disable-built-in-webcam-in-ubuntu/){:target="_blank"}
<br>Diakses tanggal: 2018/06/03
