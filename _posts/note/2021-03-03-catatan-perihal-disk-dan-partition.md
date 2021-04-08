---
layout: 'post'
title: "Catatan dalam Berinteraksi dengan Disk dan Partition"
date: 2021-03-03 13:38
permalink: '/note/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'note'
tags: ['Tips']
wip: true
pin:
contributors: []
description: "Berinteraksi dengan disk partition mungkin merupakan pekerjaan harian bagi sebagian teman-teman, namun tidak dengan saya dan sebagian teman-teman yang lain. Catatan ini hadir untuk menyimpan beberapa 'Best Practice' yang dapat kita gunakan, apabila sewaktu-waktu kita berurusan dengan partition."
---

# Prakata

Berinteraksi dengan disk dan partition mungkin merupakan pekerjaan harian bagi sebagian teman-teman, namun tidak dengan saya dan sebagian besar teman-teman yang lain.

Catatan ini hadir untuk menyimpan beberapa "best practice" yang dapat kita gunakan, apabila kita memerlukannya saat akan berurusan dengan disk dan partition.

# Perbedaan Block Device dan Block Partition

Saya lihat banyak sekali teman-teman yang masih suka tertukar-tukar dalam membedakan dan mengidentifikasi sebuah block termasuk block device atau block partition.

Sederhananya seperti ini,

{% pre_whiteboard %}
NAME
sda       &lt;== disebut, <strong>block devices</strong>,   biasanya ditulis <strong>/dev/sda</strong>
├─sda1    &lt;== disebut, <strong>block partition</strong>, biasanya ditulis <strong>/dev/sda1</strong>
└─sda2    &lt;== disebut, <strong>block partition</strong>  biasanya ditulis <strong>/dev/sda2</strong>
{% endpre_whiteboard %}


# Tips & Tricks

## Melihat list block device

Atau dapat kita artikan mengecek struktur dari partisi.

{% shell_term $ %}
lsblk
{% endshell_term %}

Kita juga dapat memformat tampilan output untuk menampilkan field apa saya yang ingin kita tampilkan.

{% shell_term $ %}
lsblk --output=NAME,FSTYPE,SIZE,TYPE,LABEL,MOUNTPOINT
{% endshell_term %}

Teman-teman tinggal mendefinisikan aliasnya saja biar praktis.

<br>
## Mounting file ISO dengan Udisks

Terdapat 2 tahap:

**1. Setup loop block device**

{% pre_url %}
<span class="cmd">$ </span><b>udisksctl loop-setup -f file_image.iso</b>
{% endpre_url %}

{% shell_term $ %}
udisksctl loop-mount -f archlinux.iso
{% endshell_term %}

Kalau berhasil, fileiso akan terpasang ke loop block device.

<pre>
$ lsblk
NAME      FSTYPE    SIZE TYPE LABEL       MOUNTPOINT
loop0     iso9660   681M loop ARCH_202010
├─loop0p1 iso9660   681M part ARCH_202010
└─loop0p2 vfat       56M part ARCHISO_EFI
</pre>

Tinggal dimounting.

**2. Mounting loop block device**

{% pre_url %}
<span class="cmd">$ </span><b>udisksctl mount -p block_devices/block_partition</b>
{% endpre_url %}

{% shell_term $ %}
udisksctl mount -p block_devices/loop0p1
{% endshell_term %}

<pre>
$ lsblk
NAME      FSTYPE    SIZE TYPE LABEL       MOUNTPOINT
loop0     iso9660   681M loop ARCH_202010
├─loop0p1 iso9660   681M part ARCH_202010 <mark>/run/media/bandithijo/ARCH_202010</mark>
└─loop0p2 vfat       56M part ARCHISO_EFI
</pre>

Secara otomatis **udisks** akan membuat mount point ke path $XDG_RUNTIME_USER.

<br>
## Unmounting file ISO dengan Udisks

Sekenarionya tinggal dibalik dari proses mounting di atas.

**1. Unmounting loop block device**

{% pre_url %}
udisksctl unmount -p block_devices/block_partition
{% endpre_url %}

{% shell_term $ %}
udisksctl unmount -p block_devices/loop0p1
{% endshell_term %}

<pre>
$ lsblk
NAME      FSTYPE    SIZE TYPE LABEL       MOUNTPOINT
loop0     iso9660   681M loop ARCH_202010
├─loop0p1 iso9660   681M part ARCH_202010
└─loop0p2 vfat       56M part ARCHISO_EFI
</pre>

**2. Delete loop block device**

{% pre_url %}
udisksctl loop-delete -b block_devices/block_device
{% endpre_url %}

{% shell_term $ %}
udisksctl loop-delete -b block_devices/loop0
{% endshell_term %}

<br>
## Membuat bootable flash drive dengan dd

Kita dapat menggunakan tools yang bernama **dd** untuk membuat bootable flash drive dari file ISO.

Misal, kita memiliki file ISO dari Arch Linux yang berlokasi di **$HOME/iso/archlinux.iso** dan sebuah flash drive yang apabila di pasangkan ke laptop, akan beralamat di **/dev/sdb**.

{% box_info %}
<p markdown=1>Kita dapat mengetahui alamat blok dari flashdrive dengan perintah **lsblk**.</p>
{% endbox_info %}

Selanjutnya tinggal kita ekseskusi.

{% pre_url %}
<span class="cmd">$ </span><b>sudo dd if=/path/source of=/path/target</b>
{% endpre_url %}

{% shell_term $ %}
sudo dd if=~/iso/archlinux.iso of=/dev/sdb
{% endshell_term %}

Kita juga dapat menambahkan beberapa parameter seperti `bs=BYTES` atay `status=LEVEL`.

Seringnya, saya gunakan seperti ini:

{% shell_term $ %}
sudo dd if=~/iso/archlinux.iso of=/dev/sdb bs=1M status=progress
{% endshell_term %}

Untuk penjelasan mengenai parameter lebih lengkapnya, teman-teman dapat membaca sendiri di [**man dd**](https://man.archlinux.org/man/dd.1){:target="_blank"}.





{% box_perhatian %}
<p markdown=1>Jangan tambahkan nomor atau block partition number, seperti: **/dev/sdb1**.</p>
<p markdown=1>Tapi, gunakan block device, seperti: **/dev/sdX**, di mana **X** merupakan abjad yang nilainya berbeda-beda (kondisional), sesuai dengan banyaknya external drive yang terhubung dengan sistem kita.</p>
<hr>
<p markdown=1>Kesalahan mendefinisikan **if=** dan **of=** dapat berakibat fatal.</p>
<p markdown=1>Telitilah sebelum mengeksekusi.</p>
{% endbox_perhatian %}




{% comment %}
# Referensi

1. [https://wiki.archlinux.org/index.php/USB_flash_installation_medium](https://wiki.archlinux.org/index.php/USB_flash_installation_medium){:target="_blank"}
2. [](){:target="_blank"}
{% endcomment %}
