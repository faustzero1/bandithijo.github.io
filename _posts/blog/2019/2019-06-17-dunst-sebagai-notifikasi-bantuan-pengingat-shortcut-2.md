---
layout: 'post'
title: 'Memanfaatkan Dunst Sebagai PopUp Notifikasi Bantuan Keyboard Shortcut (ver. 2)'
date: 2019-06-17 17:18
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips']
pin:
hot:
contributors: []
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Latar belakang dari ditulisnya post ini adalah, untuk menyempurnakan [post sebelumnya]({{ site.url }}/blog/dunst-sebagai-notifikasi-bantuan-pengingat-shortcut){:target="_blank"} dengan judul yang sama.

Berkat pertanyaan dari Nabil, saya memikirkan kembali script untuk Keyboard Shortcut Helper ini.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/CLxBq08Z/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}

Kalau kita lihat pada *command* di atas, saya menggunakan script bernama **help-script-browser.sh** untuk menyeleksi file dan membukanya.

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/wMLCxM51/gambar-02.png" onerror="imgError(this);"}{:class="myImg"}

Cara ini sangat tidak praktis.

Alhamdulillahnya terpikirlah cara untuk menggunakan `dmenu` saja.

![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/WbmBQDbK/gambar-03.png" onerror="imgError(this);"}{:class="myImg"}

Dengan begini, akan lebih sederhana dan singkat proses pemanggilan plain text yang berisi Keyboard Shortcut Helper.

Ide ini terinspirasi dari script [**st-urlopener**](https://github.com/thomas154/st-urlopener/blob/master/urlopener){:target="_blank"} yang digunakan untuk mengambil url pada screen terminal yang terlihat.

# Proses Pembuatan

Sekenarionya akan seperti ini.

1. Membuat *script* dmenu untuk memilih *plain text* untuk ditampilkan
2. Membuat *plain text* berisi *keyboard shortcut* yang akan dipanggil oleh dmenu

Langsung saja kita eksekusi.

## Pembuatan Script

Langsung saja tanpa bertele-tele.

1. Buat file script boleh pada direktori `~/.local/bin/` atau pada direktori `/usr/bin/` dengan nama sembarang saja, tapi berkorelasi.

    Saya akan memberi nama `keybind-helper`.
```
$ sudo touch /usr/bin/keybind-helper
$ sudo chmod +x /usr/bin/keybind-helper
```

2. Edit file script tersebut dengan *text editor* favorit kalian.
```
$ sudo vim /usr/bin/keybind-helper
```

3. Isikan, kira-kira seperti contoh di bawah ini.
```bash
#!/bin/env sh
pilihan="BSPWM\nMPV\nST\nTMUX\nVIM"
terpilih=$(echo -e "$pilihan" | dmenu -i -p KEYBINDS:)
case "$terpilih" in
        BSPWM) dunstify "$terpilih KEYBINDS:" "`tail -n 55 $HOME/.config/rofi-help/keybinds-bspwm`" ;;
        MPV) dunstify "$terpilih KEYBINDS:" "`tail -n 55 $HOME/.config/rofi-help/keybinds-mpv`" ;;
        ST) dunstify "$terpilih KEYBINDS:" "`tail -n 55 $HOME/.config/rofi-help/keybinds-st`" ;;
        TMUX) dunstify "$terpilih KEYBINDS:" "`tail -n 55 $HOME/.config/rofi-help/keybinds-tmux`" ;;
        VIM) dunstify "$terpilih KEYBINDS:" "`tail -n 55 $HOME/.config/rofi-help/keybinds-vim`" ;;
esac
```

    Sesuaikan saja dengan jumlah aplikasi yang ingin kalian buatkan *keybind*-nya.

    Seperti contoh di atas, saya baru membuat 5 aplikasi.

    Perhatikan bagian ini,

    <pre>
tail -n 55 <mark>$HOME/.config/rofi-help/keybinds-bspwm</mark></pre>

    Pada bagian yang saya *marking* adalah bagian dimana saya meletakkan *plain text* berisi *keyboard shortcut*.

    Sesuaikan dengan lokasi dimana kalian menyimpan *plain text* tersebut.

    Nilai `55` adalah maksimal banyaknya jumlah baris yang di tampilkan.

4. Apabila ingin menambahkan pilihan yang lain, cukup menambahkan pada variabel `pilihan=`.

    <pre>
pilihan="BSPWM\nMPV\nST\nTMUX\nVIM<mark>\nTAMBAHAN</mark>"</pre>

    Dan juga `case` nya.

    <pre>
case "$terpilih" in
        BSPWM) ...
        MPV) ...
        ST) ...
        TMUX) ...
        VIM) ...
        <mark>TAMBAHAN) ... </mark>
esac</pre>

5. Contoh di atas, apabila teman-teman menggunakan `dmenu`.

    Untuk yang ingin menggunakan Rofi, tinggal tambahkan saja seperti ini pada variabel `terpilih=`.

    <pre>
terpilih=$(echo -e "$pilihan" | <mark>rofi -dmenu</mark> -i -p KEYBINDS:)</pre>


Dengan begini proses pembuatan *script* telah selesai.

Kita akan lanjut membuat *plain text* yang berisi *keyboard shortcut*.

## Pembuatan Plain Text

Seperti yang sedikit sudah saya singgung pada *section* di atas.

Perhatikan lagi bagian ini,

<pre>
tail -n 55 <mark>$HOME/.config/rofi-help/keybinds-bspwm</mark></pre>

Pada bagian yang saya *marking* adalah bagian dimana saya meletakkan *plain text* berisi *keyboard shortcut*.

Sesuaikan dengan lokasi dimana kalian menyimpan *plain text* tersebut.

Tidak harus sama seperti saya.

Misalkan kalian membuat direktori khusus pada Home dan memberi nama `~/.keybind-helper/` kemudian baru mengisikan *plain text* di dalamnya.

Bebas saja.

Saya akan mencontohkan salah satu isi dari *plain text* yang berisi *keyboard shortcut* yang saya gunakan.

Dalam hal ini adalah *keyboard shortcut* untuk BSPWM.

Saya memberikan nama file `keybinds-bspwm`.

```
<b>LAUNCHER---------------------------------------</b>
mod+Enter            Terminal
mod+Shift+End        Sessions Dialog
mod+q                Close Window Focus
mod+Shift+x          Lock Screen
mod+Shift+q          Kill Window Focus
mod+d                Rofi: App Launcher
mod+F10              Rofi: Help
mod+{p,Shift+p}      Rofi: Clipboard Show/Clear
mod+Print            Screenshot Silently
mod+Shift+Print      Screenshot GUI
mod+F8               Rofi: NetworkManager_dmenu
mod+{F9/Shift+F9}    Polybar Tray Show/Hide
<b>STATE------------------------------------------</b>
mod+t                State: Tiled []=
mod+Shift+t          State: Pseudo Tiled [T]=
mod+m                State: Monocle [M]=
mod+s                State: Floating []=
mod+f                State: Fullscreen []=&lt;&gt;&lt;
mod+n                Blank Space (Receptacle)
<b>FLAGS------------------------------------------</b>
mod+Ctrl+m           Flags: Marked [*]
mod+Ctrl+x           Flags: Locked [X]
mod+Ctrl+y           Flags: Sticky [Y]
mod+Ctrl+z           Flags: Private [Z]
<b>NODE-------------------------------------------</b>
mod+{c,Shift+c}      Change Focus Next/Previous
mod+a                Focus Parent
mod+b                Focus Brother
mod+,                Focus First
mod+.                Focus Second
mod+Tab              Focus Last Node/Dekstop
mod+{o,i}            Focus Old/New Node/Dekstop
mod+{u,Shift+u}      Rotate +90/-90
mod+{Shift+-,-}      Node Hide/Show
mod+Space            Balance Split Ratio
mod+Shift+Space      Equalize Split Ratio
mod+F1               Move Focus Node to eDP1
mod+F2               Move Focus Node to HDMI2
<b>PRESELECT--------------------------------------</b>
mod+Ctrl+{hjkl}      Preselect Direction
mod+Ctrl+{1-9}       Preselect Ratio
mod+Ctrl+Space       Preselect Dismissed
<b>RESIZE/MOVE------------------------------------</b>
mod+Alt+{hjkl}       Expand Outward
mod+Alt+Shift+{hjkl} Expand Inward
mod+ArrowKeys        Move Floating Window 10px
mod+Shift+ArrowKeys  Move Floating Window 1px
```

Apabila teman-teman perhatikan, tampilan di atas tidak benar-benar *plain text*.

Karena saya mengatur Dunst untuk dapat merender kode HTML.

Kalau teman-teman lihat pada konfigurasi Dunst yang ini.

```bash
# Possible values are:
# full: Allow a small subset of html markup in notifications:
#        <b>bold</b>
#        <i>italic</i>
#        <s>strikethrough</s>
#        <u>underline</u>
#
#        For a complete reference see
#        <http://developer.gnome.org/pango/stable/PangoMarkupFormat.html>.
#
# strip: This setting is provided for compatibility with some broken
#        clients that send markup even though it's not enabled on the
#        server. Dunst will try to strip the markup but the parsing is
#        simplistic so using this option outside of matching rules for
#        specific applications *IS GREATLY DISCOURAGED*.
#
# no:    Disable markup parsing, incoming notifications will be treated as
#        plain text. Dunst will not advertise that it has the body-markup
#        capability if this is set as a global setting.
#
# It's important to note that markup inside the format option will be parsed
# regardless of what this is set to.
markup = full
```

Tujuannya agar tampilan notifikasi lebih dinamis, cetak tebal dan normal.

Kalian bisa perhatikan seperti pada bagian di bawah ini yang saya gunakan untuk menampilkan tulisan bercetak tebal.

```
<b>LAUNCHER---------------------------------------</b>
```

Kemudian, karena tag-tag HTML akan di-render oleh Dunst, mungkin teman-teman akan kesulitan apabila menggunakan tanda lebih besar `>` atau lebih kecil `<`.

Contohnya seperti di bawah ini.

Saya bermaksud menampilkan,

```
mod+f                State: Fullscreen []=<><
```

Sedangkan tanda-tanda `<><` tersebut merupakan tanda dari tag HTML. Hal ini pasti akan menyebabkan gagal dirender dengan benar.

Untuk mengatasinya, kita ganti dengan simbol alternatif entitas HTML.

```
mod+f                State: Fullscreen []=&lt;&gt;&lt;
```

Nah, sekarang tinggal teman-teman racik sendiri *keyboard shortcut* untuk aplikasi yang lain yang teman-teman ingin buatkan notifikasi pengingatnya.


# Hasilnya

Kalau sekenario di atas sudah teman-teman selesaikan, hasilnya akan seperti ini.

**Rofi**

![gambar_4]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/MKgFcjbP/gambar-04.gif" onerror="imgError(this);"}{:class="myImg"}

<br>
**dmenu**

![gambar_5]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/5tX58P48/gambar-05.gif" onerror="imgError(this);"}{:class="myImg"}

Tinggal kita pasangkan pemanggilannya pada *keyboard shortcut* pada Window Manager masing-masing.

Contohnya seperti pada BSPWM yang saya gunakan.

```
$ vim ~/.config/sxhkd/sxhkdrc
```
```
# keybind helper
super + F10
    /usr/bin/keybind-helper
```

Untuk teman-teman yang menggunakan Window Manager atau Desktop Environment yang lain, silahkan menyesuaikan sendiri yaa.

Sepertinya seperti ini saja.

Terima kasih untuk Nabil yang sudah menginspirasi untuk memperbaiki pola kerja dari pengingat *keyboard shortcut* ini.

Terima kasih sudah mampir kawan.



# Referensi

1. [github.com/thomas154/st-urlopener/blob/master/urlopener](https://github.com/thomas154/st-urlopener/blob/master/urlopener){:target="_blank"}
<br>Diakses tanggal: 2019/06/17
