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

Secara _default_, Arch Linux yang telah kita _install_ telah memiliki akun, yaitu `root`. Yang ditandai dengan tanda `#` pada Terminal. Dan saat ini pun kita sedang menggunakan akun `root`. Namun akun ini secara _default_ **belum memiliki password**. Oleh karena itu kita perlu bahkan lebih ke-**harus** mengeset _password_ untuk akun `root`.

```
# passwd root
```

Kemudian, masukkan _password_ untuk akun `root`. Karakter _password_ memang tidak akan ditampilkan. Kamu akan diminta memasukkan _password_ yang sama, sebanyak dua kali. Dan **jangan sampai lupa**, karena akun `root` ini adalah akun yang sangat penting.
```
New password:
Retype new password:
passwd: password updated successfully
```

Kita sudah membuat _password_ untuk akun `root`. Namun, untuk pengunaan sehari-hari sebaiknya kita tidak menggunakan akun ini. Sangat direkomendasikan untuk membuat akun `user`. Caranya sebagai berikut.

Buat _group_ `sudo` terlebih dahulu.

```
# groupadd sudo
```

Kemudian buat _username_.

```
# useradd -m -g users -G sudo,storage,wheel,power bandithijo
```

Saya menggunakan _username_ **bandithijo**. Kamu dapat mengganti dengan _username_ yang kamu inginkan. Sebagai catatan _username_ haruslah berupa karakter huruf, _lowercase_ \(huruf kecil\), dan tidak boleh ada spasi.

Setelah membuat akun `user`, kita akan mengeset _password_ untuk user baru ini.

```
# passwd bandithijo
```
```
New password:
Retype new password:
passwd: password updated successfully
```

Masukkan _password_ untuk akun **bandithijo**.

Selanjutnya, mengeset `/etc/sudoers`. Kita akan mengaktifkan perintah `sudo` agar dapat memiliki kemampuan seperti _superuser_.

Kemudian, _edit_ file `/etc/sudoers`.

```
# vim /etc/sudoers
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

Simpan dan keluar.

Untuk Vim, simpan dengan `:w!` untuk memaksa menyimpan perubahan pada file dengan *read only permisson*.

## 6.2 Hostname

Pada _step_ ini, kita akan memberikan _hostname_ pada sistem kita. Sebenarnya ini bukan hal yang _crucial_, namun karena ini komputer atau laptop pribadi kita, ada baiknya kita memberikan preferensi tersendiri.

Untuk mengkonfigurasi `hostname`,

```
# echo “Arch-Machine” > /etc/hostname
```

Perintah di atas akan menambahkan `Arch-Machine` pada _file_ `/etc/hostname`. Kita dapat mengecek isi dari `/etc/hostname` dengan menggunakan perintah `$ cat /etc/hostname`.

Penamaan `hostname` berbeda dengan penamaan pada `username`. Pada `hostname`, kita dapat menggunakan _uppercase_ \(kapital\), angka, simbol dan tanpa spasi.

<hr>
Oke, saat ini proses konfigurasi dasar dari sistem operasi Arch Linux sudah selesai. Namun, kita membutuhkan sistem operasi yang pengoperasiannya menggunakan GUI \(_Graphical User Interface_\) atau biasa dikenal dengan DE \(_Desktop Environment_\) agar kita dapat menggunakan sistem operasi ini dengan mudah. Karena saat ini, sudah sangat jarang ditemukan user yang masih menggunakan _text mode_ atau WM \(_Window Manager_\) pada komputer atau laptop pribadinya. Meskipun saya termasuk yang malah ketagihan menggunakan WM.

Langkah selanjutnya adalah melihat apakah proses instalasi kita berhasil atau tidak. Kita akan melakukan _reboot system_ untuk mengeceknya.

Namun sebelumnya, tambahkan dulu paket-paket di bawah ini. Agar memudahkan konektifitas jaringan. Saat kita sudah memasuki sistem dasar yang sudah kita bangun.
```
# pacman -S networkmanager network-manager-applet
```
Aktifkan servicenya.
```
# systemctl enable NetworkManager.service
```
<!-- INFORMATION -->
<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>Saya tidak memasang <code>network-manager-applet</code> karena lebih terbiasa menggunakan <code>nmtui</code> (Network Manager Terminal User Interface) yang sudah disertakan bersama paket <code>networkmanager</code>.</p>
</div>

Setelah itu _exit_ dari `chroot`.

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
Arch-Machine login: _
```

_Login_ dengan akun yang telah kita buat pada Step 6.1.

```
Last login: Thu Nov 16 14:57:01 on tty1
[bandithijo@Arch-Machine ~]$ _
```

Kalau pada tahap ini kalian berhasil. **Welcome to the BrotherHood !**


<!-- NEXT PREV BUTTON -->
<div class="post-nav">
<a class="btn-blue-l" href="/arch/step-5-set-language-and-time-zone"><img style="width:20px;" src="/assets/img/logo/logo_ap.png"></a>
<a class="btn-blue-c" href="/arch/"><img style="width:20px;" src="/assets/img/logo/logo_menu.svg"></a>
<a class="btn-blue-r" href="/arch/step-7-install-gnome-and-complete-installation"><img style="width:20px;" src="/assets/img/logo/logo_an.png"></a>
</div>
