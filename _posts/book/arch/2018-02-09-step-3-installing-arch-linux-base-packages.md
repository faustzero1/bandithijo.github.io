---
layout: 'post'
title: 'Step 3: Installing Arch Linux Base Packages'
date: 2018-02-09 04:00
permalink: '/arch/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'arch'
tags:
pin:
---


# STEP 3 : Installing Arch Linux Base Packages

Arch Linux adalah salah satu distribusi sistem operasi yang proses instalasinya membutuhkan koneksi internet untuk mengunduh paket-paket yang terdapat pada _server_ repositori.

## 3.1 Mounting Partition

Sebelum memasang _base package_ terlebih dahulu kita akan memasang \(_mounting_\) dua partisi yang telah kita buat `/dev/sda1` dan `/dev/mapper/volume-root` pada partisi `/mnt` untuk proses instalasi.

_Mount_ partisi `/dev/mapper/volume-root` ke partisi `/mnt`.

```
# mount /dev/mapper/volume-root /mnt
```

> **Mengapa bukan partisi /dev/sda2 yang dimount ke /mnt ?**
>
> Karena partisi `/dev/sda2` sudah kita enkripsi, kemudian kita dekripsi menjadi `/dev/mapper/volume-root`. Maka hanya partisi yang telah didekripsi yang dapat kita _mount_ untuk di-_install_ `base` _package_.

Membuat direktori `/boot` pada `/mnt/boot`.

```
# mkdir -p /mnt/boot
```

_Mount_ partisi `/dev/sda1` ke partisi `/mnt/boot`.

```
# mount /dev/sda1 /mnt/boot
```

> **\[ ! \] PERHATIAN**
>
> Proses mounting di atas **harus berurutan** dan **tidak dapat dibolak-balik**. Misal, _mounting_ `/boot` partisi terlebih dahulu. Apabila hal ini dilakukan akan menyebabkan **kegagalan** **saat instalasi bootloader**.

Setelah partisi yang kita siapkan telah kita _mounting_, langkah selanjutnya adalah kita akan menggunakan `pacstrap` _script_ untuk menginstal `base` _package_ Arch Linux.

```
# pacstrap /mnt base base-devel
```

Pada proses instalasi di atas saya menambahkan `base-devel` _package_. Proses instalasi ini akan berjalan lumayan lama. “Total _download size_” saat dokumentasi ini dibuat adalah 266.60 MiB.

Apabila proses `pacstrap` telah selesai, langkah selanjutnya ada _generate_ `fstab`.

```
# genfstab -U /mnt > /mnt/etc/fstab
```

Perintah ini bertujuan untuk _mounting blok_ partisi mana yang akan di-_mounted_ saat sistem di-_bootup_.  Kita bisa mengecek apakah hasil dari _generate_ `fstab` dengan perintah `# cat /mnt/etc/fstab`.

Hasil dari _generate_ `fstab` tersebut adalah sebagai berikut :

```
#
# /etc/fstab: static file system information
#
# <file system>    <dir>    <type>    <options>    <dump>    <pass>
# /dev/mapper/volume-root
UUID=56fdc3fa-8a1c-4d4e-a13f-4af99bf6ae6a    / ext4  rw,relatime,data=ordered    0 1

# /dev/sda1
UUID=3394-9E03 /boot vfat rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro    0 2
```

Kita dapat melihat `/dev/sda1` dan `/dev/mapper/volume-root`, artinya _mounting_ partisi dan _generate_ `fstab` telah berhasil dan benar. Karena apabila proses _mouting_ pada Step 3.1 salah, maka hasil _generate_ `fstab` juga akan salah. Misal, tidak terdapat partisi `/boot` yaitu `/dev/sda1`, maka apabila terjadi seperti ini, maka akan berdampak pada kegagalan saat proses instalasi `bootloader`.

Setelah kita selesai meng-_install_ _base package_, langkah selanjutnya adalah konfigurasi komponen-komponen lain yang diperlukan oleh sistem operasi seperti _Bootloader_, _Time Zone_, _Locale_, _Hostname_, _Username_, _Passwords_, dll.

Untuk masuk ke dalam sistem yang sudah kita _install_ kita akan berpindah dari _root_ Arch _Installer_ ke _root_ Arch sistem yang baru saja kita buat.

Caranya dengan menggunakan `chroot` \(_change root_\).

```
# arch-chroot /mnt
```

Apabila perintah di atas berhasil, makan kalian dapat melihat perubahan pada `username` dan `hostname`. Artinya kita telah masuk ke dalam `root` sistem yang baru saja kita _install_. Pada tahap ini, kita dapat bergerak ke _step_ selanjutnya.

