---
layout: 'post'
title: 'MPV, Bukan Pemutar Video Biasa'
date: 2019-01-11 17:45
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Tools', 'Ulasan']
pin:
hot:
contributors: []
---

<!-- BANNER OF THE POST -->
<!-- <img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="#" onerror="imgError(this);" alt="banner"> -->

# Prakata

Teman-teman pasti memiliki pemutar video favorit masing-masing. Begitupun saya, **MPV** adalah pemutar video favorit sepanjang 2016 sampai saat tulisan ini dibuat. (2016 - 2019).

Selama menggunakan MPV tidak habis-habisnya saya menemukan fitur-fitur yang berguna untuk memudahkan urusan-urusan saya dalam hal video. Awalnya saya hanya ingin pemutar video yang memiliki *user interface* yang minimalis (karena hanya ingin fokus pada video), ringan, dan cepat saat dipanggil.

Namun, seiring berjalannya waktu, ternyata banyak sekali fitur-fitur yang dimiliki oleh MPV, dengan fitur yang hampir menyerupai VLC. Malah beberapa fitur pada MPV, saya belum pernah menggunakannya pada saat menggunakan VLC, karena belum adanya kebutuhan akan hal tersebut saat masih menggunakan VLC.

# Sekilas Tentang MPV

MPV adalah fork dari MPlayer dan mplayer2. Memiliki banyak dukungan terhadap hampir semua format file video dan audio codecs dan subtitle.

Kelebihan-kelebihan yang dimiliki oleh MPV:

1. **Memiliki banyak *command option*** layaknya MPLayer. Namun, sudah lebih diperbaiki dalam hal susunan sintaksis agar lebih mudah digunakan dan diingat
2. **MPV tidak memiliki official GUI**, namun begitu, dapat dengan mudah kita operasikan dengan menggunakan *keyboard shortcuts* atau gerakan mouse
3. **MPV memiliki video output berbasis OpenGL** yang memiliki banyak sekali fitur-fitur yang digemari oleh penggemar video, seperti video scaling, color correction, frame timing, interpolation, HDR, dan masih banyak lagi
4. **MPV memanfaatkan API FFmpeg hwaccel** untuk mendukung format VDPAU, VAAPI, DXVA2, VDA dan akselerasi decoding video VideoToolbox
5. Tentu saja **MPV masih aktif dikembangkan**, berfokus pada refactoring dan pembersihan kode serta menambahkan fitur
6. **Free, open source dan multi platform**

# Instalasi

Untuk distribusi Arch Linux, langsung saja pasang dari repository.
```
$ sudo pacman -S mpv
```
Untuk distribusi lain, silahkan menyesuaikan.

# Konfigurasi

Secara *default*, MPV akan membaca file konfigurasi yang terdapat pada direktori `/etc/mpv` (untuk *system wide*) atau `~/.config/mpv/` (untuk *user*).

Untuk membantu konfigurasi awal, kita dapat mengambil sampel konfigurasi default settings, dengan cara sebagai berikut.
```
$ cp -r /usr/share/doc/mpv/ ~/.config/
```
Saat ini saya hanya menggunakan 2 file yang ada pada direktori config ini, yaitu:
1. `input.conf` - Untuk *keyboard shortcuts*
2. `mpv.conf` - Untuk konfigurasi mpv itu sendiri

Saya akan mulai dari file `mpv.conf` terlebih dahulu.

## Konfigurasi mpv.conf

Buka Terminal dan edit file `mpv.conf`.

Saya menambahkan pada baris paling akhir setelah bagian/blok `profiles`, option-option di bawah.
<pre>
###########
# General #
###########

input-ipc-server=/tmp/mpvsocket           # listen for IPC on this socket
<mark>save-position-on-quit=no</mark>                  # handled by a script

#no-border                                # no window title bar
msg-module                                # prepend module name to log messages
msg-color                                 # color log messages on terminal
<mark>term-osd-bar</mark>                              # display a progress bar on the terminal
use-filedir-conf                          # look for additional config files in the directory of the opened file
#pause                                    # no autoplay
<mark>keep-open</mark>                                 # keep the player open when a file's end is reached
<mark>autofit-larger=90%x90%</mark>                    # resize window in case it's larger than W%xH% of the screen
cursor-autohide-fs-only                   # don't autohide the cursor in window mode, only fullscreen
input-media-keys=no                       # enable/disable OSX media keys
cursor-autohide=1000                      # autohide the curser after 1s
prefetch-playlist=yes
force-seekable=yes

<mark>screenshot-format=png
screenshot-png-compression=8
screenshot-template='~/pix/ScreenShot/%F (%P) %n'</mark>

hls-bitrate=max                           # use max quality for HLS streams

<mark>[ytdl-desktop]
profile-desc=cond:is_desktop()
ytdl-format=bestvideo[height<=?720]+bestaudio/best</mark>

<mark>[ytdl-laptop]
profile-desc=cond:is_laptop()
ytdl-format=bestvideo[height<=?720][fps<=?30][vcodec!=?vp9][protocol!=http_dash_segments]+bestaudio/best</mark>

[default]


#########
# Cache #
#########

# Configure the cache to be really big (multiple GBs)
# We have a lot of memory, so why not use it for something

cache=no
#cache-default=4000000                    # size in KB
#cache-backbuffer=250000                  # size in KB
#demuxer-max-bytes=1147483647             # ~1 GiB in bytes


#############
# OSD / OSC #
#############

osd-level=1                               # enable osd and display --osd-status-msg on interaction
osd-duration=2500                         # hide the osd after x ms
osd-status-msg='${time-pos} / ${duration}${?percent-pos:　(${percent-pos}%)}${?frame-drop-count:${!frame-drop-count==0:　Dropped: ${frame-drop-count}}}\n${?chapter:Chapter: ${chapter}}'

osd-font='Source Sans Pro'
osd-font-size=32
osd-color='#CCFFFFFF'                     # ARGB format
osd-border-color='#DD322640'              # ARGB format
#osd-shadow-offset=1                      # pixel width for osd text and progress bar
osd-bar-align-y=0                         # progress bar y alignment (-1 top, 0 centered, 1 bottom)
osd-border-size=2                         # size for osd text and progress bar
osd-bar-h=2                               # height of osd bar as a fractional percentage of your screen height
osd-bar-w=60                              # width of " " "


#############
# Subtitles #
#############

sub-auto=all                              # membuat mpv tetap mendeteksi file subtitle
no-sub-visibility                         # namun dalam keadaan terhidden
#sub-auto=fuzzy                           # external subs don't have to match the file name exactly to autoload
sub-file-paths-append=ass                 # search for external subs in these relative subdirectories
sub-file-paths-append=srt
sub-file-paths-append=sub
sub-file-paths-append=subs
sub-file-paths-append=subtitles

demuxer-mkv-subtitle-preroll              # try to correctly show embedded subs when seeking
embeddedfonts=yes                         # use embedded fonts for SSA/ASS subs
sub-fix-timing=no                         # do not try to fix gaps (which might make it worse in some cases)
sub-ass-force-style=Kerning=yes           # allows you to override style parameters of ASS scripts
sub-use-margins
sub-ass-force-margins

# the following options only apply to subtitles without own styling (i.e. not ASS but e.g. SRT)
sub-font="Source Sans Pro Semibold"
sub-font-size=36
sub-color="#FFFFFFFF"
sub-border-color="#FF262626"
sub-border-size=3.2
sub-shadow-offset=1
sub-shadow-color="#33000000"
sub-spacing=0.5


#############
# Languages #
#############

slang=enm,en,eng,de,deu,ger               # automatically select these subtitles (decreasing priority)
alang=ja,jp,jpn,en,eng,de,deu,ger         # automatically select these audio tracks (decreasing priority)


#########
# Audio #
#########

audio-file-auto=fuzzy                     # external audio doesn't has to match the file name exactly to autoload
audio-pitch-correction=yes                # automatically insert scaletempo when playing with higher speed
volume-max=200                            # maximum volume in %, everything above 100 results in amplification
volume=100                                # default volume, 100 = unchanged
</pre>

Berikut ini adalah penjelasan dari beberapa option yang saya gunakan. Saya tidak dapat menjelaskan semuanya secara detail.

### Save Position on Quit
```
save-position-on-quit=no
```
Option di atas digunakan untuk menyimpan posisi terakhir dari *seek bar*. Sehingga memungkinkan kita saat membuka file video yang sama, akan kembali dimulai pada menit sebelum mpv di-*quit*.

### Display Progress Bar on Terminal
```
term-osd-bar
```
Karena terkadang saya menjalankan mpv juga dari Terminal, misalkan menonton video melalui url youtube, saya membutuhkan progress bar untuk memberikan saya referensi di mana posisi saya saat ini (sudah berapa menit).

### Keep Open After Video End
```
keep-open
```
Option ini digunakan agar mpv tidak otomatis keluar saat selesai menjalankan video/audio.

### Default Window Size
```
autofit-larger=90%x90%
```
Option ini saya pergunakan agar saat membuka mpv, video tidak lebih besar dari resolusi layar yang saya gunakan.

### ScreenShot Format
```
screenshot-format=png
screenshot-png-compression=8
screenshot-template='~/pix/ScreenShot/%F (%P) %n'
```
Option ini saya pergunakan untuk mengatur screenshot file type dan lokasi dimana hasil screenshot disimpan beserta format namanya.

### youtube-dl Format
```
[ytdl-desktop]
profile-desc=cond:is_desktop()
ytdl-format=bestvideo[height<=?720]+bestaudio/best

[ytdl-laptop]
profile-desc=cond:is_laptop()
ytdl-format=bestvideo[height<=?720][fps<=?30][vcodec!=?vp9][protocol!=http_dash_segments]+bestaudio/best
```
Option di atas saya pergunakan untuk mengatur format video yang akan dipilih pada saat menonton streaming YouTube. Saya menggunakan fiber optik internet, sehingga tidak ada masalah untuk mengeset pada resoulsi 720.

## Konfigurasi input.conf

Untuk file konfigurasi `input.conf` saya tidak menambahkan banyak pengaturan *keyboard shortcuts*.

Saya hanya menambahkan untuk pengaturan **horizontal flip** dan **rotate** video.

Edit file `input.conf` dan tambahkan di paling bawah.
```
- cycle-values video-rotate "90" "180" "270" "0"
= vf toggle hflip
```
Option di atas bertujuan untuk melakukan rotate ke kanan dengan menekan tombol <kbd> - </kbd> dan tombol <kbd> = </kbd> untuk membuat video menjadi horizontal flip.

Saya menggunakan kedua tombol tersebut, karena belum terdapat command apapun yang dimiliki oleh keduanya.


# Contoh Pemanfaatan MPV

## Menonton YouTube
Sangat praktis sekali untuk dapat menonton video YouTube di MPV.

Caranya pun sangat mudah. Hanya perlu mengcopy paste url video YouTube setelah perintah mpv.
```
$ mpv https://www.youtube.com/watch?v=Jju_lt5f0Zo
```

<!-- PERTANYAAN -->
<div class="blockquote-yellow">
<div class="blockquote-yellow-title">Mengapa Menonton YouTube Menggunakan MPV ?</div>
Berikut ini adalah beberapa alasan saya:
<ol>
<li><b>Praktis</b> dan <b>simpel</b></li>
<li><b>Minim distraksi</b> dari user interface YouTube</li>
<li><b>Bebas dari iklan</b></li>
<li><b>Volume</b> dapat kita push hingga <b>lebih dari 100%</b> untuk video yang memiliki suara yang kecil</li>
<li><b>Brightness, Contrast</b> serta <b>Saturation</b> yang <b>dapat kita atur</b> sendiri. Karena terkadang ada video yang terlalu gelap</li>
<li><b>Video dapat dikontrol</b>, seperti: fast, slow, maju satu frame, maju 10 frame, dll</li>
<li>dll.</li>
</ol>
</div>

## WebCam Viewer
Selain dapat memutar video, MPV juga saya pergunakan untuk menampilkan output dari kamera WebCam.

Tidak seperti aplikasi WebCam pada umumnya yang harus bergantian dalam menampilkan output dari kamera. MPV dapat melakukannya secara bersamaan. Yaa jelas, karena mpv memanggil alamat dari masing-masing WebCam.

Sepertinya untuk menggunakan fitur ini, kita memerlukan paket `v4l-utils`.
```
$ sudo pacman -S v4l-utils
```
Namun, saya belum yakin apakah fitur ini membutuhkan paket `v4l-utils` atau tidak.

Sebelumnya cek dulu apakah terdapat webcam yang aktif.
```
$ ls -l /dev/video*
```
```
crw-rw----+ 1 root video 81, 0 Jan 11 21:39 /dev/video0
crw-rw----+ 1 root video 81, 1 Jan 11 21:39 /dev/video1
```

Setelah itu baru kita panggil WebCam yang aktif.

Dalam kasus ini hanya `/dev/video0/` saja yang saya gunakan.
<pre>
$ mpv <mark>av://v4l2:/dev/video0</mark>
</pre>

Apabila ingin menambahkan propertis lain seperti hitam putih dan horizontal flip, kira-kira seperti ini contohnya.

Horizontal flip.
<pre>
$ mpv av://v4l2:/dev/video0 <mark>--vf=hflip</mark>
</pre>
Atau hitam putih.
<pre>
$ mpv av://v4l2:/dev/video0 <mark>--saturation=-100</mark>
</pre>

Hasilnya,

<!-- PERTANYAAN -->
<div class="blockquote-yellow">
<div class="blockquote-yellow-title">Mengapa Mengunakan MPV sebagai WebCam viewer ?</div>
Berikut ini adalah beberapa alasan saya:
<ol>
<li><b>Praktis</b> dan <b>simpel</b></li>
<li><b>Minim distraksi</b> dari user interface YouTube</li>
<li><b>Brightness, Contrast</b> serta <b>Saturation</b> yang <b>dapat kita atur</b> sendiri.</li>
<li> Dapat <b>Multi Cam</b></li>
<li>Cenderung <b>ringan</b> dan tidak membuat laptop menjadi panas</li>
</ol>
</div>

<!-- IMAGE CAPTION -->
![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/LXK2R865/gambar-01.gif" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 1 - MPV menampilkan output dari banyak WebCam</p>

<!-- IMAGE CAPTION -->
![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/KYrxGyK5/gambar-02.gif" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 2 - Demonstrasi Horizontal Flip dan Rotate menggunakan keyboard Shortcut</p>


## Subtitle

Pada konfigurasi yang saya buat, saya menghidden visibility dari subtitle.
```
no-sub-visibility
```
Tujuannya, agar subtitle tidak langsung ditampilkan pada semua video.

Cara menggunakannya,
1. Tekan <kbd>V</kbd> untuk meng-*enable* dan *disable* visibility dari subtitle.
2. Apabila terdapat lebih dari 1 subtitle, kita dapat berpindah antar subtitle menggunakan <kbd>J</kbd> untuk Next Subtitle dan <kbd>SHIFT</kbd> + <kbd>J</kbd> untuk Previous Subtitle.


## Dual Subtitle

MPV juga dapat menampilkan dual subtitle.

```
$ mpv video.mp4 --sub-file=subtitle1.srt --sub-file=subtitle2.srt --secondary-sid=2
```

![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/tTtgmqnz/gambar-03.png" onerror="imgError(this);"}{:class="myImg"}


# Keyboard Shortcuts

Default Keyboard Shortcuts berdasarkan file `input.conf`.

**Play/Pause**

| <kbd>SPACE</kbd> | toggle play/pause |
| <kbd> p </kbd> | toggle play/pause |

**Show Progress**

| <kbd> o </kbd> | show progress |
| <kbd> P </kbd> | show progress |

**Skip 5 atau 60 detik**

| <kbd> → </kbd> | seek 5 |
| <kbd> ← </kbd> | seek -5 |
| <kbd> ↑ </kbd> | seek 60 |
| <kbd> ↓ </kbd> | seek -60 |

**Kecepatan Play Video**

| <kbd> [ </kbd> | multiply speed 0.9091 |
| <kbd> ] </kbd> | multiply speed 1.1 |
| <kbd> { </kbd> | multiply speed 0.5 |
| <kbd> } </kbd> | multiply speed 2.0 |


**Keluar**

| <kbd> q </kbd> | quit |
| <kbd> Q </kbd> | quit-watch-later |

**Subtitle**

| <kbd> v </kbd> | toggle subtitle visibility |
| <kbd> j </kbd> | toggle next subtitle |
| <kbd> J </kbd> | toggle previous subtitle |
| <kbd> z </kbd> | add sub-delay -0.1 |
| <kbd> x </kbd> | add sub-delay +0.1 |

**Volume**

| <kbd> 0 </kbd> | add volume +2 |
| <kbd> 9 </kbd> | add volume -2 |
| <kbd> m </kbd> | toggle mute |

**Color Correction**

| <kbd> 1 </kbd> | add contrast -1 |
| <kbd> 2 </kbd> | add contrast +1 |
| <kbd> 3 </kbd> | add brightness -1 |
| <kbd> 4 </kbd> | add brightness +1 |
| <kbd> 5 </kbd> | add gamma -1 |
| <kbd> 6 </kbd> | add gamma +1 |
| <kbd> 7 </kbd> | add saturation -1 |
| <kbd> 8 </kbd> | add saturation +1 |

**Fullscreen**

| <kbd> f </kbd> | fullscreen |

**Looping**

| <kbd> l </kbd> | A-B loop |

Keyboard Shortcuts yang saya tambahkan.

| <kbd> - </kbd> | rotate left 90 180 270 0 |
| <kbd> = </kbd> | horizontal flip |

# Pesan Penulis

Masih banyak fitur-fitur keren dari MPV yang mungkin belum tercover oleh tulisan ini. Mudah-mudahan dapat saya tambahkan lagi dilain waktu apabila menemukan penerapan lain dari penggunaan MPV.


# Referensi

1. [mpv.io](https://mpv.io/){:target="_blank"}
<br>Diakses tanggal: 2019/01/11

2. [github.com/mpv-player/mpv](https://github.com/mpv-player/mpv){:target="_blank"}
<br>Diakses tanggal: 2019/01/11

3. [wiki.archlinux.org/index.php/mpv](https://wiki.archlinux.org/index.php/mpv){:target="_blank"}
<br>Diakses tanggal: 2019/01/11

