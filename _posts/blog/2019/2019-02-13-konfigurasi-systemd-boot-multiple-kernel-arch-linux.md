---
layout: 'post'
title: 'Konfigurasi Systemd-Boot untuk Multiple Kernel pada Arch Linux'
date: 2019-02-13 23:30
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Arch Linux', 'Tips']
pin:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Sejak masih menggunakan Arch Linux pada Macbook Pro 8.1, saya sudah tidak menggunakan **GRUB** sebagai *bootloader*, melainkan **Gummiboot**. Ini adalah kali pertama saya menggunakan *bootloader* ini, karena selama menggunakan distribusi sistem operasi yang lain, selalu menggunakan GRUB sebagai *default boorloader*.

Setelah menggunakan Thinkpad X260, saya pun memutuskan untuk menggunakan kembali *gummiboot* yang saat ini sudah berganti nama menjadi **systemd-boot**.

### Alasan menggunakan systemd-boot?

Mudah untuk saya konfigurasi. Karena sudah pernah mencobanya saat masih menggunakan Macbook Pro 8.1.
### Apa yang menjadi kekurangan dari systemd-boot?

Hanya dapat membaca/menjalankan EFI excutable seperti: Linux Kernel EFISTUB, UEFI Shell, GRUB, dan Windows Boot Manager.

# Konfigurasi

## Satu Kernel

Saat proses instalasi Arch Linux, saya hanya menggunakan satu buah kernel, yaitu kernel vanilla.

Saya akan menunjukkan isi dari konfigurasi file `/boot/loader/loader.conf` yang saya meiliki.
```
$ cat /boot/loader/loader.conf
```
<pre>
timeout 0
editor 0
default <mark>arch</mark>
</pre>
Terlihat pada tanda yang saya *marking*, bahwa file loader ini akan memanggil file konfigurasi lain yang bernama `arch` yang merupakan kependekan dari `arch.conf`.

File ini berada pada `/boot/loader/entries/arch.conf`.

Saya akan menunjukkan isi dari konfigurasi file `arch.conf` yang saya gunakan.
```
title    Arch Linux
linux    /vmlinuz-linux
initrd	 /intel-ucode.img
initrd   /initramfs-linux.img
options	 root=PARTUUID=327fd9bc-2e55-4649-b801-2b66819fe70b rw irqpoll hpet=disable
```
Di sini, saya hanya menggunakan satu buah kernel untuk dipanggil. Dapat dilihat pada bagian `initrd /initramfs-linux.img`.

Lantas bisa tidak apabila kita memasang dua kernel, misalkan kernel `linux-lts` dan menampilkan pilihannya pada **systemd-boot**?

Jawabannya, tentu saja bisa.

## Menambahkan Pilihan Kernel

Untuk menambahkan pilihan kernel pada systemd-boot caranya cukup mudah.

Hanya tinggal membuat file konfigurasi satu lagi pada direktori `/boot//loader/entries`. Misalnya file ini akan saya beri nama `arch-lts.conf`.

Saya asumsikan teman-teman sudah memasang linux kernel satu lagi. Misal dalam kasus saya `linux-lts`.

Kita tinggal mengambil contekan dasarnya dari file `arch.conf`
```
$ cd /boot/loader/entries
$ sudo cp arch.conf arch-lts.conf
```
Nanti, akan terbuat file baru dengan nama `arch-lts.conf`.

Selanjutnya kita perlu memodifikasi nama dari beberapa value yang ada di dalam file konfigurasi ini.
```
$ sudo vim /boot/loader/entries/arch-lts.conf
```
<pre>
<mark>title    Arch Linux LTS</mark>
<mark>linux    /vmlinuz-linux-lts</mark>
initrd	 /intel-ucode.img
<mark>initrd   /initramfs-linux-lts.img</mark>
options	 root=PARTUUID=327fd9bc-2e55-4649-b801-2b66819fe70b rw irqpoll hpet=disable
</pre>
Pada bagian yang saya *marking*, adalah bagian-bagian yang saya rubah dengan nama kernel yang saya gunakan. Dalam hal ini `linux-lts`.

Apabila kita ingin menggunakan kernel `zen`, tinggal diganti atau ditambahkan lagi file konfigurasinya saja.

Sangat *easy busy* bukan?

<!-- PERTANYAAN -->
<div class="blockquote-yellow">
<div class="blockquote-yellow-title">Apakah Maksud dari RW, IRQPOLL, dll yang Berada pada Akhir Baris Nilai Options?</div>
<p>Maksud dari nilai-nilai tersebut adalah, <b>Kernel Parameters</b>.</p>
<p>Sangat mudah sekali untuk menambahkan kernel parameter pada systemd-boot.</p>
<p>Hanya seperti itu saja, dengan menambahkan nilai-nilai parameter yang ingin kita gunakan pada akhir dari baris <code>options</code>.</p>
</div>

# Cara Menggunakannya

Karena saya menggunkaan nilai `timeout` pada konfigurasi `/boot/loader/loader.conf` bernilai `0`. Hal ini menyebabkan menu dari pilihan kernel tidak akan ditampilkan. Saya melakukan ini karena saya tidak memerlukan untuk selalu melihat pilihan ini.

Lantas, untuk melihat pilihan menu kernel dari systemd-boot, cukup dengan menekan berulang-kali tombol <kbd>SPACE</kbd>.


# Tips Menambah Kernel

Beberapa bulan terakhir ini banyak dari teman-teman yang saya dapati beru bermigrasi menggunakan Arch Linux.

Saya akan membagikan tips sebagai pengguna yang lebih dahulu mencicipi Arch Linux sejak pertengahan 2016.

## Jangan Sekedar Menambahkan Kernel

Apabila teman-teman ingin menggunakan kernel selain kernel `linux`, jangan sekedar menambahkan paket kernelnya saja. Ada beberapa hal yang setidaknya perlu teman-teman perhatiakan.

### Kernel Headers

Apabila teman-teman menggukanan VirtualBox, aplikasi ini membutuhkan **Kernel Headers**. Tentu saja VirtualBox akan menampilkan pesan-pesan merah pada proses *booting* apabila teman-teman tidak memasang kernel headers.

Setiap dari paket kernel, memiliki kernel headers masing-masing.

Misal:
1. Kernel: `linux`, Headers: `linux-headers`
2. Kernel: `linux-lts`, Headers: `linux-lts-headers`
3. dll.

Jadi, <mark>jangan lupa!</mark> untuk memasang paket kernel headers nya juga.

### VirtualBox Host Module

Masih berhubungan dengan aplikasi VirtualBox. Apabila teman-teman menggunakan Arch Linux sebagai host untuk VirtualBox, jangan lupa untuk menambahkan paket bernama `virtualbox-host-modules-arch`, ini untuk teman-teman yang menggunakan kernel `linux`.

Namun, untuk yang menggunakan kernel <mark>selain</mark> `linux`, misal `linux-lts`, `linux-zen`, `linux-ck`, dll. Paket host module yang digunakan adalah `virtualbox-host-dkms`.

| <center>VirtualBox Host Modules</center> | <center>Kernel yang Digunakan</center> |
| :-- | :-- |
| `virtualbox-host-modules-arch` | `linux` |
| `virtualbox-host-dkms` | `linux-lts`, `linux-zen`, `linux-ck` |

### ACPI Module

Tidak hanya paket VirtualBox saja yang membutuhkan module yang berbeda apabila kita menggunakan kernel selain `linux`. ACPI juga memmerlukan module yang berbeda.

Langsung saja saya berikan tabelnya agar mudah dipahami.

| <center>ACPI Modules</center> | <center>Kernel yang Digunakan</center> |
| :-- | :-- |
| `acpi_call` | `linux` |
| `acpi_call-dkms` | `linux-lts`, `linux-zen`, `linux-ck` |

# Pesan Penulis

Tidak bosan-bosan saya mengingatkan,

Sebaik-baik dokumentasi adalah dokumentasi yang ditulis/dibuat langsung oleh developer pengembang dari aplikasi/distribusi yang bersangkutan.

Tulisan ini bukan untuk memberikan tandingan dari dokumentasi resi yang sudah ada, melainkan sebagai ulasan dan catatan pribadi hasil berekplorasi saya terhadap aplikasi/distribusi yang saya pergunakan sehari-hari.

Sepertinya segini saja catatan mengenai **systemd-boot**.

Mudah-mudahan dapat bermanfaat bagi teman-teman yang memerlukan.


# Referensi

1. [wiki.archlinux.org/index.php/Arch_boot_process#Boot_loader](https://wiki.archlinux.org/index.php/Arch_boot_process#Boot_loader){:target="_blank"}
<br>Diakses tanggal: 2019/02/13

2. [wiki.archlinux.org/index.php/Systemd-boot](https://wiki.archlinux.org/index.php/Systemd-boot){:target="_blank"}
<br>Diakses tanggal: 2019/02/13


