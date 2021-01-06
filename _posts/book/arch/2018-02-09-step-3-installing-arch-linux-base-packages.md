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

{% shell_root %}
mount /dev/mapper/volume-root /mnt
{% endshell_root %}

<pre>
NAME                          RM   SIZE RO TYPE  MOUNTPOINT
/dev/loop0                     0 559.5M  1 loop  /run/archiso/sfs/airootfs
/dev/sr0                       1 682.3M  0 rom   /run/archiso/bootmnt
/dev/sda                       0    10G  0 disk
├─/dev/sda1                    0   512M  0 part
└─/dev/sda2                    0   9.5G  0 part
  └─/dev/mapper/lvm            0   9.5G  0 crypt
    └─/dev/mapper/volume-root  0   9.5G  0 lvm   <mark>/mnt</mark>
</pre>

{% box_pertanyaan %}
<p><b>Mengapa bukan partisi /dev/sda2 yang dimount ke /mnt?</b></p>
<p>Karena partisi <code>/dev/sda2</code> sudah kita enkripsi, kemudian kita dekripsi menjadi <code>/dev/mapper/volume-root</code>. Maka hanya partisi yang telah didekripsi yang dapat kita <i>mount</i> untuk di-<i>install</i> <code>base</code> <i>package</i>.</p>
{% endbox_pertanyaan %}

Selanjutnya, membuat direktori `/boot` pada `/mnt/boot`.

{% shell_root %}
mkdir -p /mnt/boot
{% endshell_root %}

_Mount_ partisi `/dev/sda1` ke partisi `/mnt/boot`.

{% shell_root %}
mount /dev/sda1 /mnt/boot
{% endshell_root %}

<pre>
NAME                          RM   SIZE RO TYPE  MOUNTPOINT
/dev/loop0                     0 559.5M  1 loop  /run/archiso/sfs/airootfs
/dev/sr0                       1 682.3M  0 rom   /run/archiso/bootmnt
/dev/vda                       0    10G  0 disk
├─/dev/vda1                    0   512M  0 part  <mark>/mnt/boot</mark>
└─/dev/vda2                    0   9.5G  0 part
  └─/dev/mapper/lvm            0   9.5G  0 crypt
    └─/dev/mapper/volume-root  0   9.5G  0 lvm   /mnt
</pre>

{% box_perhatian %}
<p>Proses mounting di atas <b>harus berurutan</b> dan <b>tidak dapat dibolak-balik</b>. Misal, <i>mounting</i> <code>/dev/sda1 /mnt/boot</code> partisi terlebih dahulu. Apabila hal ini dilakukan akan menyebabkan <b>kegagalan saat instalasi bootloader</b>.</p>
{% endbox_perhatian %}

Setelah partisi yang kita siapkan telah kita _mounting_, langkah selanjutnya adalah kita akan menggunakan `pacstrap` _script_ untuk menginstal `base` _package_ Arch Linux.

{% shell_root %}
pacstrap /mnt base base-devel linux linux-headers linux-firmware archlinux-keyring
{% endshell_root %}

Pada proses instalasi di atas saya menambahkan `base-devel` _package_. Proses instalasi ini akan berjalan lumayan lama. “Total _download size_” saat dokumentasi ini dibuat adalah 418.26 MiB.

Saya juga menambahkan kernel `linux` beserta `linux-headers` (yang biasanya diperlukan oleh paket seperti virtualbox, dll), serta `linux-firmware`. Karena pada berita ini, [(New kernel packages and mkinitcpio hooks 2019-11-10)](https://www.archlinux.org/news/new-kernel-packages-and-mkinitcpio-hooks/){:target="_blank"}, paket linux sudah dipisahkan dari group `base`. Tentunya ini merupakan keuntungan untuk yang ingin menggunakan paket kernel yang lain, seperti kernel `linux-lts`, `linux-hardened` dan `linux-zen`.

Apabila proses `pacstrap` telah selesai, langkah selanjutnya adalah _generate_ `fstab`.

{% shell_root %}
genfstab -U /mnt > /mnt/etc/fstab
{% endshell_root %}

Perintah ini bertujuan untuk _mounting blok_ partisi mana yang akan di-*mounted* saat sistem di-*bootup*.  Kita bisa mengecek apakah hasil dari _generate_ `fstab` dengan perintah `# cat /mnt/etc/fstab`.

Hasil dari _generate_ `fstab` tersebut adalah sebagai berikut :

{% highlight_caption /mnt/etc/fstab %}
<pre class="caption">
# /dev/mapper/volume-root
UUID=be69e81c-90aa-4db9-be19-1444ecb76a35       /               ext4            rw,relatime     0 1

# /dev/vda1
UUID=3834-9DA2   /boot   vfat    rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro       0 2
</pre>

Kita dapat melihat `/dev/sda1` dan `/dev/mapper/volume-root`, artinya _mounting_ partisi dan _generate_ `fstab` telah berhasil dan benar. Karena apabila proses _mouting_ pada Step 3.1 salah, maka hasil _generate_ `fstab` juga akan salah. Misal, tidak terdapat partisi `/boot` yaitu `/dev/sda1`, maka apabila terjadi seperti ini, akan berdampak pada kegagalan saat proses instalasi `bootloader`.

Setelah kita selesai meng-*install* _base package_, langkah selanjutnya adalah konfigurasi komponen-komponen lain yang diperlukan oleh sistem operasi seperti _Bootloader_, _Time Zone_, _Locale_, _Hostname_, _Username_, _Passwords_, dll.

Untuk masuk ke dalam sistem yang sudah kita _install_ kita akan berpindah dari _root_ Arch _Installer_ ke _root_ Arch sistem yang baru saja kita buat.

Caranya dengan menggunakan `chroot` \(_change root_\).

{% shell_root %}
arch-chroot /mnt
{% endshell_root %}

{% box_info%}
<p markdown=1>Apabila perintah di atas berhasil, makan kalian dapat melihat perubahan pada `username` dan `hostname` yang terbungkus oleh tanda `[ ... ]`. Artinya kita telah masuk ke dalam `root` sistem yang baru saja kita _install_.</p>

<p markdown=1>Sebelum `arch-chroot`.</p>
<pre>
<span style="color:red;">root</span>@archiso ~ #
</pre>

<p markdown=1>Setelah `arch-chroot`.</p>
<pre>
[root@archiso /]#
</pre>
{% endbox_info %}

Pada tahap ini, kita dapat bergerak ke _step_ selanjutnya.



<!-- NEXT PREV BUTTON -->
{% assign btn-next = "/arch/step-2-disk-partitioning" %}
{% assign btn-menu = "/arch/" %}
{% assign btn-prev = "/arch/step-4-set-up-bootloader" %}
<div class="post-nav">
<a class="btn-blue-l" href="{{ btn-next }}"><img class="btn-img" src="/assets/img/logo/logo_ap.png"></a>
<a class="btn-blue-c" href="{{ btn-menu }}"><img class="btn-img" src="/assets/img/logo/logo_menu.svg"></a>
<a class="btn-blue-r" href="{{ btn-prev }}"><img class="btn-img" src="/assets/img/logo/logo_an.png"></a>
</div>
