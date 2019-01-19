---
layout: 'post'
title: 'Mendapatkan Info Update Artikel Terbaru Blog/Website dengan Newsboat'
date: 2018-12-12 06:44
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Terminal', 'Tools', 'Tips']
pin:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="" alt="banner"> -->

# Prakata

Sejak di rumah sudah dipasang akses internet, saya mulai konstan untuk menjelajah berbagai macam website. Terkadang ada beberapa website menarik yang selalu saya ikuti. Semakin lama, jumlah website yang saya kunjungi semakin banyak, dan sangat melelahkan membukanya satu-persatu. Terkadang saat saya berkunjung, tidak terdapat informasi terbaru (biasanya pada blog/news). Misalkan ada 10 saja website yang ingin kita kunjungi satu per satu, namun sayangnya tidak dari semuanya sudah memiliki artikel baru. Tidak efisien bukan? Bayangkan bila 10, 20, 50 website yang harus kita kunjungi.

Dari masalah di atas, tentu saja saya menggunakan *bookmark* yang ada di *browser* untuk mencatat alamat-alamat website favorit saya. Hanya saja, lama-kelamaan menjadi kegiatan yang tidak efektif karena saya harus membuka dulu website serta me-*load* konten-konten yang ada di dalamnya, namun tidak menemukan update artikel terbaru.

# Pemecahan Masalah

Kita dapat menggunakan fitur **RSS** (*RDF Site Summary*/*Rich Site Summary*/*Really Simple Syndication*). RSS adalah salah satu tipe dari web feed yang memungkinkan pengguna untuk mendapatkan akses dari update konten online. Dengan menggunakan RSS reader kita akan dengan mudah mendapatkan pemberitahuan mengenai artikel terbaru dari website yang kita favoritkan.

**Hari gini siapa yang masih menggunakan RSS?**

Entahlah, namun saya masih menggunakannya karena sangat memudahkan aktifitas saya dalam hal memanajemen aset-aset informasi dari blog/website yang banyak.

Setelah melihat beberapa YouTuber yang *concent* terhadap GNU/Linux memanfaatkan fitur RSS feed reader untuk memanajeman daftar website yang mereka ikuti, saya pun baru mengerti kegunaan dari RSS feed ini.

Saya sendiri termasuk yang *aware* terhadap keberadaan RSS feed pada sebuah blog/website.


# Instalasi

Kita membutuhkan aplikasi RSS feed reader untuk mengumpulkan semua daftar RSS dari website yang kita favoritkan.

Aplikasi yang saya rekomendasikan adalah [`newsboat`](https://www.archlinux.org/packages/community/x86_64/newsboat/){:target="_blank"}. Newsboat adalah aplikasi yang berjalan di atas Terminal.

1. Pasang aplikasi `newsboat`.
```
$ sudo pacman -S newsboat
```
Sesuaikan dengan distribusi sistem operasi GNU/Linux masing-masing.

2. Karena aplikasi ini berjalan di atas Terminal dan belum tersedia *application launcher*-nya, maka kita perlu membuatnya sendiri.
```
$ vim .local/share/applications/newsboat.desktop
```
<pre>
[Desktop Entry]
Name=newsboat
Comment=Newsbeuter is an open-source RSS/Atom feed reader for text terminals.
<mark>Exec=urxvt -e newsboat</mark>
Icon=liferea
Terminal=false
Type=Application
StartupNotify=true
Categories=Network;News;
Keywords=news;feed;aggregator;blog;podcast;
</pre>
Pada bagian `Exec=`, Terminal emulator `urxvt` mungkin ingin diganti dengan Terminal emulator yang teman-teman gunakan, misal: `gnome-terminal`, `xfce4-terminal`, `termite`, `konsole`, dan lain sebagainya. Perhatikan `-e` tidak berlaku untuk semua Terminal Emulator. Beberapa diantara yang lainnya menggunakan `-x`.

# Konfigurasi

Sebelum kita jalankan, sebaiknya kita konfigurasi terlebih dahulu. Karena newsboat tidak dapat menjalankan apa-apa tanpa ada alamat RSS feed di dalamnya. Kalian dapat meletakkan file konfigurasi pada direktori `~/.newsboat/`, namun saya lebih menyukai meletakkan file konfigurasi pada direktori `~/.config/newsboat/`.

```
$ mkdir -p ~/.config/newsboat
```

Setelah itu di dalam direktori `~/.config/newsboat/` ini, kita perlu membuat 2 buah file, yaitu `config` dan `urls`.

File `config` diperlukan untuk pengaturan dari newsboat, seperti: *keyboard shortcuts*, *colorscheme*, dll. Sedangkan file `urls` diperlukan untuk menempakatan semua koleksi alamat RSS feed yang kita favoritkan.

## Membuat File Konfigurasi

Kita akan membuat file konfigurasi. Pada tahap ini teman-teman dapat mencontoh konfigurasi yang saya miliki.

```
$ vim ~/.config/newsboat/config
```
```
auto-reload yes
datetime-format "%Y/%m/%d, %R"

external-url-viewer "urlview"

# ----------------------------------------------------------------------------
# Shortcut Keys
# ----------------------------------------------------------------------------
bind-key j down
bind-key k up
#bind-key j next articlelist
#bind-key k prev articlelist
bind-key J next-feed articlelist
bind-key K prev-feed articlelist
bind-key G end
bind-key g home
bind-key d pagedown
bind-key u pageup
bind-key l open
bind-key h quit
bind-key a toggle-article-read
bind-key n next-unread
bind-key N prev-unread
bind-key D pb-download
bind-key U show-urls
bind-key x pb-delete
bind-key $ delete-article
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Highlights
# ----------------------------------------------------------------------------
highlight article "^(Title):.*$" blue default
highlight article "https?://[^ ]+" red default
highlight article "\\[image\\ [0-9]+\\]" green default
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Browser Linkhandler
# ----------------------------------------------------------------------------
browser "/usr/lib/firefox/firefox %u"
macro . open-in-browser
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# c copies the link to the clipboard
# ----------------------------------------------------------------------------
# The line below is probably the skiddiest lien i've ever writer.
macro c set browser "copy(){ echo $1 | xclip ;}; copy "; open-in-browser ; set browser linkhandler
# ----------------------------------------------------------------------------


# ----------------------------------------------------------------------------
# Dark solarized color scheme for newsbeuter, based on
# Ethan Schoonover's Solarized.
#
# In order to use this color scheme, you must first configure
# your terminal emulator to use the Solarized palette.
# See <http://ethanschoonover.com/solarized/> for more information.
# ----------------------------------------------------------------------------
color background         default   default
color listnormal         default   default
color listnormal_unread  default   default bold
color listfocus          black     yellow
color listfocus_unread   black     yellow bold
color info               yellow    black
color article            default   default
# ----------------------------------------------------------------------------

```
Selesai.

Langkah konfigurasi file `config` hanya seperti ini saja.

Silahkan disesuaikan dengan preferensi masing-masing.


## Membuat File URL RSS Feeds

Selanjutnya, kita akan membuat file `urls` yang digunakan untuk mendaftar link dari RSS feed favorit kita.

```
$ vim ~/.config/newsboat/urls
```
```
--------------------------------------------------------------------DOTFRIENDS
https://bandithijo.com/feed/blog.xml "~BanditHijo Blog" "dotfriends"
https://bandithijo.com/feed/vlog.xml "~BanditHijo Vlog" "dotfriends"

---------------------------------------------------------------LINUX_MAGAZINES
https://www.archlinux.org/feeds/news/ "Tech News"
https://kabarlinux.id/feed/ "Tech News"
https://fedoramagazine.org/feed/ "Tech News"
http://planet.gnome.org/atom.xml "Tech News"

```
Selesai.

Langkah konfigurasi file `urls` hanya seperti ini saja.

Untuk format penulisan file `urls` ini, seperti di bawah.
```
https://rss-feed-url "~custom feed name" "tag"
https://rss-feed-url "~custom feed name"
https://rss-feed-url "tag"
```

Silahkan diisi sesuai dengan daftar RSS feed masing-masing.

# Bagaimana Mendapatkan RSS Feed URL?

Biasanya pemilik blog/website tanpa sadar atau dengan sengaja meletakkan icon/tulisan RSS.

<!-- IMAGE CAPTION -->
![gambar_4](https://i.postimg.cc/nzRT1sRY/gambar-04.png)
<p class="img-caption">Gambar 0 - Icon dari RSS Feed</p>

Teman-teman bisa mencari dan menelusuri *layout* dari blog/website yang teman-teman incar.

Atau kita dapat menggunakan add-ons untuk mendeteksi dan membaca format RSS feed yang terdapat pada sebuah blog/website. Tinggal cari saja untuk *browser* masing-masing.


<!-- INFORMATION -->
<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>Bertepatan dengan artikel ini saya tulis, Firefox baru-baru saja mengeluarkan update versi <b>64.0</b>. Dan sangat disayangkan pada update versi ini, Firefox memutuskan untuk <a href="https://support.mozilla.org/en-US/kb/feed-reader-replacements-firefox" target="_blank">menghentikan dukungan terhadap fitur <b>web feeds</b> dan <b>Live Bookmarks</b></a>.</p>
<p>Fitur ini yang biasanya saya manfaatkan untuk menangkap RSS feed yang terdapat pada sebuah blog/website.</p>
</div>

Untuk mengatasi hal tersebut di atas, saya biasa menggunakan add-ons juga apabila menggunakan Google Chrome. Maka tidak ada jalan lain selain menambahkan add-ons pada Firefox.

Firefox add-ons yang saya pergunakan adalah [**Easy to RSS**](https://addons.mozilla.org/en-US/firefox/addon/easy-to-rss){:target="_blank"}. Add-ons ini juga saya pergunakan di Google Chrome. Fungsinya sederhana, untuk mengambil RSS feed dari website. Tanpa Web Interface.

Namun, cara di atas tidak sepenuhnya berhasil. Hanya berhasil terhadap blog/website yang meletakkan RSS feed pada head markup html. Sebagai contoh, add-ons Easy to RSS tidak dapat mendeteksi RSS feed milik saya, karena saya letakkan di bagian footer.


# Tampilan Newsboat

<!-- IMAGE CAPTION -->
![gambar_1](https://i.postimg.cc/Vs3fvJ7t/gambar-01.png)
<p class="img-caption">Gambar 1 - Tampilan Depan, daftar RSS feed</p>

<br>
<!-- IMAGE CAPTION -->
![gambar_2](https://i.postimg.cc/fW3WMcvZ/gambar-02.png)
<p class="img-caption">Gambar 2 - Daftar Artikel dari Salah Satu Blog</p>

<br>
<!-- IMAGE CAPTION -->
![gambar_3](https://i.postimg.cc/DyL2X7DM/gambar-03.png)
<p class="img-caption">Gambar 3 - Tampilan Isi</p>


# Lokasi Cache Data dari Newsboat

Ada satu lagi lokasi yang perlu teman-teman ketahui. Yaitu, lokasi di mana data-data seperti cache dan history disimpan. Newsboat secara default meletakkan pada direktori `~/.local/share/newsboat/`. Tujuannya, tidak lain dan tidak bukan, "Jangan lupakan aku saat proses backup." Hahahaha. Karena tidak semua RSS feed akan terdownload semua apabila kita memasang Newsboat pada sistem yang baru atau yang lain. Terkadang terdapat RSS feed yang membatasi hanya 10 judul artikel saja. Meskipun ada juga yang semua RSS feed dari waktu ke waktu.


# Mengapa Memilih Newsboat?

*Resource* yang kecil. Meskipun laptop saya i5, 8 GB of RAM, 480 GB of SSD, tapi menggunakan aplikasi di atas Terminal apabila semua tujuan kita sudah tercapai, maka sudah lebih dari cukup.

Saya sudah pernah menggunakan RSS feed reader tipe web apps, yaitu **Commafeed**. Sudah juga menggunakan GTK+ apps yaitu **Liferea**. Sehingga saat menemukan newsboat, saya suda mengetahui apa-apa kebutuhan yang saya perlukan dari sebuah RSS feed reader.

# Pesan Penulis

Saya melihat masih banyak potensi yang dapat dimanfaatkan dari tools RSS feed reader ini. Namun, saya hanya menggunakan sebatas untuk mengetahui update terbaru artikel dari website favorit saya.

Dokumentasi lebih lengkap dapat dilihat pada `man newsboat`. Coba periksa, banyak hal-hal menarik yang belum saya bahasa karena keterbatasan waktu dan ilmu saya saat ini.


# Referensi

1. [https://en.wikipedia.org/wiki/RSS](https://en.wikipedia.org/wiki/RSS){:target="_blank"}
<br>Diakses tanggal: 2018/12/12

2. [https://wiki.archlinux.org/index.php/Newsboat](https://wiki.archlinux.org/index.php/Newsboat){:target="_blank"}
<br>Diakses tanggal: 2018/12/12

