---
layout: 'post'
title: 'Melokalisasi File .lnk yang Dihasilkan oleh Microsoft Office pada Arch Linux'
date: 2019-03-28 08:33
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Wine', 'Arch Linux']
pin:
hot: true
contributors: []
resume:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Beberapa waktu yang lalu, saya mencoba memasang **Microsoft Office 2010** pada distribusi sistem operasi **Arch Linux** menggunakan **Wine 4.4-1**.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/yWqzSvDJ/gambar-01.gif" onerror="imgError(this);"}{:class="myImg"}

Hasilnya lumayan memuaskan, meskipun beberapa aplikasi yang dibawa oleh Microsoft Office ini belum dapat dijalankan.

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/sXSKwrKg/gambar-02.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 2 - Microsoft Word 2010</p>

![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/SxjzTwBC/gambar-03.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 3 - Microsoft Excel 2010</p>

![gambar_4]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/sDKmnKP7/gambar-04.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 4 - Microsoft Access 2010</p>

![gambar_5]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/PfW2DdP6/gambar-05.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 5 - Microsoft Outlook 2010</p>

![gambar_6]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/prJCMJwN/gambar-06.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 6 - Microsoft Clip Organizer</p>

![gambar_7]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/WbsS6xZs/gambar-07.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 7 - Microsoft Publisher 2010</p>

![gambar_8]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/x14RQC4d/gambar-08.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 8 - Microsoft Office Picture Manager</p>

<br>
Beberapa aplikasi Microsoft Office yang belum dapat dijalankan, diantaranya :

![gambar_9]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/Wzv8yHf6/gambar-09.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 9 - Microsoft OneNote 2010</p>

![gambar_10]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/LsgV8pc3/gambar-10.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 10 - Microsoft PowerPoint 2010</p>

<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p> Ternyata, untuk dapat menjalankan Microsoft PowerPoint, kita perlu menambahkan library pada <code>winecfg</code> bernama <code>riched20</code>.</p>
</div>

Meski begitu saat ini saya tidak benar-benar menggunakan aplikasi Microsoft Office.

Saya hanya menggunakan Microsoft Word untuk melihat template dokumen-dokumen dari tugas akhir yang disediakan oleh kampus dalam format `.doc` dan `.docx` kemudian secara manual saya buat ulang untuk format `.odt` (LibreOffice Word Document).

{% box_pertanyaan %}
<p><b>Kenapa tidak menggunakan Microsoft Word saja? Kan sudah berhasil dipasang?</b></p>
<ol>
<li>Saya tidak takut untuk menjadi berbeda.</li>
<li>Saya tidak takut untuk menggunakan LibreOffice.</li>
<li>Saya menggunakan format <code>.fodt</code> (<i>Flat XML Open Document Text</i>) yang dapat digunakan di dalam <b>Git</b> sehingga memudahkan saya dalam mengerjakan tugas akhir (<i>Version Control System</i>).</li>
</ol>
<p>Poin ketiga adalah yang menjadi alasan terbesar saya. Mengapa saya bersikeras untuk menggunakan LibreOffice dalam mengerjakan tugas akhir.</p>
<p>Mengenai file berekstensi <code>.fodt</code> akan saya ulas pada tulisan yang lain.</p>
{% endbox_pertanyaan %}

# Permasalahan

Pada tulisan ini, saya hanya mengkhususkan pada **Microsoft Word** saja. Karena aplikasi ini yang sedang saya pergunakan.

Permasalahan yang muncul dari penggunaan aplikasi Microsoft Word di atas sistem operasi Arch Linux dengan menggunakan Wine adalah:

<mark><b>Muncul file berekstensi '.lnk' dengan diawali oleh nama dari dokumen yang sedang kita buka pada Microsoft Word</b>.</mark>

File ini seperti file *shortcut*. Letaknya pun random. Kadang berada di direktori yang sama dengan file dokumen. Kadang berada di Home, kadang berada di direktori Documents.

Contohnya seperti ini.

**.lnk pada direktori yang sama**.

<pre>
/home/bandithijo
├── Desktop
├── Documents
│   └── Tugas_akhir
│       ├── Template-PROPOSAL.doc
│       ├── <mark>Template-PROPOSAL.lnk</mark>
│       ├── Template-SKRIPSI.doc
│       └── <mark>Template-SKRIPSI.lnk</mark>
├── Downloads
├── Music
├── Pictures
├── Public
├── Templates
└── Videos
</pre>

**.lnk pada direktori Documents**.

<pre>
/home/bandithijo
├── Desktop
├── Documents
│   ├── <mark>Template-PROPOSAL.lnk</mark>
│   ├── <mark>Template-SKRIPSI.lnk</mark>
│   └── Tugas_akhir
│       ├── Template-PROPOSAL.doc
│       └── Template-SKRIPSI.doc
├── Downloads
├── Music
├── Pictures
├── Public
├── Templates
└── Videos
</pre>

**.lnk pada direktori Home**.

<pre>
/home/bandithijo
├── Desktop
├── Documents
│   └── Tugas_akhir
│       ├── Template-PROPOSAL.doc
│       └── Template-SKRIPSI.doc
├── Downloads
├── Music
├── Pictures
├── Public
├── <mark>Template-PROPOSAL.lnk</mark>
├── <mark>Template-SKRIPSI.lnk</mark>
├── Templates
└── Videos
</pre>

Kira-kira, ilustrasinya seperti di atas.

Awalnya, saya tidak begitu menghiraukan. Namun, lama-kelamaan menjadi tidak sedap dipandang juga.

# Penyelesaian

Untuk mengatasi permasalahan ini, ternyata sangat mudah sekali.

Kita hanya perlu membuatkan direktori di dalam direktori Wine yang akan berguna sebagai tempat penyimpanan *Recent Documents*.

Asumsi saya, permasalahan ini terjadi karena Microsoft Office, dalam hal ini Microsoft Word yang sedang saya pergunakan, selalu membuat daftar *Recent Documents* agar dapat dengan mudah kita panggil kembali di dalam Microsoft Word, sedangkan pada direktori Home di GNU/Linux, tidak terdapat direktori yang dapat dipergunakan oleh Microsoft Word untuk menyimpan file *Recent Documents* ini.

Memang, tidak semua aplikasi Windws yang berjalan di atas Wine memiliki polah dan tingkah laku seperti Microsoft Office ini. Contohnya saya, saya sudah menggunakan Macromedia Flash, Naver Line, dan Balsamiq Mockups 3. Ketiga aplikasi ini tidak memiliki perilaku yang sama seperti Microsoft Office.

Nah, sekarang kita akan sediakan direktori *Recent* untuk mengatasi permasalahan ini.

1. Masuk ke dalam direktori **WINEPREFIX**.

    Secara *default* berada pada `~/.wine/`.

    Kemudian, lanjutkan ke dalam direktori *users* yang kita miliki di dalam WINEPREFIX.

    Contohnya seperti punya saya.

    <pre>
    $ <b>cd ~/.wine/drive_c/users/bandithijo</b></pre>

2. Kemudian , lihat isi di dalam direktori ini. Apakah sudah terdapat direktori yang bernama `Recent` atau tidak.

    <pre>
    $ <b>ls -la</b></pre>

    ```
    drwxr-xr-x  AppData
    drwxr-xr-x 'Application Data'
    drwxr-xr-x  Contacts
    drwxr-xr-x  Cookies
    lrwxrwxrwx  Desktop -> /home/bandithijo/dex
    drwxr-xr-x  Downloads
    drwxr-xr-x  Favorites
    drwxr-xr-x  .LINE
    drwxr-xr-x  Links
    drwxr-xr-x 'Local Settings'
    lrwxrwxrwx 'My Documents' -> /home/bandithijo/doc
    lrwxrwxrwx 'My Music' -> /home/bandithijo/snd
    lrwxrwxrwx 'My Pictures' -> /home/bandithijo/pix
    lrwxrwxrwx 'My Videos' -> /home/bandithijo/vid
    drwxr-xr-x 'Saved Games'
    drwxr-xr-x  Searches
    drwxr-xr-x 'Start Menu'
    drwxr-xr-x  Temp
    ```

    Dapat dilihat, tidak ada direktori yang bernama `Recent`.

    Maka, kita akan buatkan.

3. Ketik perintah di bawah untuk membuat direktori `Recent`.

    <pre>
    $ <b>mkdir Recent</b></pre>

    Lalu, periksa kembali keberadaan direktori ini, apakah sudah berhasil dibuat atau tidak.

    <pre>
    drwxr-xr-x  AppData
    drwxr-xr-x 'Application Data'
    drwxr-xr-x  Contacts
    drwxr-xr-x  Cookies
    lrwxrwxrwx  Desktop -> /home/bandithijo/dex
    drwxr-xr-x  Downloads
    drwxr-xr-x  Favorites
    drwxr-xr-x  .LINE
    drwxr-xr-x  Links
    drwxr-xr-x 'Local Settings'
    lrwxrwxrwx 'My Documents' -> /home/bandithijo/doc
    lrwxrwxrwx 'My Music' -> /home/bandithijo/snd
    lrwxrwxrwx 'My Pictures' -> /home/bandithijo/pix
    lrwxrwxrwx 'My Videos' -> /home/bandithijo/vid
    <mark>drwxr-xr-x  Recent</mark>
    drwxr-xr-x 'Saved Games'
    drwxr-xr-x  Searches
    drwxr-xr-x 'Start Menu'
    drwxr-xr-x  Temp</pre>

    Buat juga, direktori **Recent** pada *users* Public.

    Yang beralamat di `~/.wine/drive_c/users/Public`.

    Selesai.

# Pengujian

Sekarang coba buka kembali file dokumen yang berekstensi `.doc` atau `.docx` dari dalam Microsoft Word.

Lalu, periksa direktori Home, Documents, dan direktori tempat file dokumen berada, apakah masih terdapat file berkestensi `.lnk` atau tidak.

Apabila tidak, sekarang coba periksa pada direktori **Recent** yang baru saja kita buat.

{% shell_user %}
ls -l ~/.wine/drive_c/users/bandithijo/Recent
{% endshell_user %}

Hasilnya,

<pre>
total 12
<mark>-rw-r--r-- Template-PROPOSAL.doc.lnk</mark>
<mark>-rw-r--r-- Template-SKRIPSI.doc.lnk</mark>
</pre>

Sekarang file berekstensi `.lnk` yang dihasilkan oleh Microsoft Office sudah tidak lagi berhamburan pada struktur direktori GNU/Linux, karena sudah kita lokalisasi pada direktori **Recent** sebagaimana pada habitat asalnya. Hehe.



# Referensi

1. [Office 2010 and .lnk files ](https://www.codeweavers.com/support/forums/general/?t=26;msg=128936){:target="_blank"}
<br>Diakses tanggal: 2019/03/27

2. [Microsoft Office under Linux: .lnk files, WINE, Crossover, and you](http://www.efficientsoftware.co.nz/microsoft-office-linux-lnk-wine/){:target="_blank"}
<br>Diakses tanggal: 2019/03/27

