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

## Melihat List Block Device

Atau dapat kita artikan mengecek struktur dari partisi.

{% shell_cmd $ %}
lsblk
{% endshell_cmd %}

Kita juga dapat memformat tampilan output untuk menampilkan field apa saya yang ingin kita tampilkan.

{% shell_cmd $ %}
lsblk --output=NAME,FSTYPE,SIZE,TYPE,LABEL,MOUNTPOINT
{% endshell_cmd %}

Teman-teman tinggal mendefinisikan aliasnya saja biar praktis.

<br>
## Mounting File ISO dengan Udisks

Terdapat 2 tahap:

**1. Setup loop block device**

{% pre_url %}
<span class="cmd">$ </span><b>udisksctl loop-setup -f file_image.iso</b>
{% endpre_url %}

{% shell_cmd $ %}
udisksctl loop-mount -f archlinux.iso
{% endshell_cmd %}

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

{% shell_cmd $ %}
udisksctl mount -p block_devices/loop0p1
{% endshell_cmd %}

<pre>
$ lsblk
NAME      FSTYPE    SIZE TYPE LABEL       MOUNTPOINT
loop0     iso9660   681M loop ARCH_202010
├─loop0p1 iso9660   681M part ARCH_202010 <mark>/run/media/bandithijo/ARCH_202010</mark>
└─loop0p2 vfat       56M part ARCHISO_EFI
</pre>

Secara otomatis **udisks** akan membuat mount point ke path $XDG_RUNTIME_USER.

<br>
## Unmounting File ISO dengan Udisks

Sekenarionya tinggal dibalik dari proses mounting di atas.

**1. Unmounting loop block device**

{% pre_url %}
udisksctl unmount -p block_devices/block_partition
{% endpre_url %}

{% shell_cmd $ %}
udisksctl unmount -p block_devices/loop0p1
{% endshell_cmd %}

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

{% shell_cmd $ %}
udisksctl loop-delete -b block_devices/loop0
{% endshell_cmd %}



{% comment %}
# Referensi

1. [](){:target="_blank"}
{% endcomment %}
