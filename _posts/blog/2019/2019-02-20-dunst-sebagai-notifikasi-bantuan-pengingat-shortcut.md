---
layout: 'post'
title: 'Memanfaatkan Dunst Sebagai PopUp Notifikasi Bantuan Keyboard Shortcut'
date: 2019-02-20 10:45
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'I3WM']
pin:
hot: true
contributors: []
resume: "Dunst adalah replacement untuk standalone notification daemon yang ringan. Biasanya digunakan oleh pengguna Window Manager. Catatan kali ini, saya akan memanfaatkan dunst untuk menampilkan daftar keybind keymap."
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

{% box_info %}
<p>Sudah ada versi yang lebih baru dari topik ini.</p>
<p>Silahkan mengunjungi alamat di bawah.</p>
<p>"<a href="{{ site.url }}/blog/dunst-sebagai-notifikasi-bantuan-pengingat-shortcut-2">Memanfaatkan Dunst Sebagai PopUp Notifikasi Bantuan Keyboard Shortcut (ver. 2)</a>"</p>
{% endbox_info %}

# Prakata

Sebenarnya agak malu menuliskan dokumentasi kali ini. Karena merasa algoritma pemecahan solusinya terlalu bertele-tele. Hihihi. Tapi ah sudahlah! Namanya juga belajar.

Mungkin sebagian dari teman-teman yang menggunakan *environment* sistem yang mirip seperti saya, pernah mengalami "lupa" terhadap beberapa *keyboard shortcut* yang jarang digunakan.

Hal ini sangat wajar -- setidaknya menurut saya. Karena *environment* kami dalam menggunakan aplikasi mengharuskan untuk menggunakan *keyboard shortcut*.

Sebentar...

Mungkin ada beberapa dari teman-teman yang belum mengerti. *Environment* seperti apa sih itu?

1. **i3 Window Manager**
2. **Tmux**
3. **Vim**
4. **Ranger**
5. **Neomutt**
6. **Newsboat**
7. **MPV**
8. **st Terminal**
9. dst...

Di atas adalah contoh dari beberapa aplikasi yang memiliki konfigurasi *keyboard shortcut* agar dapat digunakan.

Memang tidak semua kita gunakan dan kita perlukan.

Maka dari itu, tujuan tulisan kali ini adalah untuk memecahkan permasalahan **apabila kita mengalami kelupaan dan tidak ingin repot membuka `man` (manual) dari aplikasi tersebut**. Cukup dengan membuat *script* sederhana untuk memanggil "catatan" berisi *keyboard shortcut* yang sudah kita rangkum sebelumnya.

Sangat memudahkan sekali (menurut saya). Hehe.

# Sekenario

Ada banyak sekali *blueprint* yang terpikirkan, namun untuk saat ini, saya menggunakan cara yang akan saya tuliskan ini terlebih dahulu.

Karena daripada menunggu sampai berhasil menerapkan rancangan yang ideal namun tidak sempat menuliskan proses awalnya. Saya memutuskan untuk langsung menuliskan catatan di blog ini.

Sekenarionya secara sederhana akan seperti ini:

1. Membuat Shell *script* yang digunakan untuk menampilkan isi dari sebuah direktori, sekaligus dapat mengeksekusi isi file yang ada di dalamnya apabila dipilih.
2. Membuat Shell *script* yang digunakankan untuk memanggil `dunstify` yang akan menampilkan file text yang berisi daftar *keyboard shortcut*.
3. Membuat file text berisi daftar *keyboard shortcut*.

# Eksekusi

## Membuat Script File Browser

Pada tahap ke-1 ini, saya menyebut ini sebagai **file browser** karena secara global memang menggunakan perintah `ls` yang berarti *list* atau daftar. Namun dengan menambahkan kemampuan untuk eksekusi file yang dipilih.

1. Buat file bernama `help-script-browser.sh`.

   Saya memilih untuk meletakannya pada direktori `~/.config/rofi/`.

   {% shell_user %}
cd ~/.config/rofi
touch help-script-browser.sh
chmod +x help-script-browser.sh
vim help-script-browser.sh
{% endshell_user %}

   Isikan di dalamnya seperti ini.

   ```sh
   #!/bin/env sh

   # direktori target tempat script dunstify berada
   helpDir=~/.config/rofi-help

   # untuk menghandle argument
   if [ -n "$@" ]; then
   helpDir="${helpDir}/$@"
   fi

   # untuk menghandle apabila argument bukan merupakan direktori
   if [ ! -d "${helpDir}" ]; then
       coproc ( "${helpDir}" & > /dev/null  2>&1 )
       exit;
   fi

   # proses direktori target
   helpDir=$(readlink -e "${helpDir}")
   pushd "${helpDir}" >/dev/null

   # tampilkan hanya shell script kecuali file text
   ls --group-directories-first --hide="keybinds-*"
   ```

2. Apabila teman-teman menggunakan **i3wm** dan **Rofi**, tinggal kita buatkan konfigurasi `bindkey` nya saja. Pada konfigurasi i3wm.

   {% shell_user %}
vim ~/.config/i3/config
{% endshell_user %}

   Tambahkan seperti ini, kira-kira.

   ```sh
   # ...
   # ...

   # Keybind Bantuan
   bindsym $mod+F10 exec --no-startup-id rofi -modi "KEYBINDS:~/.config/rofi/help-script-browser.sh" -show KEYBINDS -lines 6 -width 300
   ```

   Dapat dilihat bahwa saya meletakkannya pada <kbd>SUPER</kbd>+<kbd>F10</kbd>.

   Silahkan menyesuaikan dengan preferensi masing-masing.

   Tahap ke-1, telah selesai.

## Membuat Script Dunstify

Pada tahap ke-2, saya akan membuat Shell *script* yang akan berpasangan dengan file text berisi daftar *keyboard shortcut*.

Jadi, pada tahap ini, satu Shell *script* mewakili satu file text.

Misalnya,

| <center>Shell Script</center> | <center>File Text</center> |
| :-- | :-- |
| `i3 Window Manager.sh` | `keybinds-i3.txt` |
| `MPV Video Player.sh` | `keybinds-mpv.txt` |
| `VIM Text Editor.sh` | `keybinds-vim.txt` |
| dst... | dst... |

1. Buat direktori khusus untuk menyimpan Shell *script* ini. Saya akan memilih membuat direktori baru dengan nama `~/.config/rofi-help/`.

   {% shell_user %}
mkdir -p ~/.config/rofi-help
{% endshell_user %}

2. Buat file Shell *script* dari *keyboard shortcut* yang akan kita gunakan.

   Misalkan i3wm. Namun, jangan berikan ekstensi `.sh` agar tampilannya lebih rapi.

   {% shell_user %}
cd ~/.config/rofi-help
touch "I3WM Window Manager"
chmod +x "I3WM Window Manager"
vim "I3 Window Manager"
{% endshell_user %}

   Kemudian isikan seperti ini.

   ```sh
   #!/bin/env sh
   dunstify "i3WM KEYBINDS:" "`tail -n 50 $HOME/.config/rofi-help/keybinds-i3`"
   ```

   Shell *script* di atas, memanggil file text dengan nama `keybinds-i3` yang akan kita buat setelah ini.


## Membuat Daftar Keyboard Shortcut

Pada tahap ke-3, kita perlu membuat file text yang berisi daftar dari *keyboard shortcut*.

Saya akan melanjutkan proses di atas. Yaitu membuat file text untuk daftar *keyboard shortcut* dari i3wm.

1. Masih pada direktori sebelumnya, yaitu di `~/.config/rofi-help/`.

   Buat file text dengan nama yang relevan dengan Shell *script* yang kita buat di atas.

   Dalam konteks ini, kita sedang membuat untuk daftar *keyboard shortcut* dari i3wm.

   {% shell_user %}
touch keybinds-i3
{% endshell_user %}

   **Perhatian!** Saya menggunakan aturan penamaan yang sama pada setiap file text. Yaitu, dengan memberikan awalan `keybinds-`.

   Tujuannya agar saat dipanggil dengan program `help-script-browser.sh`, semua file yang tidak berawalan `keybinds-`, tidak ikut ditampilkan di dalam rofi.

2. Selanjutnya tinggal mengisi daftar dari *keyboard shortcut* dari i3wm yang kita perlukan.

   Sebagai contoh, ini adalah beberapa daftar *keyboard shortcut* i3wm yang saya perlukan.

   ```
   <b>LAUNCHER--------------------------------</b>
   mod+Enter          Terminal
   mod+Shift+End      Sessions Dialog
   mod+Shift+x        Lock Screen
   mod+Shift+q        Kill Window Focus
   mod+Shift+r        Restart i3 Config
   mod+d              Rofi: App Launcher
   mod+Tab            Rofi: Window Switcher
   mod+/              Rofi: Help
   mod+p              Rofi: Clipboard
   mod+Shift+p        Clipboard Cleared
   mod+Print          Screenshot Silently
   mod+Shift+Print    Screenshot GUI
   mod+F7             Arandr
   mod+F8             Wifi ON/OFF [T]
   <b>LAYOUT----------------------------------</b>
   mod+s              Layout: Stacking
   mod+w              Layout: Tabbed
   mod+e              layout: Split [T]
   mod+b              Split Horizontal
   mod+v              Split Vertical
   mod+o              Blank Space
   <b>WINDOW----------------------------------</b>
   mod+f              Fullscreen Window [T]
   mod+r              Resize Window
   mod+Shift+Plus     Sticky Window [T]
   mod+Shift+Minus    Scratchpad Mode [T]
   mod+Minus          Scratchpad Show [T]
   mod+Shift+Space    Floating Window [T]
   mod+Space          Change Focus [T]
   mod+a              Focus Parent
   mod+Shidt+a        Focus Child
   <b>BORDER----------------------------------</b>
   mod+t              Border Normal 1
   mpd+shift+t        Border Normal 0
   mod+y              Border None
   mod+shift+y        Border Pixer 1
   <b>WALLPAPER-------------------------------</b>
   mod+F5             Blogging Mode
   mod+F6             Unixporn Mode
   ```

   Tinggi dari notifikasi ini tidak kurang dari 50 baris dan lebarnya tidak lebih dari 40 karakter.

   Pengaturan lebar dari notifikasi **Dunst** ini akan berbeda setiap dari teman-teman. Bergantung pada konfigurasi lebar notifikasi dunst yang teman-teman pergunakan (pada `dunstrc` bagian `geometry = `).

   Contoh-contoh daftar *keboard shortcut* yang saya pergunakan dapat di lihat pada dotfiles milik saya, [di sini](https://github.com/bandithijo/dotfiles/tree/master/.config/rofi-help){:target="_blank"}.


<br>
Silahkan menambahkan menambahkan sendiri untuk membuat daftar *keyboard shortcut* aplikasi yang lain. Dengan mengulang tahap ke-2 dan ke-3.

# Hasilnya

{% image https://i.postimg.cc/vZsSj7b9/gambar-01.gif | 1 | Demonstrasi hasil akhir dari semua proses di atas %}


# Pesan Penulis

Saya menyadari bahwa masih terdapat banyak kekurangan dari metode yang saya gunakan untuk membuat "bantuan pengingat *keyboard shortcut*" ini. Sehingga tidak menutup kemungkinan pada kesempatan berikutnya akan ada metode lain yang saya tulisakan kembali.

Mudah-mudahan catatan saya yang sederhana ini dapat memberikan inspirasi kepada teman-teman untuk membuat metode yang lebih baik.

Saya rasa, seperti ini saja.
