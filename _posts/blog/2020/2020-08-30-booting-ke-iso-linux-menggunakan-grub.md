---
layout: 'post'
title: "Booting ke Linux ISO menggunakan GRUB2 (Tanpa Bootable FlashDrive) a.k.a RecoveryHD"
date: 2020-08-30 19:47
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Arch Linux']
pin:
hot:
contributors: []
---

# Latar Belakang Masalah

Sejak migrasi ke Arch Linux, saya selalu menyediakan FlashDrive dengan Bootable berisi ArchISO yang ~~rutin~~ saya perbaharui setiap bulannya (kalau ingat 😁).

Tujuan saya melakukan hal ini adalah untuk berjaga-jaga apabila saya tidak dapat masuk ke sistem dikarenakan satu dan lain hal. Meskipun hal ini **sangat jarang sekali** terjadi, namun apabila sedang terjadi, rasanya sangat merepotkan apabila tidak memiliki ArchISO.

Saya memerlukan ArchISO untuk melakukan proses chroot. Singkatnya chroot adalah tools yang dapat kita gunakan untuk berpindah root direktori. Dengan melakukan chroot saya dapat masuk ke dalam sistem Arch yang sedang bermasalah dan memperbaikinya dari dalam.

# Permasalahan

Mengerjakan rutinitas membuat bootable FlashDrive setiap bulannya sangat membosankan dan lebih sering terlupakan.

Namun, menyediakan jalan untuk situasi emergency adalah protokol yang sangat perlu saya lakukan. Saya tidak tahu kapan situasi buruk akan terjadi sehingga saya tidak dapat menggunakan sistem operasi saya.

# Pemecahan Masalah

Kalau kalian pernah memiliki laptop dengan Windows yang asli atau memiliki mesin Apple seperti Macbook, Macbook Pro, iMac dan Mac Mini. Teman-teman pasti pernah melihat sebuah partisi yang bernama Windows Recovery (Windows) atau RecoveryHD (macOS). Saya lebih sering menggunakan Recovery sewaktu masih menggunakan Macbook Pro.

Dengan RecoveryHD (seingat saya) kita dapat melakukan:

1. Instalasi ulang macOS tanpa menggunakan DVD yang berisi sistem operasi macOS
2. Manipulasi partition
3. Check Disk
4. dll. (saya lupa)

Dengan menggunakan RecoveryHD, sangat memudahkan sekali apabila sewaktu-waktu sistem operasi kita mengalami masalah.

Nah, saya ingin menerapkan cara ini kepada Arch Linux saya.

Kebetulan saya menggunakan GRUB2 sebagai boot loader. Saya pernah melihat fitur ini dalam tabel perbadingan antar boot loader, namun saat tulisan ini dibuat, saya tidak lagi dapat menemukan keterangan tersebut.

Intinya, **kita dapat booting ke dalam ArchISO yang image (.iso)-nya tersimpan di dalam hard drive menggunakan GRUB2**.

# Caranya

## Persiapkan Arch ISO image

Download terlebih dahulu ArchISO terbaru.

Setelah itu, mounting dan periksa struktur direktori dan beberapa file yang akan kita perlukan.

1. **vmlinuz-linux**

2. **intel-ucode.img** (kalau menggunakan Intel)*

3. **amd-ucode** (kalau menggunakan AMD)*

*Pilih salah satu saja

<pre>
ARCH_202008/
├── arch/
│   └── boot/
│       ├── x86_64/
│       │   ├── <mark>initramfs-linux.img</mark>
│       │   └── <mark>vmlinuz-linux</mark>
│       ├── <mark>amd-ucode.img</mark>
│       └── <mark>intel-ucode.img</mark>
├── EFI/
├── isolinux/
├── loader/
└── shellx64.efi
</pre>

**Catatan**: Untuk teman-teman yang menggunakan distribusi yang bukan Arch Linux, besar kemungkinan alamat dari kedua file tersebut akan berbeda.

Setelah kita mengetahui lokasi file-file tersebut, kita akan gunakan pada tahap berikutnya.

## Kenali Alamat dari Hard Drive Partition

GRUB menggunakan penamaan yang berbeda dengan yang digunakan oleh GNU/Linux dalam mendefinisikan drive name dan partisi.

Daripada menjelaskan dengan paragraf, saya akan langsung menjelaskan dengan bagan. Mudah-mudahan langsung dapat dipahami.

<pre>
LINUX           GRUB           KETERANGAN
-------------------------------------------------------
sda       ->    hd0      ->    HardDrive 1
├─sda1    ->    hd0,1    ->    HardDrive 1, Partition 1
├─sda2    ->    hd0,2    ->    HardDrive 1, Partition 2
└─sda3    ->    hd0,3    ->    HardDrive 1, Partition 3
sdb       ->    hd1      ->    HardDrive 2
├─sdb1    ->    hd1,1    ->    HardDrive 2, Partition 1
└─sdb2    ->    hd1,2    ->    HardDrive 2, Partition 1
sdc       ->    hd2      ->    HardDrive 3
├─sdc1    ->    hd2,1    ->    HardDrive 3, Partition 1
└─sda2    ->    hd2,2    ->    HardDrive 3, Partition 1
</pre>

Tujuannya adalah untuk mengarahkan dimana letak partisi dari lokasi file image ISO yang akan kita pergunakan.

Saya meletakaanya di `/root/iso/archlinux-2020.08.01-x86_64.iso` berada pada partisi `/dev/sda1` artinya ada pada `hd0,1`.

Oke, kalau sudah mengetahui hal ini, simpan informasi ini karena akan kita gunakan pada langkah selanjutnya.

## Menambahkan Custom Boot Menu ke GRUB2

Cara paling mudah untuk menambahkan *custom boot menu* adalah dengan menambahkannya pada file `/etc/grub.d/40_custom`.

Saya akan menambahkan custom boot menu di bawah nya, seperti pada baris 7-14 di bawah.

<pre>
$ <b>sudoedit /etc/grub.d/40_custom</b>
</pre>

{% highlight_caption /etc/grub.d/40_custom %}
{% highlight bash linenos %}
#!/bin/sh
exec tail -n +3 $0
# This file provides an easy way to add custom menu entries.  Simply type the
# menu entries you want to add after this comment.  Be careful not to change
# the 'exec tail' line above.

menuentry "ArchLinux ISO" {
    set root="(hd0,1)"
    set isofile="/root/iso/archlinux-2020.10.01-x86_64.iso"
    set dri="free"
    search --no-floppy -f --set=root $isofile
    probe -u $root --set=abc
    set pqr="/dev/disk/by-uuid/$abc"
    loopback loop $isofile
    linux  (loop)/arch/boot/x86_64/vmlinuz-linux img_dev=$pqr img_loop=$isofile driver=$dri
    initrd (loop)/arch/boot/intel-ucode.img
    initrd (loop)/arch/boot/x86_64/initramfs-linux.img
}
{% endhighlight %}

Untuk kernel parameter, kalian dapat memodifikasi sesuai preferensi masing-masing.

Untuk `-ucode`, saya menggunakan Intel. Kalian yang menggunakan AMD dapat menggunakan `amd-ucode.img`.

Simpan dan **jangan lupa update GRUB**.



## Update GRUB

Setiap melakukan modifikasi terhadap GRUB, lakukan GRUB update.

**Arch Linux based**

<pre>
$ <b>sudo grub-mkconfig -o /boot/grub/grub.cfg</b>
</pre>

**Debian/Ubuntu based**

<pre>
$ <b>sudo update-grub</b>
</pre>

Kalau sudah, tinggal menikmati hasilnya.

# Hasilnya

{% include youtube_embed.html id="xZWZ7gLH5FM" %}


# Pesan Penulis

Sepertinya, segini dulu yang saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)



# Referensi

1. [en.wikipedia.org/wiki/Chroot](https://en.wikipedia.org/wiki/Chroot){:target="_blank"}
<br>Diakses tanggal: 2020/08/30

2. [wiki.archlinux.org/index.php/GRUB](https://wiki.archlinux.org/index.php/GRUB){:target="_blank"}
<br>Diakses tanggal: 2020/08/30

3. [linoxide.com/linux-how-to/boot-linux-iso-images-directly-hard-drive/](https://linoxide.com/linux-how-to/boot-linux-iso-images-directly-hard-drive/){:target="_blank"}
<br>Diakses tanggal: 2020/08/30

4. [archcraft-os.github.io/blog/grub.html](https://archcraft-os.github.io/blog/grub.html){:target="_blank"}
<br>Diakses tanggal: 2020/08/30

5. [krisko210.blogspot.com/2019/12/boot-archlinux-cd-iso-from-local-disk.html?m=1](http://krisko210.blogspot.com/2019/12/boot-archlinux-cd-iso-from-local-disk.html?m=1){:target="_blank"}
<br>Diakses tanggal: 2020/09/20
