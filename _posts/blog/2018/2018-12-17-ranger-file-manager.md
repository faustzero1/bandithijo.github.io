---
layout: 'post'
title: 'Ranger, Terminal Based File Manager yang Ternyata Sangat Memudahkan'
date: 2018-12-17 09:18
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Terminal', 'Tools', 'Tips', 'Ulasan']
pin:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="#" alt="banner"> -->

# Prakata

Ranger adalah *text-based file manager* (aplikasi untuk memanajemen file bebasis teks) yang ditulis dengan bahasa Python.

Ranger menampilkan konten dalam bentuk kolom per kolom. Terdapat tiga buah kolom, yaitu: kolom direktori sebelumnya, direktori sekarang, dan file preview atau direktori selanjutnya.

<!-- IMAGE CAPTION -->
![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/TY3F2Fbw/gambar-01.gif"}
<p class="img-caption">Gambar 1 - Antar muka Ranger. (1) Direktori sebelumnya, (2) Direktori Sekarang, (3) Direktori Selanjutnya atau file preview</p>

<!-- IMAGE CAPTION -->
![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/02X3znGC/gambar-02.png"}
<p class="img-caption">Gambar 2 - Kolom ke-3 menampilkan konten dari file teks</p>

<!-- IMAGE CAPTION -->
![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/y8wbPNbg/gambar-03.png"}
<p class="img-caption">Gambar 3 - Kolom ke-3 menampilkan preview dari gambar</p>

<!-- IMAGE CAPTION -->
![gambar_4]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/rwdHx4Q2/gambar-04.png"}
<p class="img-caption">Gambar 4 - Kolom ke-3 menampilkan detail dari audio atau video file</p>

<br>
**Gimana keren yaa?**

Menurut saya sih keren. Kekerenan nomor satu, karena *file manager* ini sudah dapat menampilkan *preview* dari file yang sedang kita seleksi - bahasa kitanya, mengintip. Yang paling berguna dan sering saya manfaatkan adalah *preview* untuk file gambar dan teks. Jujur saja, kalau pada *file manager* GUI, saya harus membuka file teks dan gambar tersebut terlebih dahulu untuk melihat isinya.

Kekerenan nomor dua adalah, *Vim-style key bindings*, pencet-pencetan yang mirip dengan Vim. Dengan begini, tidak perlu lama beradaptasi. Setidaknya dalam hal navigasi, tinggal <kbd>H</kbd> <kbd>J</kbd> <kbd>K</kbd> <kbd>L</kbd>. Tinggal mempelajari fitur-fitur lain yang dimiliki oleh Ranger yang biasa saya gunakan pada *file manager* lain.

Sejauh ini, fitur-fitur yang saya pergunakan adalah:
1. Navigasi yang super efektif dengan pencet-pencetan ala Vim.
2. Selections
3. Copy dan paste dengan pencet-pencetan yang super.
4. Termasuk juga kemampuan membuat *symbolic link* dengan super mudah
5. Bookmarks
6. Tagging
7. Tabs
8. dll.

Kekerenan nomor tiga adalah, nama Ranger itu sendiri. Ini subjektif saya memang. Hahahaha. Tapi iya bukan? Keren kan? Ranger. Ndak malu-maluin lah kalo ditanya sama temen, "Kamu pake apa itu, Bro?" Dengan bangga kita persembahkan jawaban, "Ranger."

Masih banyak fitur-fitur dari Ranger yang belum saya manfaatkan. Tapi saya tidak khawatir dan terburu-buru, biarlah proses belajar yang akan menuntun saya mencoba fitur-fitur lain yang dimiliki oleh Ranger.

Jadi, apa kalian mau ikut?

Tiga bulan, enam bulan, satu tahun dari sekarang mungkin kemampuan saya dalam menggunakan Ranger akan bertambah. Siapa yang tahu.

Tentukan pilihanmu, Bro.

*I hate to say,"I told you so."*


<!-- INFORMATION -->
<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>Ranger bukan merupakan <i>Terminal based file manager</i> yang paling cepat dan terbaik. Sebagian orang menyebutnya sangat <i>bloated</i> (buncit) maksudnya, banyak fitur-fitur yang sebenarnya tidak kita perlukan. Karena kebutuhan setiap orang berbeda-beda.</p>
<p>Sebagaian orang juga mengatakan Ranger lambat karena ditulis dengan bahasa pemrograman Python.</p>
<p>Namun bagi saya, itu pendapat mereka, dan ini pilihan saya. Pasti ada alasan dan tujuan yang baik, mengapa Ranger sudah membawa banyak fitur secara <i>default</i>.</p>
</div>

# Instalasi

Proses instalasi Ranger, saya rasa sudah pasti sangat mudah. Hanya tinggal menggunakan paket manajer dari distribusi sistem operasi teman-teman.
```
$ sudo pacman -S ranger
```

Instalasi juga paket-paket tambahan yang diperlukan untuk membuat Ranger lebih "wow".

```
$ sudo pacman -S highlight odt2txt pdftotext mediainfo
```

Lalu untuk image preview.

```
$ sudo pacman -S w3m
```

## Membuat App Launcher

Seperti biasa kita perlu membuat `.desktop` agar mudah dipaggil dengan *application launcher* seperti dmenu dan rofi sehingga tidak perlu membuka Terminal terlebih dahulu.
```
$ vim ~/.local/share/applications/ranger.desktop
```
<pre>
[Desktop Entry]
Type=Application
Name=ranger
Comment=Launches the ranger file manager
Icon=ranger
Terminal=false
<mark>Exec=st -e ranger</mark>
Categories=ConsoleOnly;System;FileTools;FileManager
MimeType=inode/directory;
</pre>
Pada bagian `Exec=`, sesuaikan dengan Terminal emulator yang teman-teman pergunakan

# Konfigurasi

Apabila kita langsung menjalankan Ranger saat ini, maka Ranger akan menggunakan *default config*. Saya lebih *prefer* untuk menggunakan konfigurasi saya sendiri, karena lebih bebas untuk dimodifikasi dalam hal *colorscheme*, *key bindings*, dll.

Saat kita menjalankan ranger pertama kali, Ranger akan secara otomatis membuatkan direktori config untuk kita yang terdapat pada `~/.config/ranger/`. Namun, belum terdapat file apapun di dalamnya.

Untuk mengcopy *default configuration files*, kita perlu menjalankan perintah di bawah.
```
$ cd ~/.config/ranger
$ ranger --copy-config=all
```
```
creating: /home/bandithijo/.config/ranger/rifle.conf
creating: /home/bandithijo/.config/ranger/commands.py
creating: /home/bandithijo/.config/ranger/commands_full.py
creating: /home/bandithijo/.config/ranger/rc.conf
creating: /home/bandithijo/.config/ranger/scope.sh

> Please note that configuration files may change as ranger evolves.
  It's completely up to you to keep them up to date.

> To stop ranger from loading both the default and your custom rc.conf,
  please set the environment variable RANGER_LOAD_DEFAULT_RC to FALSE.
```
Sekarang coba lihat isi dari direktori `~/.config/ranger/` saat ini.
```
$ ls -al
```
```
drwxr-xr-x .
drwxr-xr-x ..
-rw-r--r-- commands_full.py
-rw-r--r-- commands.py
-rw-r--r-- rc.conf
-rw-r--r-- rifle.conf
-rwxr-xr-x scope.sh
```
Langkah selanjutnya, kita akan mengkonfigurasi file `rc.conf`.

## rc.conf - Konfigurasi Options

Oke, sekarang kita sudah memiliki file configurasi dasar. Selanjutnya coba periksa terlebih dahulu bagaimana bentuk dari isi file `rc.conf`.
```
$ vim rc.conf
```
Dapat teman-teman lihat, isi dari file `rc.conf`. Sangat mudah dipahami bukan?

Kita langsung dapat memahami arti dari baris perintah karena terdapat komentar yang ditulis dengan jelas.

Seperti besar perbandingan lebar dari kolom den berapa banyak kolom.
```
# How many columns are there, and what are their relative widths?
set column_ratios 1,3,4
```

Tidak banyak yang harus saya rubah. Tapi saya akan bahas, apa saja yang saya modifikasi.

Tentunya teman-teman tidak harus mengikuti konfigurasi saya. Silahkan bereksplorasi sendiri.

### Konfirmasi Saat Delete

Terdapat *key bindings* untuk melakukan *recursive delete* seperti `rm`. Tentunya kita perlu hati-hati terhadap hal ini. Kita menghindari apabila suatu waktu kita mengalami *human error*. Untuk itu perlu sekali membuat langkah antisipasi. Salah satunya dengan mmberikan konfirmasi saat akan melakukan *recursive delete/remove*.
```
# Ask for a confirmation when running the "delete" command?
# Valid values are "always", "never", "multiple" (default)
# With "multiple", ranger will ask only if you delete multiple files at once.
set confirm_on_delete always
```
Secara *default* bernilai `multiple`, hanya menampilkan konfirmasi saat menghapus banyak file/direktori. Namun, saya lebih *prefer* untuk menggunakan value `always`. Agar setiap file/direktori yang akan saya *recursive delete* selalu ditampilkan konfirmasi untuk saya tinjau kembali. Dengan begini dapat meminimalisir dampak dari *human error*. Hehehe.


### Aktifkan Preview Script

Saya merekeomendasikan untuk mengaktifkan variabel ini `preview_script`.
```
# Use non-default path for file preview script?
# ranger ships with scope.sh, a script that calls external programs (see
# README.md for dependencies) to preview images, archives, etc.
set preview_script ~/.config/ranger/scope.sh
```
Hilangkan tanda pagar pada `set preview_script ...`.

Kegunaanya untuk memberikan kemapuan preview pada Ranger untuk menjadi lebih super. Hahaha.

Sekarang buka dan edit file `~/.config/ranger/scope.sh`.
```
$ vim ~/.config/ranger/scope.sh
```
Nah, sekarang tinggal teman-teman cari dan pilih ekstensi dari file apa yang akan diaktifkan.

Sebagai gambaran saya mengaktifkan fitur untuk menampilkan file dengan ekstensi `SVG` dan `PDF`. Secara *default* masih dalam keadaan ter-*comment*. Kita perlu meng-*enable*-kannya.

Lihat saja contoh di bawah untuk mengetahui bagian mana saja yang perlu di-*uncomment*.
<pre>
...
...

# SVG
<mark>image/svg+xml)
    convert "${FILE_PATH}" "${IMAGE_CACHE_PATH}" && exit 6
    exit 1;;</mark>

...
...
</pre>
<pre>
...
...

# PDF
<mark>application/pdf)
    pdftoppm -f 1 -l 1 \
                -scale-to-x 1920 \
                -scale-to-y -1 \
                -singlefile \
                -jpeg -tiffcompression jpeg \
                -- "${FILE_PATH}" "${IMAGE_CACHE_PATH%.*}" \
                && exit 6 || exit 1;;</mark>

...
...
</pre>
Dengan mengaktifkan kedua *section* di atas, yaitu `SVG` dan `PDF`, Ranger akan memiliki kemampuan untuk menampilkan *preview* dalam bentuk gambar dari file `.png` dan `.pdf`. Sehinggal kita tidak perlu untuk membukanya terlebih dahulu. Sangat *convenient* sekali bukan?

Sengaja saya tidak mengaktifkan `VIDEO`. Tidak ada alasan apa-apa, hanya masalah selera saja.


### Menampilkan Gambar

Untuk menampilkan gambar, Ranger memerlukan paket bernama `w3m`. Silahkan dipasang terlebih dahulu apabila belum.
```
$ sudo pacman -S w3m
```
Selanjutnya, tinggal meng-*enable*-kan konfignya.
```
# Use one of the supported image preview protocols
set preview_images true

# ...
# ...
set preview_images_method w3m

# Delay in seconds before displaying an image with the w3m method.
# Increase it in case of experiencing display corruption.
set w3m_delay 0.01

```

### Memilih Colorscheme

Secara *default*, Ranger sudah menyertakan *colorscheme* bawaan, yaitu: default, jungle, snow, solarized. Saat ini kita masih menggunakan *colorscheme* default. Coba ganti dengan *colorscheme* lain yang disediakan.
```
# Which colorscheme to use?  These colorschemes are available by default:
# default, jungle, snow, solarized
set colorscheme solarized
```
Teman-teman juga dapat memodifikasi atau membuat sendiri *colorscheme* sesuai yang teman-teman inginkan.

Caranya, dengan mendownload *coloscheme* dasar dari repositori GitHub.
```
$ mkdir -p ~/.config/ranger/colorschemes
$ cd ~/.config/ranger/colorschemes
$ wget https://raw.githubusercontent.com/ranger/ranger/master/ranger/colorschemes/default.py
$ wget https://raw.githubusercontent.com/ranger/ranger/master/ranger/colorschemes/jungle.py
$ wget https://raw.githubusercontent.com/ranger/ranger/master/ranger/colorschemes/snow.py
$ wget https://raw.githubusercontent.com/ranger/ranger/master/ranger/colorschemes/solarized.py
```
Sekarang tinggal bereksplorasi dengan warna.

Jangan lupa untuk megeset *colorscheme* yang teman-teman modif pada file `rc.conf`.

Saya sendiri menggunakan *colorscheme* solarized hasil modifan sendiri. Karena terdapat beberapa bagian warna yang saya kurang begitu suka. Hehehe.

Mengenai memodifikasi warna dalam *colorscheme*, sepertinya tidak ingin saya tulis dulu saat ini. Terlalu panjang.


### Mengaktifkan Border

Kalian juga dapat mengaktifkan border, karena secara *default*, variable ini dalan keadaan `none`.
```
# Draw borders around columns? (separators, outline, both, or none)
# Separators are vertical lines between columns.
# Outline draws a box around all the columns.
# Both combines the two.
set draw_borders none
```
Saya sendiri termasuk yang tidak begitu senang menggunakan border.


### Mengaktifkan Line Number

Untuk dapat memudahkan kita dalam bernavigasi antar baris, berlompat-lompat antar baris seperti pada Vim, Ranger memberikan kita fitur untuk menampilkan *line numbers*. Terdapat tiga pilihan: *false*, *absolute*, dan *relative*.
```
# Disable displaying line numbers in main column.
# Possible values: false, absolute, relative.
set line_numbers relative
```
Saya lebih senang menggunakan `relative` karena lebih memudahkan untuk navigasi.

### Scroll Wrapping

Untuk memudahkan navigasi juga, saya lebih senang mengaktifkan fitur *scroll wrapping*, agar ketika saya sudah melakukan *scrolling* sampai bawah, saya dapat dengan mudah menuju ke atas.
```
# Enable scroll wrapping - moving down while on the last item will wrap around to
# the top and vice versa.
set wrap_scroll true
```

## rc.conf - Konfigurasi Key Bindings

Tidak banyak modifikasi *key bindings* yang saya modifikasi. Karena saya berusaha untuk membiasakan dengan *key bindings* yang sudah ada. Toh dalam hal navigasi dasar mirip-mirip dengan Vim.

Saya hanya merubah dua buah *keyborad shortcut*.

Untuk membuka Terminal pada direktori yang sedang aktif. Karena secara *default* apabila kita menekan tombol <kbd>S</kbd>, maka interface Ranger akan berubah menjadi Shell pada direktori yang aktif. Sedangkan saya ingin sambil membuka Terminal tetap dapat menggunakan Ranger.
<pre>
...
...
map w taskview_open
#map S shell $SHELL
<mark>map S terminal</mark>

map :  console
..
..
</pre>

Modifikasi *keyboard* yang lain adalah saya merubah fungsi tombol <kbd>DELETE</kbd>.
<pre>
# In case you work on a keyboard with dvorak layout
...
...
...
map &lt;CR&gt;       move right=1
#map &lt;DELETE&gt;   console delete
<mark>map &lt;DELETE&gt;   shell -s trash-put %s</mark>
map $lt;INSERT&gt;   console touch%space
...
...
</pre>
Saya menggunakan aplikasi `trash-cli`, agar file/direktori yang saya hapus dengan tombol <kbd>DELETE</kbd> tidak langsung lenyap, tetapi masuk ke Trash. Sayangnya saya belum dapat membuatnya menampilkan konfirmasi terlebih dahulu.

Untuk memasang aplikasi `trash-cli` cukup psaang dengan paket manager masing-masing.
```
$ sudo pacman -S trash-cli
```
Untuk penggunaan `trash-cli`, seperti: *restore*, *empty-trash*, dll. dapat dieksplorasi sendiri yaa.

## rifle.conf - Konfigurasi File Executor/Opener

File `rifle.conf` ini adalah file konfigurasi yang digunakan untuk mendaftarkan file tipe apa saja dan akan dieksekusi oleh aplikasi/prgram apa file tersebut.

Saya akan berikan satu saja contoh, saya yakin teman-teman langsung akan mengerti fungsi dari file `rifle.conf` ini.

Misal, terdapat file `.pdf`, nah, teman-teman ingin membuka file ini secara *default* dengan apa? atau dapat juga kita buatkan pilihan seperti *open with* pada *file manager* GUI.

```
#-------------------------------------------
# Documents
#-------------------------------------------
ext pdf, has evince,    X, flag f = evince -- "$@"
ext pdf, has calibre,   X, flag f = calibre -- "$@"
...
...
```
Dari konfigurasi di atas, sederhananya, saya membuat file `.pdf` akan terbuka dengan `evince` secara *default* apabila saya menekan tombol <kbd>L</kbd> atau <kbd>ENTER</kbd>.

Nah, apabila saya ingin membukanya dengan `calibre`, kita dapat menekan tombol <kbd>R</kbd>. Ranger akan menampilkan pilihan yang mirip sseperti menu *Open with...*.

<!-- IMAGE CAPTION -->
![gambar_5]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/QC91qj2M/gambar-05.gif"}
<p class="img-caption">Gambar 5 - Ilustrasi penggunaan tombol R, seperti menu <i>Open with...</i></p>

Jika ingin memilih `calibre`, pilih `1`, lalu tekan <kbd>ENTER</kbd>. Maka, file `.pdf` tersebut akan terbuka dengan `calibre`.

Pilihan `0` adalah *default program* yang akan dibuka apabila kita langsung menekan <kbd>ENTER</kbd> / <kbd>L</kbd>.

Nah, sekarang silahkan bereksplorasi dengan file `rifle.conf` ini.

Apabila ingin membandingkan file `rifle.conf` dengan milik saya, teman-teman dapat berkunjung [ke sini](https://github.com/bandithijo/dotfiles/blob/master/.config/ranger/rifle.conf){:target="_blank"}.

## Konfigurasi Plugins

Sejauh ini saya belum banyak menggunakan plugins. Plugins yang baru saya gunakan hanya [**alexanderjeurissen/ranger_devicons**](https://github.com/alexanderjeurissen/ranger_devicons){:target="_blank"}.

Proses instalasinya juga terbilang mudah. Hanya tinggal *clone* repo GitHubnya di mana saja. Letakkan di tempat terbaik. Lalu jalankan `$ make install`.

`ranger_devicons` akan membuat direktori `/plugins/` secara otomatis.

Sekarang buka Ranger dan lihat, sudah terdapat icon disamping name file/direktori.

Untuk unintsall juga mudah, tinggal `$ make uninstall`.

# Pesan Penulis

Sepertinya seperti ini dahulu. Mungkin tulisan ini akan mengalami update, tapi saya tidak bisa janji. Silahkan diekplorasi sendiri lebih jauh.

Apabila membutuhkan bantuan, dapat membaca `man ranger`.

Apabila sedang di dalam Ranger dapat memanggil pilihan bantuan dengan menekan tombol <kbd>?</kbd>. Nanti akan keluar pilihan:
1. <kbd>M</kbd> untuk *manual page*
2. <kbd>K</kbd> untuk melihat *Key Bindings* yang tersedia
3. <kbd>C</kbd> untuk melihat daftar *commands*
4. <kbd>S</kbd> untuk melihat variabel-variabel *settings*
5. <kbd>Q</kbd> untuk keluar

Sekian catatan ini saya tulis. Mudah-mudahan catatan yang masih belum sempurna ini dapat sedikit membantu memberikan gambaran, seperti apa *Terminal based file manager* yang bernama Ranger.

# Update Berikutnya

Masih terdapat beberapa hal yang belum sempat saya tuliskan. Seperti:
1. Permasalahan menampilkan gambar pada Terminal emulator tertentu
2. Fungsi-fungsi yang sama dengan GUI *file manager*, seperti: *copy paste*, *selected*, *tab*, *symbolic link*, dll.
3. dll.


# Referensi

1. [github.com/ranger/ranger](https://github.com/ranger/ranger){:target="_blank"}
<br>Diakses tanggal: 2018/12/17

2. [wiki.archlinux.org/index.php/Ranger](https://wiki.archlinux.org/index.php/Ranger){:target="_blank"}
<br>Diakses tanggal: 2018/12/17

