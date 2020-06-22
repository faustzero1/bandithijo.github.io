---
layout: 'post'
title: 'Step 3: Installing Arch Linux Base Packages'
date: 2018-02-09 04:00
permalink: '/arch/:title'
author: 'BanditHijo'
license: true
comments: false
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

<!-- PERTANYAAN -->
<div class="blockquote-yellow">
<div class="blockquote-yellow-title">Mengapa bukan partisi /dev/sda2 yang dimount ke /mnt ?</div>
<p>Karena partisi <code>/dev/sda2</code> sudah kita enkripsi, kemudian kita dekripsi menjadi <code>/dev/mapper/volume-root</code>. Maka hanya partisi yang telah didekripsi yang dapat kita <i>mount</i> untuk di-<i>install</i> <code>base</code> <i>package</i>.</p>
</div>

Membuat direktori `/boot` pada `/mnt/boot`.

```
# mkdir -p /mnt/boot
```

_Mount_ partisi `/dev/sda1` ke partisi `/mnt/boot`.

```
# mount /dev/sda1 /mnt/boot
```

<!-- PERHATIAN -->
<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
<p>Proses mounting di atas <b>harus berurutan</b> dan <b>tidak dapat dibolak-balik</b>. Misal, <i>mounting</i> <code>/boot</code> partisi terlebih dahulu. Apabila hal ini dilakukan akan menyebabkan <b>kegagalan saat instalasi bootloader</b>.</p>
</div>

Setelah partisi yang kita siapkan telah kita _mounting_, langkah selanjutnya adalah kita akan menggunakan `pacstrap` _script_ untuk menginstal `base` _package_ Arch Linux.

```
# pacstrap /mnt base base-devel linux linux-headers linux-firmware archlinux-keyring
```

Pada proses instalasi di atas saya menambahkan `base-devel` _package_. Proses instalasi ini akan berjalan lumayan lama. “Total _download size_” saat dokumentasi ini dibuat adalah 266.60 MiB.

Saya juga menambahkan kernel `linux` beserta `linux-headers` (yang biasanya diperlukan oleh paket seperti virtualbox, dll), serta `linux-firmware`. Karena pada berita ini, [(New kernel packages and mkinitcpio hooks 2019-11-10)](https://www.archlinux.org/news/new-kernel-packages-and-mkinitcpio-hooks/){:target="_blank"}, paket linux sudah dipisahkan dari group `base`. Tentunya ini merupakan keuntungan untuk yang ingin menggunakan paket kernel yang lain, seperti kernel `linux-lts`, `linux-hardened` dan `linux-zen`.

Apabila proses `pacstrap` telah selesai, langkah selanjutnya ada _generate_ `fstab`.

```
# genfstab -U /mnt > /mnt/etc/fstab
```

Perintah ini bertujuan untuk _mounting blok_ partisi mana yang akan di-*mounted* saat sistem di-*bootup*.  Kita bisa mengecek apakah hasil dari _generate_ `fstab` dengan perintah `# cat /mnt/etc/fstab`.

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

Kita dapat melihat `/dev/sda1` dan `/dev/mapper/volume-root`, artinya _mounting_ partisi dan _generate_ `fstab` telah berhasil dan benar. Karena apabila proses _mouting_ pada Step 3.1 salah, maka hasil _generate_ `fstab` juga akan salah. Misal, tidak terdapat partisi `/boot` yaitu `/dev/sda1`, maka apabila terjadi seperti ini, akan berdampak pada kegagalan saat proses instalasi `bootloader`.

Setelah kita selesai meng-*install* _base package_, langkah selanjutnya adalah konfigurasi komponen-komponen lain yang diperlukan oleh sistem operasi seperti _Bootloader_, _Time Zone_, _Locale_, _Hostname_, _Username_, _Passwords_, dll.

Untuk masuk ke dalam sistem yang sudah kita _install_ kita akan berpindah dari _root_ Arch _Installer_ ke _root_ Arch sistem yang baru saja kita buat.

Caranya dengan menggunakan `chroot` \(_change root_\).

```
# arch-chroot /mnt
```

Apabila perintah di atas berhasil, makan kalian dapat melihat perubahan pada `username` dan `hostname` yang terbungkus oleh tanda `[ ... ]`. Artinya kita telah masuk ke dalam `root` sistem yang baru saja kita _install_.

Sebelum `arch-chroot`.
<pre>
<span style="color:red;">root</span>@archiso ~ #
</pre>

Setelah `arch-chroot`.
<pre>
[root@archiso /]#
</pre>

Pada tahap ini, kita dapat bergerak ke _step_ selanjutnya.


<!-- NEXT PREV BUTTON -->
<div class="post-nav">
<a class="btn-blue-l" href="/arch/step-2-disk-partitioning"><img style="width:20px;" src="/assets/img/logo/logo_ap.png"></a>
<a class="btn-blue-c" href="/arch/"><img style="width:20px;" src="/assets/img/logo/logo_menu.svg"></a>
<a class="btn-blue-r" href="/arch/step-4-set-up-bootloader"><img style="width:20px;" src="/assets/img/logo/logo_an.png"></a>
</div>
