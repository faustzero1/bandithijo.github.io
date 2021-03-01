---
layout: 'post'
title: "Membuat Recovery Partition Artix Linux ISO dengan GRUB2"
date: 2021-03-01 09:14
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips']
pin:
hot:
contributors: []
resume: "Sebelumnya, saya sudah pernah mencatat tentang bagaimana booting ke ISO Linux dari GRUB2, ternyata, terdapat keterbatasan, karena ISO berada pada partisi yang sama dengan partisi sistem yang akan direcovery, sehingga kita tidak dapat melakukan intervansi terhadap sistem. Catatan ini adalah modifikasi, ISO diletakkan pada partisi berbeda."
---

# Latar Belakang Masalah

Sebelumnya, saya sudah membuat catatan dengan judul serupa, [**Booting ke Linux ISO menggunakan GRUB2 (Tanpa Bootable FlashDrive) a.k.a RecoveryHD**](/blog/booting-ke-iso-linux-menggunakan-grub){:target="_blank"}.

Namun, ternyata setelah saya gunakan untuk melakukan **arch-chroot**, partisi tidak dapat di-mounting ke **/mnt**.

Saya menduga hal ini diakibatkan oleh, saya menjalankan Arch ISO dari dalam filesystem yang akan saya mounting. Melakukan mounting ke filesystem yang sudah dimounting oleh Arch ISO. Karena Arch ISO disimpan pada partisi **/dev/sda1**, yaitu pada direktori **/root/iso/archlinux.iso**. Sedangkan, saya ingin memounting **/dev/sda1** ke **/mnt** untuk melakukan arch-chroot. Lucu kan 😄.

# Pemecahan Masalah

Dari kasus tersebut, sudah terlihat solusi sederhana yang dapat saya lakukan adalah, membuat partisi sendiri khusus untuk menyimpan file ISO.

## Membuat Partisi Recovery

Cara untuk membuat partisi, bebas saja, teman-teman dapat menggunakan tools favorit teman-teman.

Saya pribadi mengguakan [**GParted LiveUSB**](https://gparted.org/download.php){:target="_blank"} agar lebih mudah dalam mevisualisasikan partisi.

Kira-kira, seperti di bawah ini.

<pre>
NAME   FSTYPE   SIZE TYPE LABEL    MOUNTPOINT
sda           447.1G disk
├─sda1 ext4   446.1G part ROOT     /
└─<mark>sda2 ext4    1023M part RECOVERY</mark>
</pre>

Saya membuat partisi **/dev/sda2** sebesar 1 GiB dan saya beri label **RECOVERY** degan filesystem **ext4**.

Ukuran partisi hanya 1 GiB karena tujuan saya membuat partisi ini adalah untuk menyimpan file ISO dari Artix Linux Base OpenRC yang hanya sebesar 600an MiB


## Membuat GRUB2 Menuentry

Selanjutnya, kita perlu membuat menuentry pada GRUB2, untuk mengarahkan boot ke dalam partisi recovery yang di dalamnya sudah berisi Artix Linux ISO.

{% highlight_caption /etc/grub.d/40_custom %}
{% highlight sh linenos %}
#!/bin/sh
exec tail -n +3 $0
# This file provides an easy way to add custom menu entries.  Simply type the
# menu entries you want to add after this comment.  Be careful not to change
# the 'exec tail' line above.

menuentry "ArtixLinux ISO (OpenRC)" {
  iso_drv=(hd0,msdos2)
  iso_path="/artix-base-openrc-20210101-x86_64.iso"
  export iso_path
  search --set=root --file "$iso_path"
  probe -u $root --set=rootuuid
  export rootuuid
  loopback loop "$iso_drv$iso_path"
  root=(loop)
  configfile /boot/grub/loopback.cfg
  loopback --delete loop
}
{% endhighlight %}

**Yang harus diperhatikan!**

**iso_drv**, adalah path yang mengarahkan ke partisi yang kita siapkan khusus untuk recovery. **hd0** berarti disk pertama, **msdos2** berarti partisi kedua. (**/dev/sda2**).

**iso_path**, adalah letak dimana Artix ISO kita letakkan di dalam partisi recovery. Saya meletakkanya di luar, tanpa direktori apapun, agar path tidak terlalu panjang.

Kedua variable di atas, perlu teman-teman sesuaikan sendiri dengan kondisi sistem yang teman-teman miliki.

## Update GRUB2

Kalau sudah, tinggal update GRUB2.

{% shell_cmd $ %}
sudo update-grub
{% endshell_cmd %}

Atau,

{% shell_cmd $ %}
sudo grub-mkconfig -o /boot/grub/grub.cfg
{% endshell_cmd %}

Agar custom menuentry yang baru saja kita buat/modifikasi, digenerate ke dalam GRUB2 menuentry.

Mantap!

Kalau sudah begini tinggal mencobanya.


# Demonstrasi

{% youtube 1WImC1ge40c %}







<br>
# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Selanjutnya, saya serahkan kepada imajinasi dan kreatifitas teman-teman. Hehe.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)




# Referensi

1. [forum.artixlinux.org/index.php/topic,1669.0.html](https://forum.artixlinux.org/index.php/topic,1669.0.html){:target="_blank"}
<br>Diakses tanggal: 2021/03/01
