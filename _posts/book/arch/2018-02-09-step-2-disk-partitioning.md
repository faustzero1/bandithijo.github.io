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

```
# ls /sys/firmware/efi
```

Kemudian perhatikan apakah terdapat direktori `efivars` atau tidak. Jika ada, berarti kita sudah berada di jalan yang benar. Apabila belum, berarti kita harus mengeset ulang pengaturan pada BIOS dan merubahnya menjadi UEFI.

## 2.2 Mengatur Partisi Tabel

Kita akan membuat **dua** partisi. Yang pertama adalah partisi **ESP** \(_EFI System Partition_\) dan partisi `/` \(baca: _root_\). Saya lebih _prefer_ menggunakan **satu** partisi `/` dan tidak memisahkan partisi `/home` dari `/`.

<!-- PERTANYAAN -->
<div class="blockquote-yellow">
<div class="blockquote-yellow-title">Mengapa saya tidak memisahkan partisi /home ?</div>
<p>Karena saya tidak berniat untuk memasang distribusi sistem operasi GNU/Linux yang lain.</p>
</div>

Pertama-tama kita harus mengetahui alamat blok dari _hard drive_ yang akan kita partisi.

```
# lsblk -p
```

Pada kasus saya, _storage device_ saya memiliki nama block `sda`. Saya dapat mengetahui dari jumlah kapasitasnya.

Kemudian langkah selanjutnya adalah mempartisi _hard disk_. Terdapat banyak aplikasi yang dapat kita gunakan seperti `parted`, `fdisk`, `gdsik`, `cfdisk`, `cgdisk`, dll. Namun pada dokumentasi ini saya akan menggunakan `gdisk`.

```
# gdisk /dev/sda
```

| Steps | Details |
| :--- | :--- |
| o↲ → Y↲ | =&gt; Membuat GPT |
| n↲ → ↲ → ↲ → +512MiB↲ → EF00↲ | =&gt; Membuat ESP \(EFI System Partition\) |
| n↲ → ↲ → ↲ → ↲ → 8E00↲ | =&gt; Membuat sisa block partisi menjadi / \(LVM\) |
| w↲ → Y↲ | =&gt; Menulis table partition ke disk |

Setelah kembali ke `#`, kita dapat mengecek apakah partisi kita telah berhasil dibuat atau tidak, dengan perintah.

```
# fdisk -l
```

Akan terdapat detail keterangan bahwa kita menggunakan **gpt** dan terdapat 2 partisi `/dev/sda1` \(EFI System\) dan `/dev/sda2` \(Linux LVM\).

`sda1` akan kita gunakan sebagai partisi `/boot` dan `sda2` akan kita gunakan sebagai partisi `/`.

<!-- PERTANYAAN -->
<div class="blockquote-yellow">
<div class="blockquote-yellow-title">Mengapa saya tidak menggunakan partisi SWAP ?</div>
<p>Karena saya menggunakan SSD. Kalau ingin menggunakan SWAP, dapat kita tambahkan belakangan, setelah sistem kita jadi.</p>
<p>Saya juga lebih memilih menggunakan <b>swapfile</b> saja. Sehingga swapfile hanya akan saya buat apabila saya perlukan.</p>
</div>


## 2.3 Mengenkripsi Partisi /dev/sda2

Pada saat ini, dimana semua orang mulai ~~memperhatikan~~ keamanan data, meskipun hanya laptop pribadi namun saya berusaha untuk tetap belajar mengerti bagaimana cara mengamankan data yang ada di dalam _hard disk_ saya.

Pada dokumentasi instalasi ini saya akan menggunakan enkripsi pada partisi `/dev/sda2` dan juga akan mengenkripsi direktori `/home/username`. Mungkin bisa disebut ini keamanan kue lapis. Hehe

Aplikasi *disk encryption* yang saya pergunakan adalah [**LUKS**](https://gitlab.com/cryptsetup/cryptsetup/){:target="_blank"} \(`dm-crypt`\).

```
# cryptsetup luksFormat /dev/sda2
```

| Steps | Details |
| :--- | :--- |
| YES↲ | =&gt; Konfirmasi dengan **YES** huruf kapital |
| \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\* | =&gt; Masukkan password untuk enksripsi `/sda2` |
| \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\* | =&gt; Konfirmasi password `/sda2` |

Kita telah berhasil membuat `/dev/sda2` terenkripsi dengan LUKS.

Tahap selanjutnya adalah mengkonfigurasi **LVM** pada `/dev/sda2`. Untuk itu kita perlu membuka kembali `/dev/sda2` yang baru saja kita enkripsi.

```
# cryptsetup luksOpen /dev/sda2 lvm
```

Membuat **_physical volume_**.

```
# pvcreate /dev/mapper/lvm
```

Membuat **_volume group_**.

```
# vgcreate volume /dev/mapper/lvm
```

Membuat **_logical volume_** dengan nama "**root**".

```
# lvcreate -l 100%FREE volume -n root
```

Kita telah berhasil mengkonfigurasi LVM pada `/dev/sda2` yang terenkripsi.

## 2.4 Memformat Partisi

Setelah kita mengkonfigurasi partisi tabel, langkah selanjutnya adalah mem-*format* partisi sesuai tipe partisi yang telah kita buat. Terdapat dua _file_ sistem yang akan kita gunakan, yaitu `FAT32` dan `EXT4`. _File_ sistem `FAT32` akan kita gunakan untuk `/dev/sda1` yang merupakan partisi ESP \(_EFI System Partition_\). Sedangkan _file_ sistem `EXT4` akan kita gunakan untuk `/dev/sda2` yang merupakan `/` partisi.

Mem-_format_ partisi `/dev/sda1`.

```
# mkfs.fat -F32 /dev/sda1
```

Mem-_format_ partisi `/dev/sda2`.

```
# mkfs.ext4 /dev/mapper/volume-root
```

Untuk melihat apakah konfigurasi partisi kita telah sesuai atau tidak, kita dapat menggunakan perintah di bawah ini untuk melihat struktur dari tabel partisi.

```
# lsblk
```

```
NAME                MAJ:MIN  RM    SIZE  RO  TYPE  MOUNTPOINT
loop0                 7:0     0  408.5M   1  loop  /run/archiso/sfs/
sda                   8:0     0      8G   0  disk
├─sda1                8:1     0    512M   0  part
└─sda2                8:2     0    7.5G   0  part
  └─lvm             254:0     0    7.5G   0  crypt
    └─volume-root   254:1     0    7.5G   0  lvm
sr0                  11:0     1    523M   0  rom   /run/archiso/bootmnt
```

Apabila telah sesuai, akan menampilkan susunan `/dev/sda` pada kolom **NAME**, seperti yang terdapat pada tabel di atas.



<!-- NEXT PREV BUTTON -->
<div class="post-nav">
<a class="btn-blue-l" href="/arch/step-1-connecting-to-the-internet"><img style="width:20px;" src="/assets/img/logo/logo_ap.png"></a>
<a class="btn-blue-c" href="/arch/"><img style="width:20px;" src="/assets/img/logo/logo_menu.svg"></a>
<a class="btn-blue-r" href="/arch/step-3-installing-arch-linux-base-packages"><img style="width:20px;" src="/assets/img/logo/logo_an.png"></a>
</div>
