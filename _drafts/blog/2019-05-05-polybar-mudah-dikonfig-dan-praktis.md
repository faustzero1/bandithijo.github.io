---
layout: 'post'
title: 'Polybar, Bar yang Mudah Dikonfig, Praktis, dan Mudah Dikustomisasi'
date: 2019-05-05 11:18
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Ulasan']
pin:
hot:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Apa itu Polybar?

Polybar. untuk teman-teman yang menggunakan Window Manager, pasti sudah tidak asing lagi mendengar aplikasi ini.

Polybar adalah *standalone* taskbar/panel yang dapat kita gunakan sebagai wadah untuk meletakkan berbagai macam status indikator yang kita perlukan.

Biasanya pengguna Desktop Environment menyebutnya dengan istilah "Panel".

Saya juga pernah menyinggung sedikit tentang Polybar pada tulisan sebelumnya, mengenai "[i3wm, Window Manager yang Taktis namun Praktis]({{ site.url }}/i3wm-window-manager-yang-taktis-namun-praktis){:target="_blank"}".

Taskbar/panel adalah salah satu aplikasi pendukung agar kita dapat menggunakan sistem kita dengan mudah.

Secara pribadi, status indikator yang saya perlukan, meliputi:

1. Workspace indikator
2. Focused Window Title Name
3. Tanggal dan Jam
4. Battery status
5. CPU temperatur
6. RAM usage indikator
7. Volume indikator
8. Brightness screen indikator
9. Network status
10. Network speed indikator

Status indikator yang *optional* seperti:

1. HDD capacity indikator
2. CPU usage indikator

Di bawah ini adalah contoh Polybar yang saya pergunakan.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/NfwPVNhT/gambar-01.png"}

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/ZYNMVGQ4/gambar-02.png"}

Jangan bingung, tampilan Polybar saya memang sederhana seperti ini saja.

Di forum-forum online seperti [/r/unixporn](https://www.reddit.com/r/unixporn/){:target=_blank""}, [Telegram: dotfiles Indonesia](https://t.me/dotfiles_id){:target="_blank"}, dll, cukup banyak teman-teman yang menggunakan Polybar dengan bentuk dan warna yang beraneka ragam. Keren-keren sekali.

Sekedar pengetahuan saja, selain Polybar, masih ada lagi *standalone* taskbar/panel yang sering terdengar di telinga saya, seperti:

1. [lemonbar](https://github.com/LemonBoy/bar){:target="_blank"}
2. [tint2](https://gitlab.com/o9000/tint2){:target="_blank"}
3. [dzen](http://robm.github.io/dzen/){:target="_blank"}
4. [bumblebee-status](https://github.com/tobi-wan-kenobi/bumblebee-status){:target="_blank"}
5. [dll.](https://wiki.archlinux.org/index.php/List_of_applications#Taskbars){:target="_blank"}

# Gimana Cara Pasangnya?

Mumpung sedang pembahasan taskbar/panel, saya sekalian memberi informasi bahwa masing-masing taskbar/panel tersebut, memiliki proses konfigurasinya yang berbeda satu dengan yang lainnya -- pastinya.

Dalam proses konfigurasi Polybar, saya akan membagi menjadi 2 sesi, yaitu:

1. [Konfigurasi Menjalankan Polybar]({{ site.url }}/blog/polybar-mudah-dikonfig-dan-praktis#1-konfigurasi-menjalankan-polybar){:target="_blank"}
2. [Konfigurasi Memodifikasi Polybar]({{ site.url }}/blog/polybar-mudah-dikonfig-dan-praktis#2-konfigurasi-memodifikasi-polybar){:target="_blank"}

Tujuannya untuk memudahkan saat ada pertanyaan mengenai "konfigurasi Polybar".

## 1. Konfigurasi Menjalankan Polybar

Tentu saja kita perlu melakukan instalasi terlebih dahulu.

### Instalasi dari Repositori

Karena saya menggunakan Arch Linux, saya akan mencontohkan dengan cara Arch.

Gunakan AUR Helper favorit kalian karena paket Polybar masih terdapat di AUR.

```
$ yay polybar
```

Untuk yang menggunakan distribusi lain, silahkan menyesuaikan. Hehe.

### Instalasi dengan Meng-*compile* Sendiri

Perhatikan terlebih dahulu paket-paket dependensi yang diperlukan sebelum mengkompile Polybar.

Silahkan melihat daftarnya [di sini](https://github.com/jaagr/polybar#dependencies){:target="_blank"}.

Setelah dipastikan semua kebutuhan dependensi, baik yang utama maupun yang optional sudah terpenuhi.

Selanjutnya, Download versi Polybar [di sini](https://github.com/jaagr/polybar/releases){:target="_blank"}.

Download `polybar-<version>.tar`

Pilih versi yang paling baru saja.

Kemudian ekstrak dengan,

```
$ tar xvf polybar-<version>.tar
```

Kemudian, masuk ke dalam direktori yang baru saja di ekstrak tadi.

Lalu, jalankan perintah di bawah ini untuk mem-*compile* Polybar.

```
$ mkdir build
$ cd build
$ cmake ...
$ make -j$(nproc)
$ sudo make install
```
Tunggu sampai proses *compile* selesai.

---

Setelah dipastikan proses instalasi selesai, baik dari repositori maupun meng-*compile* langsung dari source, coba jalankan Polybar terlebih dahulu dengan menambahkan option `-h`.

```
$ polybar -h                                                                                                                                                                                   ~
```
```
Usage: polybar [OPTION]... BAR

  -h, --help               Display this help and exit
  -v, --version            Display build details and exit
  -l, --log=LEVEL          Set the logging verbosity (default: WARNING)
                           LEVEL is one of: error, warning, info, trace
  -q, --quiet              Be quiet (will override -l)
  -c, --config=FILE        Path to the configuration file
  -r, --reload             Reload when the configuration has been modified
  -d, --dump=PARAM         Print value of PARAM in bar section and exit
  -m, --list-monitors      Print list of available monitors and exit
  -w, --print-wmname       Print the generated WM_NAME and exit
  -s, --stdout             Output data to stdout instead of drawing it to the X window
  -p, --png=FILE           Save png snapshot to FILE after running for 3 seconds
```

Kalau sudah tampil seperti di atas, berarti Polybar sudah berhasil kita pasang.

Selanjutnya, Kita akan meng-*copy* file `config`.

File config dapat dipasang dengan menggunakan perintah,

```
$ make userconfig
```

Jalankan dari dalam direktori `build` yang sebelumnya kita buat untuk meng-*compile*.

atau,

*Copy* dan *paste* secara manual file `config` yang berada pada direktori `/usr/...`

1. `/usr/share/doc/polybar/config`
2. `/usr/local/share/doc/polybar/config`

Tergantung parameter yang kalian gunakan saat melakukan instalasi Polybar.

Silahkan di copy ke direktori `~/.config/polybar/`. Kalau belum ada direktori ini, silahkan di buat dahulu.

```
$ mkdir -p ~/.config/polybar
```

Lalu tinggal jalankan perintah `cp`.

<pre>
$ cp <mark>/usr/share/doc/polybar/config</mark> ~/.config/polybar/config
</pre>

Sesuaikan path yang saya marking kuning dengan lokasi file `config` yang berada pada direktori `/usr/...` di sistem kalian.

Kalau pada Arch Linux, hasil instalasi Polybar yang bersumber dari AUR, akan terdapat pada path seperti yang tertulis pada  nomor 1 di atas.

### Menjalankan Polybar

Setelah selesai meng-*copy* file konfig, selanjutnya kita perlu mengkonfigurasi untuk memanggil Polybar.

Memanggil/menjalankan Polybar diperlukan agar Polybar dapat menampakkan diri pada Desktop.

Cara menjalankan Polybar saya bagi menjadi 2, yaitu :

1. [Langsung]({{ site.url }}/blog/polybar-mudah-dikonfig-dan-praktis#1-langsung){:target="_blank"}
2. [Tidak Langsung]({{ site.url }}/blog/polybar-mudah-dikonfig-dan-praktis#2-tidak-langsung){:target="_blank"}

#### 1. Langsung

Dengan menggunakan perintah,

```
$ polybar example -r
```

Argument `example` yang berada setelah perintah `polybar`, dimaksudkan untuk memanggil nama dari bar yang ada di dalam file `config`.

Contoh nama dari bar yang dapat kita temukan di dalam file `config`, secara *default* akan seperti ini.

```
[bar/example]
```

Cari saja dengan *scrolling* ke bawah, baris yang memiliki isi seperti di atas.

Nah, kalau mau, kita dapat merubahnya sesuai keinginan kita.

Misal,

```
[bar/topbar]
```

Nah, maka cara memanggilnya pun akan menjadi,

```
$ polybar topbar -r
```

Option `-r` di sini berguna untuk,

```
-r, --reload  Reload when the configuration has been modified
```

Maksudnya, semacam *autoreload*, jadi sambil kita mengubah-ubah nilai yang ada di dalam file `config`, Polybar akan secara otomatis me-*reload*-kan untuk kita. Asik bukan?

<div class="blockquote-yellow">
<div class="blockquote-yellow-title">Kapan kita gunakan cara langsung seperti ini?</div>
<p>Selera saja sih.</p>
<p>Kalau saya, biasanya menggunakan cara langsung ini untuk <i>debuging</i> Polybar.</p>
<p>Karena saat kita menjalankan secara langsung seperti ini. Terminal tempat kita menjalankan Polybar akan menampilkan log-log dari apa yang kita ubah pada file <code>config</code>.</p>
</div>

#### 2. Tidak Langsung

Cara tidak langsung yaitu dengan menggunakan file executable.

Seperti yang di contohkan oleh Wiki Polybar, dengan menggunakan file `launch.sh` yang di letakkan di dalam direktori `~/.config/polybar/`.

Sekarang kita coba buat dan membuatnya menjadi executable.

```
$ touch ~/.config/polybar/launch.sh
$ chmod +x ~/.config/polybar/launch.sh
```

Sekarang saatnya kita mengisikan beberapa baris perintah di dalamnya.

```
$ vim ~/.config/polybar/launch.sh
```
```
#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar with name example
polybar example -r &

echo "Bars launched..."
```

Ingat, argument `example` di atas adalah nama dari bar yang kita berikan. Secara *default* (kalau masih belum berubah) akan bernama `example`.

Teman-teman dapat menggantinya dengan nama bar yang teman-teman atur pada file `config` seperti contoh pada nomor 1 di atas.

Sekarang, saatnya menjalankan file `launch.sh` ini.

##### i3WM

Kalau yang menggunakan i3wm, tinggal pasang di file `config` dari i3wm saja.

```
exec_always --no-startup-id $HOME/.config/polybar/launch.sh
```

Jangan lupa untuk mendisable bar bawaan dari i3WM, kalau sudah tidak diperlukan lagi.

```
#bar {
#    status_command ...
#}
```

Atau di hapus juga tidak masalah.

Saya pribadi, saya hapus.

Karena jujur saja, lebih suka menggunakan Polybar ketimbang bar bawaan dari i3WM. Hehe.

Kalau sudah, restart i3WM.

##### BSPWM

Untuk teman-teman yang menggunakan BSPWM, dapat memasang baris perintah pemanggilan Polybar pada file config `~/.config/bspwm/bspwmrc` atau yang berkorelasi, seperti saya, saya letakkan pada file `~/.config/bswpm/autorun`.

```
$HOME/.config/polybar/launch.sh
```

Kalau sudah, restart BSPWM.

## 2. Konfigurasi Memodifikasi Polybar

Saat pertama kali menjalankan Polybar, secara *default* akan menampilkan tampilan seperti ini.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/C5N3j57m/gambar-03.png"}

Gambar di atas adalah contoh dari pemanggilan `[bar/example]` dari file `config` yang belum kita modifikasi.

Sudah sangat keren yaa? Wkwkwkwk

Nah sekarang kita akan mem-*breakdown* isi dari file config.

Secara garis besar, di dalam file config, baris-baris kode tersebut terkelompokkan menjadi beberapa blok.

1. [**Blok [colors]**]({{ site.url }}/blog/polybar-mudah-dikonfig-dan-praktis#blok-colors){:target="_blank"}
2. [**Blok [bar/nama_bar]**]({{ site.url }}/blog/polybar-mudah-dikonfig-dan-praktis#blok-barnama_bar){:target="_blank"}
3. [**Blok-blok [module/nama_modul]**](){:target="_blank"}
4. [**Blok [settings]**](){:target="_blank"}
5. [**Blok [global/wm]**](){:target="_blank"}

Selanjutnya, akan kita bahas satu-persatu mengenai isi yang ada di dalam blok-blok tersebut.

<mark>Tapi yang akan saya akan jadikan contoh adalah isi dari file config milik saya.</mark>

### Blok [colors]

```
[colors]
foreground = #BCC3C3
background = #002B36
foreground-alt = #56696F
background-alt = #073642
alert = #CB4B16
```

Blok ini berisi variabel-variabel color yang dapat kita definisikan dan memberi nilai warna (Hexacolor).

Kita juga dapat membuat variabel baru selain dari variabel yang sudah ada, tinggal disesuaikan dengan kebutuhan kita akan variabel warna saja. Enak sekali bukan?

Cara penggunaan atau pemanggilan variabel color ini dengan menggunakan cara seperti ini,

1. `foreground = ${colors.foreground}`
2. `background = ${colors.background}`
3. `label-urgent-foreground = ${colors.alert}`
4. dll.

Jangan bingung dulu karena nanti akan teman-teman lihat contoh-contoh lain mengenai cara penggunannya pada blok-blok selanjutnya.

### Blok [bar/nama_bar]

`nama_bar` di sini maksudnya nama dari bar yang teman-tman berikan.

Defaultnya masih bernama `example` (`[bar/example]`).

Kalau saya, karena saya menggunakan BSPWM, untuk alasan automatisasi pemanggilan nama bar pada script `launch.sh` saya menggunakan nama `barbspwm` (`[bar/barbspwm]`).

Berikut ini isi dari blok [bar/nama_bar].

Saya akan bahas bagian perbagian.

```
[bar/barbspwm]
monitor = ${env:MONITOR:}
monitor-fallback = eDP1
width = 100%
height = 24
radius = 5.0
;offset-x = 0
;offset-y = 0
fixed-center = true
bottom = false

foreground = ${colors.foreground}
background = ${colors.background}

line-size = 1
line-color = #dfdfdf

;border-size = 0
border-top-size = 5
border-bottom-size = 0
border-left-size = 5
border-right-size = 5
;border-color = ${colors.background}

padding-left = 0
padding-right = 1

module-margin-left = 0
module-margin-right = 0

font-0 = Fira Code Retina:pixelsize=9;2
font-1 = FontAwesome:pixelsize=10;2
font-2 = Font Awesome 5 Brands:size=10;2
font-3 = Fira Code Retina:weight=Bold:pixelsize=9;2
font-4 = Fira Code Retina:weight=Bold:pixelsize=6;-1
font-5 = FontAwesome:weight=Bold:pixelsize=4;-2

;separator = " "

modules-left = sp1 bspwm xwindow
modules-center =
modules-right = xkeyboard netspdwlan netspdeth sp1 wlan eth sp2 xbacklight sp2 pulseaudio sp2 memory sp1 temperature sp2 battery1 battery0 sp2 date sp2 profile

;tray-position = right
;tray-padding = 0
;tray-detached = false
;tray-maxsize = 16
;tray-scale = 1.0
;tray-foreground = ${colors.foreground}
;tray-background = ${colors.background}
;tray-offses-x = 0
;tray-offset-y = 0

wm-restack = bspwm

override-redirect = false

cursor-click = pointer
cursor-scroll = ns-resize
```

1. `monitor =`, untuk mendefinisikan dimana Polybar akan ditampilkan.

    Gunakan perintah di bawah ini untuk mengecek nama dari monitor yang sedang kita pergunakan.

    ```
    $ xrandr -q | grep " connected" | cut -d ' ' -f1
    ```
    Saya menggunakan nilai `${env:MONITOR:}` karena berkaitan dengan blok code yang saya jalankan pada file `launch.sh` untuk mendefinisikan dual monitor.

2. `monitor-fallback =`, sebagai *backup* apabila variabel `monitor =` tidak ditemukan nilainya.

3. `width =` dan `height =`, untuk mendefinisikan lebar dan tinggi dari Polybar.

4. `radius =`, untuk membuat sudut-sudut Polybar menjadi rounded.

5. `offset-x =` dan `offset-y =`, apabila kalian ingin menggeser letak dari Polybar pada titik koordinat tertentu.

6. `fixed-center =`, untuk membuat Polybar berada di tengah berdasarkan `modules-center`.

    Ketika bernilai `false`, posisi center akan ukuran dari blok yang lain.

7. `bottom =`, untuk mendefinisikan letak Polybar pada monitor, berada di atas dari layar, atau berada di bawah.

8. `foreground =`, untuk mendefinisikan warna foreground yang akan digunakan secara global oleh setiap modul yang menggunakan label dan icon.

    Untuk variabel seperti ini, dapat menggunakan pemanggilan variabel `colors` dengan cara seperti yang saya pergunakan di atas.

    ```
    foreground = ${colors.foreground}
    ```

    Atau dapat pula diisikan dengan hexa color code-nya.

    ```
    foreground = #002B36
    ```

9. `background =`, untuk mendefinisikan warna background yang akan digunakan secara global oleh setiap modul.

    Variabel ini termasuk variabel warna. Seperti yang dicontohkan pada variabel foreground di atas.

10. `line-size =`, untuk mendefinisikan nilai dari tebal garis, baik garis bawah maupun garis atas, yang akan digunakan secara global.

11. `line-color =`, untuk mendefinisikan nilai warna dari variabel `line-` di atas.



# Referensi

1. [wiki.archlinux.org/index.php/List_of_applications#Taskbars](https://wiki.archlinux.org/index.php/List_of_applications#Taskbars){:target="_blank"}
<br>Diakses tanggal: 2019/05/05

2. [github.com/jaagr/polybar](https://github.com/jaagr/polybar){:target="_blank"}
<br>Diakses tanggal: 2019/05/05

3. [](){:target="_blank"}
<br>Diakses tanggal: 2019/05/05
