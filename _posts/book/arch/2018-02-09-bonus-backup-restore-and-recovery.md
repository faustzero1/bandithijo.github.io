---
layout: 'post'
title: 'Bonus: Backup, Restore, and Recovery'
date: 2018-02-09 09:00
permalink: '/arch/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'arch'
tags:
pin:
---


# Bonus: Backup, Restore & Recovery

## Backup

Mungkin sebagian dari teman-teman sudah sangat familiar dan mempunyai cara sendiri dalam melakukan backup terhadap data-data yang dimiliki.

Pada part ini saya akan berbagi informasi bagaimana cara saya melakukan backup. Saya sangat menyadari bahwa mungkin cara yang saya dalam melakukan backup, bukan merupakan cara yang baik dan benar. Dengan keterbatasan ilmu saya saat menulis dokumentasi ini, maka cara ini yang masih saya pergunakan.

**Pertama**, kita membutuhkan partisi backup dengan kapasitas sebesar partisi root.

Bagaimana caranya ?

1. Siapkan satu buah hard disk minimal berkapasitas yg sama dengan partisi root, atau dapat juga berkapasitas lebih besar.
2. Apabila ingin menggunakan hard disk external yang sudah ada, maka siapkan satu buah partisi backup sebesar partisi root atau lebih besar.

**Kedua**, format partisi sekaligus memberikan memproteksi dengan LUKS enkripsi agar data-data backup kita tidak dapat dibuka oleh orang lain dengan mudah.

Bagaimana caranya ?

Buka aplikasi **GNOME Disks** \(`gnome-disk-utility` – Disk management utility for GNOME\).

![]({{ site.lazyload.logo_blank }}){:data-echo="/assets/Gambar 2.png"}

Gambar 2 - GNOME Disks

Seperti yang kalian lihat pada Gambar 2, saya mempunyai hard disk berkapasitas 1 TB, dengan tiga buah partisi.

```
1. 540 GB | /dev/sdb1 | Partition 1         | LUKS Encryption
2. 250 GB | /dev/sdb2 | Partition 2         | LUKS Encryption
3. 215 GB | /dev/sdb3 | BANDITHIJO-NTFS    | NTFS
```

Terdapat dua partisi dengan LUKS Encryption, yaitu **Partition 1** dan **Partition 2**. Ini adalah contoh dari bentuk partisi yang telah dipasang LUKS. Bisa dilihat pada **Contents :** \(paling bawah\), terdapat status **Locked**. Maksudnya, apabila partisi ini di_mounting_, kita diminta untuk memasukkan password.

Cara mengesetnya sangat mudah. Saya berasumsi bahwa kalian sudah mempartisi hard disk yang akan kalian gunakan sebagai media backup. Saya telah menyiapkan **Partition 1**, yang akan saya gunakan. Kemudian ikutin langkah-langkah di bawah.

![]({{ site.lazyload.logo_blank }}){:data-echo="/assets/Gambar 3.1.png"}

Gambar 3.1 - Format Partition

Pilih **Partition 1** → **klik Gear icon** → pilih **Formation Partition**.

![]({{ site.lazyload.logo_blank }}){:data-echo="/assets/Gambar 3.2.png"}

Gambar 3.2 - Format Volume Window \(1\)

Pilih **Type : Encrypted, compatible with Linux systems \(LUKS + Ext4**\).

![]({{ site.lazyload.logo_blank }}){:data-echo="/assets/Gambar 3.3.png"}

Gambar 3.3 - Format Volume Window \(1\)

Maka akan menampilkan form seperti di atas. Isi **Name** dan **Passphrase**. Lalu, pilih **Format**.

![]({{ site.lazyload.logo_blank }}){:data-echo="/assets/Gambar 3.4.png"}

Gambar 3.4 - Format Volume Window \(3\)

Muncul Pop Up Window yang menanyakan apakah kamu yakin ? Kalau yakin, pilih **Format**.

![]({{ site.lazyload.logo_blank }}){:data-echo="/assets/Gambar 3.5.png"}

Gambar 3.5 - Partition 1 dalam kondisi Unlocked

![]({{ site.lazyload.logo_blank }}){:data-echo="/assets/Gambar 3.6.png"}

Gambar 3.6 - Partition 1 dalam kondisi Locked

Sampai tahap ini, maka partisi kita telah siap untuk menjadi target media tempat kita menyimpan backup partisi root.

Sekarang kita akan melakukan backup. Terlebih dahulu, buka status Locked pada partisi yang sudah kita persiapkan. Dengan cara klik icon gembok yang terbuka. Apabila berhasil, Partition 1 akan terbagi menjadi 2 bagian, atas \(Partition 1 LUKS\) dan bawah \(BACKUP-ROOT Ext4\).

Kita akan menggunakan `rsync` untuk melakukan backup. Dengan beberapa parameter dan properties. Lihat contoh command di bawah.

```
$ sudo rsync -aAXvP --delete --exclude=dev --exclude=proc --exclude=sys --exclude=tmp --exclude=run --exclude=mnt --exclude=home/.ecryptfs / /run/media/archer/BACKUP-ROOT/
```

Perintah di atas dapat diartikan, kita akan menjalankan perintah `rsync` dengan **tidak mengikutsertakan** direktori-direktori berikut ini : `dev`, `proc`, `sys`, `tmp`, `run`, `mnt`, `home/.ecryptfs` dari `/` ke `/run/media/archer/BACKUP-ROOT/`.

Untuk details dari option `-aAXvP` dan `--delete`, dapat dibaca pada `man rsync`.

Proses ini akan memindahkan semua isi yang ada pada direktori `/` menuju direktori yang ada pada hard disk external kita yaitu `/run/media/archer/BACKUP-ROOT/`, tidak termasuk directory yang sudah kita tuliskan di atas.

Proses ini memakan waktu lama, bergantung pada seberapa banyak file yang ada pada direktori root `/` kalian. Sebaiknya pilih hard disk yang sudah menggakan teknologi USB 3.0 agar proses transfer data lebih cepat.

> **Mengapa tidak mem-backup /home directory ?**
>
> Karena `/home` directory sudah terdapat di dalam directory `/`.
>
> **Mengapa mem-backup semua direktori pada /, tidak /home saja ?**
>
> Karena beberapa preferensi pribadi saya terdapat pada direktori `/etc` dan `/usr`.

Kalian dapat menentukan direktoi-direktori apa saja yang tidak ingin ikut dibackup, tambahkan dengan cara `--exclude=namaDirektori`. Atau bahkan kalian ingin merubah source dan destination. Sangat bisa. Saya tidak mengharuskan untuk mengikuti preferensi saya.

Sampai pada tahap ini, langkah-langkah membuat backup telah selesai.

Kalian dapat membuat alias dari command di atas, agar tidak perlu menulis kembali command backup yang sangat panjang dan beresiko untuk typo.

Caranya tambahkan sebaris command alias pada `.bashrc` atau `.zshrc` \(tergantung kalian pakai `shell` yang mana\).

```
$ nano .bashrc
```

```
...
...

# BACKUP ENTIRE SYSTEM
alias backup-root=”sudo rsync -aAXvP --delete --exclude=dev --exclude=proc --exclude=sys --exclude=tmp --exclude=run --exclude=mnt --exclude=home/.ecryptfs / /run/media/archer/BACKUP-ROOT/”
```

`backup-root` dapat kalian ganti sesuai keinginan. Maka, saat ingin melakukan backup, kalian tinggal menghubungkan hard disk dengan komputer/laptop → masukkan password enkripsi → buka Terminal → ketikan backup-root.

## Restore

Setelah kita melakukan backup, langkah selanjutnya adalah mengerti bagaimana proses _restore_. Secara sederhana, dan memang sederhana, proses _restore_ yang saya lakukan adalah meng-_copy_ direktori-direktori yang saya perlukan, satu persatu. Karena apabila saya melakukan instalasi ulang, sebisa mungkin saya menjaga bagaimana sistem tetap dalam keadaan _fresh_ and _clean_. Hanya data-data tertentu dan saya inginkan saja yang saya _restore_. Sangat “rambo” dan manual sekali bukan. Hehehe

Mungkin kalian perlu melakukan _testing_ terhadap file hasil backup sebelum _system_ _failure_ yang sebenarnya terjadi.

> “_**An untested backup is NOT backup !**_” – Average Linux User.

## Recovery

Apabila terjadi _system failure_, yang saya lakukan adalah mengambil flash drive bootable berisi Arch Installer, dan melakukan seperti yang ada pada **Step 3.1** sampai `pacstrap` script saja. Kemudian `arch-chroot`, dan melakukan update. Atau sambil menunggu maintainer memperbaiki package yang _error_ tersebut.

> Sebuah keharusan untuk menyiapkan sendiri sebuah flash drive bootable berisi Arch Installer. Agar sewaktu-waktu apabila terjadi kegagalam sistem, kita dapat melakukan tindakan recovery.

4 dari 5 system failure yang pernah saya alami selama 2 tahun menggunakan Arch Linux adalah karena terlalu sering melakukan update. Sedangkan package satu dengan package lain saling berketergantungan. Misal, package A dan B saling ketergantungan, namun package A sudah lebih dulu diupdate, sedangkan package B belum. Hal-hal seperti ini dapat saja dapat menyebabkan system failure saat kita melakukan reboot. Pas lagi apes-apesnya. Biasanya saya tunggu beberapa jam atau satu hari. Lalu saya lakukan **Step 3.1 → pacstrap → arch-chroot → update**. Dan kebanyakan problem terselesaikan.

Banyak lagi hal-hal lain yang dapat menyebabkan _system failure_. Contoh dan metode di atas dapat saya katakan sebagai **P3K** \(Pertolongan Pertama Pada Ke-error-an\) yang terjadi pada sistem kita.


<!-- NEXT PREV BUTTON -->
<div class="post-nav">
<a class="btn-blue-l" href="/arch/step-7-install-gnome-and-complete-installation"><img style="width:20px;" src="/assets/img/logo/logo_ap.png"></a>
<a class="btn-blue-c" href="/arch/"><img style="width:20px;" src="/assets/img/logo/logo_menu.svg"></a>
<a class="btn-blue-r" href="/arch/references"><img style="width:20px;" src="/assets/img/logo/logo_an.png"></a>
</div>
