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
contributors: []
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

Dengan beberapa alasan tersebut, selama tulisan ini dibuat saya ~~hanya~~ menggunakan 24 *patches*. yaitu:

1. actualfullscreen
2. autostart
3. canfocusrule
4. center
5. centerkeybinding
6. cfacts
7. config
8. dwmc
9. focusonnetactive
10. moveresize
11. movestack
12. noborder
13. pertag
14. resizecorners
15. ru-gaps
16. savefloats
17. scratchpad-gaspar
18. statusallmons
19. sticky
20. systray
21. xrdb
22. zoomswap

Saya meracik semua *patches* tersebut menjadi Git branches. Masing-masing *patch*, memiliki satu branch. Setelah itu, untuk mengcompila mejadi dwm yang utuh, saya menggunakan bantuan beberapa script. Script ini bertugas mengautomatisasi proses yang berulang-ulang. Tujuannya jelas untuk mempermudah saya agar tidak kelelahan berlama-lama depan laptop.

## Bagaimana Cara Patching?

Seperti yang dijelaskan pada website [suckless.org/hacking](https://suckless.org/hacking/){:target="_blank"}. Terdapat 2-3 cara.
Namun, karena saya menggunakan git, maka, saya akan memanfaatkan cara *patching* menggunakan git.

**Menggunakan Git Apply**

<pre>
$ <b>git apply path/to/patch.diff</b>
</pre>

Nah, kalau cara pertama tidak berhasil, lakukan cara manual.

**Manual Patching**

Biasanya manual patching dilakukan apabila patching tersebut tidak dibuat dengan versi master yang sama dengan master yang kita miliki.

Manula patching adalah melakukan patching dengan meng-copy-kan baris demi baris yang ada di dalam *patch* ke dalam file-file yang berkaitan di dalam direktori dwm kita.


<br>

Nah! untuk mempermudah proses *compiling*, saya menggunakan bantuan beberapa script.

Berikut ini daftar script yang saya gunakan.

1. **suckclean** : untuk mereset master
2. **suckdiff** : untuk membuat backup branch dalam bentuk *patch* yang tersimpan di `~/.config/suckless/`
3. **suckmerge2** : untuk me-*merge*-kan branch-branch terpilih ke master branch, sekaligus mengcompilenya

Nah, berikut ini adalah isi dari script-script tersebut.

# Suckless Script

**suckclean** - Created by: HexDSL

{% highlight bas linenos %}
#!/usr/bin/env bash

make clean &&
rm -f config.h && git reset --hard origin/master
{% endhighlight %}

**suckdiff** - Created by: HexDSL

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

**suckmerge2** - Created by: BanditHijo | versi terbaru [di sini](https://github.com/bandithijo/sucklessthing/blob/master/suckmerge2){:target="_blank"}

{% highlight ruby linenos %}
#!/usr/bin/env ruby

# For dwm
dwm_branches = [
  'config',                # merge w/: actualfullscreen, scratchpad-gaspar
  'sticky',                # merge w/: actualfullscreen, center
  'canfocusrule',          # merge w/: systray
  'actualfullscreen',
  'xrdb',
  'noborder',
  'autostart',
  'movestack',
  'moveresize',
  'pertag',
  'resizecorners',
  'focusonnetactive',
  'systray',               # merge w/: scratchpad-gaspar, zoomswap, sticky
  'scratchpad-gaspar',
  'zoomswap',
  'savefloats',
  'centerkeybinding',
  'center',
  'cfacts',
  'dwmc',                  # merge w/: systray
  'statusallmons',         # merge w/: systray
  'ru-gaps',               # merge w/: noborder, cfacts
]

dir_name = `basename $PWD`.strip
if dir_name == 'dwm'
  branches = dwm_branches
else
  puts 'You are not in suckless directory!'
  exit
end

puts '=> Convert All Branch to Patch'
system '''
suckdiff &&
git reset --hard origin/master
'''
puts '=> Converting COMPLETE!'

puts "\n=> Patching All Branch to Master"
branches.each do |branch|
  print "Patching #{branch}... "
  `git merge #{branch} -m #{branch}`
  print "DONE\n"
end
puts '=> Patching COMPLETE!'

puts "\n=> Installing"
%x(`make && sudo make clean install`)
puts '=> Installation COMPLETE!'
{% endhighlight %}

Cara penggunannya gampang. Saya akan tuliskan dalam bentuk runutan.

1. Setelah selesai meracik *patch* di dalam masing-masing branch, kembali ke master branch.
2. Jalankan [`suckmerge2`](https://github.com/bandithijo/sucklessthing/){:target="_blank"}*
3. Apabila berhasil, restart dwm.
4. Saat ini master branch dalam keadaan "kotor", jalankan [`suckclean`](https://github.com/bandithijo/sucklessthing/){:target="_blank"}* untuk mereset dan membersihkannya.
5. Untuk mengedit *patch* branch dengan cara `git checkout <nama_branch>`, wajib menjalankan `suckclean` terlebih dahulu.

**INFO**: *dapat di-download

Apabila terdapat perubahan di dalam branch *patch*, ulangi lagi dari langkah pertama. Mudah bukan?

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

<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>Hanya sekedar saran. Apabila di dalam <i>patch</i> terdapat pengaturan <i>keys</i>, sebaiknya tidak perlu diikutkan dan langsung dipindahkan ke branch config pada file <b>config.def.h</b>.</p>
</div>

Berikut ini adalah ilustrasi isi dari branch **config**.

File **config.mk**.

{% highlight c linenos %}
// config.mk
...
X11INC = /usr/local/include
X11LIB = /usr/local/lib
{% endhighlight %}

File **config.def.h**.

{% highlight c linenos %}
// config.def.h
...
static const unsigned int snap      = 5;        /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static int showsystray                   = 0;   /* 0 means no systray */

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

...
...

static Key keys[] = {
    /* modifier                     key        function        argument */
    ...
    ...
    { MODKEY|ShiftMask,             XK_b,      togglesystray,  {0} },
    ...
    ...
    { MODKEY,                       XK_s,      togglesticky,   {0} },
    { MODKEY,                       XK_0,      view,           {.ui = ~scratchpad_mask } },
    { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~scratchpad_mask } },
    ...
    ...
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

File **dwm.c**

{% highlight c linenos %}
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
{% endhighlight %}

## Status Bar

Seperti yang teman-teman ketahui, sebelumnya saya menggunakan Polybar. Namun, setelah migrasi menggunakan DWM, saya memutuskan untuk putus dengan Polybar dan memilih untuk meracik bar sendiri, tujuannya agar lebih sederhana.

Saya juga hanya menggunakan top bar saja, yang sebelumnya saya menggunakan top dan bottom bar. Dengan alasan, lagi-lagi untuk meminimalisir proses yang berlangsung. Karena saya hanya menggunakan top bar, artinya terdapat beberapa module yang saya tidak gunakan, seperti module CPU dan Brightness. Module CPU tidak saya pergunakan lagi karena saya sudah merujuk pada indikator suhu.

Nah, seperti ini tampilan bar yang saya pergunakan sekarang.

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/4NNsVpvT/gambar-02.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 2 - dwmsatus (custom made)</p>

Saya membuat file bernama `~/.local/bin/dwmstatus`. Dan tambahkan *execute permission* `$ chmod +x dwmstatus`.

{% highlight bash linenos %}
#!/usr/bin/env bash

# For dwmstatus
while true; do
    xsetroot -name " $($HOME/bin/network-wlan-tfc.sh) $($HOME/bin/cpu-temp.sh) $($HOME/bin/memory.sh) $($HOME/bin/filesystem.sh) $($HOME/bin/volume.sh) $(date +" 0%u%y%m%d%H%M") $($HOME/bin/bat-state.sh) $($HOME/bin/bat-capacity.sh)  BANDITHIJO "
    sleep 1
done
{% endhighlight %}

Seperti yang teman-teman lihat, isinya adalah pemanggilan terhadap script lain atau saya sebut saja sebagai module. Saya akan jabarkan di sini masing-masing module tersebut.

<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
<p>Kode-kode di bawah ini, karena keterbatasan dari Blog, sehingga tidak dapat menampilkan simbol-simbol seperti yang ada pada screenshot Gambar 2.</p>
</div>

<br>
**network-wlan-tfc.sh** - Created by: BanditHijo

{% highlight bash linenos %}
#!/usr/bin/env bash

wlan_card='wlan0'
wlan_online=$(ip a s dev $wlan_card | grep -i inet)
if [[ $wlan_online ]]; then
    wlan_do=$(ifstat2 -i $wlan_card 1 1 | awk 'NR%3==0 {print $1}')
    wlan_up=$(ifstat2 -i $wlan_card 1 1 | awk 'NR%3==0 {print $2}')
    echo "" $wlan_do "" $wlan_up "KB/s"
else
    echo " OFFLINE"
fi
{% endhighlight %}

Saya menggunakan [**aur/ifstat**](https://aur.archlinux.org/packages/ifstat/){:target="_blank"}.

<br>
**cpu-temp.sh** - Created by: BanditHijo

{% highlight bash linenos %}
#!/usr/bin/env bash

get_temp_cpu0=$(cat /sys/class/thermal/thermal_zone0/temp)
temp_cpu0=$(($get_temp_cpu0/1000))
echo " "$temp_cpu0"°C"
{% endhighlight %}

<br>
**memory.sh** - Created by: BanditHijo

{% highlight bash linenos %}
#!/usr/bin/env bash

mem_total=$(free | awk 'NR%2==0 {print $2}')
mem_used=$(free | awk 'NR%2==0 {print $3}')
mem_usage=$(( $mem_used * 100 / $mem_total ))
echo " "$mem_usage"%"
{% endhighlight %}

<br>
**filesystem.sh** - Created by: BanditHijo

{% highlight bash linenos %}
#!/usr/bin/env bash

cap_percentage=$(df -h --output=pcent / | awk 'NR%2==0 {print $0}')
echo ""$cap_percentage
{% endhighlight %}

<br>
**volume.sh** - Created by: BanditHijo

{% highlight bash linenos %}
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
{% endhighlight %}

<br>
**bat-state.sh** - Created by: BanditHijo

{% highlight bash linenos %}
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
{% endhighlight %}

<br>
**bat-capacity.sh** - Created by: BanditHijo

{% highlight bash linenos %}
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
{% endhighlight %}

## Autorun

Saya menggunakan *patch* autostart untuk menghandle program-program yang akan dijalankan pada autorun.

Dan saya merubah *default path* yang diberikan oleh *patch* di alamat `~/.dwm/autostart.sh` menjadi `~/.local/bin/autostart.sh`.

{% highlight c linenos %}
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
{% endhighlight %}

Dan ini adalah isi dari file `autostart.sh` yang saya pergunakan.

{% highlight bash linenos %}
#!/usr/bin/env bash

pkill -f "dwmbar"; dwmbar &
pkill -f "dunst"; dunst -config ~/.config/dunst/dunstrc &
xsetroot -solid "#1E1E1E"
feh --bg-fill -Z $WALLPAPER2
xinput set-button-map "TPPS/2 IBM TrackPoint" 1 0 3
pkill -f "unclutter"; unclutter --timeout 3 &
pkill -f "notify-hightemp"; notify-hightemp &
pkill -f "bash /usr/bin/clipmenud"; pkill -f "clipnotify"; /usr/bin/clipmenud &
/usr/bin/flameshot &
pkill -f "xcompmgr"; xcompmgr &
pkill -f "lxpolkit"; lxpolkit &
{% endhighlight %}

## suckpush script

`suckpush` script adalah script untuk melakukan *push* setiap *commit* yang sudah terjadi pada tiap-tiap *patch* branch di lokal repo ke GitHub repo dengan cara memasuki (*checkout*) ke dalam tiap-tiap *patch* branch dan melakukan *push*.

Berikut ini scriptnya.

**suckpush** - Created by: BanditHijo

Versi terbaru dari **suckpush** dapat teman-teman temukan [di sini](https://github.com/bandithijo/sucklessthing/blob/master/suckpush){:target="_blank"}

{% highlight ruby linenos %}
#!/usr/bin/env ruby

remote_repo = 'bandithijo'

puts '=> Reset the master branch'
system '''
git checkout master
git reset --hard origin/master
'''
puts '=> Reseting COMPLETE!'

branch_list = `git branch`
rejected_items = %w[* master]
branches = branch_list.split(' ').reject { |n| rejected_items.include? n }.unshift('master')

puts "\n=> Push each branch to GitHub"
branches.each do |branch|
  print "Pushing #{branch}... "
  %x(`
  git checkout #{branch}  > /dev/null 2>&1
  git push -u #{remote_repo} #{branch} > /dev/null 2>&1
  `)
  print "DONE\n"
end
%x(`git checkout master > /dev/null 2>&1`)
puts '=> All Pushing COMPLETE!'
{% endhighlight %}

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
Patching config... DONE
Patching sticky... DONE
Patching rmaster... DONE
Patching canfocusrule... DONE
Patching actualfullscreen... DONE
Patching xrdb... DONE
Patching noborder... DONE
Patching autostart... DONE
Patching movestack... DONE
Patching moveresize... DONE
Patching pertag... DONE
Patching resizecorners... DONE
Patching focusonnetactive... DONE
Patching systray... DONE
Patching scratchpad-gaspar... DONE
Patching zoomswap... DONE
Patching savefloats... DONE
Patching centerkeybinding... DONE
Patching center... DONE
Patching cfacts... DONE
Patching deck... DONE
Patching dwmc... DONE
Patching statusallmons... DONE
Patching fullgaps... DONE
=> Patching COMPLETE!

=> Installing
[sudo] password for bandithijo:
usage: dwm [-v]
=> Installation COMPLETE!
```

# Instalasi

Saya menyimpan konfigurasi yang sudah saya buat dalam bentuk branch kemudian saya simpan di GitHub.

Bisa teman-teman lihat [di sini](https://github.com/bandithijo/dwm){:target="_blank"}.

Cara pasangnya sangat mudah.

<pre>
$ <b>git clone https://github.com/bandithijo/dwm.git $HOME/.config/dwm</b>
$ <b>cd $HOME/.config/dwm</b>
</pre>

Kalau kita menjalankan,

<pre>
$ <b>git branch</b>
</pre>

Maka yang ada hanya branch Master.

Kita perlu melakukan `git checkout` ke setiap branch. Karena saya adalah orang yang malas, maka saya memilih untuk membuat script automatis saja. Hehe.

Saya beri nama **suckchkout**.

Versi terbaru dari **suckchkout** dapat teman-teman temukan [di sini](https://github.com/bandithijo/sucklessthing/blob/master/suckchkout){:target="_blank"}

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

<pre>
$ <b>chmod +x suckchkout</b>
</pre>

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
