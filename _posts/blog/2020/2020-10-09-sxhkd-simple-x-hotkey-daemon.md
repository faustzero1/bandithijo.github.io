---
layout: 'post'
title: "SXHKD, Simple X Hotkey Daemon"
date: 2020-10-09 21:37
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Ulasan', 'Tips']
pin:
hot:
contributors: []
---

# Latar Belakang

SXHKD, adalah Daemon yang sederhana (simple) untuk keyboard shortcut (hotkey) pada lingkungan X (Xorg).

Sederhananya, SXHKD digunakan sebagai alat bantu untuk mendefinisikan "keyboard shortcut" (keybindings) pada lingkungan X.

SXHKD digunakan secara default oleh BSPWM (Binary Space Partitioning Window Manager) sebagai tempat kita mendefinisikan keyboard shortcut.

Umumnya, penggunan Window Manager --terkhusus untuk Tiling Window Manager-- akan lebih sering memanipulasi window (seperti: switch window focus, resize window, move window, dll.) dan pemanggilan aplikasi hanya dengan menggunakan keyboard shortcut --tanpa perlu menggunakan mouse.

Window Manager pertama yang saya gunakan untuk beraktifitas adalah i3WM. Pada i3WM, kita dapat mendefinisikan keyboard shortcut langsung di dalam file config dari i3WM.

Berbeda dengan BSPWM, yang menggunakan SXHKD sebagai alat bantu untuk menghandle keyboard shortcut.

# Keuntungan Menggunakan SXHKD

Terdapat beberapa keuntungan yang akan kita dapatkan apabila kita memanfaatkan SXHKD sebagai alat bantu untuk menghandle keyboard shortcut, diantaranya:

1. **Modularity**<br>
    Kita akan mendapatkan konfigurasi keyboard shortcut yang terpisah dari config yang lain. Ibarat mengklasifikasikan dan memisahkan bagian khusus (tertentu) untuk keyboard shortcut. Dengan begini, diharapkan kita akan mendapatkan keuntungan dalam hal "easy to mantain" apabila konfigurasi yang kita gunakan semakin banyak.

2. **Flexibility**<br>
    Kita dapat menulis dan berkespresi dengan lebih bebas dalam mendifinisikan keyboard shortcut serta statement yang akan dipanggil juga menjadi lebih luwes.

3. **Independent**<br>
    SXHKD tidak hanya untuk BSPWM, tetapi dapat digunakan untuk Window Manager atau Desktop Environment yang lain pula.

# Cara Penggunaan

Berikut ini beberapa contoh isi dari konfigurasi SXHKD yang saya pergunakan.

Saya akan ambil beberapa contoh yang simple dan berbeda dengan yang lain.

## 1. Single Key

Ini adalah contoh yang menggnunakan single key.

```shell
# screenshot
Print
    /usr/bin/scrot-full
```

```shell
# pulseaudio controls mute speaker on/off
XF86AudioMute
    pamixer --toggle-mute
```

Dalam contoh di atas, saya menggunakan tombol <kbd>PrtScr</kbd> untuk memanggil script yang bernama `scrot-full`.

## 2. Simple Combination Sequence Key

Kita dapat menggunakan 2 atau lebih kombinasi tombol yang kita gunakan dengan cara "press & hold".

<kbd>Key1</kbd> + <kbd>Key2</kbd> + <kbd>KeyX</kbd>

<br>
**Contoh**:

Ini adalah contoh 2 kombinasi untuk menggunakan command terminal.

```shell
# make sxhkd reload its configuration files
super + Escape
	pkill -USR1 -x sxhkd
```

Ini adalah contoh 2 kombinasi untuk memanggil script dmenu (custom) launcher.

```shell
# application launcher
super + d
    /usr/bin/dmenu-apps
```

Ini adalah contoh 3 kombinasi untuk memanggil program slock.

```shell
# lock screen
super + shift + x
	/usr/local/bin/slock
```

## 3. Simple Parenthesis

**Different Statement**

```shell
{F1, F2, Fx}
    {statement A, statement B, statement x}
```

Arti dari keybind di atas adalah:

<kbd>F1</kbd> untuk menjalankan `statement A`.

<kbd>F2</kbd> untuk menjalankan `statement B`.

Dan seterusnya.

<br>
**Same Statement with Different Options**

```shell
{F1, F2, Fx}
    statement {--option A, --option B, --option x}
```

Arti dari keybind di atas adalah:

<kbd>F1</kbd>, untuk menjalankan `statement --option A`.

<kbd>F2</kbd>, untuk menjalankan `statement --option B`.

Dan seterusnya.

<br>
**Contoh**:

```shell
# pulseaudio controls speaker volume up & down
{XF86AudioRaiseVolume, XF86AudioLowerVolume}
    pamixer {--increase 2, --decrease 2}
```

## 4. Combination Sequence Key with Parenthesis

```shell
super + {_+shift} + F1
    statement {--option A, --option B}
```

Kelihatannya ribet yaa? Tapi sebenarnya ini sangat sederhana.

Arti dari keybind di atas adalah:

<kbd>Super</kbd> + <kbd>F1</kbd>, untuk menjalankan `statement --option A`. Tanda `_` dapat diartikan sebagai null atau tidak ada.

<kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>F1</kbd>, untuk menjalankan `statement --option B`.

## 5. Toggling On/Off

```shell
~F11
    {statement on, statement off}
```
Ini adalah contoh dari penggunaan toggling function. Cirinya adalah penggunaan tanda tilda `~`.

Toggling artinya kita bisa berganti on/off dengan menggunakan keybind yang sama.

Kalau diperhatikan, bagian statement menggunakan parenthesis.

Penggunaannya adalah pada dua statement yang saling berlawanan atau statement yang sama namun berbeda option.

Misal, statement A, adalah statement untuk memanggil, sedangkan statement B, adalah statement untuk menutup.

> Intinya, jangan terpaku pada on & off, tapi bisa beranekaragam tergantung dari kreatifitas teman-teman.

**Contoh**:

```shell
# key-mon
super + ~F11
    {/usr/bin/key-mon, killall key-mon}
```

## 6. Multiline for Long Statement

```shell
super + F1
    notify-send \
    "Header Title" \
    "Isi dari notifikasi"
```

Kita dapat menggunakan `\` backslash untuk memisahkan satu statement panjang menjadi beberapa baris. Dengan begini, command yang kita tulis akan lebih mudah untuk dibaca.

## 7. Multistatement

```shell
super + F1
    pamixer --increase 10; notify-send "Volume +"
```

Kita dapat menggunakan tanda `;` untuk memisahkan antar statement. Maka statement ini akan dijalankan berurutan dimulai dari yang paling depan.

## 8. Multiline for Multistatement

```shell
super + F1
    pamixer --increase 10; \
    notify-send "Volume +"
```

Ini adalah kombinasi dari point ke 6 & 7. Tujuannya agar statement yang kita definisikan menjadi lebih readable.

## 9. Etc.

Silahkan lihat pada `man sxhkd` untuk fungsi-fungsi yang lain.

# Contoh

Saya akan mencontohkan penggunaan yang terlihat ribet.

Tujuannya untuk menjelaskan dari keuntungan menggunakan SXHKD sesuai pada point ke-2, yaitu "Fleksibilitas".

```shell
# pulseaudio controls speaker volume up & down
{XF86AudioRaiseVolume, XF86AudioLowerVolume}
    pamixer {-i 2, -d 2}; \
    ou_vol=$(pamixer --get-volume); \
    jack_stat=$($HOME/bin/has_headphone); \
    [ $jack_stat = "yes" ] && icon=" "; \
    [ $jack_stat = "no" ]  && icon=" "; \
    dunstify "$icon Volume: "$ou_vol -t 1000 -r 1

# pulseaudio controls mic volume up & down
shift + {XF86AudioRaiseVolume, XF86AudioLowerVolume}
    pamixer --source 1 {-i 2, -d 2}; \
    ou_mic=$(pamixer --source 1 --get-volume); \
    dunstify "  Microphone: "$ou_mic -t 1000 -r 1

# pulseaudio controls monitor volume up & down
alt + {XF86AudioRaiseVolume, XF86AudioLowerVolume}
    pamixer --source 0 {-i 2, -d 2}; \
    ou_mon=$(pamixer --source 0 --get-volume); \
    dunstify "  Monitor: "$ou_mon -t 1000 -r 1

# pulseaudio controls mute speaker
XF86AudioMute
    pamixer \
    --toggle-mute; \
    ou_mute=$(pamixer --get-mute); \
    jack_stat=$($HOME/bin/has_headphone); \
    [ $jack_stat = "yes" ] && icon_on=" " icon_off=" "; \
    [ $jack_stat = "no" ]  && icon_on=" " icon_off=" "; \
    [ $ou_mute = "true" ]  && dunstify "$icon_off MUTED" -t 1000 -r 1; \
    [ $ou_mute = "false" ] && dunstify "$icon_on UNMUTED" -t 1000 -r 1

# pulseaudio controls mute mic
shift + XF86AudioMute
    pamixer \
    --source 1 --toggle-mute; \
    in_mute=$(pamixer --source 1 --get-mute); \
    [ $in_mute = "true" ]  && dunstify "  MUTED" -t 1000 -r 1; \
    [ $in_mute = "false" ] && dunstify "  UNMUTED" -t 1000 -r 1

# pulseaudio controls mute monitor
alt + XF86AudioMute
    pamixer \
    --source 0 --toggle-mute; \
    mo_mute=$(pamixer --source 0 --get-mute); \
    [ $mo_mute = "true" ]  && dunstify "  MUTED" -t 1000 -r 1; \
    [ $mo_mute = "false" ] && dunstify "  UNMUTED" -t 1000 -r 1

# screen brightness controls
{XF86MonBrightnessUp, XF86MonBrightnessDown}
    xbacklight {-inc 5, -dec 5}; \
    get_brightness=$(xbacklight -get | cut -f 1 -d '.'); \
    dunstify "  Brightness: "$get_brightness -t 1000 -r 1

```

Penggunaan seperti ini tidak saya rekomendasikan. Saya lebih merekomendasikan dimasukkan saja ke dalam file script.

# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Untuk repositori SXHKD milik saya, dapat teman-teman lihat [di sini](https://github.com/bandithijo/dotfiles/tree/master/.config/sxhkd){:target="_blank"}.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)

# Referensi

1. [baskerville/sxhkd](https://github.com/baskerville/sxhkd){:target="_blank"}
<br>Diakses tanggal: 2020/10/12
