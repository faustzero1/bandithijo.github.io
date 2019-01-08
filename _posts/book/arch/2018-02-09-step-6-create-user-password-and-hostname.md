---
layout: 'post'
title: 'Step 6: Create User, Password and Hostname'
date: 2018-02-09 07:00
permalink: '/arch/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'arch'
tags:
pin:
---


# STEP 6 : Create User, Password and Hostname

## 6.1 User and Password

Secara _default_, Arch Linux yang telah kita _install_ telah memiliki akun, yaitu `root`. Yang ditandai dengan tanda `#` pada Terminal. Dan saat ini pun kita sedang menggunakan akun `root`. Namun akun ini secara _default_ **belum memiliki password**. Oleh karena itu kita perlu \(**harus**\) mengeset _password_ untuk akun `root`.

```
# passwd root
```

Kemudian, masukkan _password_ untuk akun `root`. Karakter _password_ memang tidak akan ditampilkan. Kamu akan diminta memasukkan _password_ yang sama, sebanyak dua kali. Dan jangan sampai lupa, karena akun `root` ini adalah akun yang sangat penting.

Kita sudah membuat _password_ untuk akun `root`. Namun, untuk pengunaan sehari-hari sebaiknya kita tidak menggunakan akun ini. Sangat direkomendasikan untuk membuat akun `user`. Caranya sebagai berikut.

Buat _group_ `sudo` terlebih dahulu.

```
# groupadd sudo
```

Kemudian buat _username_.

```
# useradd -m -g users -G sudo,storage,wheel,power archer
```

Saya menggunakan _username_ **archer**. Kamu dapat mengganti dengan _username_ yang kamu inginkan. Sebagai catatan _username_ haruslah berupa karakter huruf, _lowercase_ \(huruf kecil\), dan tidak boleh ada spasi.

Setelah membuat akun `user`, kita akan mengeset _password_-nya.

```
# passwd archer
```

Masukkan _password_ untuk akun **archer**.

Selanjutnya, mengeset `/etc/sudoers`. Kita akan mengaktifkan perintah `sudo` agar dapat memiliki kemampuan seperti _superuser_.

Kemudian, _edit_ dengan `nano` _text editor_ `/etc/sudoers`.

```
# nano /etc/sudoers
```

_Scrolling_ ke bawah dan cari `# %sudo ALL = (ALL) ALL`. Lalu hapus tanda pagar `#` untuk meng-_enable_-kan user yang termasuk dalam _group_ `sudo` dapat mengeksekusi semua _command_ \(perintah\) pada Terminal. Hasilnya seperti contoh di bawah.

<pre>
...
...
## Uncomment to allow members of group sudo to execute any command
<mark>   %sudo    ALL=(ALL) ALL</mark>
...
...
</pre>

## 6.2 Hostname

Pada _step_ ini, kita akan memberikan _hostname_ pada sistem kita. Sebenarnya ini bukan hal yang _crucial_, namun karena ini komputer atau laptop pribadi kita, ada baiknya kita memberikan preferensi tersendiri.

Untuk mengkonfigurasi `hostname`,

```
# echo “Archer-Computer” > /etc/hostname
```

Perintah di atas akan menambahkan `Archer-Computer` pada _file_ `/etc/hostname`. Kita dapat mengecek isi dari `/etc/hostname` dengan menggunakan perintah `$ cat /etc/hostname`.

Penamaan `hostname` berbeda dengan penamaan pada `username`. Pada `hostname`, kita dapat menggunakan _uppercase_ \(kapital\), angka, simbol dan tanpa spasi.

Oke, saat ini proses konfigurasi dasar dari sistem operasi Arch Linux sudah selesai. Namun, kita membutuhkan sistem operasi yang pengoperasiannya menggunakan GUI \(_Graphical User Interface_\) atau biasa dikenal dengan DE \(_Desktop Environment_\) agar kita dapat menggunakan sistem operasi ini dengan mudah. Karena saat ini, sudah sangat jarang ditemukan user yang masih menggunakan _text mode_ atau WM \(_Window Manager_\) pada komputer atau laptop pribadinya. Meskipun saya termasuk yang malah ketagihan menggunakan WM.

Langkah selanjutnya adalah melihat apakah proses instalasi kita berhasil atau tidak. Kita akan melakukan _reboot system_ untuk mengeceknya.

_Exit_ dari `chroot`.

```
# exit
```

_Unmounting_ semua partisi yang sebelumnya kita _mount_ ke direktori `/mnt`.

```
# umount -R /mnt
```

Lalu _restart_.

```
# reboot
```

Setelah berhasil menampilkan halaman _login_.

```
Arch Linux 4.13.12-1-ARCH (tty1)
Archer-Computer login: _
```

_Login_ dengan akun yang telah kita buat pada Step 6.1.

```
Last login: Thu Nov 16 14:57:01 on tty1
[archer@Archer-Computer ~]$ _
```

Kalau pada tahap ini kalian berhasil. **Welcome to the BrotherHood !**


<!-- NEXT PREV BUTTON -->
<div class="post-nav">
<a class="btn-blue-l" href="/arch/step-5-set-language-and-time-zone"><img style="width:20px;" src="/assets/img/logo/logo_ap.png"></a>
<a class="btn-blue-c" href="/arch/"><img style="width:20px;" src="/assets/img/logo/logo_menu.png"></a>
<a class="btn-blue-r" href="/arch/step-7-install-gnome-and-complete-installation"><img style="width:20px;" src="/assets/img/logo/logo_an.png"></a>
</div>
