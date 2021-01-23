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
hot: true
contributors: []
resume: 
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

{% box_info %}
<p>Menurut pendapat saya,</p>
<p>"Gak pake ribet" di sini juga saya maksudkan kepada perilaku dari tilling layout yang menganut prinsip "Master & Slave" tadi. Karena apabila dibandingkan berdasarkan kemampuan untuk mengelola window, i3WM dan BSPWM "jauh" lebih mumpuni.</p>
{% endbox_info %}

# Alasan Migrasi ke DWM

**Lah, kalau i3WM dan BPSWM jauh lebih mumpuni untuk mengelola window, kenapa pindah, mas Bro?**

Sama halnya seperti saat menggunakan i3WM, seiring berjalannya waktu, perilaku saya dalam mengelola window pun berubah. Tidak lagi banyak memerlukan layout yang *complicated* seperti pada saat saya mengerjakan soal-soal CCNA (lihat videonya di sini, ["Bagaimana i3wm Menghandle Banyak Window"](https://www.youtube.com/watch?v=Iw2t_k1QqJ8){:target="_blank"}).

Saat berpindah dari i3WM ke BSPWM, saya lebih banyak menggunakan susunan tilling seperti ini.

{% pre_whiteboard %}
+-----+-----+ +----------+ +-----+-----+ +-----+-----+
|     |     | |    1     | |     |  2  | |  1  |  2  |
|  1  |  2  | +----------+ +  1  +-----+ |-----+-----+
|     |     | |    2     | |     |  3  | |  4  |  3  |
+-----+-----+ +----------+ +-----+-----+ +-----+-----+
{% endpre_whiteboard %}

Nah, karena itu, saya berpikir, kenapa tidak coba untuk bermigrasi menggunakan window manager yang lebih sederhana dalam perilaku membuat layout? Maka saya pun melakukan riset kecil-kecilan, dan pilihan jatuh pada BSPWM.

Awalnya saya sempat mencoba DWM lebih dahulu, namun ternyata kebutuhan saya masih terlalu tinggi. Dengan ilmu saya saat itu, saya kesulitan mengkonfigurasi DWM agar dapat mengikuti keinginan saya. Maka saya memutuskan untuk menggunakan BSPWM. BSPWM, dapat mengikuti dan memenuhi kebutuhan saya dalam mengatur komposisi window.

Kemudian, sampai pada tahap perubahan perilaku saya dalam menyusun Window. Saya lebih banyak menggunakan tilling layout seperti ini.

{% pre_whiteboard %}
+-----+-----+ +-----+-----+
|     |     | |     |  2  |
|  1  |  2  | +  1  +-----+
|     |     | |     |  3  |
+-----+-----+ +-----+-----+
{% endpre_whiteboard %}

Karena kebutuhan yang lebih sederhana, maka saya pun merasa cukup untuk menggunakan DWM tanpa perlu melakukan banyak *patching*. Karena saya sendiri masih kesulitan apabila memasang terlalu banyak *patching*.

Saya lebih banyak menggunakan model tilling layout yang mana window ke-1 lebih sering digunakan. Maka ini sangat cocok dengan filosofi "Master & Slave" milik DWM.

Eits! Namun, bukan berarti DWM hanya sesederhana itu. Buat yang menggemari kompleksitas dalam menggunakan Tilling Window Manager, kalian masih dapat meracik DWM sesuai keinginan yang kalian perlukan dengan menambah *patch*.

# Patching

Ada banyak sekali daftar *patch* yang tersedia.

Namun, jujur saja, saya tidak sanggup mengujicobanya satu persatu saat ini. Dari sekian banyak *patch* yang tesedia, saya memilah-milah, kira-kira *patch* mana saja yang saya benar-benar perlukan. Kenapa saya memilah-milah? Ada beberapa alasan, diantaranya:

1. Dengan banyaknya *patch* yang tersedia, saya tidak ingin dibingungkan dengan fungsi yang sama namun saling tumpang tindih.
2. Mengelola banyak *patch* sangat melelahkan. Mungkin dikarenakan saya belum memahami, bagaimana *best practice* dalam mengelola dan mengaplikasikan *patch.
3. Saya tidak ingin menambahkan *patch* yang saya tidak benar-benar perlukan.

<br>
Dengan beberapa alasan tersebut, selama tulisan ini dibuat saya ~~hanya~~ menggunakan 24 patches.

Tulisan ini saya update 3 Januari 2021, saya sudah memasang 31 pathces.

1. actualfullscreen
2. aspectresize
3. autostart
4. center
5. cfacts
6. cfacts-dragcfact
7. fixborders
8. focusmaster
9. focusonclick
10. focusonnetactive
11. moveresize
12. movestack
13. movethrow
14. nmaster-sym
15. noborder
16. pertag
17. resetlayout
18. resizecorners
19. ru-bottomstack
20. ru-centeredmaster
21. ru-fibonacci
22. ru-gaps
23. savefloats
24. scratchpad
25. status2d
26. statusallmons
27. sticky
28. warp
29. wasfocus
30. xrdb
31. zoomswap

<br>
Saya meracik semua *patches* tersebut menjadi Git branches. Masing-masing *patch*, memiliki satu branch. Setelah itu, untuk mengcompila mejadi dwm yang utuh, saya menggunakan bantuan beberapa script. Script ini bertugas mengautomatisasi proses yang berulang-ulang. Tujuannya jelas untuk mempermudah saya agar tidak kelelahan berlama-lama depan laptop.

## Bagaimana Cara Patching?

Seperti yang dijelaskan pada website [suckless.org/hacking](https://suckless.org/hacking/){:target="_blank"}. Terdapat 2-3 cara.
Namun, karena saya menggunakan git, maka, saya akan memanfaatkan cara *patching* menggunakan git.

**Menggunakan Git Apply**

{% shell_user %}
git apply path/to/patch.diff
{% endshell_user %}

Nah, kalau cara pertama tidak berhasil, lakukan cara manual.

**Manual Patching**

Biasanya manual patching dilakukan apabila patching tersebut tidak dibuat dengan versi master yang sama dengan master yang kita miliki.

Manula patching adalah melakukan patching dengan meng-copy-kan baris demi baris yang ada di dalam *patch* ke dalam file-file yang berkaitan di dalam direktori dwm kita.



## Bagaimana Cara Compiling?

Nah! untuk mempermudah proses *compiling*, saya menggunakan bantuan beberapa script.

Berikut ini daftar script yang saya gunakan.

1. **suckclean** : untuk mereset master
2. **suckdiff** : untuk membuat backup branch dalam bentuk *patch* yang tersimpan di `~/.config/suckless/`
3. **suckmerge2** : untuk me-*merge*-kan branch-branch terpilih ke master branch, sekaligus mengcompilenya

Nah, berikut ini adalah isi dari script-script tersebut.

# Suckless Script

Created by: HexDSL

{% highlight_caption suckclean %}
{% highlight bash linenos %}
#!/usr/bin/env bash

make clean &&
rm -f config.h && git reset --hard origin/master
{% endhighlight %}

Created by: HexDSL

{% highlight_caption suckdiff %}
{% highlight bash linenos %}
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
{% endhighlight %}

Created by: BanditHijo, versi terbaru [di sini](https://github.com/bandithijo/sucklessthing/blob/master/suckmerge2){:target="_blank"}

{% highlight_caption suckmerge2 %}
{% highlight ruby linenos %}
#!/usr/bin/env ruby

# Suckmerge2 was inspired by suckmerge by HexDSL. This script has functionality
# to merge selected branches, make, & make install.

# Options:
# -d for debugging. Merge all selected branches and make only.
# -i for installing. Merge all selected branches, make, & make install

# Usage:
# $ suckmerge2 -[i/d]

# Legend:
# n    => branch without config
# n*   => branch with config on config branch
# n :  => branch has merge with other branch (patch^n : n stack patches)
# n <- => latest branch on the fleet

# For dwm
dwm_branches = [
  'config',            # 1*  : nodmenu
  'sticky',            # 19*
  'wasfocus',          # 20  : sticky
  'ru-gaps',           # 17* : cfacts, noborder
  'cfacts',            # 15*
  'cfacts-dragcfact',  # 16* : cfacts
  'actualfullscreen',  # 13* : sticky
  'xrdb',              # 3*
  'pertag',            # 2
  'noborder',          # 11
  'movestack',         # 8*
  'moveresize',        # 9*
  'resizecorners',     # 6
  'focusonnetactive',  # 7
  'focusonclick',      # 24* : moveresize
  'fixborders',        # 25
  'scratchpad',        # 13*
  'zoomswap',          # 4
  'autostart',         # 26  : zoomswap
  'savefloats',        # 28
  'center',            # 29  : savefloats, wasfocus^1
  'ru-bottomstack',    # 18*
  'statusallmons',     # 12
  'ru-fibonacci',      # 27*
  'warp',              # 32
  'nmaster-sym',       # 30  : pertag, cfacts-dragcfact^1, warp
  'movethrow',         # 33* : moveresize
  'status2d',          # 34  : autostart, statusallmons, focusonclick
  'focusmaster',       # 35*
  'resetlayout',       # 36* : noborder
  'ru-centeredmaster', # 37*
  'aspectresize',      # 38* <-
]

# Define dir_name based on cwd
dir_name = `basename $PWD`.strip
if dir_name == 'dwm'
  branches = dwm_branches
else
  puts 'You are not in Suckless directory!'
  exit
end

def clean_reset
  puts '=> Convert All Branch to Diff'
  system 'suckclean && git reset --hard origin/master'
  puts '=> Converting COMPLETE!'
end

def clean_diff_reset
  puts '=> Convert All Branch to Diff'
  system 'suckclean && suckdiff && git reset --hard origin/master'
  puts '=> Converting COMPLETE!'
end

def merge_selected(branches)
  puts "\n=> Patching All Branch to Master"
  branches.each do |branch|
    print "Patching #{branch}... "
    system "git merge #{branch} -m #{branch}"
    print "DONE\n"
    puts
  end
  puts '=> Patching COMPLETE!'
end

def make_only
  puts "\n=> Making"
  system 'make'
  puts '=> Making COMPLETE!'
end

def make_install
  puts "\n=> Installing"
  system 'make && sudo make clean install'
  puts '=> Installation COMPLETE!'
end

def option_for_debugging(branches)
  puts "
+-----------------------+
| SUCKMERGE2: DEBUGGING |
+-----------------------+
  "
  sleep 1
  clean_reset
  merge_selected(branches)
  make_only
end

def option_for_installing(branches)
  puts "
+------------------------+
| SUCKMERGE2: INSTALLING |
+------------------------+
  "
  sleep 1
  clean_diff_reset
  merge_selected(branches)
  make_install
end

option = ARGV[0]

if option == '-d'
  option_for_debugging(branches)
elsif option == '-i'
  option_for_installing(branches)
else
  puts "\nERROR: You enter the wrong option!"
  puts "
Options:
  -d for debugging  - Merge all selected branches and make only.
  -i for installing - Merge all selected branches, make, & make install

Usage:
  $ suckmerge2 -[d/i]
  "
  puts '  Or,'
  puts
  puts '  Press (d) for debugging'
  puts '  Press (i) for installing'
  print "\n=> "
  second_option = gets.chomp
  if second_option == 'd'
    option_for_debugging(branches)
  elsif second_option == 'i'
    option_for_installing(branches)
  else
    puts "\nERROR: You enter the wrong option!"
    exit
  end
end

if dir_name == 'dwm' && (option == '-i' || second_option == 'i')
  puts "
  +----------------------------------------------------------------------+
  | STATUSBAR:                                                           |
  +----------------------------------------------------------------------+
  | Bandithijo's DWM doesn't bring the status bar.                       |
  | You should bring your own. My recommendation is dwmblocks.           |
  | But, I prefer built my own status.                                   |
  |                                                                      |
  | Sample: https://s.id/bandithijo-dwmbar                               |
  +----------------------------------------------------------------------+
  +----------------------------------------------------------------------+
  | KEYBOARD:                                                            |
  +----------------------------------------------------------------------+
  | Bandithijo's DWM doesn't bring the keyboard shortcut for apps.       |
  | You should bring your own. My personal preferences are use SXHKD.    |
  |                                                                      |
  | Sample: https://s.id/bandithijo-sxhkdrc-dwm                          |
  +----------------------------------------------------------------------+
  +----------------------------------------------------------------------+
  | AUTOSTART:                                                           |
  +----------------------------------------------------------------------+
  | BanditHijo's DWM use autostart patch. But I modified the path.       |
  | Please, provide the autostart file on:                               |
  | ~/.local/bin/autostart.sh                                            |
  |                                                                      |
  | And the other one:                                                   |
  | ~/.local/bin/autostart_blocking.sh (just empty file)                 |
  |                                                                      |
  | Don't forget to make all of them as executeable file, with:          |
  | $ chmod +x ~/.local/bin/autostart*.sh                                |
  |                                                                      |
  | Sample: https://s.id/bandithijo-autostart                            |
  +----------------------------------------------------------------------+
  "
end
{% endhighlight %}

Cara penggunannya gampang. Saya akan tuliskan dalam bentuk runutan.

1. Setelah selesai meracik *patch* di dalam masing-masing branch, kembali ke master branch.
2. Jalankan [`suckmerge2`](https://github.com/bandithijo/sucklessthing/){:target="_blank"}*
3. Apabila berhasil, restart dwm.
4. Saat ini master branch dalam keadaan "kotor", jalankan [`suckclean`](https://github.com/bandithijo/sucklessthing/){:target="_blank"}* untuk mereset dan membersihkannya.
5. Untuk mengedit *patch* branch dengan cara `git checkout <nama_branch>`, wajib menjalankan `suckclean` terlebih dahulu.

\*Klik untuk download

Apabila terdapat perubahan di dalam branch *patch*, ulangi lagi dari langkah pertama. Mudah bukan?

<br>
**Apakah akan terdapat conflict?**

Jelas! Pasti akan ada kalau kita menggunakan banyak *patch*.

Biasanya kalau terjadi *conflict*, saya selesaikan dengan me-*merge*-kan kedua *patch* branch yang berkonflik, lalu saya selesaikan baris-baris kode yang *conflict* dengan cara manual.

Bisa dilihat, beberapa *patch* branch yang berkonflik pada script **suckmerge2** di atas, saya catat branch apa dan merge dengan branch apa saja.

Nah, berikut ini adalah tangkapan layar dari DWM yang saat ini saya pergunakan.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/8kyg5LVJ/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 1 - RicingShow: DeWayEm Project 2020-05</p>

Repositorinya dapat dilihat [di sini](https://github.com/bandithijo/dwm){:target="_blank"}.

# Tambahan

## Patch from User

**sracthpad by Gaspar Vardanyan**

Sejauh yang saya ingat, ada satu *patch* yang saya gunakan namun bukan dari halaman website suckless. Yaitu [**GasparVardanyan/dwm-scratchpad**](https://github.com/GasparVardanyan/dwm-scratchpad){:target="_blank"}.

*Patch* scratchpad ini berbeda dengan scratchpad yang ada pada website suckless. Perilaku dari scratphad ini mirip dengan yang ada di i3WM. Dimana, window yang dijadikan scratphad akan memiliki kemampuan untuk menghilang dan muncul kembali, layaknya seorang ninja -- apasih wkwk.

<br>
**centerkeybinding by fake_larry**

Patch ini memungkinkan kita untuk memindahkan floating window ke posisi tengah dari screen.

Saya mendapatkan patch ini dari post Reddit yang berjudul ["dwm center floating window with multiple monitors"](https://www.reddit.com/r/suckless/comments/cphe3h/dwm_center_floating_window_with_multiple_monitors/){:target="_blank"}.

Di dalam post tersebut, terdapat balasan dari user yang bernama **fake_larry**, dan memberikan jawaban berupa blok kode dari sebuah patch.

Kalian dapat menyalin patch tersebut atau dapat mendownload versi yang sudah saya jadikan file [di sini](https://github.com/bandithijo/sucklessthing/blob/master/patches/dwm/dwm-centerkeybinding-20190813-4adc917.diff){:target="_blank"}.

## Personal Branch

### config branch
Saya membuat branch yang isinya kurang lebih seperti personal konfigurasi untuk menampung beberapa pengaturan seperti font, border, gap, window rules, dan keybind.

Jadi, saya menambahkan 1 branch yang bukan termasuk dwm *patch*, yaitu:

Branch ini berisi konfigurasi global, seperti font, border, gaps, warn, dll yang sebagian besar berada pada file **config.def.h** atau **dwm.c**.

{% box_info %}
<p markdown=1>Hanya sekedar saran. Apabila di dalam <i>patch</i> terdapat patch yang mengarahkan ke file **config.def.h**, sebaiknya tidak perlu diikutkan dan langsung dipindahkan ke **branch config** pada file **config.def.h**.</p>
{% endbox_info %}

Berikut ini adalah ilustrasi isi dari branch **config**.

File **config.mk**.

{% highlight_caption config.mk %}
{% highlight c linenos %}
// ...
// ...
X11INC = /usr/local/include
X11LIB = /usr/local/lib
{% endhighlight %}

File **config.def.h**.

{% highlight_caption config.def.h %}
{% highlight c linenos %}
// ...
// ...
static const unsigned int snap      = 5;        /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static int showsystray                   = 0;   /* 0 means no systray */

// ...
static const char *fonts[]          = { "FuraCode Nerd Font:style=Medium:size=8" };
static const char dmenufont[]       = "FuraCode Nerd Font:style=Medium:size=8";

// ...
    { MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = -1 } },

// ...
// ...

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    /* class                  instance              title                         tags mask     iscentered     isfloating      monitor */
    // Non FLoating
    { "Gimp-2.10",            NULL,                 NULL,                         0,            1,             0,              -1 },
    { "firefox",              NULL,                 NULL,                         2,            1,             0,              -1 },
    { "Chromium-browser",     NULL,                 NULL,                         2,            1,             0,              -1 },
    { "TelegramDesktop",      NULL,                 NULL,                         1 << 7,       1,             0,              -1 },
    { "Thunderbird",          NULL,                 NULL,                         1 << 6,       1,             0,              -1 },
    { "Hexchat",              NULL,                 NULL,                         1 << 5,       1,             0,              -1 },
    { "mpv",                  NULL,                 NULL,                         0,            1,             0,              -1 },
    { NULL,                   "libreoffice",        NULL,                         0,            1,             0,              -1 },
    { "Thunar",               "thunar",             NULL,                         1 << 2,       1,             0,              -1 },
    { "St",                   NULL,                 "neomutt",                    1 << 6,       1,             0,              -1 },
    { "St",                   NULL,                 "ranger",                     1 << 2,       1,             0,              -1 },
    { "St",                   NULL,                 "newsboat",                   1 << 5,       1,             0,              -1 },
    { "St",                   NULL,                 "WeeChat",                    1 << 5,       1,             0,              -1 },
    { "Transmission-gtk",     NULL,                 NULL,                         1 << 5,       1,             0,              -1 },
    { "Postbird",             NULL,                 NULL,                         0,            1,             0,              -1 },
    // Floating
    { "St",                   NULL,                 "st+",                        0,            1,             1,              -1 },
    { "copyq",                NULL,                 NULL,                         0,            1,             1,              -1 },
    { "Arandr",               NULL,                 NULL,                         0,            1,             1,              -1 },
    { "Gcolor3",              NULL,                 "Color picker",               0,            1,             1,              -1 },
    { "Gnome-calculator",     NULL,                 "Calculator",                 0,            1,             1,              -1 },
    { "Hexchat",              NULL,                 "Network List - HexChat",     1 << 5,       1,             1,              -1 },
    { "SimpleScreenRecorder", NULL,                 NULL,                         0,            1,             1,              -1 },
    { "Soffice",              NULL,                 "Print",                      0,            1,             1,              -1 },
    { "Chrome",               NULL,                 "Save File",                  2,            1,             1,              -1 },
    { "Barrier",              NULL,                 NULL,                         0,            1,             1,              -1 },
    { "Soffice",              "soffice",            NULL,                         0,            1,             0,              -1 },
    { "Thunar",               "thunar",             "File Operation Progress",    0,            1,             1,              -1 },
    { "System-config-printer.py", NULL,             NULL,                         0,            1,             1,              -1 },
    { "Nm-connection-editor", NULL,                 "Network Connections",        0,            1,             1,              -1 },
    { "Pavucontrol",          NULL,                 NULL,                         0,            1,             1,              -1 },
    { "Gpick",                NULL,                 NULL,                         0,            1,             1,              -1 },
    { "vokoscreen",           NULL,                 NULL,                         0,            1,             1,              -1 },
    { "Blueman-manager",      NULL,                 NULL,                         0,            1,             1,              -1 },
    { "Xsane",                NULL,                 "No devices available",       0,            1,             1,              -1 },
    { "scrcpy",               NULL,                 NULL,                         0,            1,             1,              -1 },
    { "GParted",              NULL,                 NULL,                         0,            1,             1,              -1 },
    { "zoom",                 NULL,                 "Question and Answer",        0,            1,             1,              -1 },
    { "guvcview",             NULL,                 "Guvcview  (8.32 fps)",       0,            1,             1,              -1 },
    // Scratchpad
    { NULL,                   NULL,                 "hidden",       scratchpad_mask,            0,             1,              -1 },
};

// ...
// ...

static Key keys[] = {
    /* modifier                     key        function        argument */
    // ...
    // ...
    { MODKEY|ShiftMask,             XK_b,      togglesystray,  {0} },
    // ...
    // ...
    { MODKEY,                       XK_s,      togglesticky,   {0} },
    { MODKEY,                       XK_0,      view,           {.ui = ~scratchpad_mask } },
    { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~scratchpad_mask } },
    // ...
    // ...
    { MODKEY,                       XK_minus, scratchpad_show, {0} },
    { MODKEY|ShiftMask,             XK_minus, scratchpad_hide, {0} },
    { MODKEY|ControlMask,           XK_minus,scratchpad_remove,{0} },

    // Custom Keys
    /* modifier                     key                        function        argument */
    { MODKEY|ControlMask,           XK_Return,                 spawn,          SHCMD("st -T 'st+'") },
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
{% endhighlight %}

{% box_info %}
<p markdown="1">Saat ini (2020/09/17), saya sudah tidak lagi mendefinisikan **Custom Keys** di config.def.h yang ada di branch config.</p>
<p markdown="1">Saya memindahkan, semua *custom keys* tersebut ke **SXHKD**.</p>
<p markdown="1">Tujuannya, agar saat ingin dimodifikasi, tidak perlu mengcompile ulang dwm.</p>
<p markdown="1">Selain itu, juga lebih mudah untuk pengaturan fungsi toggling.</p>
{% endbox_info %}


## Status Bar

Seperti yang teman-teman ketahui, sebelumnya saya menggunakan Polybar. Namun, setelah migrasi menggunakan DWM, saya memutuskan untuk putus dengan Polybar dan memilih untuk meracik bar sendiri, tujuannya agar lebih sederhana.

Saya juga hanya menggunakan top bar saja, yang sebelumnya saya menggunakan top dan bottom bar. Dengan alasan, lagi-lagi untuk meminimalisir proses yang berlangsung. Karena saya hanya menggunakan top bar, artinya terdapat beberapa module yang saya tidak gunakan, seperti module CPU dan Brightness. Module CPU tidak saya pergunakan lagi karena saya sudah merujuk pada indikator suhu.

Nah, seperti ini tampilan bar yang saya pergunakan sekarang.

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/4NNsVpvT/gambar-02.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 2 - dwmsatus (custom made)</p>

Saya membuat file bernama `~/.local/bin/dwmstatus`. Dan tambahkan *execute permission* `$ chmod +x dwmstatus`.

{% highlight_caption $HOME/.local/bin/dwmstatus %}
{% highlight bash linenos %}
#!/usr/bin/env bash

# For dwmstatus
while true; do
    xsetroot -name " $($HOME/bin/network-wlan-tfc.sh) $($HOME/bin/cpu-temp.sh) $($HOME/bin/memory.sh) $($HOME/bin/filesystem.sh) $($HOME/bin/volume.sh) $(date +" 0%u%y%m%d%H%M") $($HOME/bin/bat-state.sh) $($HOME/bin/bat-capacity.sh)  BANDITHIJO "
    sleep 1
done
{% endhighlight %}

Seperti yang teman-teman lihat, isinya adalah pemanggilan terhadap script lain atau saya sebut saja sebagai module. Saya akan jabarkan di sini masing-masing module tersebut.

{% box_perhatian %}
<p>Kode-kode di bawah ini, karena keterbatasan dari Blog, sehingga tidak dapat menampilkan simbol-simbol seperti yang ada pada screenshot Gambar 2.</p>
{% endbox_perhatian %}

<br>
**network-wlan-tfc.sh** - Created by: BanditHijo

{% highlight_caption network-wlan-tfc.sh %}
{% highlight bash linenos %}
#!/bin/sh

wlan_card='wlan0'

wlanmon_card=$(ip a s | grep $wlan_card'mon' | awk 'NR%1==0 {print $2}' | sed 's/://g')
if [ $wlanmon_card ]; then
    printf " MONITOR"
fi

wlan_online=$(iw $wlan_card link | grep 'Connected' | awk 'NR%1==0 {print $1}')
wlan_offline=$(iw $wlan_card link | grep 'Not' | awk 'NR%1==0 {print $1}')
internet=$(wget -qO- ifconfig.co)
internet_logo=""
if [ $internet ]; then
    internet_logo=" "
else
    internet_logo=" "
fi

if [ $wlan_online ]; then
    wlan_do=$(ifstat2 -i $wlan_card 1 1 | awk 'NR%3==0 {print $1}')
    wlan_up=$(ifstat2 -i $wlan_card 1 1 | awk 'NR%3==0 {print $2}')
    printf "$internet_logo %5s  %5s\\n" \
    $(numfmt --to=none $wlan_do) \
    $(numfmt --to=none $wlan_up)
elif [ $wlan_offline ];then
    printf " OFFLINE"
else
    printf " NOADPTR"
fi
{% endhighlight %}

Saya menggunakan [**aur/ifstat**](https://aur.archlinux.org/packages/ifstat/){:target="_blank"}.

<br>
**cpu-temp.sh** - Created by: BanditHijo

{% highlight_caption cpu-temp.sh %}
{% highlight bash linenos %}
#!/bin/sh

icon=""
get_temp_cpu0=$(cat /sys/class/thermal/thermal_zone0/temp)
temp_cpu0=$(($get_temp_cpu0/1000))
if [ $temp_cpu0 -ge 90 ]; then
    printf "$icon $temp_cpu0°C!"
else
    printf "$icon $temp_cpu0°C"
fi
{% endhighlight %}

<br>
**memory.sh** - Created by: BanditHijo

{% highlight_caption memory.sh%}
{% highlight bash linenos %}
#!/bin/sh

icon=""
mem_total=$(free -m | awk 'NR%2==0 {print $2}')
mem_avail=$(free -m | awk 'NR%2==0 {print $7}')
mem_used=$(( $mem_total - $mem_avail ))
mem_usage=$(( $mem_used * 100 / $mem_total ))
if [ $mem_usage -ge 80 ]; then
    printf "$icon ${mem_usage//%}!"
else
    printf "$icon ${mem_usage//%}"
fi
{% endhighlight %}

<br>
**filesystem.sh** - Created by: BanditHijo

{% highlight_caption filesystem.sh %}
{% highlight bash linenos %}
#!/bin/sh

icon=""
cap_percentage=$(df -h --output=pcent / | awk 'NR%2==0 {print $0}'  | cut -f 1 -d '%'  | xargs)
printf "$icon $cap_percentage"
{% endhighlight %}

<br>
**volume.sh** - Created by: BanditHijo

{% highlight_caption volume.sh %}
{% highlight bash linenos %}
#!/bin/sh

# PulseAudio
ou_mute=$(pamixer --get-mute)
in_mute=$(pamixer --source 1 --get-mute)
ou_vol=$(pamixer --get-volume)
in_vol=$(pamixer --source 1 --get-volume)
jack_stat=$($HOME/.local/bin/has_headphone)

if   [ $jack_stat = "yes" ]; then
    icon_ou_on=""
    icon_ou_off=""
elif [ $jack_stat = "no"  ]; then
    icon_ou_on=""
    icon_ou_off=""
fi
icon_in_on=""
icon_in_off=""

if   ([ $ou_mute = "true"  ] || [ $ou_mute = "off" ]) && ([ $in_mute = "true"  ] || [ $in_mute = "off" ]); then
    printf "$icon_ou_off Ø $icon_in_off Ø"
elif ([ $ou_mute = "true"  ] || [ $ou_mute = "off" ]) && ([ $in_mute = "false" ] || [ $in_mute = "on"  ]); then
    printf "$icon_ou_off Ø $icon_in_on $in_vol"
elif ([ $ou_mute = "false" ] || [ $ou_mute = "on"  ]) && ([ $in_mute = "true"  ] || [ $in_mute = "off" ]); then
    printf "$icon_ou_on $ou_vol $icon_in_off Ø"
elif ([ $ou_mute = "false" ] || [ $ou_mute = "on"  ]) && ([ $in_mute = "false" ] || [ $in_mute = "on"  ]); then
    printf "$icon_ou_on $ou_vol $icon_in_on $in_vol"
else
    printf "$icon_ou_off ERROR"
fi
{% endhighlight %}

{% highlight_caption $HOME/.local/bin/has_headphone %}
{% highlight bash linenos %}
#!/bin/sh

# PulseAudio
pacmd list-sinks | grep 'Headphones' | awk '{print $10}' | tr -d ')'
{% endhighlight %}

<br>
**bat-state.sh** - Created by: BanditHijo

{% highlight_caption bat-state.sh%}
{% highlight bash linenos %}
#!/bin/sh

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
{% endhighlight %}

<br>
**bat-capacity.sh** - Created by: BanditHijo

{% highlight_caption bat-capacity.sh %}
{% highlight bash linenos %}
#!/bin/sh

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
{% endhighlight %}

## Autorun

{% box_info %}
<p markdown="1">**2020/09/20**, menggunakan autostart patch 20200610-cb3f58a.diff.</p>
<p>Dan juga menggunakan .xinitrc untuk menjalankan beberapa program yang saya perlukan saat startup.</p>
{% endbox_info %}

Saya menggunakan *patch* autostart untuk menghandle program-program autorun yang dinamis. Yang saya maksudkan sebagai dinamis adalah konfigurasi program mungkin akan mengalami modifikasi sehingga memungkinkan untuk direload ulang ditengah-tengah session.

Kalau hanya menggunakan .xinitrc, tentunya perlu restart session (logout). Namun, dengan patch autostart, kita hanya perlu reload dwm saja.

{% highlight_caption dwm.c %}
{% highlight c linenos %}

// ...
// ...

/* variables */
static const char autostartblocksh[] = "autostart_blocking.sh";
static const char autostartsh[] = "autostart.sh";
static const char broken[] = "broken";
static const char dwmdir[] = "dwm";
static const char localshare[] = ".local/share";
static char stext[256];
static int screen;
// ...
// ...
{% endhighlight %}

Perhatikan baris 8 dan 9, disanalah tempat kita akan meletakkan file **autostart.sh** dan **autostart_blocking.sh**.

{% shell_user %}
mkdir -p ~/.local/share/dwm
touch ~/.local/share/dwm/autostart_blocking.sh
touch ~/.local/share/dwm/autostart.sh
{% endshell_user %}

Dan ini adalah isi dari file `autostart.sh` yang saya pergunakan.

{% highlight_caption $HOME/.local/share/dwm/autostart.sh %}
{% highlight bash linenos %}
#!/bin/sh

pkill -f "slstatus"; slstatus &
pkill -f "sxhkd"; sxhkd -c ~/.config/sxhkd/sxhkdrc-dwm &
pkill -f "dunst"; dunst -config ~/.config/dunst/dunstrc &
pkill -f "unclutter"; unclutter --timeout 3 &
pkill -f "notify-hightemp"; notify-hightemp &
pkill -f "bash /usr/bin/clipmenud"; pkill -f "clipnotify"; clipmenud &
pkill -f "flameshot"; flameshot &
pkill -f "xcompmgr"; xcompmgr &
pkill -f "lxpolkit"; lxpolkit &
{% endhighlight %}

**autostart_blocking.sh** saya kosongin.

Kemudian, ini adalah isi dari **xinitrc** yang berhubungan dengan dwm.

{% highlight_caption $HOME/.xinitrc %}
{% highlight bash linenos %}
#!/bin/sh

## Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
export SSH_AUTH_SOCK

# Autostart (STAIC)
xsetroot -solid "#1E1E1E"
feh --bg-fill -Z $WALLPAPER2
xinput set-button-map "TPPS/2 IBM TrackPoint" 1 0 3

# Autostart (DYNAMIC)
sanitizer
slstatus &
sxhkd -c ~/.config/sxhkd/sxhkdrc-dwm &
dunst -config ~/.config/dunst/dunstrc &
unclutter --timeout 3 &
notify-hightemp &
clipmenud &
flameshot &
clipmenud &
xcompmgr &
lxpolkit &

# For dwm
while true; do
   # Log stderror to a file
   /usr/local/bin/dwm 2> ~/.dwm.log
done
{% endhighlight %}


# Instalasi

Saya menyimpan konfigurasi yang sudah saya buat dalam bentuk branch kemudian saya simpan di GitHub.

Bisa teman-teman lihat [di sini](https://github.com/bandithijo/dwm){:target="_blank"}.

Cara pasangnya sangat mudah.

{% shell_user %}
git clone https://github.com/bandithijo/dwm.git $HOME/.config/dwm
cd $HOME/.config/dwm
{% endshell_user %}

Kalau kita menjalankan,

{% shell_user %}
git branch
{% endshell_user %}

Maka yang ada hanya branch Master.

Kita perlu melakukan `git checkout` ke setiap branch. Karena saya adalah orang yang malas, maka saya memilih untuk membuat script automatis saja. Hehe.

Saya beri nama **suckchkout**.

Versi terbaru dari **suckchkout** dapat teman-teman temukan [di sini](https://github.com/bandithijo/sucklessthing/blob/master/suckchkout){:target="_blank"}

{% highlight_caption suckchkout %}
{% highlight ruby linenos %}
#!/usr/bin/env ruby

branch_list = `git branch -a`
rejected_items = %w[* master remotes/origin/HEAD remotes/origin/master origin/master ->]
branches = branch_list.split(' ').reject { |n| rejected_items.include? n }.map { |n| n.gsub('remotes/origin/', '') }

puts "\n=> Checkout each branch to Local"
branches.each do |branch|
  print "Checkout #{branch}..."
  %x(`git checkout #{branch} > /dev/null 2>&1`)
  print "DONE\n"
end
%x(`git checkout master > /dev/null 2>&1`)
puts '=> All Checkout COMPLETE!'
{% endhighlight %}

Jangan lupa buat menjadi executeable.

{% shell_user %}
chmod +x suckchkout
{% endshell_user %}

Lalu jalankan.

Kalau berhasil, hasilnya akan seperti ini.

```
=> Check Out each branch to Local
Checkout actualfullscreen... DONE
Checkout autostart... DONE
Checkout center... DONE
Checkout cfacts... DONE
Checkout config... DONE
Checkout deck... DONE
Checkout focusonnetactive... DONE
Checkout movestack... DONE
Checkout pertag... DONE
Checkout resizecorners... DONE
Checkout rmaster... DONE
Checkout savefloats... DONE
Checkout scratchpad-gaspar... DONE
Checkout sticky... DONE
Checkout systray... DONE
Checkout zoomswap... DONE
=> All Check Out COMPLETE!
```

Nah, kalo sudah bisa check menggunakan `git branch`.

Apabila sudah keluar semua daftar branch, tinggal jalankan script **suckmerge2**.

```
=> Convert All Branch to Patch
Already on 'master'
Your branch is up to date with 'bandithijo/master'.
rm -f dwm drw.o dwm.o util.o dwm-6.2.tar.gz
HEAD is now at 61bb8b2 Fix x coordinate calculation in buttonpress.
HEAD is now at 61bb8b2 Fix x coordinate calculation in buttonpress.
=> Converting COMPLETE!

=> Patching All Branch to Master
Patching config... Updating 61bb8b2..b821139
Fast-forward (no commit created; -m option ignored)
 config.def.h | 191 ++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 151 insertions(+), 40 deletions(-)
DONE
Patching sticky... Merge made by the 'recursive' strategy.
 dwm.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)
DONE
...
...
=> Installation COMPLETE!

  +----------------------------------------------------------------------+
  | STATUSBAR:                                                           |
  +----------------------------------------------------------------------+
  | Bandithijo's DWM doesn't bring the status bar.                       |
  | You should bring your own. My recommendation is dwmblocks.           |
  | But, I prefer built my own status.                                   |
  |                                                                      |
  | Sample: https://s.id/bandithijo-dwmbar                               |
  +----------------------------------------------------------------------+
  +----------------------------------------------------------------------+
  | KEYBOARD:                                                            |
  +----------------------------------------------------------------------+
  | Bandithijo's DWM doesn't bring the keyboard shortcut for apps.       |
  | You should bring your own. My personal preferences are use SXHKD.    |
  |                                                                      |
  | Sample: https://s.id/bandithijo-sxhkdrc-dwm                          |
  +----------------------------------------------------------------------+
  +----------------------------------------------------------------------+
  | AUTOSTART:                                                           |
  +----------------------------------------------------------------------+
  | BanditHijo's DWM use autostart patch. But I modified the path.       |
  | Please, provide the autostart file on:                               |
  | ~/.local/bin/autostart.sh                                            |
  |                                                                      |
  | And the other one:                                                   |
  | ~/.local/bin/autostart_blocking.sh (just empty file)                 |
  |                                                                      |
  | Don't forget to make all of them as executeable file, with:          |
  | $ chmod +x ~/.local/bin/autostart*.sh                                |
  |                                                                      |
  | Sample: https://s.id/bandithijo-autostart                            |
  +----------------------------------------------------------------------+
```

Perhatikan pesan yang sudah saya berikan mengenai statusbar, keyboard, dan autostart.


# Pesan Penulis

Pasti tulisan ini akan kadaluarsa dan ketinggalan update terabru dari yang saya lakukan.

Untuk mendapatkan versi update terbaru, kalian dapat langsung mengunjungi beberapa GitHub repo yang saya pergunakan.

1. [**dwm**](https://github.com/bandithijo/dwm){:target="_blank"}

    Repo ini adalah repo master dari dwm namun berisi branch-branch yang sudah dipatch. Gunakan **suckmerge2** untuk melakukan compile agar proses membangun dwm menjadi lebih mudah.

2. [**sucklessthing**](https://github.com/bandithijo/sucklessthing/){:target="_blank"}

    Repo ini berisi script-script yang saya pergunakan untuk membangun/membuild/mengcompile suckless tools seperti dwm, dmenu, slstatus, dll.

    Repo ini juga berisi daftar patch yang saya pergunakan.

3. [**dmenu**](https://github.com/bandithijo/dmenu){:target="_blank"}

    Repo ini berisi master dmenu dengan branch config yang sudah saya modifikasi.

4. [**slstatus**](https://github.com/bandithijo/slstatus){:target="_blank"}

    Repo ini berisi master slstatus dengan branch config yang sudah saya modifikasi.






# Referensi

1. [suckless.org/](http://suckless.org/){:target="_blank"}
<br>Diakses tanggal: 2020/04/24

2. [dwm.suckless.org/](https://dwm.suckless.org/){:target="_blank"}
<br>Diakses tanggal: 2020/04/24
