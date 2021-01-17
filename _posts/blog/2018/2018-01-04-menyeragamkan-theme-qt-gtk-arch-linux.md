---
layout: 'post'
title: 'Menyeragamkan Theme Qt dan GTK+ pada Arch Linux'
date: 2018-01-04
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Arch Linux', 'Tips']
pin:
hot:
contributors: []
---

<img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="https://3.bp.blogspot.com/-rVnxY2exXrI/WmWg56pxTKI/AAAAAAAAG8w/_9tne4RcflQOM7Y0g_WXL_EhKQ7iWmZzQCLcBGAs/s1600/Default%2BHeader%2BTemplate%2BPost%2B2X.png" onerror="imgError(this);" alt="banner">

# Latar Belakang
Sebagai pengguna GNU/Linux, tentu pernah mendapati beberapa aplikasi membawa _default theme_ yang terkadang tidak sesuai dengan _theme_ yang sedang kita gunakan. Sekedar informasi sedikit, tampilan _engine_ untuk GUI (_Graphical User Interface_) pada GNU/Linux yang banyak digunakan biasanya **GTK+** atau **Qt**. GTK+ biasanya digunakan oleh aplikasi yang dipaketkan bersama Gnome, sedangkan Qt biasanya digunakan oleh aplikasi yang dipaketkan bersama KDE.

Sekitar tahun 2005, saya masih merasakan KDE sebelum versi KDE 4. Disaat itu , saya benar-benar jatuh cinta dengan _Desktop Environment_ ini. Namun begitu memasuki KDE 4, yang saya masih ingat disaat itu adalah kepopuleran UI (_User Interface_) yang berdesain _glass look_. Saya tidak begitu menyukai desain-desain bergaya _glass look_ ini. Sekitar tahun 2009, saya mulai beralih menggunakan Ubuntu dengan Gnome yang menggunakan _engine_ GTK+, saya merasa cocok dengan tampilan UI dari GTK+ ini, hingga sekarang (2018). Meskipun saat ini saya sudah tidak menggunakan Gnome, tapi saya masih lebih memilih menggunakan paket-paket program aplikasi yang menggunakan GTK+.

Karena alasan tersebut di atas yang mendorong saya untuk menuliskan dokumentasi ini, bagaimana saya mengadaptasikan apikasi yang menggunakan _engine_ Qt agar terlihat seperti aplikasi _native_ GTK+. Sekaligus juga bagaimana mengganti _theme_ hanya pada aplikasi tertentu saja.

# Prasyarat
Ada beberapa paket yang perlu kita sediakan untuk menunjang pengaturan ini. Beberapa paket ini mungkin tidak langsung dipasang secara _default_ pada distro Arch Linux kalian. Paket-paket tersebut adalah :
1. [`adwaita-qt4`](https://aur.archlinux.org/packages/adwaita-qt4/){:target="_blank"} (AUR) *
2. [`adwaita-qt5`](https://aur.archlinux.org/packages/adwaita-qt5/){:target="_blank"} (AUR) *
3. [`qt5ct`](https://www.archlinux.org/packages/community/x86_64/qt5ct/){:target="_blank"}

Paket _optional_ ( * ), tidak wajib dipasang.

Kalian dapat melihat bahwa saya juga memasang _theme_ `adwaita-qt4` dan `adwaita-qt5`, karena saya menyukai _theme_ Adwaita. Jadi untuk kedua paket ini bersifat _optional_.

Sedangkan paket `qt5ct` adalah paket wajib yang akan kita gunakan untuk mengatur _environtment_ GUI untuk semua aplikasi yang menggunakan Qt5. Untuk aplikasi yang menggunakan Qt4, terdapat aplikasi bernama `qtconfig-qt4`, namun sepertinya palikasi ini sudah jadi satu _bundle_ apabila memasang _engine_ Qt4. Saya kurang begitu paham.

Pasang paket-paket yang dibutuhkan. Paket wajib,

{% shell_user %}
sudo pacman -S qt5ct
{% endshell_user %}

Paket tambahan,

{% shell_user %}
pacaur -S adwaita-qt4 adwaita-qt5
{% endshell_user %}

Atau

{% shell_user %}
yaourt adwaita-qt4; yaourt adwaita-qt5
{% endshell_user %}

# Penerapan
Kita dapat melakukan dua macam konfigurasi. Penerapan konfigurasi secara global atau penerapan hanya pada aplikasi tertentu.

## Global
### GTK+
Karena saya sudah menggunakan _desktop environment_ yang mayoritas menggunakan _engine_ GTK+, baik 2 maupun 3, makan untuk konfigurasi global, saya cukup menggunakan _Settings_ atau _Preferences_ yang disediakan oleh _desktop environment_ untuk mengganti _theme_ yang saya mau. Selain itu juga dapan menggunakan aplikasi bernama [`lxappearance`](https://www.archlinux.org/packages/community/x86_64/lxappearance/){:target="_blank"}.

### Qt5
Untuk penerapan konfigurasi ini, dampaknya adalah semua aplikasi yang menggunakan _engine_ Qt5 akan terpengaruh.

Konfigurasinya cukup mudah karena kita menggunakan aplikasi GUI yang bernama Qt5 Settings (`qt5ct`).

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://1.bp.blogspot.com/-qTQQ9JJm6JU/WmWjOErMKhI/AAAAAAAAG9I/1-Ny_Rsw5i8IhlsqRTytmPH8MAh1qilwwCLcBGAs/s1600/Screenshot%2Bfrom%2B2018-01-21%2B18-56-24.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 1 - Qt5 Settings</p>

Tampilan GUI Qt5 Settings seperti pada Gambar 1. Kalian dapat melihat pada bagian “_Style_” saya menggunakan Adwaita _theme_.

Dengan menggunakan Qt5 Settings, kalian dapat mengatur _Appearance_, _Fonts_, _Icon Theme_, _Interface_, dan _Style Sheets_.

Qt5 Settings ini sendiri menggunakan _engine_ Qt5, sehingga juga akan ikut terpengaruh terhadap perubahan pengaturan yang dilakukan.

## Specific Apps
Untuk penerapan konfigurasi pada aplikasi spesifik yang kita inginkan, kita dapat mengaturnya dengan mengedit nilai dari parameter `Exec=` pada file `.desktop` dari aplikasi tersebut.

Kita perlu menyesuaikan nilai yang kita tulis pada parameter `Exec=` sesuai dengan _engine_ yang digunakan oleh aplikasi tersebut. Apakah menggunakan GTK+2, GTK+3, atau Qt5?

Langkah-langkah awalnya sebagai berikut.

1. **Cek lokasi .desktop**

    _Launcher_ dari aplikasi biasanya tersimpan pada dua lokasi yang berbeda. Global dan lokal.

    * Global tersimpan pada `/usr/share/applications/`
    * Lokal tersimpan pada `.local/share/applications/`

    Yang akan kita modifikasi adalah `.desktop` yang ada pada lokal, jadi kita lakukan pengecekan pada direktori `.local/share/applications/` apakah terdapat file bernama `org.gnome.Nautilus.desktop`.

    Apabila tidak ditemukan, kita lanjut melakukan pencarian ke lokasi global di `/usr/share/applications/`.

2. **Copy ke direktori lokal**

    Setelah ketemu, _copy_ file `org.gnome.Nautilus.desktop` ke direktori lokal yaitu di `.local/share/applications/`.

    ><p class="title-quote">Mengapa harus dicopy ke direktori lokal ?</p>
    >Agar apabila sewaktu-waktu apabila kita memerlukan kembali, kita dapat mengeditnya kembali tanpa memerlukan _sudo permission_. Dengan mecopy ke dalam direktori lokal, maka tidak akan merusak pengaturan `.desktop` asli yang tersimpan pada direktori global.
    >
    >Saya lebih merekomendasikan cara ini.


### GTK+3

Saya mencontohkan dengan menggunakan aplikasi `nautilus`. Kalian dapat mencoba pada aplikasi yang lain. Tentu saja yang juga menggunakan GTK+3.

Untuk langkah awal, dapat di lihat pada langkah 1 dan 2 yang sudah dijelaskan pada baris <a href="/posts/mengatur-theme-qt-gtk-arch-linux#specific-apps">di atas</a>.

1. **Edit isi .dekstop**

   Untuk dapat mengubah pengaturan _theme_ secara spesifik pada aplikasi tertentu, kita akan mengedit isi dari `.desktop` aplikasi yang kita ingin ubah.
   <pre>
   $ <b>vim .local/share/applications/org.gnome.Nautilus.desktop</b></pre>

2. **Modifikasi nilai dari parameter Exec=**

   Cari baris yang berawalan `Exec=`, kemudian tambahkan nilai seperti contoh di bawah, sesuai dengan _engine_ yang digunakan oleh aplikasi tersebut.

   >Untuk aplikasi yang menggunakan GTK+3 tambahkan,
   >
   ><code>Exec=<mark>env GTK_THEME=namatema</mark> ...</code>

   Karena Nautilus adalah aplikasi yang menggunakan GTK+3, maka akan seperti di bawah ini hasilnya.

   <pre>
   $ <b>vim .local/share/applications/org.gnome.Nautilus.desktop</b></pre>

   {% highlight_caption $HOME/.local/share/applications/org.gnome.Nautilus.desktop %}
   <pre class="caption">
   #!/usr/bin/env xdg-open
   [Desktop Entry]
   Name=Nautilus
   ...
   ...
   Exec=<mark>env GTK_THEME=Adwaita</mark> nautilus --new-window %U
   ...
   ...</pre>

   Adwaita juga memiliki _dark theme_, kita dapat menggunakannya dengan cara seperti ini.
   <pre>
   Exec=<mark>env GTK_THEME=Adwaita-dark</mark> nautilus --new-window %U</pre>

### GTK+2

Saya mencontohkan dengan menggunakan aplikasi `inkscape`. Kalian dapat mencoba pada aplikasi yang lain. Tentu saja yang juga menggunakan GTK+2 seperti `gimp` atau `dia`.

Untuk langkah awal, dapat di lihat pada langkah 1 dan 2 yang sudah dijelaskan pada baris <a href="/posts/mengatur-theme-qt-gtk-arch-linux#specific-apps">di atas</a>.

1. **Edit isi .dekstop**

   Untuk dapat mengubah pengaturan _theme_ secara spesifik pada aplikasi tertentu, kita akan mengedit isi dari `.desktop` aplikasi yang kita ingin ubah.

   <pre>
   $ <b>vim .local/share/applications/inkscape.desktop</b></pre>

2. **Modifikasi nilai dari parameter Exec=**

   Cari baris yang berawalan `Exec=`, kemudian tambahkan nilai seperti contoh di bawah, sesuai dengan _engine_ yang digunakan oleh aplikasi tersebut.

   >Untuk aplikasi yang menggunakan GTK+2 tambahkan,
   >
   ><code>Exec=<mark>env GTK2_RC_FILES=/tema_yang_mempunyai/gtkrc</mark> ...</code>

   Karena Inkscape adalah aplikasi yang menggunakan GTK+2, maka akan seperti di bawah ini hasilnya.
   <pre>
   $ <b>vim .local/share/applications/inkscape.desktop</b></pre>

   {% highlight_caption $HOME/.local/share/applications/inkscape.desktop %}
   <pre class="caption">
   [Desktop Entry]
   Name=Inkscape
   ...
   ...
   Exec=<mark>env GTK2_RC_FILES=/usr/share/themes/NumixSolarizedLightBlue/gtk-2.0/gtkrc</mark> inkscape %F
   ...
   ...</pre>

### Qt5

Saya akan mencontohkan dengan menggunakan aplikasi `vokoscreen`. Kalian dapat mencoba pada aplikasi yang lain. Tentu saja yang juga menggunakan Qt5.

Untuk langkah awal, dapat di lihat pada langkah 1 dan 2 yang sudah dijelaskan pada baris <a href="/posts/mengatur-theme-qt-gtk-arch-linux#specific-apps">di atas</a>.

1. **Edit isi .dekstop**

   Untuk dapat mengubah pengaturan _theme_ secara spesifik pada aplikasi tertentu, kita akan mengedit isi dari `.desktop` aplikasi yang kita ingin ubah.

   <pre>
   $ <b>vim .local/share/applications/vokoscreen.desktop</b></pre>

2. **Modifikasi nilai dari parameter Exec=**

   Cari baris yang berawalan `Exec=`, kemudian tambahkan nilai seperti contoh di bawah, sesuai dengan _engine_ yang digunakan oleh aplikasi tersebut.

   >Untuk aplikasi yang menggunakan Qt5 tambahkan,
   >
   ><code>Exec=<mark>env QT_STYLE_OVERRIDE=Adwaita</mark> ...</code>

   Karena Vokoscreen adalah aplikasi yang menggunakan Qt5, maka akan seperti di bawah ini hasilnya.

   <pre>
   $ <b>vim .local/share/applications/vokoscreen.desktop</b></pre>

   {% highlight_caption $HOME/.local/share/applications/vokoscreen.desktop %}
   <pre class="caption">
   [Desktop Entry]
   Name=vokoscreen
   ...
   ...
   Exec=<mark>env QT_STYLE_OVERRIDE=Adwaita</mark> vokoscreen
   ...
   ...</pre>

   ><p class="title-quote">[ ! ] Perhatian</p>
   >Saya menggunakan tema Adwaita yang khusus untuk Qt, maka dari itu di awal dokumentasi ini, paket `adwaita-qt4` dan `adwaita-qt5`, saya ikut sertakan untuk dipasang.
   >
   >Untuk penggunaan tema lain, mungkin bisa menggunakan `breeze` atau tema Qt yang lain, saya kurang begitu paham untuk tema-tema yang digunakan pada Qt.


<br>
Nah, mudah bukan ?

Kebebasan seperti ini yang membuat saya betah menggunakan sistem operasi GNU/Linux.

# Referensi
1. [wiki.archlinux.org/index.php/Uniform_look_for_Qt_and_GTK_applications](https://wiki.archlinux.org/index.php/Uniform_look_for_Qt_and_GTK_applications){:target="_blank"}
<br>Diakses tanggal: 2018/01/22
