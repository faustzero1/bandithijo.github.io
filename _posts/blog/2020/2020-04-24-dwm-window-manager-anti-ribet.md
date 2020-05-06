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

Dengan beberapa alasan tersebut, selama tulisan ini dibuat saya ~~hanya~~ menggunakan 11 *patches*. yaitu:

1. actualfullscreen
2. autostart
3. center
4. cfacts
5. focusonnetactive
6. fullgaps
7. movestack
8. pertag
9. resizecorners
10. statusallmons
11. zoomswap

Saya meracik semua *patches* tersebut menjadi Git branches. Masing-masing *patch*, memiliki satu branch. Setelah itu, untuk mengcompila mejadi dwm yang utuh, saya menggunakan bantuan beberapa script. Script ini bertugas mengautomatisasi proses yang berulang-ulang. Tujuannya jelas untuk mempermudah saya agar tidak kelelahan berlama-lama depan laptop.

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
'zoomswap',
'center',
'rules',              # merge /w: config, center
'fullgaps',           # merge /w: config
'cfacts',             # merge /w: config, movestack, fullgaps
'keys',               # merge /w: config

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

## Personal Branch

Saya membuat beberapa branch yang isinya kurang lebih seperti personal konfigurasi untuk menampung beberapa pengaturan seperti font, border, gap, window rules, dan keybind.

Jadi, saya menambahkan 3 branch yang bukan termasuk dwm *patch*., yaitu:

1. config
2. rules
3. keys

Saya akan jabarkan.

<br>
**config** branch

Berisi konfigurasi global, seperti font, border, gaps, warn, dll.

```c
// config.def.h
...
static const unsigned int snap      = 5;        /* snap pixel */

...
static const char *fonts[]          = { "FuraCode Nerd Font:style=Medium:size=8" };
static const char dmenufont[]       = "FuraCode Nerd Font:style=Medium:size=8";

...
    { MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = -1 } },

// config.mk
...
X11INC = /usr/local/include
X11LIB = /usr/local/lib

```

<br>
**rules** branch

Berisi pengaturan window aplikasi.

```c
// config.def.h

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
```

<br>
**keys** branch

Berisi pengaturan keybindings.

```c
// config.def.h

static Key keys[] = {
    /* modifier                     key        function        argument */
    { MODKEY,                       XK_d,      spawn,          SHCMD("/usr/bin/dmenu-apps") },
    { MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
    { MODKEY,                       XK_b,      togglebar,      {0} },
    { MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
    { MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
    { MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
    { MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = -1 } },
    { MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
    { MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
    { MODKEY,                       XK_Return, zoom,           {0} },
    { MODKEY,                       XK_Tab,    view,           {0} },
    { MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
    { MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
    { MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
    { MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
    { MODKEY,                       XK_space,  setlayout,      {0} },
    { MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
    { MODKEY,                       XK_0,      view,           {.ui = ~0 } },
    { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
    { MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
    { MODKEY,                       XK_period, focusmon,       {.i = +1 } },
    { MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
    { MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
    TAGKEYS(                        XK_1,                      0)
    TAGKEYS(                        XK_2,                      1)
    TAGKEYS(                        XK_3,                      2)
    TAGKEYS(                        XK_4,                      3)
    TAGKEYS(                        XK_5,                      4)
    TAGKEYS(                        XK_6,                      5)
    TAGKEYS(                        XK_7,                      6)
    TAGKEYS(                        XK_8,                      7)
    TAGKEYS(                        XK_9,                      8)
    { MODKEY|ShiftMask,             XK_q,      quit,           {0} },

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
