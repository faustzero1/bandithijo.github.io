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

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/NfwPVNhT/gambar-01.png" onerror="imgError(this);"}

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/ZYNMVGQ4/gambar-02.png" onerror="imgError(this);"}

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

Download `polybar-{version}.tar`

Pilih versi yang paling baru saja.

Kemudian ekstrak dengan,

```
$ tar xvf polybar-{version}.tar
```

Kemudian, masuk ke dalam direktori yang baru saja di ekstrak tadi.

Lalu, jalankan perintah di bawah ini untuk mem-*compile* Polybar.

```
$ mkdir build
$ cd build
$ cmake ..
$ make -j$(nproc)
$ sudo make install
```
Tunggu sampai proses *compile* selesai.

---

Setelah dipastikan proses instalasi selesai, baik dari repositori maupun meng-*compile* langsung dari source, coba jalankan Polybar terlebih dahulu dengan menambahkan option `-h`.

```
$ polybar -h
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

1. [Langsung]({{ site.url }}/blog/polybar-mudah-dikonfig-dan-praktis#1-langsung)
2. [Tidak Langsung]({{ site.url }}/blog/polybar-mudah-dikonfig-dan-praktis#2-tidak-langsung)

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

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/C5N3j57m/gambar-03.png" onerror="imgError(this);"}

Gambar di atas adalah contoh dari pemanggilan `[bar/example]` dari file `config` yang belum kita modifikasi.

Sudah sangat keren yaa? Wkwkwkwk

Nah sekarang kita akan mem-*breakdown* isi dari file config.

Secara garis besar, di dalam file config, baris-baris kode tersebut terkelompokkan menjadi beberapa blok.

1. [**Blok [colors]**]({{ site.url }}/blog/polybar-mudah-dikonfig-dan-praktis#blok-colors)
2. [**Blok [bar/nama_bar]**]({{ site.url }}/blog/polybar-mudah-dikonfig-dan-praktis#blok-barnama_bar)
3. [**Blok-blok [module/nama_modul]**]({{ site.url }}/blog/polybar-mudah-dikonfig-dan-praktis#blok-modulenama_modul)
4. [**Blok [settings]**]({{ site.url }}/blog/polybar-mudah-dikonfig-dan-praktis#blok-settings)

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

`nama_bar` di sini maksudnya nama dari bar yang teman-teman berikan.

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

<br>

```
foreground = ${colors.foreground}
background = ${colors.background}
```

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

<br>

```
line-size = 1
line-color = #dfdfdf
```

10. `line-size =`, untuk mendefinisikan nilai dari tebal garis, baik garis bawah maupun garis atas, yang akan digunakan secara global.

11. `line-color =`, untuk mendefinisikan nilai warna dari variabel `line-` di atas.

<br>

```
;border-size = 0
border-top-size = 5
border-bottom-size = 0
border-left-size = 5
border-right-size = 5
;border-color = ${colors.background}
```

12. `border-size =`, untuk mendefinisikan size dari keempat sisi border dari Polybar.

    Contoh di atas menunjukkan bawha saya tidak mengaktifkan variabel ini, dikarenakan saya ingin memiliki nilai border yang berbeda setiap sisinya.

    Untuk itu saya menggunakan variabel border seperti contoh di bawahnya `border-{sisi}-size =`.

13. `border-top-size =`, `border-bottom-size =`, `border-left-size = `, `border-right-size =`, untuk mendefinisikan ukuruan border sisi atas, bawa, kiri, dan kanan.

14. `border-color =`, untuk mendefinisikan warna background dari border.

    Namun, saya tidak menggunakan `border-color`, agar border menjadi transparan.

<br>

```
padding-left = 1
padding-right = 1
```

15. `padding-left =` dan `padding-right =`, untuk mendefinisikan besar padding yang ada pada sisi kanan dan kiri dari Polybar.

    Ingat, ini **padding** bukan **margin**, sehingga outputnya akan memberikan jarak pada sisi bagian dalam dari Polybar.

    Saya memberikan nilai `1`, agar modul tidak terlalu dempet dengan sisi kanan dan kiri dari Polybar.

<br>

```
module-margin-left = 0
module-margin-right = 0
```

16. `module-margin-left =` dan `module-margin-right =`, untuk mendefinisikan besarnya margin di sisi kanan atau kiri pada tiap modul.

    Saya tidak ingin membuat jarak yang terlalu jauh antar modul sehingga saya membuat nilainya menjadi `0`.

<br>

```
font-0 = Fira Code Retina:pixelsize=9;2
font-1 = FontAwesome:pixelsize=10;2
font-2 = Font Awesome 5 Brands:size=10;2
font-3 = Fira Code Retina:weight=Bold:pixelsize=9;2
font-4 = Fira Code Retina:weight=Bold:pixelsize=6;-1
font-5 = FontAwesome:weight=Bold:pixelsize=4;-2
```

17. `font-{n} =`, untuk mendefinisikan font beserta ukuran dan tinggi karakternya.

    Saya ambil contoh,

    ```
    font-0 = Fira Code Retina:pixelsize=9;2
             └──────────────┘ └─────────┘ ╵
                    a              b      c
    ```

    - (a) Adalah font yang kita akan gunakan.

    - (b) Adalah ukuran dari font yang akan kita gunakan.

    - (c) Adalah tinggi dari karakter font. Dapat bernilai negatif.

<br>

```
;separator =
```

18. `separator =`, untuk mendefinisikan karakter pemisah antara modul.

    Karena saya tidak ingin ada karakter apapun yang memisahkan antar modul, maka saya disable.

<br>

```
modules-left = bspwm xwindow
modules-center =
modules-right = xkeyboard netspdwlan netspdeth sp1 wlan eth sp2 xbacklight sp2 pulseaudio sp2 memory sp1 temperature sp2 battery sp2 date sp2 profile
```

19. `module-left =`, `module-center =`, `module-right =`, untuk mendefinisikan modul-modul yang akan ditampilkan pada bar sesuai dengan blok posisinya masing-masing.

    Modul-modul ini yang akan kita konfigurasikan pada baris-baris selanjutnya di bawah.

    Untuk melihat apa saja modul-modul yang tersedia, dapat melihat pada Wiki Polybar, [di sini](https://github.com/polybar/polybar/wiki){:target="_blank"}.

    Kita akan bahas lebih lanjut pada pembahasan blok [bar/nama_modul].

<br>

```
;tray-position = right
;tray-padding = 0
;tray-detached = false
;tray-maxsize = 16
;tray-scale = 1.0
;tray-foreground = ${colors.foreground}
;tray-background = ${colors.background}
;tray-offses-x = 0
;tray-offset-y = 0
```

20. Deretan baris kode di atas, digunakan untuk mengkonfigurasi **trayicon** yang akan ditampilkan pada Polybar.

    Sebagai catatan, saya tidak mengaktifkan tray icon pada **[bar/nama_bar]**, karena saya akan meletakkan tray icon pada bar yang akan saya letakkan di bawah dan dapat saya buat *show/hide* dengan menggunakan kombinasi tombol pada keyboard. Bar ini saya beri nama **[bar/traybspwm]**. Kita akan bahas di bawah.

<br>

```
wm-name = bspwm
```

21. `wm-name =`, untuk mendefinisikan atom WM_NAME.

<br>

```
wm-restack = bspwm
```

22. `wm-restack =`, untuk menyusun kembali window bar dan meletakkannya di atas window manager yang kita pilih. Untuk memperbaiki masalah dimana bar tetap akan muncul pada saat window fullscreen.

    Terdapat dua Window Manager yang disupport, i3WM dan BSPWM.

    i3WM juga harus mengaktifkan `override-redirect = true`. Apabila ingin mengaktifkan fitur ini.

<br>

```
override-redirect = false
```

23. `override-redirect =`, untuk mengatur agar Window Manger tidak menghandle window.

    Saya menggunakan nilai `false` karena saya tidak ingin window yang tampil akan menutupi Polybar.

<br>

```
cursor-click = pointer
cursor-scroll = ns-resize
```

24. `cursor-click =`, untuk mendefinisikan cursor yang digunakan saat berada di atas modul yang memiliki fungsi `click`.

25. `cursor-scroll =`, untuk mendefinisikan fungsi dari scroll apabila dilakukan pada modul yang memiliki fungsi `resize` seperti modul backlight dan pulseaudio/alsa.

<br>

Untuk penjelasan lebih lengkap mengenai topik yang sudah saya bahas di atas, dapat merujuk pada Wiki Polybar, [di sini](https://github.com/polybar/polybar/wiki/Configuration){:target="_blank"}.

<br>

### Blok [module/nama_modul]

Untuk pembahasan modul, saya akan tulis dengan mendahulukan nama-nama modul yang sudah disediakan oleh Polybar.

Untuk beberapa modul yang teman-teman lihat (pada daftar modul di atas) tidak terdapat pada modul bawaan Polybar (custom module), akan saya tulis belakangan.

#### Modul BSPWM

```
[module/bspwm]
type = internal/bspwm

pin-workspaces = true
inline-mode = false
enable-click = false
enable-scroll = false
reverse-scroll = false
fuzzy-match = true

format = <label-state> <label-mode>

label-monitor = "%name%%{F#56696F} |%{F-}"

label-dimmed-foreground = ${colors.foreground}
label-dimmed-focused-background = ${colors.background}

label-focused = "%{T6}  %{T-}%{T1}%name%%{T-}%{F#56696F} |%{F-}"
label-focused-foreground = #ffffff
label-focused-background = ${colors.background}

label-occupied = "%{T6}  %{T-}%{T1}%name%%{T-}%{F#56696F} |%{F-}"

label-urgent = "%{T6}  %{T-}%{T1}%name%%{T-}%{F#56696F} |%{F-}"
label-urgent-foreground = ${colors.alert}
label-urgent-background = ${colors.background}

label-empty = "%{T6}%{F#002B36}  %{F-}%{T-}%name%%{F#56696F} |%{F-}"
label-empty-foreground = ${colors.foreground-alt}

label-tiled = []=
label-monocle = [M]=
label-floating = <><
label-fullscreen = [F]
label-pseudotiled = [T]
label-locked = [X]
label-locked-foreground = ${colors.foreground}
label-sticky = [Y]
label-sticky-foreground = ${colors.foreground}
label-private = [Z]
label-private-foreground = ${colors.foreground}

label-separator =
label-separator-padding = 0
label-separator-foreground = ${colors.foreground-alt}
```

Untuk penjelasan lebih lengkap mengenai blok-blok kode modul BSPWM di atas, silahkan mengunjungi halaman Wiki Polybar, [di sini](https://github.com/polybar/polybar/wiki/Module:-bspwm){:target="_blank"}.

Pada baris kode di atas, teman-teman juga dapat melihat beberapa baris kode yang memiliki **tag formating** seperti ini.

1. `%{T3}...%{T-}`, untuk Label Text Formating. `T3` berarti variabel `font-2`, karena variabel font dimulai dari `font-0`.
2. `%{F#56696F}...%{F-}`, untuk Label Color.

Penjelasan lebih lengkap mengenai Text Formating, tentang apa yang dapat dan tidak dapat dilakukan, silahkan merujuk ke halaman Wiki Polybar, [di sini](https://github.com/polybar/polybar/wiki/Formatting){:target="_blank"}.

<br>

#### Modul xwindow

```
[module/xwindow]
type = internal/xwindow
format = <label>
format-padding = 0

label = " %title%"
label-maxlen = 30
label-foreground = ${colors.foreground}
label-background = ${colors.background}

label-empty =
label-empty-foreground = ${colors.background}
```

Untuk penjelasan lebih lengkap mengenai blok-blok kode modul xwindow di atas, silahkan mengunjungi halaman Wiki Polybar, [di sini](https://github.com/polybar/polybar/wiki/Module:-xwindow){:target="_blank"}.

<br>

#### Modul xkeyboard

```
[module/xkeyboard]
type = internal/xkeyboard
blacklist-0 = num lock
blacklist-1 = scroll lock

format = <label-indicator>
format-spacing = 0

format-prefix = " "
format-prefix-foreground = ${colors.alert}
format-prefix-background = ${colors.background}

label-layout = "%layout%"
label-layout-foreground = ${colors.foreground}
label-layout-background = ${colors.background}

label-indicator-padding = 0
label-indicator-margin = 0
label-indicator = %{T4} CAPS %{T-}
label-indicator-foreground = ${colors.alert}
label-indicator-background = ${colors.background}
```

Untuk penjelasan lebih lengkap mengenai blok-blok kode modul xkeyboard di atas, silahkan mengunjungi halaman Wiki Polybar, [di sini](https://github.com/polybar/polybar/wiki/Module:-xkeyboard){:target="_blank"}.

<br>

#### Modul xbacklight

```
[module/xbacklight]
type = internal/xbacklight

;format = "<label><bar>"
format = "<label>"
label = " %percentage%%"
label-foreground = ${colors.foreground}
label-background = ${colors.background}

bar-width = 5
bar-indicator = |
bar-indicator-foreground = ${colors.foreground}
bar-indicator-background = ${colors.background}
bar-indicator-font = 1

bar-fill = -
bar-fill-font = 1
bar-fill-foreground = ${colors.foreground}
bar-fill-background = ${colors.background}

bar-empty = -
bar-empty-font = 1
bar-empty-foreground = ${colors.foreground}
bar-empty-background = ${colors.background}
```

Pada baris `format =`, terdapat dua tipe format yang saya gunakan, terkadang saya ingin menggunakan style dengan bar dan bukan dengan persentase. Namun, pada baris `format =` di atas, saya sedang menggunakan persentase.

Untuk penjelasan lebih lengkap mengenai blok-blok kode modul xkeyboard di atas, silahkan mengunjungi halaman Wiki Polybar, [di sini](https://github.com/polybar/polybar/wiki/Module:-xkeyboard){:target="_blank"}.

<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>Sebagai catatan tambahan, beberapa dari teman-teman mungkin sudah tidak lagi menggunakan <code>xbacklight</code> sebagai backend untuk mengatur kecerahan layar.</p>
<p>Mungkin, dapat menggunakan <a href="https://github.com/polybar/polybar/wiki/Module:-backlight" target="_blank">modul backlight</a>.</p>
</div>

<br>

#### Modul PulseAudio

```
[module/pulseaudio]
type = internal/pulseaudio

sink = alsa_output.pci-0000_12_00.3.analog-stereo

use-ui-max = true

interval = 5

format-volume = <ramp-volume> <label-volume>

label-muted = 
label-muted-foreground = ${colors.alert}

ramp-volume-0 = 
ramp-volume-1 = 
ramp-volume-2 = 
```

Untuk penjelasan lebih lengkap mengenai blok-blok kode modul pulseaudio di atas, silahkan mengunjungi halaman Wiki Polybar, [di sini](https://github.com/polybar/polybar/wiki/Module:-pulseaudio){:target="_blank"}.

<br>

#### Modul Memory

```
[module/memory]
type = internal/memory
interval = 1

format-prefix = " "
format-prefix-foreground = ${colors.foreground}
format-prefix-background = ${colors.background}

label = "%percentage_used%%"
label-foreground = ${colors.foreground}
label-background = ${colors.background}
```

Untuk penjelasan lebih lengkap mengenai blok-blok kode modul memory di atas, silahkan mengunjungi halaman Wiki Polybar, [di sini](https://github.com/polybar/polybar/wiki/Module:-memory){:target="_blank"}.

<br>

#### Modul CPU

```
[module/cpu]
type = internal/cpu
interval = 1
format-prefix = " "
format-prefix-foreground = ${colors.foreground}
format-prefix-background = ${colors.background}
;format-underline = ${colors.foreground}
label = "%percentage:2%%"
label-foreground = ${colors.foreground}
label-background = ${colors.background}
```

Untuk penjelasan lebih lengkap mengenai blok-blok kode modul CPU di atas, silahkan mengunjungi halaman Wiki Polybar, [di sini](https://github.com/polybar/polybar/wiki/Module:-cpu){:target="_blank"}.

<br>

#### Modul FileSystem

```
[module/filesystem]
type = internal/fs
interval = 25

mount-0 = /

label-mounted = " %percentage_used%%"
label-mounted-foreground = ${colors.foreground}
label-mounted-background = ${colors.background}

label-unmounted = %mountpoint% not mounted
label-unmounted-foreground = ${colors.foreground}
```

Untuk penjelasan lebih lengkap mengenai blok-blok kode modul filesystem di atas, silahkan mengunjungi halaman Wiki Polybar, [di sini](https://github.com/polybar/polybar/wiki/Module:-filesystem){:target="_blank"}.

<br>

#### Modul Temperature

```
[module/temperature]
type = internal/temperature
thermal-zone = 0
warn-temperature = 80

format = "<ramp><label>"
format-foreground = ${colors.foreground}
format-background = ${colors.background}
label = "%temperature-c%"
label-foreground = ${colors.foreground}
label-background = ${colors.background}

format-warn = <ramp><label-warn>
label-warn = "%temperature-c%"
label-warn-foreground = ${colors.alert}

ramp-0 = " "
ramp-1 = " "
ramp-2 = " "
ramp-3 = " "
ramp-4 = " "
ramp-foreground = ${colors.foreground}
ramp-background = ${colors.background}
```

Untuk penjelasan lebih lengkap mengenai blok-blok kode modul temperature di atas, silahkan mengunjungi halaman Wiki Polybar, [di sini](https://github.com/polybar/polybar/wiki/Module:-temperature){:target="_blank"}.

<br>

#### Moudul Date

```
[module/date]
type = internal/date
interval = 1

date = "0%u%y%m%d"
date-alt = "%a %Y/%m/%d"

time = "%H%M"
time-alt = " %H:%M"

format-prefix = " "
format-prefix-foreground = ${colors.foreground}
format-prefix-background = ${colors.background}

label = %date%%time%
label-foreground = ${colors.foreground}
label-background = ${colors.background}
```

Untuk penjelasan lebih lengkap mengenai blok-blok kode date network di atas, silahkan mengunjungi halaman Wiki Polybar, [di sini](https://github.com/polybar/polybar/wiki/Module:-date){:target="_blank"}.

<br>


#### Modul Network

Untuk Wireless LAN

```
[module/netspdwlan]
type = internal/network
interface = wlp4s0
interval = 1.0
format-connected = "<label-connected>"
label-connected = " %downspeed:3%  %upspeed:3%"
label-connected-foreground = ${colors.foreground}
label-connected-background = ${colors.background}


[module/wlan]
type = internal/network
interface = wlp4s0
interval = 1.0

format-connected = "<ramp-signal>"
label-connected = " %essid:0:10:% "
label-connected-foreground = ${colors.foreground}
label-connected-background = ${colors.background}

format-disconnected = <label-disconnected>
label-disconnected = " OFFLINE "
label-disconnected-foreground = ${colors.foreground}

ramp-signal-0 = %{T5}0%{T-}
ramp-signal-1 = %{T5}1%{T-}
ramp-signal-2 = %{T5}2%{T-}
ramp-signal-3 = %{T5}3%{T-}
ramp-signal-foreground = ${colors.foreground}
ramp-signal-background = ${colors.background}
```

Untuk Wired LAN

```
[module/netspdeth]
type = internal/network
interface = enp0s31f6
interval = 1.0
format-connected = "<label-connected>"
label-connected = " %downspeed:3%  %upspeed:3% |"
label-connected-foreground = ${colors.foreground}
label-connected-background = ${colors.background}


[module/eth]
type = internal/network
interface = enp0s31f6
interval = 1.0

format-connected-prefix = " "
format-connected-prefix-foreground = ${colors.foreground}
format-connected-prefix-background = ${colors.background}
label-connected = " %local_ip% "

;format-disconnected = <label-disconnected>
;label-disconnected =  %ifname%
;label-disconnected-foreground = ${colors.foreground}
```

Untuk penjelasan lebih lengkap mengenai blok-blok kode modul network di atas, silahkan mengunjungi halaman Wiki Polybar, [di sini](https://github.com/polybar/polybar/wiki/Module:-network){:target="_blank"}.

<br>

#### Modul Battery

```
[module/battery]
type = internal/battery
battery = BAT0
adapter = AC
full-at = 90

format-charging = "<animation-charging><label-charging>"
;format-charging-underline = ${colors.foreground}
label-charging-foreground = ${colors.foreground}
label-charging-background = ${colors.background}

format-discharging = "<ramp-capacity><label-discharging>"
;format-discharging-underline = ${self.format-charging-underline}
label-discharging-foreground = ${colors.foreground}
label-discharging-background = ${colors.background}

format-full-prefix = "  "
format-full-prefix-foreground = ${colors.foreground}
format-full-prefix-background = ${colors.background}
;format-full-underline = ${self.format-charging-underline}

ramp-capacity-0 = "  "
ramp-capacity-0-foreground = ${colors.alert}
ramp-capacity-1 = "  "
ramp-capacity-2 = "  "
ramp-capacity-3 = "  "
ramp-capacity-foreground = ${colors.foreground}
ramp-capacity-background = ${colors.background}

animation-charging-0 = "  "
animation-charging-1 = "  "
animation-charging-2 = "  "
animation-charging-3 = "  "
animation-charging-foreground = ${colors.foreground}
animation-charging-background = ${colors.background}
animation-charging-framerate = 750
```

Karena saya mempunyai dua battery, yaitu Internal (BAT0) dan Eksternal (BAT1), saya memodifikasi nama module menjadi `[module/battery0]` dan `[module/battery1]`. Saya mengcopy paste [module/battery0] menjadi [module/battery1] dan mengganti value pada variabel `battery =` menjadi `BAT0`.

Untuk penjelasan lebih lengkap mengenai blok-blok kode modul battery di atas, silahkan mengunjungi halaman Wiki Polybar, [di sini](https://github.com/polybar/polybar/wiki/Module:-battery){:target="_blank"}.

<br>

#### Modul Text

```
[module/profile]
type = custom/text
content = "%{T3}%{T-} BANDITHIJO"
content-foreground = ${colors.foreground}
content-background = ${colors.background}

[module/sp1]
type = custom/text
content = " "
content-foreground = ${colors.foreground}
content-background = ${colors.background}

[module/sp2]
type = custom/text
content = " | "
;content = "  "
content-foreground = ${colors.foreground-alt}
content-background = ${colors.background}
```

Saya menggunkaan modul text untuk menambahkan beberapa element text pada Polybar. Seperti text bertulisakan  "BANDITHIJO".

Saya juga menggunakan modul text untuk memberikan jarak atau pun simbol pemisah seperti `|`.

Untuk penjelasan lebih lengkap mengenai blok-blok kode modul text di atas, silahkan mengunjungi halaman Wiki Polybar, [di sini](https://github.com/polybar/polybar/wiki/Module:-text){:target="_blank"}.

<br>

### Blok [settings]

Pada blok ini tidak banyak yang saya pahami.

Hanya mengikuti konfigurasi dari Wiki Polybar.

```
[settings]
throttle-output = 5
throttle-output-for = 10
throttle-input-for = 30
screenchange-reload = true
compositing-background = over
compositing-foreground = over
compositing-overline = over
compositing-underline = over
compositing-border = over
pseudo-transparency = false
```

Untuk penjelasan lebih lengkap mengenai kode blok settings di atas, silahkan mengunjungi halaman Wiki Polybar, [di sini](https://github.com/polybar/polybar/wiki/Configuration#application-settings){:target="_blank"}.

<br>

### Blok [global/wm]

```
[global/wm]
margin-top = 0
margin-bottom = 0
```

Untuk penjelasan lebih lengkap mengenai kode blok global/wm di atas, silahkan mengunjungi halaman Wiki Polybar, [di sini](https://github.com/polybar/polybar/wiki/Configuration#global-wm-settings){:target="_blank"}.

<br>

# Tips

## Show/Hide Bar untuk Trayicon

Karena saya tidak memerlukan trayicon selalu muncul pada tampilan Polybar saya. Karena icon-icon pada trayicon tidak selalu berinteraksi dengan saya. Saya berinteraksi dengan trayicon hanya apabila saya perlukan saja.

Maka dari itu, saya membuat trayicon terpisah pada bar tersendiri yang dapat di panggil apabila diperlukan dan disembunyikan apabila sudah tidak digunakan.

Caranya sangat mudah.

Dengan menambahkan bar kedua.

Saya akan berinama `[bar/traybspwm]`

Berikut ini isi dari bar ini.

```
[bar/traybspwm]
monitor = eDP1
width = 5.0%
height = 22
radius = 5.0
offset-x = -3
offset-y = 0.6%
fixed-center = true
bottom = yes

foreground = ${colors.foreground}
background = ${colors.background}

line-size = 1
line-color = #dfdfdf

border-size = 0

padding-left = 0
padding-right = 0

module-margin-left = 0
module-margin-right = 0

font-0 = Fira Code Retina:pixelsize=9;2

;separator =

modules-left = sp1
modules-center =
modules-right = sp1

tray-position = left
tray-padding = 0
tray-maxsize = 16
tray-scale = 1.0
tray-foreground = ${colors.foreground}
tray-background = ${colors.background}
tray-detached = true
tray-offset-x = 3
tray-offset-y = 0

;wm-restack = bspwm

override-redirect = true

cursor-click = pointer
cursor-scroll = ns-resize
```

Sepintas hampir mirip dengan [bar/barbspwm], namun apabila diperhatikan dengan baik, nilai yang ada di dalam bar ini sangat berbeda.

Selanjutnya tinggal membuat pemicu agar dapat dipanggil dan disembunyikan.

Pertama, buat dahulu script untuk mengaktifkan dan mematikan `traybspwm` ini.

```
$ sudo touch /usr/bin/polybar-tray
$ sudo chmod +x /usr/bin/polybar-tray
$ sudo vim /usr/bin/polybar-tray
```

```
#!/bin/sh

status=${1}

if [ $status = 'on' ]; then
    polybar traybspwm &
elif [ $status = 'off' ]; then
    kill `ps aux | awk '/[p]olybar traybspwm/ {print $2}'`
else
    echo 'Wrong argument! [on/off]'
fi
```

Maksud dari script di atas adalah, apabila kita memanggil `polybar-tray on` pada Terminal, maka bar traybspwm akan diaktifkan. Begitupula sebaliknya apabila kita menjalankan `polybar-tray off`.

Kedua, tinggal meletakkan pemanggilan ini pada keyboard shortcut pada Window Manager.

Saya akan mencontohkan pada BSPWM. Untuk teman-teman yang menggunakan Window Manager yang lain, silahkan menyesuaikan sendiri yaa. Hehehe.

Untuk BSPWM, konfigurasi keyboard shortcut ada pada file `~/.config/sxhkd/sxhkdrc`.

Kita akan tambahkan blok kode untuk memanggil dan menyembunyikan `traybspwm`.

```
$ vim ~/.config/sxhkd/sxhkdrc
```

Tambahkan saja di baris paling akhir.

```
# polybar-tray
super + {_,shift + }F12
    {polybar-tray off; polybar-tray on, polybar-tray off}
```

Saya menggunakan kombinasi keyboard <kbd>SUPER</kbd>+<kbd>F12</kbd> untuk mengaktifkan bar traybspwm dan <kbd>SUPER</kbd>+<kbd>SHIFT</kbd>+<kbd>F12</kbd> untuk menyembunyikannya.

Berikut ini adalah demonstrasinya.

![gambar_4]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/FKKM6wWh/gambar-04.gif" onerror="imgError(this);"}


# Contoh File Konfigurasi

Nah, kalo sudah memahami blok demi blok di atas. Saya akan memberikan gambaran full dari baris kode konfigurasi Polybar yang saya miliki.

```
;============================================================================;
;                                                                            ;
;   To learn more about how to configure Polybar                             ;
;   go to https://github.com/jaagr/polybar                                   ;
;                                                                            ;
;   The README contains alot of information                                  ;
;                                                                            ;
;============================================================================;


;-----------------------------------------------------------------------COLORS

[colors]
foreground = #BCC3C3
background = #002B36
foreground-alt = #56696F
background-alt = #073642
alert = #CB4B16

;-----------------------------------------------------------------BAR/BARBSPWM

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

padding-left = 1
padding-right = 1

module-margin-left = 0
module-margin-right = 0

font-0 = Fira Code Retina:pixelsize=9;2
font-1 = FontAwesome:pixelsize=10;2
font-2 = Font Awesome 5 Brands:size=10;2
font-3 = Fira Code Retina:weight=Bold:pixelsize=9;2
font-4 = Fira Code Retina:weight=Bold:pixelsize=6;-1
font-5 = FontAwesome:weight=Bold:pixelsize=4;-2

;separator =

modules-left = bspwm xwindow
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

wm-name = bspwm

wm-restack = bspwm

override-redirect = false

cursor-click = pointer
cursor-scroll = ns-resize

;----------------------------------------------------------------BAR/TRAYBSPWM

[bar/traybspwm]
monitor = eDP1
width = 5.0%
height = 22
radius = 5.0
offset-x = -3
offset-y = 0.6%
fixed-center = true
bottom = true

foreground = ${colors.foreground}
background = ${colors.background}

line-size = 1
line-color = #dfdfdf

border-size = 0

padding-left = 0
padding-right = 0

module-margin-left = 0
module-margin-right = 0

font-0 = Fira Code Retina:pixelsize=9;2

;separator =

modules-left = sp1
modules-center =
modules-right = sp1

tray-position = left
tray-padding = 0
tray-maxsize = 16
tray-scale = 1.0
tray-foreground = ${colors.foreground}
tray-background = ${colors.background}
tray-detached = true
tray-offset-x = 3
tray-offset-y = 0

;wm-restack = bspwm

override-redirect = true

cursor-click = pointer
cursor-scroll = ns-resize

;-----------------------------------------------------------------MODULE:BSPWM

[module/bspwm]
type = internal/bspwm

pin-workspaces = true
inline-mode = false
enable-click = false
enable-scroll = false
reverse-scroll = false
fuzzy-match = true

format = <label-state> <label-mode>

label-monitor = "%name%%{F#56696F} |%{F-}"

label-dimmed-foreground = ${colors.foreground}
label-dimmed-focused-background = ${colors.background}

label-focused = "%{T6}  %{T-}%{T1}%name%%{T-}%{F#56696F} |%{F-}"
label-focused-foreground = #ffffff
label-focused-background = ${colors.background}

label-occupied = "%{T6}  %{T-}%{T1}%name%%{T-}%{F#56696F} |%{F-}"

label-urgent = "%{T6}  %{T-}%{T1}%name%%{T-}%{F#56696F} |%{F-}"
label-urgent-foreground = ${colors.alert}
label-urgent-background = ${colors.background}

label-empty = "%{T6}%{F#002B36}  %{F-}%{T-}%name%%{F#56696F} |%{F-}"
label-empty-foreground = ${colors.foreground-alt}

label-tiled = []=
label-monocle = [M]=
label-floating = <><
label-fullscreen = [F]
label-pseudotiled = [T]
label-locked = [X]
label-locked-foreground = ${colors.foreground}
label-sticky = [Y]
label-sticky-foreground = ${colors.foreground}
label-private = [Z]
label-private-foreground = ${colors.foreground}

label-separator =
label-separator-padding = 0
label-separator-foreground = ${colors.foreground-alt}

;---------------------------------------------------------------MODULE:XWINDOW

[module/xwindow]
type = internal/xwindow
format = <label>
format-padding = 0

label = " %title%"
label-maxlen = 30
label-foreground = ${colors.foreground}
label-background = ${colors.background}

label-empty =
label-empty-foreground = ${colors.background}

;--------------------------------------------------------------MODUL:XKEYBOARD

[module/xkeyboard]
type = internal/xkeyboard
blacklist-0 = num lock
blacklist-1 = scroll lock

format = <label-indicator>
format-spacing = 0

format-prefix = " "
format-prefix-foreground = ${colors.alert}
format-prefix-background = ${colors.background}

label-layout = "%layout%"
label-layout-foreground = ${colors.foreground}
label-layout-background = ${colors.background}

label-indicator-padding = 0
label-indicator-margin = 0
label-indicator = %{T4} CAPS %{T-}
label-indicator-foreground = ${colors.alert}
label-indicator-background = ${colors.background}

;------------------------------------------------------------MODULE:XBACKLIGHT

[module/xbacklight]
type = internal/xbacklight

;format = "<label><bar>"
format = "<label>"
label = " %percentage%%"
label-foreground = ${colors.foreground}
label-background = ${colors.background}

bar-width = 5
bar-indicator = |
bar-indicator-foreground = ${colors.foreground}
bar-indicator-background = ${colors.background}
bar-indicator-font = 1

bar-fill = -
bar-fill-font = 1
bar-fill-foreground = ${colors.foreground}
bar-fill-background = ${colors.background}

bar-empty = -
bar-empty-font = 1
bar-empty-foreground = ${colors.foreground}
bar-empty-background = ${colors.background}

;------------------------------------------------------------MODULE:PULSEAUDIO

[module/pulseaudio]
type = internal/pulseaudio

sink = alsa_output.pci-0000_12_00.3.analog-stereo

use-ui-max = true

interval = 5

format-volume = <ramp-volume> <label-volume>

label-muted = 
label-muted-foreground = ${colors.alert}

ramp-volume-0 = 
ramp-volume-1 = 
ramp-volume-2 = 

;-----------------------------------------------------------------MODUL:MEMORY

[module/memory]
type = internal/memory
interval = 1

format-prefix = " "
format-prefix-foreground = ${colors.foreground}
format-prefix-background = ${colors.background}

label = "%percentage_used%%"
label-foreground = ${colors.foreground}
label-background = ${colors.background}

;-------------------------------------------------------------------MODULE:CPU

[module/cpu]
type = internal/cpu
interval = 1
format-prefix = " "
format-prefix-foreground = ${colors.foreground}
format-prefix-background = ${colors.background}
;format-underline = ${colors.foreground}
label = "%percentage:2%%"
label-foreground = ${colors.foreground}
label-background = ${colors.background}

;------------------------------------------------------------MODULE:FILESYSTEM

[module/filesystem]
type = internal/fs
interval = 25

mount-0 = /

label-mounted = " %percentage_used%%"
label-mounted-foreground = ${colors.foreground}
label-mounted-background = ${colors.background}

label-unmounted = %mountpoint% not mounted
label-unmounted-foreground = ${colors.foreground}

;-----------------------------------------------------------MODULE:TEMPERATURE

[module/temperature]
type = internal/temperature
thermal-zone = 0
warn-temperature = 80

format = "<ramp><label>"
format-foreground = ${colors.foreground}
format-background = ${colors.background}
label = "%temperature-c%"
label-foreground = ${colors.foreground}
label-background = ${colors.background}

format-warn = <ramp><label-warn>
label-warn = "%temperature-c%"
label-warn-foreground = ${colors.alert}

ramp-0 = " "
ramp-1 = " "
ramp-2 = " "
ramp-3 = " "
ramp-4 = " "
ramp-foreground = ${colors.foreground}
ramp-background = ${colors.background}

;------------------------------------------------------------------MODULE:DATE

[module/date]
type = internal/date
interval = 1

date = "0%u%y%m%d"
date-alt = "%a %Y/%m/%d"

time = "%H%M"
time-alt = " %H:%M"

format-prefix = " "
format-prefix-foreground = ${colors.foreground}
format-prefix-background = ${colors.background}

label = %date%%time%
label-foreground = ${colors.foreground}
label-background = ${colors.background}

;---------------------------------------------------------------MODULE:NETWORK

[module/netspdwlan]
type = internal/network
interface = wlp4s0
interval = 1.0
format-connected = "<label-connected>"
label-connected = " %downspeed:3%  %upspeed:3%"
label-connected-foreground = ${colors.foreground}
label-connected-background = ${colors.background}


[module/wlan]
type = internal/network
interface = wlp4s0
interval = 1.0

format-connected = "<ramp-signal>"
label-connected = " %essid:0:10:% "
label-connected-foreground = ${colors.foreground}
label-connected-background = ${colors.background}

format-disconnected = <label-disconnected>
label-disconnected = " OFFLINE "
label-disconnected-foreground = ${colors.foreground}

ramp-signal-0 = %{T5}0%{T-}
ramp-signal-1 = %{T5}1%{T-}
ramp-signal-2 = %{T5}2%{T-}
ramp-signal-3 = %{T5}3%{T-}
ramp-signal-foreground = ${colors.foreground}
ramp-signal-background = ${colors.background}

;-----------------------------------------------------------------------------

[module/netspdeth]
type = internal/network
interface = enp0s31f6
interval = 1.0
format-connected = "<label-connected>"
label-connected = " %downspeed:3%  %upspeed:3% |"
label-connected-foreground = ${colors.foreground}
label-connected-background = ${colors.background}


[module/eth]
type = internal/network
interface = enp0s31f6
interval = 1.0

format-connected-prefix = " "
format-connected-prefix-foreground = ${colors.foreground}
format-connected-prefix-background = ${colors.background}
label-connected = " %local_ip% "

;format-disconnected = <label-disconnected>
;label-disconnected =  %ifname%
;label-disconnected-foreground = ${colors.foreground}

;---------------------------------------------------------------MODULE:BATTERY

[module/battery]
type = internal/battery
battery = BAT0
adapter = AC
full-at = 90

format-charging = "<animation-charging><label-charging>"
;format-charging-underline = ${colors.foreground}
label-charging-foreground = ${colors.foreground}
label-charging-background = ${colors.background}

format-discharging = "<ramp-capacity><label-discharging>"
;format-discharging-underline = ${self.format-charging-underline}
label-discharging-foreground = ${colors.foreground}
label-discharging-background = ${colors.background}

format-full-prefix = "  "
format-full-prefix-foreground = ${colors.foreground}
format-full-prefix-background = ${colors.background}
;format-full-underline = ${self.format-charging-underline}

ramp-capacity-0 = "  "
ramp-capacity-0-foreground = ${colors.alert}
ramp-capacity-1 = "  "
ramp-capacity-2 = "  "
ramp-capacity-3 = "  "
ramp-capacity-foreground = ${colors.foreground}
ramp-capacity-background = ${colors.background}

animation-charging-0 = "  "
animation-charging-1 = "  "
animation-charging-2 = "  "
animation-charging-3 = "  "
animation-charging-foreground = ${colors.foreground}
animation-charging-background = ${colors.background}
animation-charging-framerate = 750

;------------------------------------------------------------------MODULE:TEXT

[module/profile]
type = custom/text
content = "%{T3}%{T-} BANDITHIJO"
content-foreground = ${colors.foreground}
content-background = ${colors.background}

[module/sp1]
type = custom/text
content = " "
content-foreground = ${colors.foreground}
content-background = ${colors.background}

[module/sp2]
type = custom/text
content = " | "
;content = "  "
content-foreground = ${colors.foreground-alt}
content-background = ${colors.background}

;---------------------------------------------------------------------SETTINGS

[settings]
throttle-output = 5
throttle-output-for = 10
throttle-input-for = 30
screenchange-reload = true
compositing-background = over
compositing-foreground = over
compositing-overline = over
compositing-underline = over
compositing-border = over
pseudo-transparency = false

;--------------------------------------------------------------------GLOBAL/WM

[global/wm]
margin-top = 0
margin-bottom = 0


; vim:ft=dosini
```

# Pesan Penulis

Polybar merupakan salah satu taskbar/panel yang mudah untuk dikonfigurasi dan dikustomisasi.

Saya sendiri sudah tak terhitung berapa kali berganti-ganti komposisi module Polybar yang saya gunakan ini. Hehehe.

Oh iya, sebagai gambaran, mungkin bisa meniru atau menggunakan konfigurasi yang sudah diracikkan oleh orang lain. Misalnya seperti, themes yang dicompose oleh [adi1090x/polybar-themes](https://github.com/adi1090x/polybar-themes){:target="_blank"}.

Lumayan untuk bahan referensi.

<br>

Sekali lagi saya berpesan, tulisan ini bukan merupakan tandingan dari dokumentasi yang ditulis oleh developer dari aplikasi yang sedang kita gunakan, yaitu Polybar.

Sebaik-baik dokumentasi adalah dokumentasi yang ditulis dan dipelihara oleh si pembuat aplikasi tersebut.

Maka dari itu, apabila mengalami kendala pada proses konfigrasi Polybar, silahkan merujuk pada referensi-referensi yang sudah saya sertakan di bawah.

<br>

Sepertinya cukup seperti ini saja.

Terima kasih.

<br>
Balikpapan, 10 Mei 2019






# Referensi

1. [wiki.archlinux.org/index.php/List_of_applications#Taskbars](https://wiki.archlinux.org/index.php/List_of_applications#Taskbars){:target="_blank"}
<br>Diakses tanggal: 2019/05/05

2. [github.com/jaagr/polybar](https://github.com/jaagr/polybar){:target="_blank"}
<br>Diakses tanggal: 2019/05/05
