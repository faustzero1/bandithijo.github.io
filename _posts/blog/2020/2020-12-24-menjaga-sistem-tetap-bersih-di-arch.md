---
layout: 'post'
title: "Menjaga Sistem Tetap Bersih di Arch Linux"
date: 2020-12-24 12:23
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
---

# Latar Belakang Masalah

Seiring berjalannya waktu, sistem yang kita gunakan pasti akan penuh dengan file-file cache dan log.

Mulai dari cache dan log proses instalasi package hingga log dari penggunaan sehari-hari.

Apabila dibiarkan, tentu saja hal ini akan menumpuk sedikit-demi sedikit lama-lama menjadi bukit. 😄

Sistem komputer bukanlah sebuah makhluk yang pintar, tentu saja kita perlu untuk memprogramkan terlebih dahulu agar sistem komputer dapat melakukan hal-hal sesuai dengan yang kita programkan. Termasuk membersihkan sampah-sampah yang sudah tidak terpakai.

# 1. Clean Package Cache (Pacman)

Secara default Arch akan menyimpan cache package hasil proses unduhan dari repositori. Tentu dengan maksud dan tujuan tertentu.

Namun, saya tidak memerlukan hal ini, karena saya dapat mengakses internet 24 jam. Apabila saya memerlukan versi sebelumnya, saya tinggal unduh lagi.

Arch menyimpan paket hasil unduhan dari repositori pada direktori ini.

{% shell_user %}
ls /var/cache/pacman/pkg | less
{% endshell_user %}

Untuk memeriksa kapasitasnya gunakan perintah,

{% shell_user %}
du -sh /var/cache/pacman/pkg
{% endshell_user %}

<pre>
4.5G    /var/cache/pacman/pkg
</pre>

Lihat, ini adalah besarnya cache dari package-package pacman yang ada di sistem saya yang sebenarnya tidak saya perlu-perlukan banget.

Kapasitas sebesar itu saya dapatkan dari proses migrasi Arch ke Artix, dimana saya memilih untuk mengunduh ulang semua pakcages kurang lebih sebanyak 2000an packages. 😄

## a. Clean Manually

{% shell_user %}
sudo pacman -Sc
{% endshell_user %}

<pre>
Packages to keep:
  All locally installed packages

Cache directory: /var/cache/pacman/pkg/
:: Do you want to remove all other packages from cache? [Y/n] <span style="font-weight:bold;color:#FFCC00;">y</span>

removing old packages from cache...

Database directory: /var/lib/pacman/
:: Do you want to remove unused repositories? [Y/n] <span style="font-weight:bold;color:#FFCC00;">y</span>

removing unused sync repositories...
</pre>

`-c` berfungsi untuk menghapus "old packages" from cache.

Nah, kalau hanya menggunakan satu buah option c, yang terhapus hanya cache packet yang terbaru.

Untuk menghapus semuanya gunakan double option c.

{% shell_user %}
sudo pacman -Scc
{% endshell_user %}

Ikuti langkah2nya dengan menekan huruf **y**.

Kemudian periksa lagi kapasitas direktori tersebut.

<pre>
$ <b>du -sh /var/cache/pacman/pkg</b>
268K    /var/cache/pacman/pkg

$ <b>ls /var/cache/pacman/pkg</b>
total 0
</pre>

Nah, sudah benar-benar bersih.

{% box_info %}
<p markdown=1>Selain menggunaka **pacman**, untuk teman-teman yang menggunakan AUR Helper **yay**, dapat mengganti pacman dengan yay agar package cache dari yay yang terdapat pada direktori Home, ikut dibersihkan.</p>
{% endbox_info %}


## b. Clean Automatically

Kita akan memasang script untuk membantu kita membersikan sistem secara otomatis.

{% shell_user %}
sudo pacman -S pacman-contrib
{% endshell_user %}

Lalu jalankan scriptnya.

{% shell_user %}
paccache -r
{% endshell_user %}

`-r` untuk menghapus "candidate package".

Kalau outputnya seperti ini,

<pre>
==> no candidate packages found for pruning
</pre>

Artinya, sudah tidak ada lagi package yang perlu dibersihkan dari sistem.

### b.1. paccache dengan Systemd Timer
Kalau yang mau dihapus otomatis secara berkala (periode tertentu) bisa menggunakan systemd timer.

Misal untuk sekali dalam sebulan.

{% shell_user %}
sudoedit /etc/systemd/system/paccache.timer
{% endshell_user %}

{% highlight_caption /etc/systemd/system/paccache.timer %}
{% highlight conf linenos %}
[Unit]
Description=Clean-up old pacman pkg

[Timer]
OnCalendar=monthly
Persistent=true

[Install]
WantedBy=multi-user.target
{% endhighlight %}

Lalu enablekan,

{% shell_user %}
sudo systemctl enable paccache.timer
sudo systemctl start paccache.timer
{% endshell_user %}

Cek statusnya,

{% shell_user %}
sudo systemctl status paccache.timer
{% endshell_user %}


## c. Clean After Run Pacman

{% shell_user %}
sudoedit /usr/share/libalpm/hooks/paccache.hook
{% endshell_user %}

{% highlight_caption /usr/share/libalpm/hooks/paccache.hook %}
{% highlight dosini linenos %}
[Trigger]
Operation = Upgrade
Operation = Install
Operation = Remove
Type = Package
Target = *

[Action]
Description = Cleaning pacman cache with paccache...
When = PostTransaction
Exec = /usr/bin/paccache -r
{% endhighlight %}

Nah, sekarang setiap kita memasang atau menghapus program, maka **paccache** akan teraktivasi untuk menghapus cache package.

{% box_info %}
<p markdown=1>Teman-teman juga dapat mengatur *trigger operation* yang diinginkan.</p>
<p markdown=1>Lihat blok **[Trigger]**</p>
<p>Tinggal pilih sesuai kebutuhan teman-teman, ingin menggunakan ketiganya (Upgrade, Install, Remove) atau salah satu dari ketiganya.</p>
{% endbox_info %}

Contohnya seperti ini,

{% shell_user %}
sudo pacman -R kermit
{% endshell_user %}

<pre>
checking dependencies...

Package (1)  Old Version  Net Change

kermit       3.2-1         -0.04 MiB

Total Removed Size:  0.04 MiB

:: Do you want to remove these packages? [Y/n] Y
:: Processing package changes...
(1/1) removing kermit                               [###########################] 100%
:: Running post-transaction hooks...
<mark>(1/1) Cleaning pacman cache with paccache...</mark>
==> no candidate packages found for pruning
</pre>



# 2. Clean Cache on Home

Besar cache yang berada di home bisa cukup gila-gilaan kalau kita tidak pernah membersihkannya.

{% shell_user %}
du -sh ~/.cache
{% endshell_user %}

<pre>
8.0G    /home/bandithijo/.cache
</pre>

Cache ini berasal dari berbagai macam aplikasi. Termasuk kalau teman-teman menggunakan AUR helper seperti **yay**.

Teman-teman bisa mencari tahu apa itu cache dan tujuannya digunakan cache.

Saya tidak berkeberatan untuk membersihkan cache yang ada di direktori sistem saya.

{% shell_user %}
rm -rvf ~/.cache/*
{% endshell_user %}

Nah, sekarang Home cache kita sudah bersih.




# 3. Mencari Direktori Tergemuk

Kita dapat menggunakan program bernama **ncdu** untuk mendeteksi direktori mana yang paling obesitas.

{% shell_user %}
sudo pacman -S ncdu
{% endshell_user %}

Lalu, bisa coba jalankan di Home direktori.

{% shell_user %}
ncdu ~
{% endshell_user %}

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/26kvgVfs/gambar-01.gif" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Proses listing direktori yang kegemukan</p>

Masih ada tools-tools dengan fungsi yang sama, yang teman-teman dapat gunakan untuk mencari direktori yang kegemukan, seperti:

1. **Filelight** (Qt)
2. **Baobab** (Gtk)
3. **duc**
4. **GdMap**
5. **gt5**

Teman-teman dapat melihat daftarnya di Arch Wiki, [di sini](https://wiki.archlinux.org/index.php/List_of_applications#Disk_usage_display){:target="_blank"}.







# Pesan Penulis

Catatan ini terinspirasi dari YouTube video [**Average Linux User - How to clean Arch Linux (Manjaro)**](https://youtu.be/3OoMvyHYWDY){:target="_blank"}. Namun, saya hanya mengambil langkah-langkah yang saya butuhkan. Apabila teman-teman tertarik melihat langkah-langkah yang lebih lengkap, saya merekomendasikan untuk mengunjungin video tersebut.

Sepertinya, segini dulu yang dapat saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)


# Referensi

1. [Average Linux User - How to clean Arch Linux (Manjaro)](https://youtu.be/3OoMvyHYWDY){:target="_blank"}
<br>Diakses tanggal: 2020/12/24
