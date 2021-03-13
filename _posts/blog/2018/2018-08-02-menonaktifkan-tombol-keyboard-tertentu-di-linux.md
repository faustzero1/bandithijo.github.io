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
hot:
contributors: []
description:
---

<!-- BANNER OF THE POST -->
<img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="https://s20.postimg.cc/9myvdtav1/banner_post_19.png" onerror="imgError(this);" alt="banner">

# Permasalahan
Terkadang kita ingin membuat tombol tertentu pada keyboard untuk tidak aktif atau mengganti fungsinya menjadi fungsi yang lain. Misal, menonaktifkan tombol <kbd>PrtSc</kbd> pada keyboard ThinkPad keluaran 2014 ke atas karena letaknya yang diapit dua tombol lain, <kbd>Right Alt</kbd> <kbd>PrtSc</kbd> <kbd>Right Ctrl</kbd> sehingga lebih sering salah pencet saat akan menekan Alt atau Ctrl.

# Pemecahan Masalah

Lagkah-langkah yang saya lakukan di bawah ini saya lakukan pada distribusi sistem operasi Arch Linux. Seharusnya tidak jauh berbeda dengan distribusi yang lain.

# Menonaktifkan Tombol pada Console

1. Deteksi **keycode** dari tombol keyboard yang kita tekan menggunakan perintah di bawah.

   {% shell_user %}
sudo showkey
{% endshell_user %}

   Kemudian tekan tombol yang ingin dinonaktifkan fungsinya (dalam contoh ini adalah <kbd>PrtSc</kbd>), nanti akan keluar output seperti di bawah.

   ```
   keycode 99 press
   keycode 99 release
   ```

   Berarti keycode dari tombol <kbd>PrtSc</kbd> adalah `99`.

   Langkah selanjutnya, kita akan mengedit file `.map` dan memasukkan keycode `99` dalam daftar. `showkey` akan keluar secara otomatis apabila dalam waktu 10 detik kita tidak menekan tombol apapun pada keyboard.

2. Masuk ke dalam direktori `/usr/share/kbd/keymaps/i386/qwerty`

   {% shell_user %}
cd /usr/share/kbd/keymaps/i386/qwerty
{% endshell_user %}

3. Kita copy-kan *default keymap* menjadi nama file yang lain. Keymaps saya adalah US.

   {% shell_user %}
sudo cp us.map.gz personal.map.gz
{% endshell_user %}

4. Ekstrak file `personal.map.gz` menggunakan perintah `gunzip`.

   {% shell_user %}
gunzip personal.map.gz
{% endshell_user %}

5. Edit file `personal.map` menggunakan *text editor* favorit kalian.

   {% shell_user %}
sudo vim personal.map
{% endshell_user %}

   Lalu tambahkan di baris paling bawah.

   {% highlight_caption /usr/share/kbd/keymaps/i386/qwerty/personal.map %}
   {% pre_caption %}
...
...

keycode 99 = nul
{% endpre_caption %}

   Ingat, `99` disini adalah *keycode* dari tombol <kbd>PrtSc</kbd> yang kita dapatkan pada langkah nomor 1 di atas. Apabila ingin menonaktifkan tombol lain, silahkan diganti dengan keycode dari tombol yang ingin dinonaktifkan.

6. Kompres kembali file `personal.map` menggunakan perintah `gzip`.

   {% shell_user %}
gzip personal.map
{% endshell_user %}

   Kemudian untuk mengaktifkan file map yang kita buat ini, jalankan.

   {% shell_user %}
sudo loadkeys personal
{% endshell_user %}

   Lakukang pengujian dengan mnenjalankan `showkey` kembali.

7. Namun pengaturan `loadkeys` ini tidak permanen, kita dapat membuat menjadi permanen dengan mengedit isi dari file `/etc/vconsole.conf` (buat file `vconsole.conf` apabila belum tersedia).

   {% shell_user %}
sudo vim /etc/vconsole.conf
{% endshell_user %}

   ```
   KEYMAP=us
   ```

   Diganti dengan

   ```
   KEYMAP=personal
   ```
8. Lakukan pengujian dengan me-*Reboot* sistem kamu.

# Menonaktifkan Tombol pada X

Langkah-langkah di atas hanya berlaku pada **console**, apabila kita ingin menonaktifkan tombol <kbd>PrtSc</kbd> juga pada **X**, salah satu cara yang dapat dilakukan adalah meng-*comment* *keycode* nya dari dalam file `evdev`.

1. Buka file `/usr/share/X11/xkb/keycodes/evdev` dengan menggunakan *text editor* favorit kalian.

   {% shell_user %}
sudo vim /usr/share/X11/xkb/keycodes/evdev
{% endshell_user %}

2. Cari *key code* untuk tombol <kbd>PrtSc</kbd>.

   {% highlight_caption /usr/share/X11/xkb/keycodes/evdev %}
   {% pre_caption %}
 ...
 &lt;PRSC> = 107;
 ...
{% endpre_caption %}

3. Kemudian, *disable* dengan memberikan tanda komentar (`//`).

   {% highlight_caption /usr/share/X11/xkb/keycodes/evdev %}
   {% pre_caption %}
 ...
 // &lt;PRSC> = 107;
 ...
{% endpre_caption %}

<br>
Dengan begini maka tombol <kbd>PrtSc</kbd> benar-benar dinonaktifkan baik di console, terminal, dan X window.

Saya rasa cukup seperti ini dulu.

# Referensi

1. [unix.stackexchange.com/questions/74151/fully-disable-prntscr-key](https://unix.stackexchange.com/questions/74151/fully-disable-prntscr-key){:target="_blank"}
<br>Diakses tanggal: 18/08/02
