---
layout: 'post'
title: 'Step 2: Disk Partitioning'
date: 2018-02-09 03:00
permalink: '/arch/:title'
author: 'BanditHijo'
license: true
comments: false
toc: true
category: 'arch'
tags:
pin:
---


# STEP 2 : Disk Partitioning

## 2.1 Mengecek UEFI Mode

Saya lebih _prefer_ untuk menggunakan mode bios UEFI ketimbang mode bios Legacy. Untuk itu kita akan mengecek apakah kita sudah berada pada mode UEFI atau belum.

{% shell_root %}
ls /sys/firmware/efi
{% endshell_root %}

Kemudian perhatikan apakah terdapat direktori `efivars` atau tidak. Jika ada, berarti kita sudah berada di jalan yang benar. Apabila belum, berarti kita harus mengeset ulang pengaturan pada BIOS dan merubahnya menjadi UEFI.

## 2.2 Mengatur Partisi Tabel

Kita akan membuat **dua** partisi. Yang pertama adalah partisi **ESP** \(_EFI System Partition_\) dan partisi `/` \(baca: _root_\). Saya lebih _prefer_ menggunakan **satu** partisi `/` dan tidak memisahkan partisi `/home` dari `/`.

{% box_pertanyaan %}
<p><b>Mengapa saya tidak memisahkan partisi /home?</b></p>
<p>Karena saya tidak berniat untuk memasang distribusi sistem operasi GNU/Linux yang lain.</p>
{% endbox_pertanyaan %}

Pertama-tama kita harus mengetahui alamat blok dari _hard drive_ yang akan kita partisi.

{% shell_root %}
lsblk -p
{% endshell_root %}

Pada kasus saya, _storage device_ saya memiliki nama block `sda`. Saya dapat mengetahui dari jumlah kapasitasnya.

Kemudian langkah selanjutnya adalah mempartisi _hard disk_. Terdapat banyak aplikasi yang dapat kita gunakan seperti `parted`, `fdisk`, `gdsik`, `cfdisk`, `cgdisk`, dll. Namun pada dokumentasi ini saya akan menggunakan `gdisk`.

{% shell_root %}
gdisk /dev/sda
{% endshell_root %}

| Steps | Details |
| :--- | :--- |
| o↲ → Y↲ | =&gt; Membuat GPT |
| n↲ → ↲ → ↲ → +512MiB↲ → EF00↲ | =&gt; Membuat ESP \(EFI System Partition\) |
| n↲ → ↲ → ↲ → ↲ → 8E00↲ | =&gt; Membuat sisa block partisi menjadi / \(8E00 adalah kode untuk LVM\) |
| p↲ | =&gt; Melihat tabel partisi |
| w↲ → Y↲ | =&gt; Menulis table partition ke disk dan otomatis exit dari gdisk |

Sebelum kita write `w`, saat kita memasukkan perintah `p`, akan ditampilkan partisi tabel yang telah kita buat.

<pre>
Number  Start (sector)  End (sector)   Size      Code  Name
   1            2048       1050623    512.0 MiB  EF00  EFI system partition
   2         1050624      20971486      9.5 GiB  8E00  Linux LVM
</pre>

Setelah kembali ke prompt ArchISO shell `#`, kita dapat mengecek apakah partisi kita telah berhasil dibuat atau tidak, dengan perintah.

{% shell_root %}
fdisk -l
{% endshell_root %}

<pre>
Disk /dev/vda: 10 GiB, 10737418240 bytes, 20971520 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: <mark>gpt</mark>
Disk identifier: 978C3EB8-984B-4189-BD33-F61A7272132B

Device       Start      End  Sectors  Size Type
<mark>/dev/sda1     2048  1050623  1048576  512M EFI System</mark>
<mark>/dev/sda2  1050624 20971486 19920863  9.5G Linux LVM</mark>
</pre>

Akan terdapat detail keterangan bahwa kita menggunakan **gpt** dan terdapat 2 partisi `/dev/sda1` \(EFI System\) dan `/dev/sda2` \(Linux LVM\).

`sda1` akan kita gunakan sebagai partisi `/boot/efi` dan `sda2` akan kita gunakan sebagai partisi `/`.

{% box_pertanyaan %}
<p><b>Mengapa saya tidak menggunakan partisi SWAP?</b></p>
<p>Kalau ingin menggunakan SWAP, dapat kita tambahkan belakangan, setelah sistem kita jadi.</p>
<p>Saya juga lebih memilih menggunakan <b>swapfile</b> saja. Sehingga swapfile hanya akan saya buat apabila saya perlukan.</p>
{% endbox_pertanyaan %}


## 2.3 Mengenkripsi Partisi /dev/sda2

Pada saat ini, dimana semua orang mulai ~~memperhatikan~~ keamanan data, meskipun hanya laptop pribadi namun saya berusaha untuk tetap belajar mengerti bagaimana cara mengamankan data yang ada di dalam _hard disk_ saya.

Pada dokumentasi instalasi ini saya akan menggunakan enkripsi pada partisi `/dev/sda2` dan juga akan mengenkripsi direktori `/home/username`. Mungkin bisa disebut ini keamanan kue lapis. Hehe

Aplikasi *disk encryption* yang saya pergunakan adalah [**LUKS**](https://gitlab.com/cryptsetup/cryptsetup/){:target="_blank"} \(`dm-crypt`\).

{% shell_root %}
cryptsetup luksFormat /dev/sda2
{% endshell_root %}

| Steps | Details |
| :--- | :--- |
| YES↲ | =&gt; Konfirmasi dengan **YES** huruf kapital |
| \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\* | =&gt; Masukkan password untuk enksripsi `/sda2` |
| \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\* | =&gt; Konfirmasi password `/sda2` |

Outputnya kira-kira seperti ini,

<pre>
WARNING!
========
This will overwrite data on /dev/sda2 irrevocably.

Are you sure? (Type 'yes' in capital letters): <b>YES</b>
Enter passphrase for /dev/sda2:
Verify passphrase:
WARNING: Locking directory /run/cryptsetup is missing!
cryptsetup luksFormat /dev/sda2  10.05s user 1.22s system 43% cpu 25.939 total
</pre>

Kita telah berhasil membuat `/dev/sda2` terenkripsi dengan LUKS.

Tahap selanjutnya adalah mengkonfigurasi **LVM** pada `/dev/sda2`. Untuk itu kita perlu membuka kembali `/dev/sda2` yang baru saja kita enkripsi.

{% shell_root %}
cryptsetup luksOpen /dev/sda2 lvm
{% endshell_root %}

Kita akan diminta memasukkan password untuk mendecypt partisi.

<pre>
Enter passphrase for /dev/vda2: _
</pre>

Selanjutnya, membuat **_physical volume_**.

{% shell_root %}
pvcreate /dev/mapper/lvm
{% endshell_root %}

Membuat **_volume group_**.

{% shell_root %}
vgcreate volume /dev/mapper/lvm
{% endshell_root %}

Membuat **_logical volume_** dengan nama "**root**".

{% shell_root %}
lvcreate -l 100%FREE volume -n root
{% endshell_root %}

Kita telah berhasil mengkonfigurasi LVM pada `/dev/sda2` yang terenkripsi.

Kalau kita lihat skema partisinya.

{% shell_root %}
lsblk -p
{% endshell_root %}

<pre>
NAME                          MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
/dev/loop0                      7:0    0 559.5M  1 loop  /run/archiso/sfs/airootfs
/dev/sr0                       11:0    1 682.3M  0 rom   /run/archiso/bootmnt
/dev/vda                      254:0    0    10G  0 disk
├─/dev/vda1                   254:1    0   512M  0 part
└─/dev/vda2                   254:2    0   9.5G  0 part
  └─/dev/mapper/lvm           252:0    0   9.5G  0 crypt
    └─/dev/mapper/volume-root 252:1    0   9.5G  0 lvm
</pre>

{% box_info %}
<p>Sekedar pengetahuan saja.</p>

<p markdown=1>**Unmounting**.<br>Cara untuk meng-encrypt kembali atau unmount partisi dengan enkripsi, kita dapat menggunakan cara seperti ini:</p>
{% shell_root %}
cryptsetup luksClose /dev/mapper/volume-root
cryptsetup luksClose /dev/mapper/lvm
{% endshell_root %}
<p>*Proses unmounting dilakukan dari partisi paling bawah.</p>
<hr>
<p markdown=1>**Mounting**.<br>Cara untuk men-decrypt kembali atau mount partisi dengan enkripsi, kita dapat menggunakan cara seperti ini:</p>
{% shell_root %}
cryptsetup luksOpen /dev/sda2 lvm
{% endshell_root %}
Lihat nama volume group dan volume name.
{% shell_root %}
lvs
{% endshell_root %}
<pre>
  LV   VG     Attr       LSize Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  root volume -wi-a----- 9.48g
</pre>
Nah, tinggal di mount logical volumenya.
{% shell_root %}
lvchange -ay volume/root
{% endshell_root %}
Atau, semua logical volume di volume group tersebut.
{% shell_root %}
lvchange -ay volume
{% endshell_root %}
{% endbox_info %}

## 2.4 Memformat Partisi

Setelah kita mengkonfigurasi partisi tabel, langkah selanjutnya adalah mem-*format* partisi sesuai tipe partisi yang telah kita buat. Terdapat dua _file_ sistem yang akan kita gunakan, yaitu `FAT32` dan `EXT4`. _File_ sistem `FAT32` akan kita gunakan untuk `/dev/sda1` yang merupakan partisi ESP \(_EFI System Partition_\). Sedangkan _file_ sistem `EXT4` akan kita gunakan untuk `/dev/sda2` yang merupakan `/` partisi.

Mem-_format_ partisi `/dev/sda1`.

{% shell_root %}
mkfs.fat -F32 /dev/sda1
{% endshell_root %}

Mem-_format_ partisi `/dev/sda2`.

{% shell_root %}
mkfs.ext4 /dev/mapper/volume-root
{% endshell_root %}

Untuk melihat apakah konfigurasi partisi kita telah sesuai atau tidak, kita dapat menggunakan perintah di bawah ini untuk melihat struktur dari tabel partisi.

{% shell_root %}
lsblk -p
{% endshell_root %}

```
NAME                            SIZE RO TYPE  MOUNTPOINT
/dev/loop0                    559.5M  1 loop  /run/archiso/sfs/airootfs
/dev/sr0                      682.3M  0 rom   /run/archiso/bootmnt
/dev/sda                         10G  0 disk
├─/dev/sda1                     512M  0 part
└─/dev/sda2                     9.5G  0 part
  └─/dev/mapper/lvm             9.5G  0 crypt
    └─/dev/mapper/volume-root   9.5G  0 lvm
```

Apabila telah sesuai, akan menampilkan susunan `/dev/sda` pada kolom **NAME**, seperti yang terdapat pada tabel di atas.




<!-- NEXT PREV BUTTON -->
{% assign btn-next = "/arch/step-1-connecting-to-the-internet" %}
{% assign btn-menu = "/arch/" %}
{% assign btn-prev = "/arch/step-3-installing-arch-linux-base-packages" %}
<div class="post-nav">
<a class="btn-blue-l" href="{{ btn-next }}"><img class="btn-img" src="/assets/img/logo/logo_ap.png"></a>
<a class="btn-blue-c" href="{{ btn-menu }}"><img class="btn-img" src="/assets/img/logo/logo_menu.svg"></a>
<a class="btn-blue-r" href="{{ btn-prev }}"><img class="btn-img" src="/assets/img/logo/logo_an.png"></a>
</div>
