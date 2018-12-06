---
layout: 'post'
title: 'Update BIOS Lenovo di GNU/Linux Tanpa Menggunakan Windows'
date: 2018-05-16 18:41
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
<img class="post-body-img" src="https://s20.postimg.cc/kcm94ki19/banner_post_12.png" alt="banner">

# Pendahuluan
Sewaktu pertama kali memiliki laptop ini (Lenovo ThinkPad x260), saya berfikir bagaimana nantinya saya harus meng-update BIOS, apabila saya menghapus sistem operasi Windows dan hanya menggunakan satu sistem operasi GNU/Linux?

Saat itu saya hanya dapat menjawab pertanyaan itu dengan berbesar hati, "Kita jarang menggunakan BIOS sehari-hari dan fitur yang ada saat ini saya rasa sudah mencukupi." Namun, perjalanan dari pertanyaan ini berkata lain. Dan saya pun menemukan jawabannya. Jelas dan lugas. "Bisa! Sangat bisa!"

# Mengapa Perlu Update BIOS ?

Setiap versi pembaharuan dari BIOS terdapat "**Summary of Changes**" yang dapat kita lihat pada file berkas **.txt** yang juga dikeluarkan bersama file **.iso**.

Kategori perubahan apa saja yang ada pada ISO update BIOS Lenovo ini biasanya terangkum dalam bentuk sebagai berikut:

| Simbol Awalan | Artinya |
| ------------- | ------- |
| <0.00> | Package Version |
| UEFI: | UEFI BIOS version |
| ECP: | Embeded Controller Program version |
| [Important] | Important Update |
| (New) | New function for enhancement |
| (Fix) | Correcting to existing function |

Sebagai contoh, *Summary of Change* saat dokumentasi ini ditulis, untuk BIOS update sejak versi **1.05** hingga **1.37**, adalah sebagai berikut.

```
<1.37>
- (Fix) Applied W/A for Handelsbanken USB Smart Card Reader and for Lenovo T2424z monitor.
- (Fix) AMT: Fixed the issue that Unconfiguration process is escaped.
- (Fix) AMT: Fixed the problem that unconfiguration ME prcocess repeatedly.
- [Important] Update Thermal table.

<1.36>
- (Fix) Updated Skylake D0/K1 MCU to MC0406E3_000000C1_000000C2.
- (Fix) Add Header Checksum Calculation after modification of ACPI Header.

<1.35>
- (Fix) Fixed Network boot happened at reboot after WOL from S3.
- (Fix) Fix AMT remote force PXE boot fail.(Need Load BIOS default)

<1.34>
- (Fix) Fix SMBios Type16/17 information incorrect.

<1.33>
- (Fix) Support interface of TPM firmware update.

<1.32>
- (New) Supported disable Back Flash Prevention for Mfg.
- (New) Add the RTC Power Status to the condition of Bottom cover tamper detection.
- (New) Add Back Flash Prevention flag(THP-1) for PSIRT-TA-201708-001.
- (Fix) Security Fix: Security ID 005-009 (Intel TA201708-001) for SPI Write status command.
- (Fix) Fixed BitLocker recovery issue when PCR5 was enabled as platform validation profile.

<1.31> - <1.05> lebih lengkap dapat dilihat pada sumber di bawah
```

sumber : [**r02uj64w.txt**](https://download.lenovo.com/pccbbs/mobiles/r02uj64w.txt){:target="_blank"} (diakses tanggal: 2018/05/18)

![gambar7](https://s20.postimg.cc/fywlvhi25/gambar_07.gif)
<p class="img-caption">Ilustrasi membuka Summary of Change</p>

Nah, dengan adanya informasi di atas, mudah-mudahan dapat memberikan gambaran kepada teman-teman untuk membantu memberikan informasi sebagai bahan pertimbangan apakah update BIOS dirasa perlu atau tidak. Kira-kira seperti itu. Hehehe.

*terima kasih untuk kang [Sucipto](https://sucipto.net/){:target="_blank"}.

# Disclaimer
><p class="title-quote">[ ! ] Perhatian</p>
>Perlu saya garis bawahi, bahwa saya sebagai penulis tidak bertangung jawab atas segala bentuk resiko kerusakan, kehilangan data, *hard brick* dan lain sebagainya. Yang diakibatkan karena proses mengikuti tulisan dokumentasi ini.
>
>***Do with your own risk, Dude***.

# Langkah-langkah

## Step 1: Download Lenovo BIOS
Kita perlu mendownload BIOS image/iso dari [support.lenovo.com](https://support.lenovo.com/id/en/){:target="_blank"}, untuk tipe spesifik dari Lenovo kalian. Dalam dokumentasi ini saya menggunakan Lenovo ThinkPad x260, maka saya akan mencari dengan kata kunci "x260 bios".

![gambar1](https://s20.postimg.cc/5h63g407h/gambar_01.gif)
<p class="img-caption">Gambar 1 - Mencari BIOS x260</p>

Pilih hasil dengan awalan **[Driver] BIOS Update ...** Dan pastikan tanggalnya adalah tanggal paling terakhir atau terbaru.

Pada Gambar 1, saya memilih pilihan pertama, maka akan diarahkan ke Gambar 2, di bawah.

Apabila kamu memilih pilihan kedua, langsung saja ke Gambar 3.

![gambar2](https://s20.postimg.cc/3kdypiyzx/gambar_02.gif)
<p class="img-caption">Gambar 2 - Mencari ISO image</p>

Gambar 2 di atas, menunjukkan saya mencari **Bootable CD**, yang akan di lanjutkan ke Gambar 3 di bawah.

![gambar3](https://s20.postimg.cc/gsdchzyyl/gambar_03.gif)
<p class="img-caption">Gambar 3 - Copy download link dari ISO</p>

Gambar 3 di atas, saya melakukan **Copy link address**, pada BIOS Update (Bootable CD) ISO.

Setelah mendapatkan link tersebut, buka Terminal dan kita akan mendownload menggunakan `wget`.

```
$ cd /tmp/
$ wget https://download.lenovo.com/pccbbs/mobiles/r02uj64d.iso
```

Perhatikan baik-baik, akhir dari link yang kita *copy* tersebut harusnya berakhiran dengan **.iso**.

![gambar4](https://s20.postimg.cc/s5zvta1sd/gambar_04.gif)

Setelah selesai,

```
--2018-05-17 22:56:02--  https://download.lenovo.com/pccbbs/mobiles/r02uj64d.iso
Loaded CA certificate '/etc/ssl/certs/ca-certificates.crt'
Resolving download.lenovo.com (download.lenovo.com)... 104.93.85.205
Connecting to download.lenovo.com (download.lenovo.com)|104.93.85.205|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 22392832 (21M) [application/octet-stream]
Saving to: ‘r02uj64d.iso’

r02uj64d.iso               100%[=====================================>]  21.36M   947KB/s    in 47s

2018-05-17 22:56:52 (469 KB/s) - ‘r02uj64d.iso’ saved [22392832/22392832]
```

## Step 2 : Pasang geteltorito cli

Kita membutuhkan program bernama `geteltorito` yang akan berguna untuk mengekstrak file image dari file ISO yang baru saja kita download.

Untuk distribusi linux Debian/Ubuntu/Fedora/RedHat/OpenSUSE program ini bernama `genisoimage`.

**Debian/Ubuntu**
```
$ sudo apt-get install genisoimage
```

**Fedora**
```
$ sudo dnf install genisoimage
```

**RedHat/Centos**
```
$ sudo yum install genisoimage
```

**SUSE/OpenSUSE**
```
$ sudo zypper install genisoimage
```

**Arch Linux (AUR)**
```
$ pikaur -S geteltorito
```

Cara lain, dapat langsung menggunakan Perl script di bawah ini.
```
$ wget https://userpages.uni-koblenz.de/~krienke/ftp/noarch/geteltorito/geteltorito/geteltorito
$ chmod +x geteltorito
```

## Step 3: Ekstrak Image dari File ISO

`geteltorito` adalah **El Torito boot image extractor**. Kita akan menggunakan program ini untuk mengeluarkan file image dari file ISO.

Formulanya,
```
$ geteltorito -o {nama-output-image.img} {Bootable-CD.iso}
```

Contoh punya saya,
```
$ geteltorito -o x260.img r02uj64d.iso
```
Berikan *output name* .img sesuka kalian.

<br>
![gambar5](https://s20.postimg.cc/o9mjxqji5/gambar_05.gif)

## Step 4: Bakar Image ke dalam Flash Drive

Kalian dapat mengidentifikasi alamat dari Flash Drive dengan menggunakan perintah.
```
$ lsblk
```
```
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda      8:0    0 447.1G  0 disk
├─sda1   8:1    0   511M  0 part /boot
└─sda2   8:2    0 446.6G  0 part /
sdb      8:16   1   7.2G  0 disk
└─sdb1   8:17   1    21M  0 part
```

Dari kolom **Size** saya dapat mengetahui bahwa *flash drive* saya adalah `/dev/sdb`.

Kemudian, kita akan membakar file `x260.img` yang sudah kita ekstrak dari ISO ke dalam *flash drive* menggunakan perintah `dd`.
```
$ sudo dd if=x260.img of=/dev/sdb bs=64K
```
Kalian sesuaikan dengan nama image dan alamat dari *flash drive* yang kalian miliki.

![gambar6](https://s20.postimg.cc/tnlc52jgd/gambar_06.gif)

Dengan begini, *flash drive* sudah siap untuk kita gunakan untuk mengupdate BIOS Lenovo kita.

## Step 5: Proses Update BIOS

Berikut ini adalah video proses update BIOS Lenovo. Mohon maaf apabila video ini terlalu lama, sekitar 6 menit. Saya tidak ingin memotong bagian-bagian penting dari proses update ini.

{% youtube VjPw1RP0fYc %}

# Referensi
1. [https://www.cyberciti.biz/faq/update-lenovo-bios-from-linux-usb-stick-pen/](https://www.cyberciti.biz/faq/update-lenovo-bios-from-linux-usb-stick-pen/){:target="_blank"}
<br>Diakses tanggal : 2018/05/16
