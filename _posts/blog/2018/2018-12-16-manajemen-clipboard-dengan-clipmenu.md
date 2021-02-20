---
layout: 'post'
title: 'Manajemen Clipboard dengan Clipmenu pada i3wm'
date: 2018-12-16 11:42
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Terminal', 'Tools', 'I3WM', 'Ulasan']
pin:
hot:
contributors: []
resume:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="#" onerror="imgError(this);" alt="banner"> -->

# Prakata

Selama ini saya tidak pernah menggunakan aplikasi *clipboard manager* semacam **Clipman** (`xfce4-clipman-plugin`) yang kegunaannya untuk menangkap, mengumpulkan, dan memanajemen hasil inputan copy. Saya merasa belum membutuhkannya. Saya pikir *copy* dan *paste* adalah hal yang sangat sederhana, tidak perlu sampai dimanajemen segala.

Sampai beberapa hari lalu, saya membalas pertanyaan di group openSUSE Indonesia, dan salah mention, lalu saya *copy* jawaban dan hapus. Saat akan saya *paste* ke bubble yang bertanya, ternyata *clipboard* saya sudah tertumpuk oleh inputan *copy* yang lain. Hahaha. Beginilah yaa, usia sudah tidak lagi muda, terdistraksi sedikit dapat menimbulkan kelupaan.

# Solusi

Hal yang saya alami tidak akan terjadi apabila saya menggunakan *clipboard manager*. Tahun ini sebenarnya sudah pernah juga mencoba *clipboard manager*, karena melihat video dari [Kai Hendry tentang bagaimana dia menghandle clipboard pada sistemnya](https://youtu.be/2rs1l4YZxRo){:target="_blank"}. Ia mengunakan [**cdown/clipmenu**](https://github.com/cdown/clipmenu){:target="_blank"}. Lantas saat saya coba pasang, Hahaha, selama pemakaian *resource memory* saya terus naik. Karena kurangnya ilmu saat itu dan motivasi yang sekedar ikut-ikutan, lantas niat menggunakan *clipboard manager* pupus di pinggr jalan.

Clipmenu adalah *clipboard manager* yang menggunakan dmenu atau Rofi sebagai antar muka.

<br>
<!-- IMAGE CAPTION -->
![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/J08d4wSg/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 1 - Tampilan Clipmenu menggunakan Rofi sebagai antar muka</p>


# Instalasi

Untuk memasang **clipmenu** pada sistem, terdapat dua cara yang saya ketahui.

1. [`community/clipmenu`](https://www.archlinux.org/packages/community/any/clipmenu/){:target="_blank"} (Arch Linux)

2. [`cdown/clipmenu`](https://github.com/cdown/clipmenu){:target="_blank"} (GitHub)

Dalam catatan ini, saya akan mencoba meng-*cover* kedua cara ini.

Konfigurasi akan saya tulis pada bagian <a href="#konfigurasi">Konfigurasi</a>.

## Clipmenu from Arch Repo

Cara pasangnya sangat mudah.

{% shell_user %}
sudo pacman -S clipmenu xsel
{% endshell_user %}

Clipmenu memerlukan paket `xsel` untuk menhandle *clipboard*.

## Clipmenu from GitHub

Pertama-tama beri bintang pada repository [cdown/clipmenu](https://github.com/cdown/clipmenu){:target="_blank"}. Sebagai bentuk apresiasi kita terhadap waktu dan pikiran developer.

1. Kloning dari GitHub repo dan letakkan pada direkotri tempat kalian mengumpulkan repository dari GitHub. Saya mempunyai direktori `~/app/` tempat saya mengumpulkan resource aplikasi.

   {% shell_user %}
cd app
git clone https://github.com/cdown/clipmenu.git
{% endshell_user %}

2. Masuk ke dalam direktori `clipmenu` dan buat symbolic link ke direktori `/usr/bin/`.

   {% shell_user %}
cd clipmenu
sudo ln -sf $HOME/app/clipmenu/clipdel /usr/bin/clipdel
sudo ln -sf $HOME/app/clipmenu/clipmenu /usr/bin/clipmenu
sudo ln -sf $HOME/app/clipmenu/clipmenud /usr/bin/clipmenud
{% endshell_user %}

   Sesuaikan sumber dari link (`$HOME/app/`) dengan path tempat kalian menyimpan kloning repo.

3. Periksa apakah semua symbolic link sudah berada di tujuan dan mengarah ke arah yang benar.

   **File Binary**

   {% shell_user %}
ll /usr/bin | grep -E 'clipdel|clipmenu|clipmenud'
{% endshell_user %}

   ```
   lrwxrwxrwx 1 root root  39 Dec 16 15:18 clipdel -> /home/bandithijo/app/clipmenu/clipdel
   lrwxrwxrwx 1 root root  38 Dec 16 15:18 clipmenu -> /home/bandithijo/app/clipmenu/clipmenu
   lrwxrwxrwx 1 root root  39 Dec 16 15:18 clipmenud -> /home/bandithijo/app/clipmenu/clipmenud
   ```

   {% box_info %}
    <p>Clipmenu menyediakan <code>init/clipmenud.service</code>, namun saat saya jalankan, clipmenu tidak dapat mengambil clip. Sehingga saya tidak menggunakan cara ini.</p>
    <p>Apabila teman-teman berhasil, teman-teman dapat menggunakan cara ini.</p>
    <p>Saya menggunakan cara lain, yaitu dengan menjalankan <code>clipmenud</code> secara manual pada script autorun.</p>
   {% endbox_info %}

# Konfigurasi

Sebagai informasi, konfigurasi yang saya tulis ini adalah konfigurasi untuk **i3wm**/**i3-gaps**. Untuk teman-teman yang tidak menggunakan wm yang sama, dapat menyesuaikan dan memodifikasi dengan wm masing-masing.

## Aktifkan Clipmenu Daemon

Ada dua cara untuk menggukana mengaktifkan `clipmenud` (clipmenu daemon). Dengan menjalankannya saat sistem startup atau saat sistem booting.

## Konfigurasi Startup pada WM

**i3wm**

Tambahkan baris berikut pada file config i3wm.

{% shell_user %}
vim .config/i3/config
{% endshell_user %}

{% highlight_caption $HOME/.config/i3/config %}
{% highlight sh linenos %}
# clipmenu daemon
exec --no-startup-id clipmenud
{% endhighlight %}

<br>
**dwm**

Tambahkan baris berikut pada script autorun/autostart, atau pada **.xinitrc**.

```sh
pkill -f "bash /usr/bin/clipmenud"; pkill -f "clipnotify"; /usr/bin/clipmenud &
```

Pada perintah di atas, saya melakukan proses `kill` terlebih dahulu kepada `clipmenud` & `clipnotify`, tujuannya agar tidak terjadi redundancy pada proses yang sedang berjalan apabila dwm direstart.

Kemudian, baru saya memanggil `clipmenud` dan membuatnya berjalan di background dengan menambahkan simbol ampersand (&). `clipmenud` secara otomatis akan menjalankan `clipnotify` yang bertugas untuk menangkap clipboard.




## Systemd Service

{% box_perhatian %}
<p>Saya tidak berhasil menjalankan <code>clipmenud.service</code>. Sehingga saya tidak menggunakan cara ini.</p>
{% endbox_perhatian %}

Aktifkan/enable service, agar saat sistem booting, clipmenud akan sekalian di jalankan.

{% shell_user %}
sudo systemctl enable clipmenud.service
sudo systemctl start clipmenud.service
{% endshell_user %}

## Definisikan Default Path

Sebelum mengkonfigurasi, selalu biasakan untuk melihat help atau manual dari clipmenu terlebih dahulu.

{% shell_user %}
clipmenu -h
{% endshell_user %}

```
clipmenu is a simple clipboard manager using dmenu and xsel. Launch this
when you want to select a clip.

All arguments are passed through to dmenu itself.

Environment variables:

- $CM_DIR: specify the base directory to store the cache dir in (default: $XDG_RUNTIME_DIR, $TMPDIR, or /tmp)
- $CM_HISTLENGTH: specify the number of lines to show in dmenu/rofi (default: 8)
- $CM_LAUNCHER: specify a dmenu-compatible launcher (default: dmenu)
```

Nah, kita perlu menambahkan **environment variable**.

Secara default, clipmenu menggunakan dmenu sebagai antar muka. Namun bagi yang menggunakan rofi dapat menambahkan `rofi` pada `CM_LAUNCHER`.

Jangan lupa juga untuk mendefinisikan path dari `CM_DIR`. Saya memilih untuk membuat direktori `clipmenu` pada `/tmp` agar dapat saya manipulasi, seperti menghapus clipboard yang tersimpan.

Untuk teman-teman yang menggunakan Display Manager seperti LightDM dan GDM, silahkan tambahkan baris di bawah ini pada file `~/.profile`. Untuk yang menggunakan startx dapat menambahkannya pada `~/.xinitrc`.

{% shell_user %}
vim ~/.profile
{% endshell_user %}

{% highlight_caption $HOME/.profile %}
{% highlight sh linenos %}
# Clipmenu Environment Variables
export CM_LAUNCHER=rofi-clipmenu
export CM_DIR=/tmp
{% endhighlight %}

**Perhatian!** Pada `CM_LAUNCHER=` di atas, saya membuat *custom* bash script yang bernama `rofi-clipmenu` untuk memanggil perintah rofi yang sudah saya modif agar menampilkan prompt "CLIPBOARD" dengan baris dan lebar tertentu.

Maka kita akan membuatnya. Kalian bisa membuatnya di lokal `~/.local/bin/` (kalau punya), atau langsung saja di `/usr/bin/`.

{% shell_user %}
sudo vim ~/.local/bin/rofi-clipmenu
{% endshell_user %}

{% highlight_caption $HOME/.local/bin/rofi-clipmenu %}
{% highlight sh linenos %}
#!/bin/sh

rofi -dmenu -p 'CLIPBOARD' -lines 8 -width 500
{% endhighlight %}

Sesuaikan dengan preferensi yang kalian inginkan.

Jangan lupa buat menjadi excutable.

{% shell_user %}
chmod +x ~/.local/bin/rofi-clipmenu
{% endshell_user %}

Kalau teman-teman yang menggunakan dmenu, tinggal menggantinya menjadi dmenu.

## Keyboard Shortcuts

Selanjutnya tinggal mendefiniskan keyboard shortcut.

Karena menggunakan wm, maka caranya sangat mudah sekali, tinggal tambahkan pada konfigurasi masing-masing.

{% highlight_caption $HOME/.config/ranger/rc.conf %}
{% pre_caption %}
bindsym $mod+p exec --no-startup-id clipmenu
bindsym $mod+Shift+p exec --no-startup-id clipdel -d '.'
{% endpre_caption %}

Perhatikan pada baris kedua, saya mempergunakan untuk menghapus seluruh clipboard menggunakan perintah `$ clipdel -d '.'`.

**dwm**

{% highlight_caption config.h %}
{% pre_caption %}
{ MODKEY,             XK_p,   spawn,   SHCMD("/usr/bin/clipmenu") },
{ MODKEY|ShiftMask,   XK_p,   spawn,   SHCMD("clipdel -d '.'") },
{% endpre_caption %}

Sesuaikan keyboard shortcut sesuai preferensi kalian.

Saya menggunakan :

<kbd>SUPER</kbd> + <kbd>P</kbd>, untuk memanggil clipmenu.

<kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>P</kbd>, untuk menghapus seluruh clipboard yang ada di clipmenu.

Untuk memilih clip mana yang ingin kita pergunakan kembali, tinggal menekan arrow key <kbd> ↓ </kbd> / <kbd> ↑ </kbd> untuk memilih, tekan <kbd>ENTER</kbd> untuk memasukkannya pada PRIMARY. Kemudian, tinggal kita *paste* di mana saja.

<!-- IMAGE CAPTION -->
![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/MTkmShLQ/gambar-02.gif" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 2 - Ilustrasi penggunaan Clipmenu dengan Rofi</p>

# Pesan Penulis

Terdapat banyak sekali *clipboard management* yang dapat kita pergunakan. Saat ini saya sedang mengunakan clipmenu, entah besok akan mencoba yang mana lagi.

Catatan dokumentasi ini masih jauh dari kata sempurna. Sebaik-baik dokumentasi adalah dokumentasi resmi yang ditulis oleh developer pengembang aplikasi. Silahkan bereksplorasi terhadap clipmenu dengan merujuk pada referensi yang saya sertakan di bawah.

Karena keterbatasan pengetahuan, Saya masih mengalami kegagalan dalam menjalankan clipmenud daemon melalui systemd service. Hehehe.


# Referensi

1. [wiki.archlinux.org/index.php/Clipboard](https://wiki.archlinux.org/index.php/Clipboard){:target="_blank"}
<br>Diakses tanggal: 2018/12/16

2. [github.com/cdown/clipmenu](https://github.com/cdown/clipmenu){:target="_blank"}
<br>Diakses tanggal: 2018/12/16

