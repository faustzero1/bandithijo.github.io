---
layout: 'post'
title: 'Menonaktifkan Tombol Keyboard Tertentu di GNU/Linux'
date: 2018-08-02 12:07
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips']
pin:
---

<!-- BANNER OF THE POST -->
<img class="post-body-img" src="https://s20.postimg.cc/9myvdtav1/banner_post_19.png" alt="banner">

# Permasalahan
Terkadang kita ingin membuat tombol tertentu pada keyboard untuk tidak aktif atau mengganti fungsinya menjadi fungsi yang lain. Misal, menonaktifkan tombol <kbd>PrtSc</kbd> pada keyboard ThinkPad keluaran 2014 ke atas karena letaknya yang diapit dua tombol lain, <kbd>Right Alt</kbd> <kbd>PrtSc</kbd> <kbd>Right Ctrl</kbd> sehingga lebih sering salah pencet saat akan menekan Alt atau Ctrl.

# Pemecahan Masalah

Lagkah-langkah yang saya lakukan di bawah ini saya lakukan pada distribusi sistem operasi Arch Linux. Seharusnya tidak jauh berbeda dengan distribusi yang lain.

# Menonaktifkan Tombol pada Console

1. Deteksi **keycode** dari tombol keyboard yang kita tekan menggunakan perintah di bawah.
```
$ sudo showkey
```
Kemudian tekan tombol yang ingin dinonaktifkan fungsinya (dalam contoh ini adalah <kbd>PrtSc</kbd>), nanti akan keluar output seperti di bawah.
```
keycode 99 press
keycode 99 release
```
Berarti keycode dari tombol <kbd>PrtSc</kbd> adalah `99`.
Langkah selanjutnya, kita akan mengedit file `.map` dan memasukkan keycode `99` dalam daftar. `showkey` akan keluar secara otomatis apabila dalam waktu 10 detik kita tidak menekan tombol apapun pada keyboard.

2. Masuk ke dalam direktori `/usr/share/kbd/keymaps/i386/qwerty`
```
$ cd /usr/share/kbd/keymaps/i386/qwerty
```
3. Kita copy-kan *default keymap* menjadi nama file yang lain. Keymaps saya adalah US.
```
$ sudo cp us.map.gz personal.map.gz
```
4. Ekstrak file `personal.map.gz` menggunakan perintah `gunzip`.
```
$ gunzip personal.map.gz
```
5. Edit file `personal.map` menggunakan *text editor* favorit kalian.
```
$ sudo vim personal.map
```
lalu tambahkan di baris paling bawah.
```
...
...
keycode 99 = nul
```
Ingat, `99` disini adalah *keycode* dari tombol <kbd>PrtSc</kbd> yang kita dapatkan pada langkah nomor 1 di atas. Apabila ingin menonaktifkan tombol lain, silahkan diganti dengan keycode dari tombol yang ingin dinonaktifkan.
6. Kompres kembali file `personal.map` menggunakan perintah `gzip`.
```
$ gzip personal.map
```
kemudian untuk mengaktifkan file map yang kita buat ini, jalankan.
```
$ sudo loadkeys personal
```
Lakukang pengujian dengan mnenjalankan `showkey` kembali.
7. Namun pengaturan `loadkeys` ini tidak permanen, kita dapat membuat menjadi permanen dengan mengedit isi dari file `/etc/vconsole.conf` (buat file `vconsole.conf` apabila belum tersedia).
```
$ sudo vim /etc/vconsole.conf
```
```
KEYMAP=us
```
diganti dengan
```
KEYMAP=personal
```
8. Lakukan pengujian dengan me-*Reboot* sistem kamu.

# Menonaktifkan Tombol pada X
Langkah-langkah di atas hanya berlaku pada **console**, apabila kita ingin menonaktifkan tombol <kbd>PrtSc</kbd> juga pada **X**, salah satu cara yang dapat dilakukan adalah meng-*comment* *keycode* nya dari dalam file `evdev`.

1. Buka file `/usr/share/X11/xkb/keycodes/evdev` dengan menggunakan *text editor* favorit kalian.
```
$ sudo vim /usr/share/X11/xkb/keycodes/evdev
```
2. Cari *key code* untuk tombol <kbd>PrtSc</kbd>.
{% raw %}
    ```
    ...
    <PRSC> = 107;
    ...
    ```
{% endraw %}
3. Kemudian, *disable* dengan memberikan tanda komentar (`//`).
{% raw %}
    ```
    ...
    // <PRSC> = 107;
    ...
    ```
{% endraw %}

<br>
Dengan begini maka tombol <kbd>PrtSc</kbd> benar-benar dinonaktifkan baik di console, terminal, dan X window.

Saya rasa cukup seperti ini dulu.

# Referensi

1. [https://unix.stackexchange.com/questions/74151/fully-disable-prntscr-key](https://unix.stackexchange.com/questions/74151/fully-disable-prntscr-key){:target="_blank"}
<br>Diakses tanggal: 18/08/02
