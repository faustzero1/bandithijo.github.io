---
layout: 'post'
title: 'Menggunakan Udiskctl untuk Mount, Unmount, dan Power Off Drive'
date: 2018-12-05 06:25
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
<!-- <img class="post&#45;body&#45;img" src="" alt="banner"> -->

# Prakata

Sudah sejak bulan Juli 2018 saya memigrasikan aplikasi-aplikasi GUI (_Graphical User Interface_) menjadi aplikasi CLI (_Command Line Interface_), maksud saya selain text editor Vim. Memang terdengar absurd. Namun, ternyata setelah saya mencoba satu aplikasi, saya pun ketagihan dan mencoba mencari-cari aplikasi mana yang dapat saya migrasikan ke CLI. Untuk cerita migrasi aplikasi ini aka saya sambung pada artikel yang lain.

Karena alasan tersebut di atas, saya sampai pada tahap memigrasikan _File Manager_. _File Manager_ yang menjadi _favorite_ saya adalah **PCManFM**. Mungkin kapan-kapan _File Manager_ ini akan saya bahas, mengapa menjadi satu-satunya _File Manager_ yang saya pasang di sistem operasi saya.

# Permasalahan

Salah satu kemampuan dari _file manager_ adalah _mounting/unmounting external drive_, seperti: _Flash Drive_, _External Hard Drive_, _SD Card_, dll. Yang menjadi permasalahan adalah aplikasi _file manager_ pengganti PCManFM yang saya gunakan, **Ranger**, tidak memiliki kemampuan ini. Tentu saja ini tidak sebanding dengan banyak kelebihan yang dimiliki oleh Ranger, maka dari itu saya tetap bersikeras menggunakan Ranger sebagai _file manager_ utama saya.

# Solusi

Untuk memecahkan permasalahan di atas, saya menggunakan aplikasi [**udisck2**](https://www.archlinux.org/packages/?name=udisks2){:target="_blank"}.

Cara menggunakannya sangat mudah.

```
Usage:
  udisksctl COMMAND

Commands:
  help            Shows this information
  info            Shows information about an object
  dump            Shows information about all objects
  status          Shows high-level status
  monitor         Monitor changes to objects
  mount           Mount a filesystem
  unmount         Unmount a filesystem
  unlock          Unlock an encrypted device
  lock            Lock an encrypted device
  loop-setup      Set-up a loop device
  loop-delete     Delete a loop device
  power-off       Safely power off a drive
  smart-simulate  Set SMART data for a drive

Options:
  -p, --object-path         Object path for ATA device
  -b, --block-device        Device file for ATA device
  --no-user-interaction     Do not authenticate the user if needed

Use "udisksctl COMMAND --help" to get help on each command.
```

## Mounting

Untuk me-*mounting* _flash drive_ atau _external hard drive_, hal yang perlu kita lakukan cukup dengan :

1. Cek block dari _drive_ yang akan kita _mounting_ dengan `lsblk`
```
$ lsblk
```
```
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda      8:0    0 447.1G  0 disk
├─sda1   8:1    0   511M  0 part /boot
├─sda2   8:2    0 444.6G  0 part /
└─sda3   8:3    0     2G  0 part [SWAP]
sdX      8:16   1   7.2G  0 disk
```
Periksa nama/block `/dev/sdX` serta size, pastikan benar-benar _drive_ yang anda inginkan

2. Selanjutnya tinggal kita _mount_ menggunakan `udisk2`
```
$ udiskctl mount -b /dev/sdX
```
```
Mounted /dev/sdX at /run/media/username/AAAA-0000.
```
Kemudian cek lagi dengan `lsblk` apakah sudah berhasil di-*mounting*
```
$ lsblk
```
```
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda      8:0    0 447.1G  0 disk
├─sda1   8:1    0   511M  0 part /boot
├─sda2   8:2    0 444.6G  0 part /
└─sda3   8:3    0     2G  0 part [SWAP]
sdX      8:16   1   7.2G  0 disk /run/media/username/AAAA-0000
```
Apabila mengeluarkan tampilan seperti di atas, artinya _mounting_ berhasil.

## Unmounting

Setelah kita selesai berurusan dengan _drive_, sebelum mencabutnya sangat direkomendasikan untuk menjalankan proses _unmounting_. Caranya sangat mudah.

<!-- PERHATIAN -->
<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
Pastikan <i>file manager</i> tidak sedang membuka direktori yang ada di dalam <i>external drive</i> yang akan kita <i>unmount</i>
</div>

1. Jalankan `udisk2` untuk proses _unmounting_
```
$ udiskctl unmount -b /dev/sdX
```
```
Unmounted /dev/sdX
```

2. Selanjutnya lakukan pengecekan dengan `lsblk` untuk memastikan
```
$ lsblk
```
```
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda      8:0    0 447.1G  0 disk
├─sda1   8:1    0   511M  0 part /boot
├─sda2   8:2    0 444.6G  0 part /
└─sda3   8:3    0     2G  0 part [SWAP]
sdX      8:16   1   7.2G  0 disk
```
Apabila mengeluarkan tampilan seperti di atas, artinya _unmounting_ berhasil.

## Power Off

Nah, namun apabila kita perhatikan, _external drive_ masih dalam keadaan menyala. Apakah aman untuk kita lepas?

Jawabannya,"saya juga kurang yakin."

Agar lebih yakin sebaiknya kita mematikan _external drive_ tersebut, kemudian baru kita lepas. Caranya ada pada tahap di bawah.

1. Jalankan kembali perintah `udisk2`
```
$ udiskctl power-off -b /dev/sdX
```

2. Cek lagi apakah _external drive_ sudah berhasil di _power-off_
```
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda      8:0    0 447.1G  0 disk
├─sda1   8:1    0   511M  0 part /boot
├─sda2   8:2    0 444.6G  0 part /
└─sda3   8:3    0     2G  0 part [SWAP]
```
Apabila mengeluarkan tampilan seperti di atas, artinya  proses _power-off_ berhasil.

# Video Ilustrasi

{% youtube nixRL8esSa8 %}

# Akhir Kata

Untuk penjelasan lebih lengkap dan literatur tambahan silahkan membaca dari referensi yang saya sertakan di bawah. Karena sebaik-baiknya dokumentasi adalah dokumentasi yang ditulis sendiri oleh developer yang membuat aplikasi.


# Referensi

1. [https://wiki.archlinux.org/index.php/Udisks](https://wiki.archlinux.org/index.php/Udisks){:target="_blank"}
<br>Diakses tanggal: 2018/11/05

2. [https://www.freedesktop.org/wiki/Software/udisks/](https://www.freedesktop.org/wiki/Software/udisks/){:target="_blank"}
<br>Diakses tanggal: 2018/11/05
