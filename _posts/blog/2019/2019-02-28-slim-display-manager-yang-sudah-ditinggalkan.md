---
layout: 'post'
title: 'SLiM, Display Manager yang Sudah Lama Ditinggalkan'
date: 2019-02-28 17:47
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Ulasan', 'Tips', 'Arch Linux']
pin:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Mungkin sebagian dari teman-teman ada yang sudah pernah mencicipi distribusi sistem operasi GNU/Linux yang menggunakan SLiM display manager.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/JzS4m67p/gambar-01.png"}
<p class="img-caption">Gambar 1 - SLiM display manager dengan default theme</p>

Dari informasi yang saya baca pada halaman [Arch Wiki/SLiM](https://wiki.archlinux.org/index.php/SLiM#Match_SLiM_and_Desktop_Wallpaper){:target="_blank"}. Proyek ini sudah ditinggalkan. Rilis paling akhir pada tahun 2013. Website dari proyek inipun sudah tidak ada lagi.

Pada halaman Arch Wiki tersebut juga kita disarankan untuk mempertimbangkan menggunakan Display Manager yang lain. Karena SLiM tidak secara penuh *support* dengan systemd, termasuk logind sessions.

# Mengapa Tertarik dengan SLiM?

Sebenarnya sudah lama mencari-cari pengganti dari LightDM display manager. Saya merasa kurang fleksibel dalam mengkostumisasi sesuai preferensi sendiri. Belum lagi transisi antara verbose mode dari journalctl ke tampilan LightDM tidak begitu *smooth*.

Sampai beberapa waktu lalu, menemukan halaman pada Slant.co yang membahas [What is the best Linux Display Manager?](https://www.slant.co/topics/2053/~best-linux-display-manager){:target="_blank"}.

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/SRfqskGy/gambar-02.png"}

Saya agak heran, karena bukan LightDM yang menduduki peringkat no. 1 saat ini (2019/02/28), melainkan SLiM dengan perolehan point sebanyak 92, disusul LightDM sebesar 84.

Dengan selisih yang tidak terlampau jauh, tidak menutup kemungkinan LightDM akan segera menyusul ke peringkat pertama.

Namun, saya tetap ingin mencoba SLiM. Karena rasa penasaran saya atas apa yang membuat SLiM masih menduduki peringkat pertama, padahal telah 5 tahun ditinggalkan.

## Kelebihan dan Kekurangan SLiM

![gambar_8]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/C1N5Z5SM/gambar-08.png"}
<p class="img-caption">Sumber: <a href="https://www.slant.co/topics/2053/~best-linux-display-manager" target="_blank">Slant.co - SLiM Pros and Cons</a></p>

# Pengecekan Paket

Karena paket SLiM display manager ini termasuk paket yang sudah tidak lagi dimaintain oleh upstream developer, tentunya akan sangat penting untuk mengetahui apakah paket yang akan kita gunakan memiliki *bug reports*, *security reposts*, dll.

Pada distribusi Arch Linux, untuk menelusuri sebuah paket sangatlah mudah. Kita hanya perlu mengunjungi [archlinux.org/packages](https://www.archlinux.org/packages/){:target="_blank"}. Kemudian, mencari paket bernama `slim`.

Beberapa hal yang saya perhatikan adalah:

1. **Last Updated**
2. **View Changes**
3. **Bug Reports**

Berikut ini tampilan dari ketiga hal di atas.

![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/T2NPtdTS/gambar-03.png"}
<p class="img-caption">Gambar 3 - <a href="https://www.archlinux.org/packages/extra/x86_64/slim/" target="_blank">last Updated</a></p>

![gambar_4]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/fT3RFGLb/gambar-04.png"}
<p class="img-caption">Gambar 4 - <a href="https://git.archlinux.org/svntogit/packages.git/log/trunk?h=packages/slim" target="_blank">View Changes</a></p>

![gambar_5]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/5NZ2MsYS/gambar-05.png"}
<p class="img-caption">Gambar 5 - <a href="https://bugs.archlinux.org/?project=1&string=slim" target="_blank">Bug Reports</a></p>

Nah, dengan begini, kita dapat memantau, apakah paket SLiM ini **tidak lagi dimaintain** di Arch Linux atau **memiliki bug**.

Kita juga dapat sekalian mengecek apakah paket `slim` ini memiliki *security issue* atau tidak, pada halaman [security.archlinux.org](https://security.archlinux.org/){:target="_blank"}.

Untuk teman-teman yang menggunakan distribusi selain Arch atau turunan Arch, silahkan menyesuaikan saja yaa.

# Instalasi

<!-- PERHATIAN -->
<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
<p><b>Saya tidak merekomendasikan untuk menggunakan SLiM Display Manager</b>.</p>
<p>Apabila terjadi sesuatu yang merugikan teman-teman di kemudian hari, bukan merupakan tanggung jawab saya sebagai penulis.</p>
<p>Tanggung jawab sepenuhnya ada di tangan teman-teman.</p>
<p>Kalau setuju, yuk kita kemon!</p>
</div>

Untuk distribusi Arch Linux, sangat saya sarankan memasang paket SLiM menggunakan *package manager*, dikarenakan alasan di atas. Agar paket yang kita gunakan, adalah paket yang sudah jelas ter-*maintained* dengan baik.

```
$ sudo pacman -S slim
```

Untuk distribusi yang lain, silahkan menyesuaikan.

# Konfigurasi

## Jalankan Service SLiM

Setelah memasang paket SLiM, kita perlu menjalankan `slim.service`.

Dikarenakan kita harus memilih salah satu Display Manager yang digunakan, karena sebelumnya saya menggunakan LightDM Display Manager, saya akan men-*disable* service dari LightDM terlebih dahulu.

```
$ sudo systemctl disable lightdm.service
```

Selanjutnya, baru meng-*enable*-kan service dari SLiM.

```
$ sudo systemctl enable slim.service
```

## Sessions

SLiM dapat secara otomatis mendeteksi daftar sessions yang terdapat pada direktori `/usr/share/xsessions/`.

Contohnya seperti milik saya. Saya memiliki 3 sessions.

1. i3
2. dwm
3. qtile

```
/usr/share/xsessions/
.
├── dwm.desktop
├── i3.desktop
└── qtile.desktop
```

Sejak versi 1.3.6-2, SLiM sudah menyediakan fitur ini.

Untuk konfigurasi "pemilihan session", saya akan menuliskan dua cara.

1. Dapat memilih session pada saat login
2. Tidak dapat memilih session pada saat login

Kedua cara di atas, pada dasarnya, kita akan berurusan dengan 2 file.

1. `/etc/slim.conf`
2. `~/.xinitrc`

Saya mulai dari cara pertama.

### Menampilkan Pilihan Session pada saat Login

Edit file `/etc/slim.conf` dengan *text editor* favorit kalian.

```
$ sudo vim /etc/slim.conf
```

<pre>
...
...

# Set directory that contains the xsessions.
# slim reads xsesion from this directory, and be able to select.
<mark>sessiondir            /usr/share/xsessions/</mark>

...
...
</pre>

Perhatikan baris yang saya *marking*, pastikan sudah *enable* (tidak ada tanda # dibagian paling depan).

Bagian inilah yang akan mengaktifkan pilihan session pada saat login.

![gambar_6]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/d35FFTvd/gambar-06.gif"}

Kita dapat memilih session dengan menekan tombol <kbd>F1</kbd>.

### Tidak Dapat Memilih Session pada saat Login

Untuk Cara kedua ini, dapat pula kita sebut sebagai *automatic session*, karena kita tidak memilih session sendiri dengan menekan tombol <kbd>F1</kbd> seperti di atas. Melainkan, kita sudah terlebih dahulu mendefinisikan *default session* yang akan kita pergunakan.

Edit file `/etc/slim.conf` dengan *text editor* favorit teman-teman.

```
$ sudo vim /etc/slim.conf
```

<pre>
...
...

# Set directory that contains the xsessions.
# slim reads xsesion from this directory, and be able to select.
<mark>#sessiondir            /usr/share/xsessions/</mark>

...
...
</pre>

**Perhatikan!** bagian yang saya *marking*. Tambahkan tanda pagar `#`, untuk mendisable konfigurasi pada baris ini.

Selanjutnya, definisikan *default session* yang akan kita pergunakan.

Edit file `~/.xinitrc` dengan *text editor* favorit kalian.

```
$ vim ~/.xinitrc
```

Ada dua cara yang saya tawarkan.

#### Cara Sederhana

<pre>
...
...
<mark>exec i3</mark>
#exec dwm
#exec qtile
...
...
</pre>

Karena saya menggunakan i3wm sebagai *default session* saya, maka saya meng-*enable*-kan dengan menghapus tanda pagar `#`, seperti contoh di atas.

#### Cara Keren

<pre>
...
...

# Untuk SLiM Session
<mark>DEFAULTSESSION=i3
case "$1" in
    i3) exec i3 ;;
    dwm) exec dwm ;;
    qtile) exec qtile ;;
    *) exec $DEFAULTSESSION ;;
    esac</mark>

...
...
</pre>

Untuk mengganti *default session* yang ingin digunakan, ubah nilai dari *variabel* `DEFAULTSESSION=`.

![gambar_7]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/yxs6sHRq/gambar-07.png"}

# System Sessions

SLiM juga dapat mengakses *system sessions* seperti: reboot, shutdown, suspend, exit dan console.

| <center>System Sessions</center> | <center>Username</center> | <center>Password</center> |
| :--: | :-- | :-- |
| **REBOOT** | `reboot` | `<root_password>` |
| **SHUTDOWN** | `halt` | `<root_password>` |
| **SUSPEND** | `suspend` | `<root_password>` |
| **EXIT** | `exit` | `<root_password>` |
| **CONSOLE** | `consle` | `<root_password>` |

Untuk mengaktifkan dan menonaktifkan fitur ini, teman-teman dapat melihat pada file `/etc/slim.conf`.

<pre>

# Commands for halt, login, etc.
halt_cmd            /sbin/shutdown -h now
reboot_cmd          /sbin/shutdown -r now
console_cmd         /usr/bin/xterm -C -fg white -bg black +sb -T "Console login" -e /bin/sh -c "/bin/cat /etc/issue; exec /bin/login"
#suspend_cmd        /usr/sbin/suspend
</pre>

**suspend**, secara default dalam keadaan tidak aktif.

## Instalasi Themes

Instalasi themes pada SLiM display manager termasuk sangat mudah.

Hanya perlu memindahkan atau mengcopy paste direktori themes ke direktori `/usr/share/slim/themes`.

Salah satu contoh direktori SLiM themes, biasanya mengandung sedikitnya 3 file.

```
darky_solarized_dark_yellow
.
├── background.png
├── panel.png
└── slim.theme
```

<!-- INFORMATION -->
<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>

<p>Saya menggunakan theme <b>darky_solarized_dark_yellow</b> yang merupakan hasil modifikasi dari <b>darky_pink</b> milik <a href="https://github.com/adi1090x/slim_themes" target="_blank">GitHub/adi1090x/slim_themes</a></p>
</div>



![gambar_9]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/4x6g4MJs/gambar-09.png"}
<p class="img-caption">Themes: darky_pink</p>

![gambar_10]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/MGz8nDTR/gambar-10.png"}
<p class="img-caption">Themes: darky_solarized_dark_yellow</p>

Cara instalasi themes sangat mudah.

Secara garis besar proses instalasi dibagi dalam 2 tahap.

1. Copy direktori themes ke dalam direktori `/usr/share/slim/themes/`
2. Merubah nilai dari variabel `current_theme` pada file `/etc/slim.conf`

### Copy Direktori Themes

```
$ sudo cp -rvf <dir_themes> /usr/share/slim/themes
```

Sebagai contoh, saya memiliki themes bernama `darky_solarized_dark_yellow`.

```
$ sudo cp -rvf darky_solarized_dark_yellow /usr/share/slim/themes
```

Kemudian lakukan pengecekan pada direktori `/usr/share/slim/themes/` apakah sudah berhasil dicopy.

```
$ ll /usr/share/slim/themes
```

<pre>
<mark>drwxr-xr-x root root darky_solarized_dark_yellow</mark>
drwxr-xr-x root root default
</pre>

Nah, kalau sudah ada, berarti sudah terinstall.

### Menginisialisasi Nama Themes

Apabila langkah copy direktori themes sudah dilakukan, selanjutnya tinggal mengganti nilai dari variabel `current_theme` pada file `/etc/slim.conf` yang tadinya bernilai `default` menjadi `<nama_theme>`.

```
$ sudo vim /etc/slim.conf
```

<pre>
...
...

# current theme, use comma separated list to specify a set to
# randomly choose from
<mark>current_theme        darky_solarized_dark_yellow</mark>

...
...
</pre>


## Cara Mudah Instalasi Themes

Untuk mempermudah kedua tahap di atas, saya membuatkan shell script agar praktis.

```
$ cd <dir_themes>
$ touch install.sh
$ chmod +x install.sh
$ vim install.sh
```
```
#!/bin/env sh

: '
  ██████                           ██ ██   ██   ██      ██ ██    ██
 ░█░░░░██                         ░██░░   ░██  ░██     ░██░░    ░░
 ░█   ░██   ██████   ███████      ░██ ██ ██████░██     ░██ ██    ██  ██████
 ░██████   ░░░░░░██ ░░██░░░██  ██████░██░░░██░ ░██████████░██   ░██ ██░░░░██
 ░█░░░░ ██  ███████  ░██  ░██ ██░░░██░██  ░██  ░██░░░░░░██░██   ░██░██   ░██
 ░█    ░██ ██░░░░██  ░██  ░██░██  ░██░██  ░██  ░██     ░██░██ ██░██░██   ░██
 ░███████ ░░████████ ███  ░██░░██████░██  ░░██ ░██     ░██░██░░███ ░░██████
 ░░░░░░░   ░░░░░░░░ ░░░   ░░  ░░░░░░ ░░    ░░  ░░      ░░ ░░  ░░░   ░░░░░░
'

# Copyright (C) 2019 BanditHijo
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
# more details.
#
# You should have received a copy of the GNU General Public License along with
# this program. If not, see http://www.gnu.org/licenses/.

# Author  : Rizqi Nur Assyaufi
# Website : https://bandithijo.com
# Email   : bandithijo@gmail.com
# Created : 2019/02

# README
# File install.sh ini adalah shell script sederhana untuk meng-install/update
# theme yang akan kita gunakan.

# CARA INSTALASI
# File install.sh ini harus berada di dalam direktori theme.
# Kemudian, tinggal menjalankan dengan perintah:
#
# $ ./install.sh
#
# Dibutuhkan password root.

namaDir=`basename $PWD`

# mendefinisikan nama tema
namaTema=$namaDir

# membuat direktori tema pada dir. slim/themes/
sudo mkdir -p /usr/share/slim/themes/$namaTema
echo -e '\n[ DONE ] Direktori tema:' $namaTema 'berhasil dibuat!'

# mengcopy seluruh isi file ke dalam dir. slim/themes/
sudo cp * /usr/share/slim/themes/$namaTema
echo '[ DONE ] File-file tema berhasil dicopy ke dir. slim/themes'

# menginstall tema
sudo sed -i "s/^current_theme.*$/current_theme        $namaTema/g" /etc/slim.conf
echo '[ DONE ] Berhasil memasang tema:' $namaTema 'pada slim.conf'
```

**Perhatian!**, letakkan file shell script ini di dalam direktori themes.

Setelah itu, tinggal menjalankannya.

```
$ ./install.sh
```

```
[sudo] password for bandithijo: ******

[ DONE ] Direktori tema: darky_solarized_dark_yellow berhasil dibuat!
[ DONE ] File-file tema berhasil dicopy ke dir. slim/themes
[ DONE ] Berhasil memasang tema: darky_solarized_dark_yellow pada slim.conf
```


# Pesan Penulis

Untuk diperhatikan, SLiM display manager tidak menggunakan `~/.profile` untuk mengambil data-data aplikasi atau PATH apa saja yang harus dijalankan saat sistem startup, melainkan menggunakan `~/.xinitrc`.

Hal tersebut di atas sangat berbeda dengan Display Manager seperti GDM dan LightDM yang mengambil data-data startup applications dan PATH pada `~/.profile`.

Apabila hal ini tidak dikonfigurasi dengan benar, maka akan ada beberapa hal yang tidak berjalan sebagaimana mestinya.

Silahkan merujuk pada [.xinitrc](https://github.com/bandithijo/dotfiles/blob/master/.xinitrc){:target="_blank"} milik saya yang berada di GitHub/dotfiles, apabila memang diperlukan.

Sepertinya seperti ini dulu.

Mudah-mudahan dapat bermanfaat buat teman-teman.

Terima kasih.




# Referensi

1. [wiki.archlinux.org/index.php/SLiM](https://wiki.archlinux.org/index.php/SLiM){:target="_blank"}
<br>Diakses tanggal: 2019/02/28

2. [github.com/data-modul/slim](https://github.com/data-modul/slim){:target="_blank"}
<br>Diakses tanggal: 2019/02/28

3. [www.slant.co/topics/2053/~best-linux-display-manager](https://www.slant.co/topics/2053/~best-linux-display-manager){:target="_blank"}
<br>Diakses tanggal: 2019/02/28

4. [wiki.archlinux.org/index.php/GNOME/Keyring#Using_the_keyring_outside_GNOME](https://wiki.archlinux.org/index.php/GNOME/Keyring#Using_the_keyring_outside_GNOME){:target="_blank"}
<br>Diakses tanggal: 2019/02/28
