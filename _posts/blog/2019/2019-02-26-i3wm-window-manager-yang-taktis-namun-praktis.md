---
layout: 'post'
title: 'i3WM, Window Manager yang Taktis namun Praktis'
date: 2019-02-26 20:45
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['I3WM', 'Ulasan', 'Tips']
pin:
hot: true
contributors: []
resume: "i3WM disebut-sebut sebagai Window Manager yang cocok untuk kalian yang baru ingin memulai mengenal dan menggunakan Window Manager. Hal tersebut tidak lain karena i3wm memiliki file configurasi dalam bentuk plain text, sehingga dapat dimengerti meski tanpa pengetahuan tentang bahasa pemrograman. Selain itu, i3wm juga memiliki dokumentasi yang sangat lengkap yang berada di website resminya. Catatan kali ini, saya ingin mencoba membagikan, bagaimana cara saya mengkonfigurasi i3wm."
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Setelah setahun lebih menggunakan **i3** Window Manager (selanjutnya akan saya sebut sebagai i3wm), saya merasa sudah waktunya untuk membagikan pengalaman dalam menggunakan Window Manager yang sekaligus merupakan Window Manager pertama yang saya gunakan sehari-hari.

Berdasarkan daftar log video pada [bandithijo.com/vlog]({{ site.url }}/vlog/){:target="_blank"}, saya menggunakan i3wm pada 30 Oktober 2017.

Saya merasa perlu untuk membuat catatan mengenai apa saja yang sudah saya manfaatkan dan pergunakan dengan i3wm. Mungkin dari catatan ini, teman-teman yang membaca mendapatkan informasi yang subjektif dari sudut pandang saya sebagai pengguna. Jujur saja, saya pun sangat menyukai tulisan-tulisan yang mengulas tentang suatu teknologi dari sudut pandang pengguna.

{% image https://i.postimg.cc/WpHmyggn/gambar-18.png | 18 %}

{% image https://i.postimg.cc/ZqHpxdJ6/gambar-19.png | 19 %}

{% image https://i.postimg.cc/jjtyfXYs/gambar-20.png | 20 %}

{% image https://i.postimg.cc/50P5bFGf/gambar-21.png | 21 %}

{% image https://i.postimg.cc/6QMYz3K4/gambar-22.png | 22 %}

# Window Manager

Buat temen-temen yang belum mengetahui apa itu Window Manager. Window Manager adalah bagian dari Desktop Environment.

Saya akan coba jelaskan dengan menggunakan tabel, *insya Allah* dapat langsung dipahami dengan mudah.

| <center>Desktop Environment</center> | <center>Window Manager</center> |
| --: | :-- |
| GNOME2 | [Metacity](https://www.archlinux.org/packages/community/x86_64/metacity/){:target="_blank"} |
| GNOME3 | [Mutter](https://www.archlinux.org/packages/extra/x86_64/mutter/){:target="_blank"} |
| KDE Plasma | [KWin](https://www.archlinux.org/packages/extra/x86_64/kwin/){:target="_blank"} |
| Cinnamon | [Muffin](https://www.archlinux.org/packages/community/x86_64/muffin/){:target="_blank"} |
| Pantheon | [Gala](https://aur.archlinux.org/packages/gala/){:target="_blank"} |
| Deepin | [Deepin-Mutter](https://www.archlinux.org/packages/community/x86_64/deepin-mutter/){:target="_blank"} |
| XFCE | [xfwm4](https://www.archlinux.org/packages/extra/x86_64/xfwm4/){:target="_blank"} |
| LXDE | [Openbox](https://www.archlinux.org/packages/community/x86_64/openbox/){:target="_blank"} |
| dst... | dst...|

Seperti yang saya sebutkan di awal, Window Manager ini adalah komponen, maka beberapa dari Desktop Environment tersebut ada yang mengijinkan user untuk mengganti Window Manager *default* yang sudah disertakan bersama Desktop Environment. Asik bukan?

Terdapat banyak sekali Window Manager yang dapat kita gunakan, tanpa harus menggunakan Desktop Environment.

## Tipe-tipe Window Manager

Window Manager secara umum, terbagi dalam 3 tipe.

1. **Stacking**, atau *Floating* adalah Window Manager yang seperti Desktop Environment gunakan, yaitu dengan Window yang melayang dan dapat bertumpuk-tumpuk.
2. **Tiling**, adalah Window Manager yang tidak menumpuk Window antara satu dengan yang lain, dan tersusun kotak-kotak seperti lantai (*tile*).
3. **Dynamic**, adalah Window Manager yang dapat berganti-ganti diantara kedua tipe di atas menyesuaikan dengan kebutuhan user.

## Tabel Window Manager

Berikut ini adalah tabel dari Window Manager yang akan memberikan gambaran bahwa GNU/Linux tidak hanya GNOME dan KDE.

| <center>No.</center> | <center>Stacking</center> | <center>Tiling</center> | <center>Dynamic</center> |
| -- | -- | -- | -- |
| 1 | 2bwm | Bspwm | awesome |
| 2 | aewm | EXWM | catwm |
| 3 | AfterStep | Herbstluftwm | dwm |
| 4 | BlackBox | howm | echinus |
| 5 | Compiz | i3 | FrankenWM |
| 6 | cwm | Ion3 | spectrwm |
| 7 | eggwm | Notion | Qtile |
| 8 | Enlightenment | Ratpoison | wmii |
| 9 | evilwm | Stumpwm | xmonad |
| 10 | Fluxbox | subtle |
| 11 | Flwm | sway |
| 12 | FVWM | way-cooler |
| 13 | Gala | WMFS |
| 14 | Goomwwm | WMFS2 |
| 15 | IceWM |
| 16 | jbwm |
| 17 | JWM |
| 18 | Karmen |
| 19 | KWin |
| 20 | lwm |
| 21 | Marco |
| 22 | Metacity |
| 23 | Muffin |
| 24 | Mutter |
| 25 | MWM |
| 26 | Openbox |
| 27 | pawm |
| 28 | PekWM |
| 29 | Sawfish |
| 30 | TinyWM |
| 31 | twm |
| 32 | UWM |
| 33 | Wind |
| 34 | WindowLab |
| 35 | Window Maker |
| 36 | WM2 |
| 37 | Xfwm |

Untuk detail dari masing-masing Window Manager tersebut dapat teman-teman lihat pada Arch Wiki, [di sini](https://wiki.archlinux.org/index.php/Window_manager){:target="_blank"}.

Ada begitu banyak Window Manager, bukan?

i3wm, yang saya gunakan termasuk ke dalam jajaran *Tiling* Window Manager. Meskipun sebenarnya i3wm juga dapat berganti-ganti *layout* menjadi *tiling*, *stacking*, *tabbed*, bahkan *scratchpad*. i3wm juga termasuk dalam *tree based* Window Manager.

**Jadi, mengapa saya menggunakan Window Manager?**

Berdasarkan data-data di atas,

1. Saya ingin mencoba mengenal hal yang baru, selain Desktop Environment. Window Manager adalah dunia berbeda yang ternyata sangat luas sekali. Meskipun tidak mungkin saya cicipi semuanya.
2. Banyak fitur-fitur yang terdapat di dalam Desktop Environment yang sebenarnya tidak saya perlukan.
3. Kebebasan memilih komponen-komponen aplikasi pendukung sistem operasi yang menurut saya lebih baik dari aplikasi pendukung bawaan Desktop Environment.

# i3 Window Manager

## Pertemuan dengan dwm

Berawal dari melihat video-video YouTube dari [Kai Hendry *channel*](https://www.youtube.com/user/kaihendry){:target="_blank"}. Saya memperhatikan bagaimana ia menggunakan **dwm** Window Manager. Pengalaman yang baru pertama kali saya dapati.

Saat itu, kira-kira inilah yang saya ada dibenak saya.

1. Bagaimana bisa ia terlihat sangat mudah dan nyaman berpindah antar satu Workspace ke Workspace menggunakan *keyboard shortcut*?
2. Bagaimana bisa ia begitu terlihat nyaman melakukan window resize hanya dengan menggunakan *keyboard shortcut*?
3. Bagaimana bisa ia tidak direpotkan dengan menyusun Window yang sedang terbuka dalam satu Workspace?
4. Bagaimana bisa window yang terbuka itu tidak saling bertumpuk satu dengan yang lain?

Saya pun mencoba memasang dwm, namun karena belum pernah sama sekali mengerti hal-hal apa saja yang saya perlukan dan saya butuhkan dalam menggunakan Window Manager, saya pun kebingungan memilih *patch* apa yang hendak saya pergunakan. Lantas, saya pun menyerah pada dwm.

## Mencoba Memahami i3wm

Kemudian mengingat-ingat kembali, kalau distribusi Manjaro, beberapa kali selalu memberikan info terbaru seputar Manjaro i3 edition pada blog mereka. Kemudian, saya pun mencoba mencari referensi di YouTube mengenai i3wm.

Setelah beberapa kali melihat video ulasan i3wm dari beberapa user, saya pun memutuskan untuk mempelajarinya terlebih dahulu. Kebetulan terdapat video yang memberikan informasi dasar bagaimana cara menggunakan i3wm.

{% image https://i.postimg.cc/jj641YCy/gambar-01.png | 1 | <a href="https://www.youtube.com/watch?v=j1I63wGcvU4&list=PL5ze0DjYv5DbCv9vNEzFmP6sU7ZmkGzcf" target="_blank">Code Cast - i3wm (Playlist) at YouTube</a> %}

Menurut saya video ini sangat bagus sekali sebagai pondasi awal mengenal i3wm. Video di atas juga termasuk dalam jajaran video yang direkomendasikan oleh website i3wm.org, [di sini](https://i3wm.org/screenshots/){:target="_blank"}.

Saya sarankan untuk dapat mempelajari video-video lain yang direkomendasikan oleh i3wm.org.

{% image https://i.postimg.cc/VNGMbfhs/gambar-02.png | 2 | <a href="https://youtu.be/Wx0eNaGzAZU" target="_blank">i3 window manager screencast v4.1 at YouTube</a> %}

{% image https://i.postimg.cc/mDP93xxY/gambar-03.png | 3 | <a href="https://youtu.be/AWA8Pl57UBY" target="_blank">i3 screencast: containers and the tree data structure at YouTube</a> %}

{% image https://i.postimg.cc/8kF3csY5/gambar-04.png | 4 | <a href="https://youtu.be/QnYN2CTb1hM" target="_blank">i3 - An Improved Tiling Window Manager at YouTube</a> %}

Sebenarnya, istilah *Tiling* window manager, bukan pertama kali saya dengar. Saya pernah mendengar dari percakapan beberapa teman-teman di group Telegram BGLI (Belajar GNU/Linux Indonesia). Kang [Sucipto](https://sucipto.net){:target="_blank"} pun sudah pernah menawarkan untuk menggunakan *i3wm*, namun saat itu saya belum memahami apa kelebihannya dan keuntungan menggunakan *Tiling* window manager.

## Mengapa i3 Window Manager?

Saya akan coba merangkum dengan beberapa point, mengapa saya akhirnya memutuskan untuk mantap menggunakan i3wm dan tidak pernah kembali menggunakan Desktop Environment seperti GNOME dan XFCE.

### Konfigurasi Menggunakan Plain Text

Untuk yang sudah pernah menggunakan Vim dan Tmux, pasti sudah familiar dengan file konfigurasi yang berbentuk *plain text*. Cukup menambahkan option-option di dalam file ini, maka program akan mengalami perubahan seperti yang kita isikan di dalam file konfigurasi. Contoh lain aplikasi yang menggunakan file konfigurasi berupa *plain text*, seperti: URxvt, Termite, Ranger, mpv, mpd, ncmpcpp, irssi, neomutt, newsboat, dunst, compton, cmus, dll.

Ada pula file konfigurasi yang bukan merupakan *plain text*, namun berupa file *header* (salah satu contohnya), seperti yang digunakan oleh dwm window manager dan st terminal yang menggunakan bahasa pemrograman C. Sehingga, untuk mendapatkan hasil perubahan yang sudah kita lakukan, kita perlu meng-*compile* kembali program tersebut. Mantap kan?

Inilah alasan, mengapa saya katakan file konfigurasi yang menggunakan *plain text* seperti yang digunakan oleh i3wm termasuk mudah digunakan.

i3wm dapat membaca file konfigurasi yang terdapat pada:

1. `~/.i3/config` atau
2. `~/.config/i3/config`

Namun, untuk alasan kerapian struktur direktori, saya lebih senang mengumpulkan semua file konfigurasi pada direktori `~/.config/`.

### Keyboard Shortcut adalah Segalanya

Untuk menggunakan i3wm, sebenarnya tidak juga *keyboard* sentris, dapat pula menggunakan *mouse*, namun, saya memang sengaja memaksakan diri saya untuk mencoba *workflow* yang baru. Ternyata, memang sangat luar biasa mengoperasikan Window Manager tanpa perlu menggunakan *mouse*.

Kalau teman-teman yang sudah menggunakan Vim sebagai *text editor* pasti akan memahami bagaimana kemudahan yang didapat setelah mengoperasikan *text editor* tanpa menggunakan *mouse*. Ya, itu lah yang akan teman-teman dapatkan pula saat menggunakan i3wm.

Saya akan menunjukkan apa saja yang dapat dilakukan dengan menggunakan *keyboard* untuk mengoperasikan i3wm dengan sambil menunjukkan blok-blok kode konfigurasi yang ada di dalam file konfigurasi i3wm saya, `~/.config/i3/config`.

### Menentukan Modifier Key

Pertama kali kita harus menentukan **modifier key**, seperti **leader key** dalam Vim, atau **Prefix** dalam Tmux.

Bisanya tawarannya antara dua, tombl <kbd>SUPER</kbd> atau  tombol <kbd>ALT</kbd>.

Saya memilih menggunakan tombol <kbd>SUPER</kbd> untuk meminimalisir bentrokan dengan *keyboard shortcut* aplikasi GUI yang rata-rata banyak menggunakan tombol <kbd>ALT</kbd>.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
set $mod Mod4
{% endhighlight %}

{% box_info %}
<p>Saya menggunakan <code>$mod</code> berupa <code>Mod4</code> yang merupakan tombol <kbd>SUPER</kbd>. Sebagaian user i3, adapula yang menggunakan <kbd>ALT</kbd>, namun sangat jarang saya temui.</p>
{% endbox_info %}

### Memanggil Terminal

Untuk memanggil Terminal yang kita gunakan, dalam kasus ini saya menggunakan **st** terminal dari [Suckless](https://suckless.org/){:target="_blank"} project.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Start a Terminal
bindsym $mod+Return exec --no-startup-id st
{% endhighlight %}

Dapat dilihat pada kode di atas bahwa, saya menggunakan <kbd>SUPER</kbd>+<kbd>ENTER</kbd> untuk memanggil `st` yang merupakan nama program dari **st** terminal.

Teman-teman dapat mengganti **st** dengan terminal favorit kalian. Seperti **gnome-terminal**, **xfce4-terminal**, **urxvt**, **termite**, dll.

### Pemanggil Aplikasi

*Application launcher*, pemanggil aplikasi. Kalau di GNOME saya biasa menggunakan tombol <kbd>SUPER</kbd> untuk memanggil *application launcher*, nah pada i3wm, kita bebas untuk menggunakan aplikasi yang berfungsi sebagai *application launcher* dan bebas pula ingin kita letakkan pada *keyboard shortcut* yang mana.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Start Rofi (a program launcher)
bindsym $mod+d exec --no-startup-id j4-dmenu-desktop --dmenu='rofi -dmenu -lines 6 -width 400 -i -sort -p RUN'
{% endhighlight %}

Pada contoh di atas, saya menggunakan aplikasi **Rofi** sebagai *application launcher* yang saya letakkan pada <kbd>SUPER</kbd>+<kbd>D</kbd>.

{% image https://i.postimg.cc/dtttfbtr/gambar-05.png | 5 | Rofi+dmenu %}

Sebenarnya saya memanfaatkan **dmenu** sebagai *backend* yang berfungsi me-*list* semua aplikasi saya, kemudian Rofi yang bertugas memberikan tampilan seperti di atas.

Jadi, menggunakan **dmenu** saja, sebenarnya juga bisa.

{% box_info %}
<p>Sebelumnya, saya menggunakan paket <code>dmenu</code>, namun terasa ada <i>delay</i> yang sangat mengganggu. Kemudian, setelah mencari informasi, saya memutuskan untuk menggunakan paket <code>j4-dmenu-desktop</code> (AUR) karena terasa lebih cepat saat dikombinasikan dengan Rofi.</p>
{% endbox_info %}

### Konfigurasi Font

Untuk mengatur font pada i3wm, biasaya font akan terlihat pada Title Bar yang ada pada Window Container.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Font for Window Titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
font pango:Fantasque Sans Mono 10
{% endhighlight %}

`10`, adalah size dari font.

### Window Container

Pada i3wm, Window akan saya sebut sebagai Container. Ya, sesuai dengan penamaannya "kontainer" yang berarti tidak hanya dapat menampung 1 buah Window, namun dapat menampung banyak Window dalam 1 Container. Sehingga akan lebih cocok kalau disebut sebagai Container.

#### Berpindah Focus Container

Untuk berpindah-pindah fokus antara satu Container ke Container yang lain, saya menggunakan:

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Change Focus
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right
{% endhighlight %}

| <kbd>SUPER</kbd>+<kbd>H</kbd> | Pindah fokus ke kiri |
| <kbd>SUPER</kbd>+<kbd>J</kbd> | Pindah fokus ke bawah |
| <kbd>SUPER</kbd>+<kbd>K</kbd> | Pindah fokus ke atas |
| <kbd>SUPER</kbd>+<kbd>L</kbd> | Pindah fokus ke kanan |

Bagaimana, apakah terlihat familiar dengan navigasi tersebut?

Seperti Vim bukan?

Saya memang sengaja membuatnya agar terasa seperti Vim, untuk memudahkan dalam mengingat.

Secara *default*, seingat saya kombinasinya tidak menggunakan <kbd>H</kbd>, <kbd>J</kbd>, <kbd>K</kbd>, <kbd>L</kbd>, melainkan menggunakan <kbd>J</kbd>, <kbd>K</kbd>, <kbd>L</kbd>, <kbd>;</kbd>.

Alternatifnya selain menggunakan tombol huruf, saya juga mengaturnya pada tombol *arrow*.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Alternatively, you Can Use the Arrow Keys
bindsym $mod+Left  focus left
bindsym $mod+Down  focus down
bindsym $mod+Up    focus up
bindsym $mod+Right focus right
{% endhighlight %}

#### Memindahkan Focus Container

Memindahkan di sini dapat kita gunakan untuk memindahkan (menukar) Container pada *tiling* layout dari kanan ke kiri, *viceversa*. Dapat pula digunakan untuk menggerakan Container pada *floating* layout.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Move Focused Window
bindsym $mod+Shift+h move left  1px
bindsym $mod+Shift+j move down  1px
bindsym $mod+Shift+k move up    1px
bindsym $mod+Shift+l move right 1px
{% endhighlight %}

Saya menggunakan <kbd>SUPER</kbd>+<kbd>SHIFT</kbd>+<kbd>HJKL</kbd>.

Pada kode di atas, saya menggunakan kombinasi *keyboard shortcut* tersebut untuk menggerakkan Container sebesar 1 px apabila pada *floating* layout. Namun, pada *tiling* layout, tetap seperti fungsi asal, yaitu memindahkan (menukar) Container dari kiri kanan, atas bawah, *viceversa*.

Saya juga membuatkan alternatif untuk bergerak atau berpindah sebesar 20 px agar lebih cepat.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Alternatively, You Can Use the Arrow Keys
bindsym $mod+Shift+Left  move left  20px
bindsym $mod+Shift+Down  move down  20px
bindsym $mod+Shift+Up    move up    20px
bindsym $mod+Shift+Right move right 20px
{% endhighlight %}

#### Mengganti Orientasi Container

Pada i3wm, kita dapat mengganti-ganti orientasi dari Container yang sedang terbuka. Misalkan terdapat 2 buah Container kanan dan kiri, hanya dengan menekan kombinasi *keyboard* kita dapat membuat menjadi atas dan bawah.

Kira-kira seperti ini ilustrasinya,

<pre class="whiteboard">
# 2 Container, dengan Vertical orientation
+-----+-----+
|     |     |
|  1  |  2  |
|     |     |
+-----+-----+

# 2 Container, dengan Horizontal orientation
+-----+-----+
|     1     |
+-----------+
|     2     |
+-----+-----+
</pre>

Untuk dapat melakukan ini, saya menggunakan,

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Split in Horizontal Orientation
bindsym $mod+b split h

# Split in Vertical Orientation
bindsym $mod+v split v
{% endhighlight %}

| <kbd>SUPER</kbd>+<kbd>B</kbd> | Horizontal orientation |
| <kbd>SUPER</kbd>+<kbd>V</kbd> | Vertical orientation |

{% box_info %}
<p>Hal ini, hanya dapat dilakukan pada <i><b>tiling</b></i> layout atau bisa juga kita sebut dengan <i><b>split</b></i> layout.</p>
{% endbox_info %}

Kita dapat mengatur *default orientation* saat menggunakan *Tiling* layout, apakah ingin Vertical atau Horizontal.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Orientation for New Workspaces
# New workspaces get a reasonable default orientation: Wide-screen monitors
# (anything wider than high) get horizontal orientation, rotated monitors
# (anything higher than wide) get vertical orientation.
# Syntax: default_orientation horizontal|vertical|auto
default_orientation horizontal
{% endhighlight %}

#### Membuat Fullscreen Container

Terkadang kita memerlukan untuk membuat sebuah Window menjadi *fullscreen* karena alasan tertentu. Tentu saja i3wm juga mempunyai fitur ini.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Enter Fullscreen Mode for the Focused Container
bindsym $mod+f fullscreen toggle
{% endhighlight %}

Saya menggunakan <kbd>SUPER</kbd>+<kbd>F</kbd>. Untuk membuat Container yang sedang difokuskan menjadi *fullscreen*.

Perhatikan, terdapat option `toggle` yang menandakan *keyboard shortcut* ini berfungsi selayaknya *switch* yang dapat kita ON dan OFF kan.

<pre class="whiteboard">
# Tiling layout yang terfokus pada Container 1
+-----+-----+
|     |     |
| [1] |  2  |
|     |     |
+-----+-----+

# Setelah menekan keyboard shortcut untuk fullscreen pada Container 1
+-----------+
|           |
|     1     |
|           |
+-----------+

# Viceversa, pada Container 2
</pre>

#### Menggati Layout Container

Pada pembahasa di atas, saya beberapa kali menyebutkan tentang *tiling* layout. i3wm mempunyai 3 macam layout (sepertinya, kalau *scratchpad* tidak dihitung sebagai layout), yaitu:

1. **Tiling** layout atau **Split** layout
2. **Tabbed** layout
3. **Stacking** layout

Tiling atau Split layout ini, sebagaimana sudah dicontohkan pada tulisan-tulisan di atas.

<pre class="whiteboard">
# Tiling atau Split layout
+-----+-----+ +----------+ +-----+-----+ +-----+-----+
|     |     | |    1     | |     |  2  | |  1  |  2  |
|  1  |  2  | +----------+ +  1  +-----+ |-----+-----+
|     |     | |    2     | |     |  3  | |  4  |  3  |
+-----+-----+ +----------+ +-----+-----+ +-----+-----+
</pre>

Tabbed layout ini bayangkan seperti sedang menggunakan Browser memiliki Tab.

<pre class="whiteboard">
# Tabbed layout
+-[1]-+--2--+ +--1--+-[2]-+
|           | |           |
|     1     | |     2     |
|           | |           |
+-----------+ +-----------+
</pre>

Stacking layout pada i3wm ini tidak seperti stacking pada Desktop Environment dengan Window yang melayang. Stacking layout pada i3wm tetap dengan Container yang memenuhi seluruh layar (*maximize*).

<pre class="whiteboard">
# Stacking layout
+----[1]----+ +-----1-----+
+-----2-----+ +----[2]----+
|           | |           |
|     1     | |     2     |
|           | |           |
+-----------+ +-----------+
</pre>

Kalau masih bingung, saya ambilkan gambar dari i3wm.org.

{% image https://i.postimg.cc/mZ3wb5fm/gambar-06.png | 6 | Layout yang dimiliki oleh i3wm %}

Kita dapat mengatur *default layout* yang akan kita gunakan pada setiap Workspace.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Layout Mode for New Containers
# This option determines in which mode new containers on workspace level will start
# Syntax: workspace_layout default|stacking|tabbed
workspace_layout default
{% endhighlight %}

Saya menggunakan **default**, yang berarti *Tiling* atau *Split* layout.

#### Membuat Floating Container

Tidak semua Window harus dalam keadaan *maximize*. Contohnya seperti: dialog notifikasi window, popup window, open dan save dialog window, password dialog window, dll. i3wm secara cerdas dapat mengenali dialog-dialog seperti ini. Sehingga kita tidak perlu mengkonfigurasi lagi.

Lantas, bagaimana apabila kita ingin membuat Container kita menjadi *floating*?

Sangat mudah, saya menggunakan <kbd>SUPER</kbd>+<kbd>SHIFT</kbd>+<kbd>SPACE</kbd>.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Toggle Tiling / Floating
bindsym $mod+Shift+space floating toggle border none
{% endhighlight %}

Lagi-lagi saya beritahukan bahwa *keyboard shortcut* ini saya set menjadi `toggle`, sehingga dapat digunakan untuk mengaktif dan disablekan *floating* pada Container.

<pre class="whiteboard">
# Container 1 dan Container 2 dalam Tiling/Split layout
+-------+-------+
|       |       |
|       |       |
|  [1]  |   2   |
|       |       |
|       |       |
+-------+-------+

# Container 1 saya buat menjadi Floating
+---------------+
|  2            |
|   +-------+   |
|   |  [1]  |   |
|   +-------+   |
|               |
+---------------+
</pre>

Untuk berpindah focus antar Cotainer floating dengan yang tidak, dapat menggunakan <kbd>SUPER</kbd>+<kbd>SPACE</kbd>.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Change Focus Between Tiling / Floating Windows
bindsym $mod+space focus mode_toggle
{% endhighlight %}

Ilustrasinya seperti ini.

<pre class="whiteboard">
# Fokus pada Container 1 yang sedang dalam bentuk floating
+---------------+
|  2            |
|   +-------+   |
|   |  [1]  |   |
|   +-------+   |
|               |
+---------------+

# Fokus pada Container 2 yang sedang dalam bentuk Tiling
+---------------+
| [2]           |
|   +-------+   |
|   |   1   |   |
|   +-------+   |
|               |
+---------------+
</pre>

#### Parent dan Child Container

Saya sudah menyebutkan pada tulisan di atas, bahwa i3wm merupakan *tree based* window manager. Kita dapat mengasumsikan Container seperti sebuah ranting dan daun.

<pre class="whiteboard">
# Container 1 dan 2, pada Tiling layout di Workspace 1
                         +-------------+
+-----+-----+            | WORKSPACE 1 |
|     |     |            +-------------+
|  1  |  2  |    =>         /       \
|     |     |              /         \
+-----+-----+          +-----+     +-----+
                       |  1  |     |  2  |
                       +-----+     +-----+

# Saya merubah orientasi pada Container 2 menjadi split Vertical (terbagi atas bawah)
# dengan menggunakan SUPER+V pada Container 2,
# kemudian buka Container 3
                         +-------------+
                         | WORKSPACE 1 |
                         +-------------+
                            /        \
+-----+-----+              /          \
|     |  2  |          +-----+    +---------+
|  1  +-----+    =>    |  1  |    | SPLIT V |
|     |  3  |          +-----+    +---------+
+-----+-----+                        /   \
                                    /     \
                                +-----+ +-----+
                                |  2  | |  3  |
                                +-----+ +-----+
</pre>

Seperti pohon faktorial yaa?

Tidak ada batasan sampai berapa cabang ranting dan daun yang ingin kalian buat.

{% box_info %}
<p>Split Vertical berarti di dalam satu Container akan dibagi kedalam 2 ruang, atas dan bawah. Begitu pula untuk Split Horizontal, berarti Container akan dibagi menjadi 2 ruang, kanan dan kiri.</p>
{% endbox_info %}

Nah, yang dimaksud dengan **PARENT** di sini adalah **ranting** sedangkan **CHILD** adalah **daun**.

Sehingga, apabila kita ingin melakukan focus terhadap Container 2 dan 3, ibarat **ranting** yang memiliki 2 daun, daun Container 2 dan 3. Ini disebut **Focus Parent**.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Focus the Parent Container
bindsym $mod+a focus parent
{% endhighlight %}

Sebaliknya, untuk focus kepada Container 1, atau Container 2 saja, atau 3 saja, ibarat **daun** pada ujung ranting. Kita sebut dengan **Focus Child**.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Focus the Child Container
bindsym $mod+Shift+a focus child
{% endhighlight %}

Pembahasan mengenai layout ini sangat kompleks dan seru sekali. Sepertinya, tidak sanggup kalau harus menuliskan semuanya. Mungkin kapan-kapan akan saya buatkan video ulasannya saja.

#### Memanfaatkan Scratchpad

Pada i3wm, kita tidak mengenal *minimize*. Dan memang tidak diperlukan fitur ini.

Untuk apa kita memerlukan fitur *minimize* kalau kita memiliki 10 Workspaces?

Lantas, apabila kita sedang membuka Text Editor pada Workspace 1, lalu ingin menggunakan Browser, tidak diperlukan me-*minimize* text editor, cukup jalankan Browser pada Workspace selanjutnya.

Apakah ada diantara teman-teman yang berpikiran menggunakan banyak Workspace akan memberatkan memory (RAM)?

Oh, *come on* geys... Ini Window Manager, bukan Browser. Manfaatkan fitur Workspace semaksimal mungkin untuk memanajemen window kalian. Memanfaatkan banyak Workspace sama sekali tidak ada hubungan langsung dengan memberatkan memory.

Nah, lantas, akan ada kasus dimana kita ingin memanggil aplikasi bantuan saat sedang fokus pada aplikasi utama.

Contohnya:

1. Sedang membaca *ebook* dengan Evince. Kemudian menemukan kata yang belum diketahui artinya, lantas kita ingin membuka gKamus.

2. Sedang melakukan pemilihan warna untuk CSS code kita, lantas kita memerlukan apliaksi GColor3 untuk mengambil sampel warna.

<br>
Dari kedua kasus di atas, apakah kita langsung mengeluarkan atau memindahkan aplikasi pembantu (gKamus dan GColor3) ke tempat lain?

Akan sangat repot untuk memanggilnya kembali karena kita tidak ingin berpindah Workspace karena alasan tertentu.

Solusi dari masalah di atas adalah dengan memanfaatkan **Scratchpad**.

Scratchpad ini ibarat seperti buku coretan, kita dapat panggil dan sembunyikan sesuai kemauan kita.

<br>
Untuk menginisialisasi Container menjadi sebuah Scratchpad, saya menggunakan <kbd>SUPER</kbd>+<kbd>SHIFT</kbd>+<kbd>-</kbd>.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Make the Currently Focused Window a Scratchpad
bindsym $mod+Shift+minus move scratchpad
{% endhighlight %}

Lalu untuk memanggil dan menyembunyikannya, saya mengguakan <kbd>SUPER</kbd>+<kbd>-</kbd>.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Show the First Scratchpad Window
bindsym $mod+minus scratchpad show
{% endhighlight %}

#### Membuat Sticky Container

Secara sederhana fitur ini mirip dengan **Always on Top** pada Window yang dimiliki oleh Desktop Environment.

Saya biasa menggunakan fitur ini saat melakukan *screencasting* dengan menampilkan *output* dari kamera WebCam agar tetap dapat dilihat saat berpindah-pindah antar Workspace.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Sticky Floating Windows
# Syntax: sticky enable|disable|toggle
bindsym $mod+Shift+plus sticky toggle
{% endhighlight %}

#### Membuat Default Floating Container

Pasti akan ada beberapa aplikasi yang memiliki Window yang kecil, namun pada i3wm akan dijalankan secara *maximize*, dan kita harus melakukan *floating* terhadap aplikasi tersebut secara manual. Beberapa contoh dari aplikasi tersebut adalah GKamus, GColor3, Gnome Power Statistics, Pavucontrol, Arandr, Blueman Manager, dll.

Untuk menginisialisasi agar aplikasi-aplikasi tersebut saat dijalankan sudah berada pada kondisi *floating* container, kita dapat mengaturnya pada file konfigurasi. Asik bukan?

Saya akan mencontohkan beberapa bentuk variasi konfigurasi yang saya pergunakan.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Enable Floating Mode for Specific Programs
for_window [class="Gkamus"]                           floating enable border normal 1
for_window [class="Gnome-power-statistics"]           floating enable border normal 1
for_window [class="Modem-manager-gui"]                floating enable border normal 1
for_window [class="Gnome-system-monitor"]             floating enable border normal 1
for_window [class="Nm-connection-editor"]             floating enable border normal 1
for_window [class="zoom" title="Zoom - Free Account"] floating enable border pixel  1 move right 470px,move down 0px
for_window [class="st-256color" title="ncpamixer"]    floating enable border normal 1 resize set 500 600,move right 90px,move up 80px
for_window [class="scrcpy" title="Mi-4c"]             floating enable border none     move right 460px,move down 0px
{% endhighlight %}

Sebaliknya pula, kita dapat membuat aplikasi yang secara *default* berjalan *floating* menjadi tidak.


{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Disable Floating Mode for Specific Programs
for_window [class="pavucontrol-qt"]                    floating disable
{% endhighlight %}

Meskipun sangat jarang saya temui aplikasi yang sejak awal sudah berada pada *floating* container, namun saya rasa perlu juga untuk memiliki konfigurasi ini apabila sewaktu-waktu diperlukan pada kasus yang lain.


#### Menutup/mengakhiri Window Container

Di dalam sebuah Window, dapat berupa apa saja. Aplikasi, program, dialog, terminal, pokoknya apa saja yang ada di dalam Window, kita dapat mengakhirinya dengan <kbd>SUPER</kbd>+<kbd>SHIFT</kbd>+<kbd>Q</kbd>.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Kill Focused Window
bindsym $mod+Shift+q kill
{% endhighlight %}

Hal ini diperlukan mengingat i3wm tidak menyediakan tombol *close* atau menu *exit* pada *title bar*. Tentu saja hal ini malah membuat proses menutup/mengakhiri sebuah window menjadi lebih praktis tanpa perlu menggerakkan *mouse* ke arah menu atau tombol *close* pada *title bar*.

#### Mengganti Window Container Border Color

Kita dapat mengganti warna dari Window Container border.

Dimulai dari mendefinisikan variabel dan mengisikan warnanya.


{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Define Color Variables
set $bg-color               #B58900
set $text-color             #002B36
set $border-color           #B58900
set $inactive-bg-color      #264A53
set $inactive-text-color    #657B83
set $urgent-bg-color        #CB4B16
set $urgent-text-color      #FFFFFF
set $indicator              #FFAF00
{% endhighlight %}

Setelah itu baru masukkan variabel-variabel tersebut dengan fungsinya.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# Define Color Variables
# ...
# ...

# Window Colors
# Opetion Name           # Border            # Background        # Text                # Indicator
client.focused           $bg-color           $bg-color           $text-color           $indicator
client.unfocused         $inactive-bg-color  $inactive-bg-color  $inactive-text-color  $indicator
client.focused_inactive  $inactive-bg-color  $inactive-bg-color  $inactive-text-color  $indicator
client.urgent            $urgent-bg-color    $urgent-bg-color    $urgent-text-color    $indicator
{% endhighlight %}

Hasilnya akan seperti ini.

{% image https://i.postimg.cc/j5nmsrtC/gambar-08.png | 7 | Window Container Aktif (kiri) dan Window Container Tidak Aktf (kanan) %}

#### Menentukan Container Border

Kita dapat menentukan apakah aplikasi yang kita panggil, akan memiliki border seperti apa. Atau tidak memiliki border sama sekali.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Window Container Border Settings
# syntax: new_window normal|none|pixel
new_window none
{% endhighlight %}

Dapat pula kita atur, apakah *floating* container secara *default* memiliki border atau tidak.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Syntax: new_float normal|none|pixel
new_float normal 1
{% endhighlight %}

{% box_info %}
<p>Terdapat 3 option yang dapat kita gunakan.</p>
<table>
<tr>
<td><code>normal</code></td>
<td>Border + Title Bar</td>
</tr>
<tr>
<td><code>pixel</code></td>
<td>Border saja</td>
</tr>
<tr>
<td><code>none</code></td>
<td>Tanpa Border</td>
</tr>
</table>
<p>Untuk option <code>normal</code> dan <code>pixel</code>, kita dapat menambahkan value dari ketebalan border seperti <code>0</code>, <code>1</code>, atau <code>2</code>.</p>
{% endbox_info %}

Kita juga dapat memanipulasi Window Container Border secara langsung menggunakan *keyboard shortcut*.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# For Direct Border Changing with Keyboard Shortcut
bindsym $mod+Shift+t border normal 0
bindsym $mod+t       border normal 1
bindsym $mod+Shift+y border pixel  1
bindsym $mod+y       border none
{% endhighlight %}

Hasilnya akan seperti ini,

**Border Normal 0**, menggunakan <kbd>SUPER</kbd>+<kbd>SHIFT</kbd>+<kbd>T</kbd>
{% image https://i.postimg.cc/xCbfB7Z3/gambar-09.png | 8 | Window Container Border Normal 0 %}

**Border Normal 1**, menggunakan <kbd>SUPER</kbd>+<kbd>T</kbd>
{% image https://i.postimg.cc/QN1Nb21X/gambar-10.png | 9 | Window Container Border Normal 1 %}

**Border Pixel 1**, menggunakan <kbd>SUPER</kbd>+<kbd>SHIFT</kbd>+<kbd>Y</kbd>
{% image https://i.postimg.cc/vTrQZnb1/gambar-11.png | 10 | Window Container Border Pixel 1 %}

**Border None**, menggunakan <kbd>SUPER</kbd>+<kbd>Y</kbd>
{% image https://i.postimg.cc/905m2b55/gambar-12.png | 11 | Window Container Border None %}

#### Menentukan Container Border Aplikasi Tertentu

Seperti halnya *floating* container, kita dapat juga menentukan contianer border pada aplikasi yang kita inginkan.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Enable Specific Window Border
for_window [class="Wine"] border normal 1
{% endhighlight %}

Contohnya, seperti di atas. Kalian dapat menambahkan sendiri. Hampir sama seperti *floating* container, hanya berbeda pada parameter border di bagian buntutnya saja.

Atau, dapat pula sekalian ditambahkan pengaturan border pada saat menentukan *floating* container, seperti contoh [di sini](#membuat-default-floating-container).

#### Merubah Title Container

Kita dapat pula merubah-rubah *alignment* dari Title yang ada pada Title Bar.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Window Title Alignment
# This option determines the window title’s text alignment.
# Default is left
# Syntax: title_align left|center|right
title_align left
{% endhighlight %}

Selain itu, dapat pula merubah format dari tulisan yang ada di Title bar.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# For Adding Space and [] Character on Window Title
for_window [class="^.*"] title_format " > %title"
{% endhighlight %}

#### Membuka Container Kosong

Untuk alasan tertentu, mungkin kita ingin membuka Container kosong. Misalkan seperti yang biasa saya lakukan, untuk sekedar melihat Conky yang ada pada desktop. Atau untuk sekedar gaya-gaya saja saat mengambil screenshot.

Saya menggunakan <kbd>SUPER</kbd>+<kbd>O</kbd>.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Open the Blank Space "i3 open" or "i3-msg open"
bindsym $mod+o open
{% endhighlight %}

### Workspaces

Secara *default* pada file konfigurasi i3wm sudah menyediakan 10 Workspaces.

Kita dapat mendifinisikan Workspace dengan cara seperti ini.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Define Workspace
set $workspace1  "1"
set $workspace2  "2"
set $workspace3  "3"
set $workspace4  "4"
set $workspace5  "5"
set $workspace6  "6"
set $workspace7  "7"
set $workspace8  "8"
set $workspace9  "9"
set $workspace10 "10"
{% endhighlight %}

#### Berpindah antar Workspaces

Setelah kita mendifinisikan Workspace, kita berikan pengaturan *keyboard shortcut* untuk dapat berpindah antar Workspace dengan mudah.

Saya meletakkan *keyboard shortcut* untuk berpindah antar Workspace pada <kbd>SUPER</kbd>+<kbd>1</kbd> sampai <kbd>0</kbd>.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Switch to Workspace
bindsym $mod+1 workspace $workspace1
bindsym $mod+2 workspace $workspace2
bindsym $mod+3 workspace $workspace3
bindsym $mod+4 workspace $workspace4
bindsym $mod+5 workspace $workspace5
bindsym $mod+6 workspace $workspace6
bindsym $mod+7 workspace $workspace7
bindsym $mod+8 workspace $workspace8
bindsym $mod+9 workspace $workspace9
bindsym $mod+0 workspace $workspace10
{% endhighlight %}

#### Memindahkan Container ke Workspace Lain

Kemudian, Apabila diperlukan, kita juga dapat memindahkan Container dari satu Workspace ke Workspace yang lain.

Untuk melakukan hal ini, saya meletakkan *keyboard shortcut* pada <kbd>SUPER</kbd>+<kbd>SHIFT</kbd>+<kbd>1</kbd> sampai <kbd>0</kbd>.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Move Focused Container to Workspace
bindsym $mod+Shift+1 move container to workspace $workspace1
bindsym $mod+Shift+2 move container to workspace $workspace2
bindsym $mod+Shift+3 move container to workspace $workspace3
bindsym $mod+Shift+4 move container to workspace $workspace4
bindsym $mod+Shift+5 move container to workspace $workspace5
bindsym $mod+Shift+6 move container to workspace $workspace6
bindsym $mod+Shift+7 move container to workspace $workspace7
bindsym $mod+Shift+8 move container to workspace $workspace8
bindsym $mod+Shift+9 move container to workspace $workspace9
bindsym $mod+Shift+0 move container to workspace $workspace10
{% endhighlight %}

Menurut saya ini adalah kombinasi *keyboard shortcut* paling natural untuk berpindah-pindah antar Workspace. Sangat praktis namun taktis. Taktis dalam hal seperti ini contoh kasusnya.

1. Saya sedang mengerjakan tulisan untuk Blog. Vim+Tmux saya buka pada **Workspace 1**.
2. Kemudian sambil melihat hasilnya pada Browser yang saya buka pada **Workspace 2**.
3. Untuk urusan editing file-file gambar, saya mengerjakannya pada **Workspace 3** yang berisi File Manager sambil terkadang membuka Inkscape dan GIMP di *workspace* ini juga.
4. **Workspace 4,5,6** jarang sekali saya pergunakan karena letaknya yang agak di posisi tengah, sehingga agak menyulitkan jari-jemari saya untuk menjangkaunya tanpa perlu mengangkat telapak tangan.
5. Terkadang saya sambil mengecek Email Client yang saya buka pada **Workspace 7**.
6. Kalau bosan menulis, biasanya saya mencari bahan bacaan pada daftar blog/website langganan saya, melalui RSS feed reader yang saya letakkan pada **Workspace 8**.
7. Sembari kadang-kadang mengecek apakah terdapat kawan-kawan sesama pengguna GNU/Linux yang memerlukan bantuan di group Telegram, aplikasi Telegram biasanya saya letakkan pada **Workspace 9**.
8. Aktifitas yang memerlukan Terminal, biasanya saya buka pada **Workspace 10**.

<br>
Kira-kira seperti di atas ini sebagian sekenario yang sering saya lakukan. Tidak selalu sama, tergantung dari aktivitas yang sedang saya kerjakan.

Kita dapat membuat aplikasi yang kita ingin jalankan, secara *default* terbuka pada Workspace tertentu. Misalkan, kita selalu menggunakan browser pada Workspace 2, IRC client pada Workspace 6, email client pada Workspace 7, RSS feed reader pada Workspace 8, Telegram pada Workspace 9, dll.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Assign Startup Application to Specific Workspace
assign [class="Firefox"]                      $workspace2
assign [class="st-256color" title="irssi"]    $workspace6
assign [class="st-256color" title="neomutt"]  $workspace7
assign [class="st-256color" title="newsboat"] $workspace8
assign [class="Telegram"]                     $workspace9
{% endhighlight %}

{% box_info %}
<p>Untuk mendapatkan nilai <b>class=</b> dan nilai <b>title=</b>, saya menggunakan perintah <code>xprop</code> yang langsung saya jalankan dari Terminal. Kemudian, tinggal klik Window Container mana yang ingin diketahui nilai class dan title nya.</p>
<p>Hasilnya, akan seperti ini kira-kira. (Contoh: Firefox)</p>
<pre>
_NET_WM_OPAQUE_REGION(CARDINAL) = 2, 0, 596, 2, 0, 2, 600, 498
_NET_WM_WINDOW_TYPE(ATOM) = _NET_WM_WINDOW_TYPE_NORMAL
_NET_WM_SYNC_REQUEST_COUNTER(CARDINAL) = 65011721, 65011722
_NET_WM_USER_TIME_WINDOW(WINDOW): window id # 0x3e00008
WM_CLIENT_LEADER(WINDOW): window id # 0x3e00001
_NET_WM_PID(CARDINAL) = 3842
WM_LOCALE_NAME(STRING) = "en_US.UTF-8"
WM_CLIENT_MACHINE(STRING) = "BanditHijo-X260"
WM_NORMAL_HINTS(WM_SIZE_HINTS):
                program specified minimum size: 138 by 162
                program specified base size: 0 by 0
                window gravity: NorthWest
<mark>WM_CLASS(STRING) = "python3", "Python3"</mark>
WM_ICON_NAME(STRING) = "SoundConverter"
_NET_WM_ICON_NAME(UTF8_STRING) = "SoundConverter"
<mark>WM_NAME(STRING) = "SoundConverter"</mark>
_NET_WM_NAME(UTF8_STRING) = "SoundConverter"
</pre>
<p>Perhatikan bagian yang saya <i>marking</i> adalah, bagian yang kita perlukan.</p>
<table>
<tr>
<td><code>class=</code></td>
<td><code>WM_CLASS(STRING) =</code></td>
<td>"Python3"</td>
</tr>
<tr>
<td><code>title=</code></td>
<td><code>WM_NAME(STRING) =</code></td>
<td>"SoundConverter"</td>
</tr>
</table>
{% endbox_info %}


Memanfaatkan Workspace pada i3wm benar-benar sangat membantu mempermudah hampir setiap pekerjaan yang saya kerjakan di atas Window Manager ini.

Coba teman-teman bandingkan dengan *keyboard shortcut* yang disediakan oleh Desktop Environment untuk berpindah antar Workspace atau untuk berpindah antar focus Window.

Kira-kira, kalau sudah dapat berpindah antar Workspace dan Container dengan mudah, apakah masih diperlukan perintah seperti <kbd>ALT</kbd>+<kbd>TAB</kbd>?

Apabila memang diperlukan, saya juga menyediakan fitur ini, namun sangat jarang sekali saya pergunakan.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# For List All the Opened Container in Every Workspace
bindsym $mod+Tab exec --no-startup-id j4-dmenu-desktop --dmenu="rofi -show window -lines 10 -width 500 -display-window 'WORKSPACE'"
{% endhighlight %}

Saya menggunakan <kbd>SUPER</kbd>+<kbd>TAB</kbd>, sebagai ganti dari <kbd>ALT</kbd>+<kbd>TAB</kbd>.

{% image https://i.postimg.cc/8k3jCdGY/gambar-07.png | 12 | Mendaftar semua Window Container dengan Rofi %}


### Memuat Ulang Konfigurasi

Setiap kita selesai mengubah atau mengurangi beberapa konfigurasi pada file `~/.configi/i3/config`, tidak serta merta langsung dapat kita lihat hasilnya. Selayaknya aplikasi konfigurasi GUI, kita perlu menekan tombol "Apply" terlebih dahulu. Nah, pada i3wm, setelah kita menyimpan file konfigurasi, kita dapat memuat ulang (*reload*) konfigurasi i3wm.

Saya menggunakan *keyboard shortcut*, <kbd>SUPER</kbd>+<kbd>SHIFT</kbd>+<kbd>C</kbd>.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Reload the Configuration File
bindsym $mod+Shift+c reload
{% endhighlight %}

Nah, apabila terjadi keanehan atau kejanggalan pada i3 wm layout, kita dapat pula memuat ulang i3wm tanpa perlu keluar dari X *session*. Ini dapat pula kita lakukan untuk melihat hasil perubahan konfigurasi apabila menggunakan *keyboard shortcut* `reload` di atas tidak berdampak apa-apa.

Saya menggunakan *keyboard shortcut*, <kbd>SUPER</kbd>+<kbd>SHIFT</kbd>+<kbd>R</kbd>.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Restart i3 Inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
{% endhighlight %}

### Binding Mode

Ini adalah salah satu fitur dari i3wm yang saya suka, namun belum saya manfaatkan dengan maksimal.

Binding Mode, adalah fitur dimana kita dapat mengumpulkan semua fungsi *keyboard shortcut* yang memiliki kelas yang sama.

Maksudnya gimana sih?

Jumlah karakter yang ada di atas *keyboard* memang sangat banyak. Namun, tidak menutup kemungkinan apabila kita memiliki kombinasi *keyboard shortcut* yang banyak, kita pun akan merasa kekurangan juga.

Untuk mengatasi hal ini, kita dapat mengelompokkan fungsi-fungsi *keyboard shortcut* yang memiliki tujuan yang sama, dalam satu tempat, dalam hal ini disebutnya **Mode**. Maka dari itu dinamakan **Binding Mode**.

Langsung saja saya berikan contohnya.

Saya ingin membuat pengaturan *keyboard shortcut* untuk "Resize Window Container" baik dalam *tiling* layout, maupun *floating* container. Fitur ini sangat diperlukan mengingat terkadang kita merasa butuh melebarkan atau mengecilkan sebuah Window Container.

Fitur ini setidaknya 8 kombinasi *keyboard shortcut*. 4 untuk me-*resize* atas, bawah, kanan kiri sebesar 1 px. 4 yang lain untuk me-*resize* atas, bawah, kanan, kiri sebesar 1 ppt.

Saya tetap ingin menggunakan tombol <kbd>HJKL</kbd>, namun sudah digunakan untuk fungsi "Window Focus".

Saya masih tetap dapat menggunakan kombinasi *keyboard shortcut* yang serupa, dengan membuatnya menjadi **Mode** yang berbeda. Saya beri nama mode **Resize**.

Untuk membuatnya, pertama saya perlu menginisialisasi *keyboard shortcut* untuk mengaktifkan mode Resize.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Resize Window (you can also use the mouse for that)
bindsym $mod+r mode "resize"
{% endhighlight %}

Dapat dilihat, saya menggunakan <kbd>SUPER</kbd>+<kbd>R</kbd>, untuk masuk/mengaktifkan mode ini.

Setelah itu saya akan mendefinisikan fungsi dari masing-masing *keyboard shortcut*.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

mode "resize" {
  # These bindings trigger as soon as you enter the resize mode

  # Pressing left will shrink the window’s width.
  # Pressing right will grow the window’s width.
  # Pressing up will shrink the window’s height.
  # Pressing down will grow the window’s height.
  bindsym h resize shrink width  1 px
  bindsym j resize grow   height 1 px
  bindsym k resize shrink height 1 px
  bindsym l resize grow   width  1 px

  # same bindings, but for the arrow keys
  bindsym Left  resize shrink width  1 px or 1 ppt
  bindsym Down  resize grow   height 1 px or 1 ppt
  bindsym Up    resize shrink height 1 px or 1 ppt
  bindsym Right resize grow   width  1 px or 1 ppt

  # back to normal: Enter or Escape
  bindsym Return mode "default"
  bindsym Escape mode "default"
}
{% endhighlight %}

Kalau kita lihat, kombinasi *keyboard shortcut* ini mirip dengan konfigurasi pada "Window Focus". Ya, benar sekali. Namun bedanya, kita perlu mengaktifkan mode Resize terlebih dahulu, untuk dapat menggunakan kombinasi *keyboard shortcut* di atas ini.

Sehingga, walaupun memiliki kombinasi *keyboard shortcut* yang sama, namun berada pada mode yang berbeda.

Pada baris di bawahnya, saya menambahkan *keyboard shortcut* untuk keluar dari mode Resize ke mode Default.

Keren bukan?

Saya baru menggunakan untuk 1 mode ini saja.

Sekarang teman-teman pasti sudah mempunyai gambaran, berapa banyak kombinasi *keyboard shortcut8 yang dapat kita buat. Tentunya akan sangat cukup dan memenuhi kebutuhan kita.

### Gaps

Perlu teman-teman ketahui, bahwa i3wm tidak menyediakan fitur *gaps* atau "jeda" antar Window Container pada *tiling* layout.

Untuk dapat memiliki fitur *gaps* kita memerlukan *forking project* yaitu [**i3-gaps**](https://github.com/Airblader/i3){:target="_blank"}.

Bagi yang ingin menggunakan fitur ini. Silahkan merujuk pada dokumentasi i3-gaps, pada halam Github mereka.

Saya sendiri menggunakan i3-gaps juga.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# gaps inner|outer
#      current|all
#      set|plus|minus <px>
gaps inner 0
gaps outer 0
smart_gaps on
{% endhighlight %}

Karena saya cepat sekali bosan, jadi saya sering berganti-ganti suasana. Terkadang ingin menggunakan *gaps*, kadang juga tidak.


### BAR

i3wm juga sudah secara *default* menyediakan atau membawa Bar mereka sendiri. Bar adalah tempat untuk Workspace indicator dan Status indicator.

Secara *default*, i3 meletakkan di bagian bawah dari layar.

Sejak Juli 2018, saya sudah memigrasikan penggunaan i3 bar menjadi Polybar, sehingga saya tidak lagi menggunakan i3 bar milik i3wm.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# bar {
#   2018/07 - I had migrated to PolyBar (https://github.com/jaagr/polybar)
# }
{% endhighlight %}

**Mengapa menggunakan Polybar?**

Lebih fleksibel untuk membuat bar layout kita sendiri.

### Mengeset Wallpaper

Saya menggunakan aplikasi bantuan bernama `feh` untuk membuat desktop background saya memiliki wallpaper.

<pre>
$ <b>sudo pacman -S feh</b>
</pre>

Kemudian tambahkan konfigurasinya.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Background Wallpaper
exec_always --no-startup-id feh --bg-fill -Z ~/pix/Wallpapers/Arch-Wallpaper-Solarized.png
{% endhighlight %}

### Mengeset LockScreen

Seperti Desktop Environment, pada Window Manager, kita juga dapat mengeset lock screen.

Saya menggunakan aplikasi bantuan, di antaranya:

1. `i3lock-color`
2. `xautolock`

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# i3lock lockscreen
# (lock is bash script from nandavera | i3lock-color)
# Source: https://github.com/okitavera/dotfiles/blob/master/.bin/lock
bindsym $mod+Shift+x exec --no-startup-id /usr/bin/lock-dark
exec_always --no-startup-id xautolock -time 15 -locker "/usr/bin/lock-dark" && echo mem ? /sys/power/state
{% endhighlight %}

Saya menggunakan <kbd>SUPER</kbd>+<kbd>SHIFT</kbd>+<kbd>X</kbd> untuk mengaktifkan lock screen secara manual. Saya menggunakan aplikasi bantuan yang saya rename menjadi `lock-dark` yang awalnya bernama `lock` buatan Nanda Okitavera yang juga menggunakan backend `i3lock-color`.

Saya juga mengeset agar sistem akan mengaktifkan lock screen secara otomatis pada menit ke 15, menggunakan aplikasi `xautolock`.

Atau, apabila terlalu ribet menggunakan script `i3lock-color` dan `lock`, bisa juga menggunakan `slimlock`. Ini adalah aplikasi lock screen yang sudah disediakan oleh [SLiM Display Manager](https://wiki.archlinux.org/index.php/SLiM){:target="_blank"}.

Saya sendiri sudah tidak lagi menggunakan `lightdm` sebagai Display Manager. Saat ini sedang menggunakan `slim`. Karena lebih mudah untuk dikustomisasi.

### Autostart Application

Untuk membuat aplikasi berjalan secara otomatis saat sistem pertama kali di jalankan, sangat mudah sekali dalam i3wm.

Cukup tambahkan pada file konfigurasi `~/.config/i3/config` baris kode seperti ini.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

exec        <nama_program>
exec_always <nama_program>

exec        --no-startup-id <nama_program>
exec_always --no-startup-id <nama_program>
{% endhighlight %}

Saya akan mem-*breakdown* apalikasi apa saja yang saya jalankan saat sistem startup.

#### Power Manager

Saya menggunakan XFCE4-POWER-MANAGER.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# XFCE4-power-manager
exec --no-startup-id xfce4-power-manager
{% endhighlight %}

Saya menggunakan aplikasi ini karena mudah digunakan, secara dulunya saya adalah XFCE user.

Beberapa pemanfaatan aplikasi xfce-power-manager yang pernah saya tuliskan ada [di sini]({{ site.url }}/blog/mengaktifkan-presentasion-mode-xfce4-dari-terminal){:target="_blank"}.

#### Clipboard

Saya menggunakan Clipmenu.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Clipmenu
exec --no-startup-id clipmenud
{% endhighlight %}

Konfigurasi ini sudah pernah saya bahas pada postingan, [di sini]({{ site.url }}/blog/manajemen-clipboard-dengan-clipmenu){:target="_blank"}.

#### Disable Touchpad

Karena saya pengguna TrackPoint pada ThinkPad, saya kurang suka menggunakan Touchpad. Saya perlu untuk menonaktifkannya sejak sistem startup.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Disable TouchPad
exec_always --no-startup-id xinput --disable "SynPS/2 Synaptics TouchPad"
{% endhighlight %}

Saya juga perlu menjaga agar Touchpad tetap dapat melakukan "Tap to Click".

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Enable Tap to Click
exec_always --no-startup-id xinput --set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1
{% endhighlight %}

#### Polkit

Saya menggunakan memilih menggunakan `lxpolkit` karena lebih independen dan dapat dipasang tanpa membawa dependensi lain seperti polkit yang dimiliki oleh GNOME.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Polkit-lxsession
exec --no-startup-id /usr/bin/lxpolkit
{% endhighlight %}

#### Window Compositor

Saya menggunakan `compton` sebagai window compositor. Secara sederhaa window compositor adalah aplikasi yang memberikan efek-efek pada Window Manager kita. Seperti shadow, blur, fade, opacity, dll.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Enable Compton for compositor
exec --no-startup-id compton --config ~/.config/compton/compton.conf
{% endhighlight %}

#### Notification

Sebelumnya saya menggunakan `notify-osd`, namun setelah mengenal `dunst` saya malah jatuh cinta sama kesederhanannya. Sangat simpel dan tentu saja dapat dikonfigurasi menggunakan plain text.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Enable Dunst Notifications
exec --no-startup-id dunst -config ~/.config/dunst/dunstrc
{% endhighlight %}

#### Conky

Window Manager masih memerlukan Compton?

Ini soal selera dan kebutuhan. Saya perlu dan butuh, jadi mengapa tidak.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Start Conky
exec --no-startup-id conky -c ~/.config/conky/conkyrc
{% endhighlight %}

#### Polybar

Polybar termasuk aplikasi pengganti bar yang dapat kita gunakan. i3wm tentu saja mengijinkan usernya untuk mengganti *default* bar milik mereka dengan pihak ketiga, seperti: lemonbar, tint2, dzen, polybar, dll.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Enable Polybar
exec_always --no-startup-id ~/.config/polybar/launch.sh
{% endhighlight %}

### Keyboard Shortcuts

Kita juga dapat menambahkan pengaturan *keyboard shortcut* sendiri untuk memanggil apalikasi yang kita inginkan.

#### System Session

Saya menggunakan script `rofi-power` untuk menampilkan dialog System Session seperti Logout, Restart, dan Shut Down.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Restart, Suspend, Shutdown, Logout Dialog
bindsym $mod+Shift+End exec --no-startup-id ~/.local/bin/rofi-power "i3-msg exit"
{% endhighlight %}

Saya memanggil script ini dengan menggunakan <kbd>SUPER</kbd>+<kbd>SHIFT</kbd>+<kbd>END</kbd>

Script ini dapat teman-teman dapatkan pada dotfiles milik saya, [di sini](https://github.com/bandithijo/dotfiles/blob/master/.local/bin/rofi-power){:target="_blank"}.

#### Clipmenu

Sebelumnya saya sudah menuliskan cara menjalankan *backend service* dari `clipmenud` pada bagian *autostart*. Pada bagian ini saya akan menunjukkan pengaturan *keyboard shortcut* yang saya gunakan untuk memanggil Rofi yang berisi Clipboard.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

bindsym $mod+p exec --no-startup-id clipmenu
bindsym $mod+Shift+p exec --no-startup-id rm -rf /tmp/clipmenu/*
{% endhighlight %}

Dapat dilihat, saya menggunakan <kbd>SUPER</kbd>+<kbd>P</kbd> untuk memanggil Rofi yang menampilkan isi dari clipboard.

{% image https://i.postimg.cc/vBPLT0Lj/gambar-13.png | 13 | Clipboard dalam keadaan terisi %}

Sedangkan untuk menghapus seluruh isi clipboard, saya menggunakan <kbd>SUPER</kbd>+<kbd>SHIFT</kbd>+<kbd>P</kbd>.

{% image https://i.postimg.cc/4ymv9pW3/gambar-14.png | 14 | Clipboard dalam keadaan kosong %}

#### Volume Control

Sudah merupakan keharusan untuk memiliki sebuah *keyboard shortcut* yang dapat mengatur besar dan kecilnya volume suara.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Pulse Audio controls
bindsym XF86AudioRaiseVolume exec --no-startup-id pamixer --increase 2
bindsym XF86AudioLowerVolume exec --no-startup-id pamixer --decrease 2
bindsym XF86AudioMute        exec --no-startup-id pamixer --toggle-mute
bindsym XF86AudioMicMute     exec --no-startup-id pactl   set-source-mute 1 toggle
{% endhighlight %}

Dapat dilihat, kode dari *keyboard* di atas sangat aneh. Itu adalah penamaan dari function keyboard. Setiap laptop biasanya memiliki function keyboard seperti ini.

Di sini saya menggunakan paket `pamixer`.

#### Audio Mixer

Audio mixer adalah aplikasi yang saya perlukan. Sebenarnya teman-teman juga memerlukan ini dan perlu mengetahui akan hal ini.

Karena tidak jarang saya mendapati pertanyaan seputar audio pada group Telegram Belajar GNU/Linux Indonesia, yang mempersoalkan tentang audio.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Pavucontrol
bindsym $mod+F3 exec --no-startup-id pavucontrol
{% endhighlight %}

Saya menggunakan <kbd>SUPER</kbd>+<kbd>F3</kbd> untuk memanggil `pavucontrol` karena tombol <kbd>F3</kbd> pada ThinkPad saya memiliki gambar Speaker. Untuk mempermudah dalam mengingat jadi saya manfaatkan.

Namun, belakangan ini sudah sangat jarang saya menggunakan `pavucontrol`, lebih sering menggunakan `ncpamixer`, tapi enah mengapa, aplikasi ini tidak dapat dijalankan dengan *keybinding*.

{% image https://i.postimg.cc/8PnP19JW/gambar-15.png | 5 | Tampilan TUI dari ncpamixer %}

#### Brightness Control

Kita juga memerlukan pengaturan pencahayaan pada layar agar tetap nyaman menggunakan laptop dalam waktu lama dan dapat menyesuaikan dengan kondisi cahaya dari lingkungan sekitar.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Screen Brightness controls
bindsym XF86MonBrightnessUp   exec --no-startup-id xbacklight -inc 2
bindsym XF86MonBrightnessDown exec --no-startup-id xbacklight -dec 2
{% endhighlight %}

{% box_info %}
<p>Saya mendapati informasi, bahwa beberapa distribusi sistem operasi sudah tidak dapat menggunakan perintah <code>xbacklight</code>.</p>
<p>Apabila ini terjadi pada teman-teman, mungkin bisa mencari solusinya sendiri. Karena saya belum mengalaminya. Akan sangat sulit bagi saya melakukan perbaikan apabila saya belum mengalami pada sistem saya. Hehe.</p>
{% endbox_info %}

#### Arandr

Arandr adalah aplikasi GUI untuk Xrandr. Sederhananya aplikasi ini saya gunakan untuk mengatur monitor apabila sedang menggunakan dual monitor.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Arandr
bindsym $mod+F7 exec --no-startup-id arandr
{% endhighlight %}

Saya menggunakan <kbd>SUPER</kbd>+<kbd>F7</kbd>.

Lagi-lagi, karena tombol <kbd>F7</kbd> saya bergambar projector, maka saya letakkan kombinasi untuk memanggil Arandr pada tombol ini.

{% image https://i.postimg.cc/1XXh2RKd/gambar-16.png | 6 | Tampilan GUI dari Arandr %}


#### Network Manager

Saya tidak menggunakan trayicon untuk memilih network dan memanggil Network Manager Settings. Saya lebih senang tidak menggunakan trayicon agar tampilan desktop tetap clean dan tidak terlalu banyak icon yang tidak konvergen dengan theme.

Sebelumnya, saya menggunakan aplikasi `nmtui` untuk melakukan konfigurasi jaringan, seperti: memilih-milih SSID. Namun, baru-baru saja saya menggunakan `networkmanager_dmenu`.

Untuk memanggilnya, saya menggunakan <kbd>SUPER</kbd>+<kbd>F8</kbd>.

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# ...
# ...

# Network Manager Dmenu
bindsym $mod+F8 exec --no-startup-id networkmanager_dmenu
{% endhighlight %}

Aplikasi ini dapat kita gunakan untuk memilih-mili jaringan dan beberapa menu jaringan. Dapat menggunakan `dmenu` atau `rofi` sebagai frontend nya. Tentu saja saya memilih menggunakan `rofi` agar seragam dengan theme. Hehehe.

**Instalasi**

<pre>
$ <b>mkdir -p ~/.config/networkmanager-dmenu</b>
</pre>

<pre>
$ <b>git clone https://github.com/firecat53/networkmanager-dmenu.git ~/.config/networkmanager-dmenu</b>
</pre>

**Konfigurasi**

<pre>
$ <b>cd ~/.config/networkmanager-dmenu</b>
</pre>

<pre>
$ <b>cp config.ini.example config.ini</b>
</pre>

Edit file `config.ini` untuk konfigurasi sesuai preferensi pribadi.

Contohnya seprti saya, yang ingin menggunakan Rofi sebagai *user interface*.

<pre>
$ <b>vim ~/.config/rofi/config.ini</b>
</pre>

{% highlight_caption $HOME/.config/rofi/config.ini %}
{% highlight sh linenos %}
[dmenu]
fn = Fantasque Sans Mono
dmenu_command = /usr/bin/rofi -width 25
# # Note that dmenu_command can contain arguments as well like `rofi -width 30`
# # Rofi and dmenu are set to case insensitive by default `-i`
# l = number of lines to display, defaults to number of total network options
# fn = font string
# nb = normal background (name, #RGB, or #RRGGBB)
# nf = normal foreground
# sb = selected background
# sf = selected foreground
# b =  (just set to empty value and menu will appear at the bottom
# m = number of monitor to display on
# p = Custom Prompt for the networks menu
p = NETWORKS
# pinentry = Pinentry command
# rofi_highlight = &lt;True or False&gt; # (Default: False) use rofi highlighting instead of '**'

# # override normal foreground and background colors (dmenu) or use the
# # -password option (rofi) to obscure passphrase entry
# [dmenu_passphrase]
# nf = #222222
# nb = #222222
# rofi_obscure = True

[editor]
terminal = st
gui_if_available = True
# terminal = &lt;name of terminal program&gt;
# gui_if_available = &lt;True or False&gt;
{% endhighlight %}

Hasilnya, akan seperti di bawah ini.

{% image https://i.postimg.cc/LsHPsDVN/gambar-17.gif | 7 | Tampilan NetworkManager_dmenu dengan Rofi %}


# Dotfiles

Bagi yang memerlukan contoh file konfig secara lengkap, dapat melihat pada dotfiles milik saya, [di sini](https://github.com/bandithijo/dotfiles/blob/master/.config/i3/config){:target="_blank"}. (Sedang Diperbaiki)


# Pesan Penulis

i3wm dapat dikatakan Window Manager yang cukup kaya fitur, ada beberapa orang yang tidak menyukai hal ini, karena dianggap terlalu *bloated*.

Bagi yang sudah mengenal banyak Window Manager mungkin dapat secara mandiri menanamkan fitur-fitur yang mereka perlukan, namun bagi saya yang baru pertama kali belajar menggunakan Window Manager, adanya fitur-fitur ini dapat menjadi jembatan belajar untuk mengerti apa saja fitur-fitur yang diperlukan oleh sebuah Window Manager.

Bagi teman-teman yang membutuhkan *workflow* yang efisien dan efektif. <mark>Saya sangat merekomendasikan untuk menggunakan i3wm</mark>.

Selama setahun terakhir, saya sudah merasakan manfaatnya. Tentu saja akan terasa sulit pada awalnya. Semua hal juga seperti itu. Jadi, paksakan dan biasakan saja, karena nikmatnya akan kamu petik tidak akan lama lagi.


Tulisan ini bukan merupakan tandingan dari dokumentasi resmi yang sudah ada. i3wm disebut sebagai Window Manager yang memiliki dokumentasi yang baik, lengkap dan *up to date*. Jadi, sangat saya rekomendasikan untuk berekplorasi menggunakan dokumentasi resmi.

Banyak sekali hal-hal teknis yang tidak atau belum sempat saya tuliskan. Seperti halnya aplikasi-aplikasi pendukung yang perlu dijalankan saat startup session, seperti: keyring, ssh-agent, gpg-agent, dll.

Tapi tidak mengapa. Saya yakin teman-teman dapat mencarinya sendiri pada referensi yang lain.

Sekiranya seperti ini saja.

Mudah-mudahan dapat bermanfaat bagi teman-teman.

Terima kasih.

>Per-April 2019, saya sudah berpindah menggunakan BSPWM (*Binary Space Partition Window Manager*).



# Referensi

1. [wiki.archlinux.org/index.php/Window_manager](https://wiki.archlinux.org/index.php/Window_manager){:target="_blank"}
<br>Diakses tanggal: 2019/02/26

2. [wiki.archlinux.org/index.php/Desktop_environment](https://wiki.archlinux.org/index.php/Desktop_environment){:target="_blank"}
<br>Diakses tanggal: 2019/02/26

3. [www.youtube.com/watch?v=j1I63wGcvU4&list=PL5ze0DjYv5DbCv9vNEzFmP6sU7ZmkGzcf](https://www.youtube.com/watch?v=j1I63wGcvU4&list=PL5ze0DjYv5DbCv9vNEzFmP6sU7ZmkGzcf){:target="_blank"}
<br>Diakses tanggal: 2019/02/26

4. [i3wm.org/docs/](https://i3wm.org/docs/){:target="_blank"}
<br>Diakses tanggal: 2019/02/26

5. [i3wm.org/docs/userguide.html](https://i3wm.org/docs/userguide.html){:target="_blank"}
<br>Diakses tanggal: 2019/02/26

6. [github.com/Airblader/i3](https://github.com/Airblader/i3){:target="_blank"}
<br>Diakses tanggal: 2019/02/26

