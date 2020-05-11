---
layout: 'post'
title: "DWM, Window Manager yang Gak Pake Ribet"
date: 2020-04-24 14:23
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

# Pendahuluan

Sejak Oktober 2017, saya mulai masuk ke dunia Window Manager. Diawali dengan i3WM. Hingga April 2019, Saya mulai berpindah menggunakan BSPWM. Dan April 2020, saya kembali melangkahkan kaki ke Window Manger yang lain, yaitu DWM.

i3WM dan BSPWM masuk dalam Window Manager yang berkelas "Manual Tilling". Dimana penggunanya diberikan kebebasan untuk mengatur dan menempatkan window. Lain hal dengan DWM, yang masuk dalam kelas "Dynamic Tilling". Dengan mengusung konsep "Master & Slave", pengguna tidak perlu dipusingkan untuk mengatur sendiri dimana window akan ditampilkan. Namun, Window yang baru, akan secara otomatis masuk ke dalam stack (tumpukan) "Master", sedangkan window yang lain, akan masuk ke dalam stack "Slave"

Inilah alasan, mengapa saya memberi judul catatan ini sebagai "DWM, Window Manager yang Gak Pake Ribet".
Anti ribet-ribet kleb! lah pokoknya!

Tapi...

Untuk mencapai tahap "gak ribet" ini, kita perlu ribet-ribet dulu di awal, mas Bro.

Seperti pepatah lama, "Berakit-rakit ke hulu, bersenang-senang kemudian."

<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>Menurut pendapat saya,</p>
<p>"Gak pake ribet" di sini juga saya maksudkan kepada perilaku dari tilling layout yang menganut prinsip "Master & Slave" tadi. Karena apabila dibandingkan berdasarkan kemampuan untuk mengelola window, i3WM dan BSPWM "jauh" lebih mumpuni.</p>
</div>

# Alasan Migrasi ke DWM

**Lah, kalau i3WM dan BPSWM jauh lebih mumpuni untuk mengelola window, kenapa pindah, mas Bro?**

Sama halnya seperti saat menggunakan i3WM, seiring berjalannya waktu, perilaku saya dalam mengelola window pun berubah. Tidak lagi banyak memerlukan layout yang *complicated* seperti pada saat saya mengerjakan soal-soal CCNA (lihat videonya di sini, ["Bagaimana i3wm Menghandle Banyak Window"](https://www.youtube.com/watch?v=Iw2t_k1QqJ8){:target="_blank"}).

Saat berpindah dari i3WM ke BSPWM, saya lebih banak menggunakan susunan tilling seperti ini.

```
+-----+-----+ +----------+ +-----+-----+ +-----+-----+
|     |     | |    1     | |     |  2  | |  1  |  2  |
|  1  |  2  | +----------+ +  1  +-----+ |-----+-----+
|     |     | |    2     | |     |  3  | |  4  |  3  |
+-----+-----+ +----------+ +-----+-----+ +-----+-----+
```

Nah, karena itu, saya berpikir, kenapa tidak coba untuk bermigrasi menggunakan window manager yang lebih sederhana dalam perilaku membuat layout? Maka saya pun melakukan riset kecil-kecilan, dan pilihan jatuh pada BSPWM.

Awalnya saya sempat mencoba DWM lebih dahulu, namun ternyata kebutuhan saya masih terlalu tinggi. Dengan ilmu saya saat itu, saya kesulitan mengkonfigurasi DWM agar dapat mengikuti keinginan saya. Maka saya memutuskan untuk menggunakan BSPWM. BSPWM, dapat mengikuti dan memenuhi kebutuhan saya dalam mengatur komposisi window.

Kemudian, sampai pada tahap perubahan perilaku saya dalam menyusun Window. Saya lebih banyak menggunakan tilling layout seperti ini.

```
+-----+-----+ +-----+-----+
|     |     | |     |  2  |
|  1  |  2  | +  1  +-----+
|     |     | |     |  3  |
+-----+-----+ +-----+-----+
```

Karena kebutuhan yang lebih sederhana, maka saya pun merasa cukup untuk menggunakan DWM tanpa perlu melakukan banyak *patching*. Karena saya sendiri masih kesulitan apabila memasang terlalu banyak *patching*.

Saya lebih banyak menggunakan model tilling layout yang mana window ke-1 lebih sering digunakan. Maka ini sangat cocok dengan filosofi "Master & Slave" milik DWM.

Eits! Namun, bukan berarti DWM hanya sesederhana itu. Buat yang menggemari kompleksitas dalam menggunakan Tilling Window Manager, kalian masih dapat meracik DWM sesuai keinginan yang kalian perlukan dengan menambah *patch*.

# Patching

Ada banyak sekali daftar *patch* yang tersedia.

Namun, jujur saja, saya tidak sanggup mengujicobanya satu persatu saat ini. Dari sekian banyak *patch* yang tesedia, saya memilah-milah, kira-kira *patch* mana saja yang saya benar-benar perlukan. Kenapa saya memilah-milah? Ada beberapa alasan, diantaranya:

1. Dengan banyaknya *patch* yang tersedia, saya tidak ingin dibingungkan dengan fungsi yang sama namun saling tumpang tindih.
2. Mengelola banyak *patch* sangat melelahkan. Mungkin dikarenakan saya belum memahami, bagaimana *best practice* dalam mengelola dan mengaplikasikan *patch.
3. Saya tidak ingin menambahkan *patch* yang saya tidak benar-benar perlukan.

Dengan beberapa alasan tersebut, selama tulisan ini dibuat saya ~~hanya~~ menggunakan 12 *patches*. yaitu:

1. actualfullscreen
2. autostart
3. cfacts
4. focusonnetactive
5. fullgaps
6. movestack
7. pertag
8. resizecorners
9. statusallmons
10. savefloats
11. scratchpad-gaspar (outside suckless)
12. zoomswap

Saya meracik semua *patches* tersebut menjadi Git branches. Masing-masing *patch*, memiliki satu branch. Setelah itu, untuk mengcompila mejadi dwm yang utuh, saya menggunakan bantuan beberapa script. Script ini bertugas mengautomatisasi proses yang berulang-ulang. Tujuannya jelas untuk mempermudah saya agar tidak kelelahan berlama-lama depan laptop.

## Bagaimana Cara Patching?

Seperti yang dijelaskan pada website [suckless.org/hacking](https://suckless.org/hacking/){:target="_blank"}. Terdapat 3 cara.
Namun, karena saya menggunakan git, maka, saya akan memanfaatkan cara *patching* menggunakan git.

**Menggunakan Git Apply**

<pre>
$ <b>git apply path/to/patch.diff</b>
</pre>

Nah, kalau cara pertama tidak berhasil, lakukan cara terakhir.

**Manual Patching**

Dengan mengcopykan baris demi bari yang ada di dalam *patch* ke dalam file-file yang berkaitan di dalam direktori dwm kita.


<br>

Nah! untuk mempermudah proses *compiling*, saya menggunakan bantuan beberapa script.

Berikut ini daftar script yang saya gunakan.

1. **suckclean** : untuk mereset master
2. **suckdiff** : untuk membuat backup branch dalam bentuk *patch* yang tersimpan di `~/.config/suckless/`
3. **suckmerge-dwm** : untuk me-*merge*-kan branch-branch terpilih ke master branch, sekaligus mengcompilenya

Nah, berikut ini adalah isi dari script-script tersebut.

# Suckless Script

**suckclean** - Created by: HexDSL
```bash
#!/usr/bin/env bash

make clean &&
rm -f config.h && git reset --hard origin/master
```

**suckdiff** - Created by: HexDSL
```bash
#!/usr/bin/env bash

git checkout master &&
dotfiles="$HOME/.config/suckless"
project=$(basename $(pwd))
diffdir="${dotfiles}/${project}_diffs/"
olddiffdir="${dotfiles}/${project}_diffs/old/"
rm -rf "$olddiffdir" &&
mkdir -p "$olddiffdir" &&
mkdir -p "$diffdir" &&
mv "$diffdir"*.diff "$olddiffdir" || true &&
make clean && rm -f config.h && git reset --hard origin/master &&
for branch in $(git for-each-ref --format='%(refname)' refs/heads/ | cut -d'/' -f3); do
	if [ "$branch" != "master" ];then
		git diff master..$branch > "${diffdir}${project}_${branch}.diff"
	fi
done
```

**suckmerge-dwm** - Created by: BanditHijo
```ruby
#!/usr/bin/env ruby

puts "=> Convert All Branch to Patch"
system """
suckdiff &&
git checkout master
git reset --hard origin/master
"""
puts "=> Converting COMPLETE!"

branches = [
# Enable branch
'config',
'actualfullscreen',
'autostart',
'movestack',
'pertag',
'resizecorners',
'focusonnetactive',
'statusallmons',
'scratchpad-gaspar',  # merge /w: actualfullscreen
'zoomswap',
'center',
'rules',              # merge /w: config, center
'fullgaps',           # merge /w: config
'cfacts',             # merge /w: config, movestack, fullgaps
'keys',               # merge /w: config, scratchpad-gaspar

# Disable branch
#'singularborders',
#'noborder',
#'gaps',
#'attachbottom',
]

puts "\n=> Patching All Branch to Master"
for branch in branches do
  print "Patching #{branch}... "
  `git merge #{branch} -m #{branch}`
  print "DONE\n"
end
puts "=> Patching COMPLETE!"

puts "\n=> Installing"
system """
make && sudo make clean install
"""
puts "=> Installation COMPLETE!"
```

Cara penggunannya gampang. Saya akan tuliskan dalam bentuk runutan.

1. Setelah selesai meracik *patch* di dalam masing-masing branch, kembali ke master branch.
2. Jalankan `suckmerge-dwm`
3. Apabila berhasil, restart dwm.
4. Saat ini master branch dalam keadaan kotor, jalankan `suckclean` untuk mereset dan membersihkannya.
5. Untuk mengedit *patch* branch dengan cara `git checkout <nama_branch>`, wajib menjalankan `suckclean` terlebih dahulu.

Apabila terdapat perubahan di dalam branch *patch*, ulangi lagi dari langkah ke dua. Mudah bukan?

**Apakah akan terdapat conflict?**

Jelas! Pasti akan ada kalau kita menggunakan banyak *patch*.

Biasanya kalau terjadi *conflict*, saya selesaikan dengan me-*merge*-kan kedua *patch* branch yang berkonflik, lalu saya selesaikan baris-baris kode yang *conflict* dengan cara manual.

Bisa dilihat, beberapa *patch* branch yang berkonflik pada script **suckmerge-dwm** di atas, saya catat branch apa dan merge dengan branch apa saja.

Nah, berikut ini adalah tangkapan layar dari DWM yang saat ini saya pergunakan.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/8kyg5LVJ/gambar-01.png" onerror="imgError(this);"}
<p class="img-caption">Gambar 1 - RicingShow: DeWayEm Project 2020-05</p>

Repositorinya dapat dilihat [di sini](https://github.com/bandithijo/dwm){:target="_blank"}.

# Tambahan

## Patch from User

**sracthpad by Gaspar Vardanyan**

Sejauh yang saya ingat, ada satu *patch* yang saya gunakan namun bukan dari halaman website suckless. Yaitu [**GasparVardanyan/dwm-scratchpad**](https://github.com/GasparVardanyan/dwm-scratchpad){:target="_blank"}.

*Patch* scratchpad ini berbeda dengan scratchpad yang ada pada website suckless. Perilaku dari scratphad ini mirip dengan yang ada di i3WM. Dimana, window yang dijadikan scratphad akan memiliki kemampuan untuk menghilang dan muncul kembali, layaknya seorang ninja -- apasih wkwk.

## Personal Branch

### config branch
Saya membuat branch yang isinya kurang lebih seperti personal konfigurasi untuk menampung beberapa pengaturan seperti font, border, gap, window rules, dan keybind.

Jadi, saya menambahkan 1 branch yang bukan termasuk dwm *patch*, yaitu:

Branch ini berisi konfigurasi global, seperti font, border, gaps, warn, dll yang sebagian besar berada pada file **config.def.h** atau **dwm.c**.

<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>Hanya sekedar saran. Apabila di dalam <i>patch</i> terdapat pengaturan <i>keys</i>, sebaiknya tidak perlu diikutkan dan langsung dipindahkan ke branch config pada file <b>config.def.h</b>.</p>
</div>

File **config.mk**.

```c
// config.mk
...
X11INC = /usr/local/include
X11LIB = /usr/local/lib

```

File **config.def.h**.

```c
// config.def.h
...
static const unsigned int snap      = 5;        /* snap pixel */

...
static const char *fonts[]          = { "FuraCode Nerd Font:style=Medium:size=8" };
static const char dmenufont[]       = "FuraCode Nerd Font:style=Medium:size=8";

...
    { MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = -1 } },

...
...

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    /* class                  instance              title                         tags mask     iscentered     isfloating   monitor */
    // Non FLoating
    { "Gimp-2.10",            NULL,                 NULL,                         0,            1,             0,           -1 },
    { "firefox",              NULL,                 NULL,                         2,            1,             0,           -1 },
    { "Chromium-browser",     NULL,                 NULL,                         2,            1,             0,           -1 },
    { "TelegramDesktop",      NULL,                 NULL,                         1 << 7,       1,             0,           -1 },
    { "Thunderbird",          NULL,                 NULL,                         1 << 6,       1,             0,           -1 },
    { "Hexchat",              NULL,                 NULL,                         1 << 5,       1,             0,           -1 },
    { "mpv",                  NULL,                 NULL,                         0,            1,             0,           -1 },
    { NULL,                   "libreoffice",        NULL,                         0,            1,             0,           -1 },
    { "Thunar",               "thunar",             NULL,                         0,            1,             0,           -1 },
    // Floating
    { "St",                   NULL,                 "st+",                        0,            1,             1,           -1 },
    { "copyq",                NULL,                 NULL,                         0,            1,             1,           -1 },
    { "Arandr",               NULL,                 NULL,                         0,            1,             1,           -1 },
    { "Gcolor3",              NULL,                 "Color picker",               0,            1,             1,           -1 },
    { "Gnome-calculator",     NULL,                 "Calculator",                 0,            1,             1,           -1 },
    { "Hexchat",              NULL,                 "Network List - HexChat",     1 << 5,       1,             1,           -1 },
    { "SimpleScreenRecorder", NULL,                 NULL,                         0,            1,             1,           -1 },
    { "Soffice",              NULL,                 "Print",                      0,            1,             1,           -1 },
    { "Chrome",               NULL,                 "Save File",                  2,            1,             1,           -1 },
    { "Barrier",              NULL,                 NULL,                         0,            1,             1,           -1 },
    { "Soffice",              "soffice",            NULL,                         0,            1,             0,           -1 },
    { "Thunar",               "thunar",             "File Operation Progress",    0,            1,             1,           -1 },
    { "System-config-printer.py", NULL,             NULL,                         0,            1,             1,           -1 },
    { "Nm-connection-editor", NULL,                 "Network Connections",        0,            1,             1,           -1 },
    { "Pavucontrol",          NULL,                 NULL,                         0,            1,             1,           -1 },
    { "Gpick",                NULL,                 NULL,                         0,            1,             1,           -1 },
    { "vokoscreen",           NULL,                 NULL,                         0,            1,             1,           -1 },
    { "Blueman-manager",      NULL,                 NULL,                         0,            1,             1,           -1 },
};

...
...

static Key keys[] = {
    ...
    ...

    // Custom Keys
    /* modifier                     key                        function        argument */
    { MODKEY|ControlMask,           XK_Return,                 spawn,          SHCMD("st -T 'st+'") },
    { MODKEY,                       XK_F12,                    spawn,          SHCMD("polybar-tray off; polybar-tray on") },
    { MODKEY|ShiftMask,             XK_F12,                    spawn,          SHCMD("polybar-tray off") },
    { MODKEY|ShiftMask,             XK_End,                    spawn,          SHCMD("/usr/bin/rofi-power 'killall dwm'") },
    { MODKEY,                       XK_e,                      spawn,          SHCMD("/usr/bin/rofi-emoji") },
    { MODKEY,                       XK_Print,                  spawn,          SHCMD("scrot 'Screenshot_%Y-%m-%d_%H-%M-%S.png' -e 'mv *.png ~/pic/ScreenShots/'; notify-send 'Scrot' 'Screen has been captured!'") },
    { MODKEY|ControlMask,           XK_Print,                  spawn,          SHCMD("scrot -d 5 'Screenshot_%Y-%m-%d_%H-%M-%S.png' -e 'mv *.png ~/pic/ScreenShots/'; notify-send 'Scrot' 'Screen has been captured!'") },
    { MODKEY|ShiftMask,             XK_Print,                  spawn,          SHCMD("/usr/bin/flameshot gui") },
    { MODKEY|ShiftMask,             XK_x,                      spawn,          SHCMD("/usr/bin/lock-dark") },
    { MODKEY,                       XK_F7,                     spawn,          SHCMD("/usr/bin/arandr") },
    { MODKEY,                       XK_F10,                    spawn,          SHCMD("/usr/bin/keybind-helper") },
    { MODKEY,                       XK_p,                      spawn,          SHCMD("/usr/bin/clipmenu") },
    { MODKEY|ShiftMask,             XK_p,                      spawn,          SHCMD("rm -f /tmp/clipmenu*/*") },
    { MODKEY|ShiftMask,             XK_backslash,              spawn,          SHCMD("/usr/bin/dmenu-pass") },
    { MODKEY,                       XK_backslash,              spawn,          SHCMD("/usr/bin/passtore 0") },
    { 0,                            0x1008ff13,                spawn,          SHCMD("pamixer --increase 5") },
    { 0,                            0x1008ff11,                spawn,          SHCMD("pamixer --decrease 5") },
    { 0,                            0x1008ff12,                spawn,          SHCMD("pamixer --toggle-mute") },
};
```

File **dwm.c**

```c
// dwm.c

void
manage(Window w, XWindowAttributes *wa)
{
...
...

    wc.border_width = c->bw;

    /* for centering window client open */
    if (c->x == selmon->wx) c->x += (c->mon->ww - WIDTH(c)) / 2 - c->bw;
    if (c->y == selmon->wy) c->y += (c->mon->wh - HEIGHT(c)) / 2 - c->bw;

    XConfigureWindow(dpy, w, CWBorderWidth, &wc);

...
...
}
```

## Status Bar

Seperti yang teman-teman ketahui, sebelumnya saya menggunakan Polybar. Namun, setelah migrasi menggunakan DWM, saya memutuskan untuk putus dengan Polybar dan memilih untuk meracik bar sendiri, tujuannya agar lebih sederhana.

Saya juga hanya menggunakan top bar saja, yang sebelumnya saya menggunakan top dan bottom bar. Dengan alasan, lagi-lagi untuk meminimalisir proses yang berlangsung. Karena saya hanya menggunakan top bar, artinya terdapat beberapa module yang saya tidak gunakan, seperti module CPU dan Brightness. Module CPU tidak saya pergunakan lagi karena saya sudah merujuk pada indikator suhu.

Nah, seperti ini tampilan bar yang saya pergunakan sekarang.

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/4NNsVpvT/gambar-02.png" onerror="imgError(this);"}
<p class="img-caption">Gambar 2 - dwmsatus (custom made)</p>

Saya membuat file bernama `~/.local/bin/dwmstatus`. Dan tambahkan *execute permission* `$ chmod +x dwmstatus`.

```bash
#!/usr/bin/env bash

# For dwmstatus
while true; do
    xsetroot -name " $($HOME/bin/network-wlan-tfc.sh) $($HOME/bin/cpu-temp.sh) $($HOME/bin/memory.sh) $($HOME/bin/filesystem.sh) $($HOME/bin/volume.sh) $(date +" 0%u%y%m%d%H%M") $($HOME/bin/bat-state.sh) $($HOME/bin/bat-capacity.sh)  BANDITHIJO "
    sleep 1
done
```

Seperti yang teman-teman lihat, isinya adalah pemanggilan terhadap script lain atau saya sebut saja sebagai module. Saya akan jabarkan di sini masing-masing module tersebut.

<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
<p>Kode-kode di bawah ini, karena keterbatasan dari Blog, sehingga tidak dapat menampilkan simbol-simbol seperti yang ada pada screenshot Gambar 2.</p>
</div>

<br>
**network-wlan-tfc.sh** - Created by: BanditHijo

```bash
#!/usr/bin/env bash

wlan_card='wls3'

wlan_do=$(ifstat2 -i $wlan_card 1 1 | awk 'NR%3==0 {print $1}')
wlan_up=$(ifstat2 -i $wlan_card 1 1 | awk 'NR%3==0 {print $2}')

echo "" $wlan_do "" $wlan_up "KB/s"
```

<br>
**cpu-temp.sh** - Created by: BanditHijo

```bash
#!/usr/bin/env bash

get_temp_cpu0=$(cat /sys/class/thermal/thermal_zone0/temp)
temp_cpu0=$(($get_temp_cpu0/1000))
echo " "$temp_cpu0"°C"
```

<br>
**memory.sh** - Created by: BanditHijo

```bash
#!/usr/bin/env bash

mem_total=$(free | awk 'NR%2==0 {print $2}')
mem_used=$(free | awk 'NR%2==0 {print $3}')
mem_usage=$(( $mem_used * 100 / $mem_total ))
echo " "$mem_usage"%"
```

<br>
**filesystem.sh** - Created by: BanditHijo

```bash
#!/usr/bin/env bash

cap_percentage=$(df -h --output=pcent / | awk 'NR%2==0 {print $0}')
echo ""$cap_percentage
```

<br>
**volume.sh** - Created by: BanditHijo

```bash
#!/usr/bin/env bash

mute=$(pamixer --get-mute)
if [ $mute = "true" ]; then
    echo " MUTE"
elif [ $mute = "false" ]; then
    volume=$(pamixer --get-volume-human)
    echo " "$volume
else
    echo " ERROR"
fi
```

<br>
**bat-state.sh** - Created by: BanditHijo

```bash
#!/usr/bin/env bash

state=$(cat /sys/devices/platform/smapi/BAT0/state)
if [ $state = "charging" ]; then
    echo " " # charging
elif [ $state = "discharging" ]; then
    echo " " # discharging
elif [ $state = "idle" ]; then
    echo " " # idle
else
    echo " " # unknown
fi
```

<br>
**bat-capacity.sh** - Created by: BanditHijo

```bash
#!/usr/bin/env bash

cap=$(cat /sys/devices/platform/smapi/BAT0/remaining_percent)
if [ $cap -ge 0 ] && [ $cap -le 20 ]; then
    echo "" $cap"%"
elif [ $cap -ge 21 ] && [ $cap -le 40 ]; then
    echo "" $cap"%"
elif [ $cap -ge 41 ] && [ $cap -le 60 ]; then
    echo "" $cap"%"
elif [ $cap -ge 61 ] && [ $cap -le 90 ]; then
    echo "" $cap"%"
elif [ $cap -ge 91 ] && [ $cap -le 100 ]; then
    echo "" $cap"%"
else
    echo "UNKNWN"
fi
```

## Autorun

Saya menggunakan *patch* autostart untuk menghandle program-program yang akan dijalankan pada autorun.

Dan saya merubah *default path* yang diberikan oleh *patch* di alamat `~/.dwm/autostart.sh` menjadi `~/.local/bin/autostart.sh`.

```c
// dwm.c

...
...

void
runAutostart(void) {
	system("cd ~/.local/bin; ./autostart_blocking.sh");
	system("cd ~/.local/bin; ./autostart.sh &");
}

...
...
```

Dan ini adalah isi dari file `autostart.sh` yang saya pergunakan.

```bash
#!/usr/bin/env bash

sanitizer
pkill -f "bash /home/bandithijo/bin/dwmstatus"; dwmstatus &
killall dunst; dunst -config ~/.config/dunst/dunstrc &
xsetroot -solid "#222222"
xsetroot -cursor_name left_ptr
xinput set-button-map "TPPS/2 IBM TrackPoint" 1 0 3
killall unclutter; unclutter --timeout 3
pkill -f "notify-hightemp"; notify-hightemp &
pkill -f "bash /usr/bin/clipmenud";killall clipnotify; clipmenud &
killall flameshot; flameshot &
killall lxpolkit; lxpolkit &
feh --bg-fill -Z $WALLPAPER2
xcompmgr &


# I'm not use this anymore
#killall xautolock; xautolock -time 60 -locker "~/bin/lock-dark" &
#$HOME/.config/polybar/launch.sh
#killall picom; picom --config ~/.config/picom/picom.conf --no-use-damage &
#xfce4-power-manager &
#killall notify-listener; # notify-listener.py &
#$HOME/.config/conky/conky-launch.sh &
```

## suckpush script

`suckpush` script adalah script untuk melakukan *push* setiap *commit* yang sudah terjadi pada tiap-tiap *patch* branch di lokal repo ke GitHub repo dengan cara memasuki (*checkout*) ke dalam tiap-tiap *patch* branch dan melakukan *push*.

Berikut ini scriptnya.

**suckpush** - Created by: BanditHijo

```ruby
#!/usr/bin/env ruby

remote_repo = "bandithijo"

puts "=> Reset the master branch"
system """
git checkout master
git reset --hard origin/master
"""
puts "=> Reseting COMPLETE!"

branch_list = `git branch`
branches = branch_list.split(" ").reject{ |n| n == "*" || n == "master" }.unshift("master")

puts "\n=> Push each branch to GitHub"
for branch in branches do
  print "Pushing #{branch}... "
  `git checkout #{branch}  > /dev/null 2>&1`
  `git push -u #{remote_repo} #{branch} > /dev/null 2>&1`
  print "DONE\n"
end
`git checkout master > /dev/null 2>&1`
puts "=> All Pushing COMPLETE!"
```

**Perhatikan!** Saya menambahkan dan menamakan GitHub repo saya sebagai 'bandithijo', bisa dilihat pada variabale `remote_repo`.

Outputnya akan seperti ini.

<pre>
$ <b>suckpush</b>
</pre>

```
=> Reset the master branch
Already on 'master'
Your branch is up to date with 'bandithijo/master'.
HEAD is now at f09418b dwm crashes when opening 50+ clients (tile layout)
=> Reseting COMPLETE!

=> Push each branch to GitHub
Pushing master... DONE
Pushing actualfullscreen... DONE
Pushing autostart... DONE
Pushing center... DONE
Pushing cfacts... DONE
Pushing config... DONE
Pushing focusonnetactive... DONE
Pushing fullgaps... DONE
Pushing keys... DONE
Pushing movestack... DONE
Pushing pertag... DONE
Pushing resizecorners... DONE
Pushing rules... DONE
Pushing statusallmons... DONE
Pushing zoomswap... DONE
=> All Pushing COMPLETE!
```


*Bersambung...*









# Referensi

1. [suckless.org/](http://suckless.org/){:target="_blank"}
<br>Diakses tanggal: 2020/04/24

2. [dwm.suckless.org/](https://dwm.suckless.org/){:target="_blank"}
<br>Diakses tanggal: 2020/04/24
