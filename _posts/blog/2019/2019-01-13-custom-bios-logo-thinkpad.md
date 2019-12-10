---
layout: 'post'
title: 'Mengganti BIOS Logo ThinkPad pada GNU/Linux'
date: 2019-01-13 10:59
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'ThinkPad']
pin:
hot: true
---

<!-- BANNER OF THE POST -->
<!-- <img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="#" onerror="imgError(this);" alt="banner"> -->

<!-- PERHATIAN -->
<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
<p>Proses <i>firmware update</i> merupakan hal yang beresiko tinggi.</p>
<p>Kesalahan dalam melakukan proses ini, (mungkin) dapat mengakibatkan laptop menjadi <i>bricked</i>.</p>
<p><i>Do with your own risk!</i></p>
</div>

# Prakata

Sudah sejak 15 Oktober 2018 lalu, saya begitu mengincar untuk dapat mengganti BIOS logo ThinkPad saya yang bertuliskan gambar ini.

<!-- IMAGE CAPTION -->
![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/rmLd5HKn/gambar-01.jpg" onerror="imgError(this);"}
<p class="img-caption">Gambar 1 - Default BIOS Logo pada ThinkPad X260 saya</p>

Alasan saya begitu gigih untuk mengganti logo ini adalah, karena boot time yang molor pada saat BIOS logo ini. Luamaaaaaa aseeeeeliii. Saya berpikir akan sangat pas kalau BIOS logo ini diganti dengan logo yang saya inginkan.

# Langkah-langkah

Untuk melakukan kustomisasi BIOS logo pada laptop ThinkPad menurut pendapat saya, merupakan hal yang sangat-sangat mudah.

## Konfigurasi UEFI BIOS Update Option

Ini adalah langkah yang penting, agar kita dapat fleksibel untuk mengupdate dan downgrade BIOS firmware.

1. Masuk ke BIOS Firmware Setup (ThinkPad Setup)
2. Pindah ke tab **Security**
3. Pergi ke bagian **UEFI BIOS Update Option**
4. Pada option **Secure RollBack Prevention** ubah valuenya menjadi <mark><b>Disabled</b></mark>

## Racik Bahan-bahan

Proses merubah BIOS logo ini sebenarnya hampir sama dengan proses update firmware BIOS yang sudah pernah saya tuliskan - [Update BIOS Lenovo di GNU/Linux Tanpa Menggunakan Windows]({{ site.url }}/blog/update-lenovo-bios-dari-linux){:target="_blank"}. Hanya ada sedikit modifikasi pada *bootable flash drive* yang sudah kita buat. Kita hanya perlu memasukkan file gambar ke dalam direktori FLASH/. Just it!

### Membuat Bootable Flash Drive

Untuk proses pembuatan *bootable flash drive* yang sudah berisi *firmware update* bisa disimak pada post [di sini]({{ site.url }}/blog/update-lenovo-bios-dari-linux){:target="_blank"}.

Ikuti langkah-langkah yang diberikan sampai pada "**Step 4: Bakar Image ke dalam Flash Drive**" selesai. Kemudian kembali lagi ke sini, yaa.

<!-- INFORMATION -->
<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>File BIOS <i>firmware</i> yang digunakan tidak harus selalu yang terbaru. Menggunakan versi yang sama dengan yang kita gunakan saat ini pun juga akan berhasil.</p>
</div>


Saya akan langsung lompat pada tahap memodifikasi *bootable flash drive*.

### Mempersiapkan File Gambar

Ada beberapa persyaratan yang saya dapat dari sumber referensi **iBSD** pada videonya yang menunjukkan isi dari file README.TXT.<sup>[2]({{ site.url }}/blog/custom-bios-logo-thinkpad#referensi)</sup>
<pre>
(TO ALL USER)

***********************************************************************
*                                                                     *
*    NOTES ON CUSTOM START UP IMAGES                                  *
*    -------------------------------                                  *
*                                                                     *
*    THIS VERSION OF THE FLASH UPDATE PROGRAM GIVES THE OPTION OF     *
*    REPLACING (OR ELIMINATING) THE DEFAULT "LENOVO" IMAGE THAT IS    *
*    DISPLAYED DURING SYSTEM START UP.                                *
*                                                                     *
*    STEPS TO ENABLE CUSTOM START UP IMAGE:                           *
*                                                                     *
*    1. PREPARE TWO SAME IMAGE AND COPY IT.                           *
*    2. RENAME THE IMAGE AS FOLLOWS.                                  *
*           BITMAP FILE --> LOGO.BMP                                  *
*           JPEG FILE --> LOGO.JPG                                    *
*           GIF FILE --> <mark>LOGO.GIF</mark>                                     *
*    3. UPDATE ACCORDING TO INSTALLATION INSTRUCTIONS                 *
*                                                                     *
*    AFTER YOU UPDATE THE BIOS ON YOUR SYSTEM, YOUR LOGO WILL         *
*    APPEAR ON THE STARTUP SCREEN.                                    *
*                                                                     *
*    GUIDELINES FOR CUSTOM START UP IMAGE:                            *
*                                                                     *
*    1. THE TWO IMAGE FILE SIZE ARE LIMITES TO <mark>60KB</mark>.                  *
*    2. VALID FORMATS FOR THE IMAGE ARE AS FOLLOWS:                   *
*          BITMAP (.BMP) FILE FORMAT                                  *
*          JPEG (.JPG) FILE FORMAT                                    *
*          GIF (.GIF) FILE FORMAT                                     *
*                                                                     *
***********************************************************************
</pre>
Nah, dari penjelasan README.TXT tersebut kita dapat mengambil kesimpulan:
1. Siapkan 2 buah file gambar (sebenarnya 1 saja juga bisa)
2. Rename file gambar tersebut menjadi LOGO.BMP, LOGO.JPG, atau LOGO.GIF
3. Kapasitas file gambar tidak boleh lebih besar dari 60 KB

Setelah mendapatkan informasi yang valid, saya pun menyiapkan gambar yang saya inginkan.

<!-- IMAGE CAPTION -->
![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/76K9VL6h/gambar-02.png" onerror="imgError(this);"}
<p class="img-caption">Gambar 2 - Gambar pertama yang saya siapkan (440x440)</p>

File gambar ini saya buat berukuran lebar 440px dan tinggi 440px, tidak transparan, *background* saya buat hitam, dan berukuran 22KB.

<!-- INFORMATION -->
<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>Rekomendasi dari iBSD, sebaiknya kita merubah mode dari file gambar yang sebelumnya <b>RGB</b> menjadi <b>Indexed</b>.</p>
</div>

Caranya sangat mudah. Dengan menggunakan GIMP, buka menu **Image → Mode → Indexed...**.
<!-- IMAGE CAPTION -->
![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/V69hq1yH/gambar-06.png" onerror="imgError(this);"}
<p class="img-caption">Gambar 3 - Mode Indexed Window pada GIMP</p>

Kemudian, ubah nilai **Maximum number of colors** mnejadi **16** seperti pada gambar di atas.

Lalu, **export** file gambar ke dalam format .gif, dengan bentuk *file name* seperti ini.
```
LOGO.GIF
```
Dengan begini, file gambar kita telah siap.

<!-- PERTANYAAN -->
<div class="blockquote-yellow">
<div class="blockquote-yellow-title">Mengapa menggunakan format GIF ?</div>
<p>Saya merujuk pada contoh yang diberikan oleh iBSD. Karena beliau berkata sudah mencoba dengan format JPG namun tidak berhasil.</p>
<p>Untuk itu, saya tidak berani mengambil resiko bermain-main dengan <i>firmware update</i> karena laptop ini masih saya gunakan untuk bekerja.</p>
</div>


### Memasukkan File Gambar ke Bootable Flash Drive

Kemudian saya cabut dan colok kembali *bootable flash drive* yang sudah berisi BIOS firmware (bisa update terbaru atau versi yang sama) - agar kembali terdeteksi, kalau sudah terdeteksi tidak perlu melakukan langkah ini.

Lalu masuk ke dalam direktori *bootable flash drive* dengan menggunakan File Manager.

Berikut adalah struktur dari *bootable flash drive*.
<pre>
media/bandithijo/1234-5678
 tree
.
├── EFI
│   └── BOOT
│       └── BootX64.efi
├── <mark>FLASH</mark>
│   ├── R02ET68W
│   │   ├── $0AR0200.FL1
│   │   └── $0AR0200.FL2
│   └── SHELLFLASH.EFI
└── System Volume Information
    ├── IndexerVolumeGuid
    └── WPSettings.dat

5 directories, 6 files
</pre>
Terdapat direktori dengan nama **FLASH/**. Kita akan memasukkan file gambar *custom* BIOS logo yang sudah kita persiapkan ke dalam direktori ini.

<pre>
media/bandithijo/1234-5678
 tree
.
├── EFI
│   └── BOOT
│       └── BootX64.efi
├── FLASH
│   ├── <mark>LOGO.GIF</mark>
│   ├── R02ET68W
│   │   ├── $0AR0200.FL1
│   │   └── $0AR0200.FL2
│   └── SHELLFLASH.EFI
└── System Volume Information
    ├── IndexerVolumeGuid
    └── WPSettings.dat

5 directories, 7 files
</pre>
Dapat dilihat di atas, saya telah memasukkan file gambar **LOGO.GIF** ke dalam direktori **FLASH/**

### Eksekusi Firmware Update

Selanjutnya tinggal *reboot* dan *booting* ke dalam *bootable flash drive*.

Lakukan prosedur *firmware update* seperti biasa.

Akan ada tambahan pertanyaan yang kira-kira berisi konfirmasi bahwa di dalam direktori *firmware update* ini ditemukan *custom image*, apakah kita ingin meneruskan? Jawab saja "yes" dengan menekan tombol <kbd>Y</kbd>.

# Hasil Akhir

Setelah selesai, hasilnya akan seperti ini.

<!-- IMAGE CAPTION -->
![gambar_4]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/pVzWSnvg/gambar-04.gif" onerror="imgError(this);"}
<p class="img-caption">Gambar 4 - Percobaan pertama</p>

Gimana? Agak aneh yaa?

Kalo diperhatikan gambar logonya tidak pas tengah. Terlalu dempet ke arah atas. Meski begitu, ukurannya sudah pas. Saya suka.

Kemduian saya coba menambahkan **Canvas Size** pada bagian atas dengan menggunakan GIMP.

Kira-kira seperti ini hasilnya.

<!-- IMAGE CAPTION -->
![gambar_5]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/C5dN6VBN/gambar-03.png" onerror="imgError(this);"}
<p class="img-caption">Gambar 5 - Gambar kedua dengan ukuran (440x600)</p>

Gambar kedua ini berukuran masih 440px dan tinggi yang saya ubah menjadi 600px. Dapat dilihat pada iliustrasi di atas. Tujuannya agar logo terlihat lebih di tengah dari screen laptop.

Kemudian saya ulangin langkah memasukkan gambar ke dalam *bootable flash drive* seperti di atas dan melakukan proses *firmware update* seperti sebelumnya.

Hasilnya seperti ini.

<!-- IMAGE CAPTION -->
![gambar_6]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/pLxgqqY6/gambar-05.gif" onerror="imgError(this);"}
<p class="img-caption">Gambar 6 - Percobaan kedua, logo terlihat lebih di tengah.</p>

<!-- PERTANYAAN -->
<div class="blockquote-yellow">
<div class="blockquote-yellow-title">Apakah custom BIOS logo ini akan kembali ke default apabila kita melakukan update BIOS?</div>
<p><b>Tidak</b>.</p>
<p>Apabila kita melakuakan update versi BIOS, misal: versi r02uj69d ke versi r02uj70d, maka custom BIOS tidak akan kembali ke default BIOS logo.</p>
<p>2019/03/06, saya baru saja mengupdate bios dari versi r02uj69d -> r02uj70d. Setelah proses update selesai. Custom BIOS logo masih tetap tidak berubah.</p>
<p>Jadi, kita hanya perlu melakukan proses penggantian custom BIOS logo ini sekali saja, dan akan kita pakai seterusnya.</p>
</div>


# Pesan Penulis

Meskipun proses mengkustomisasi BIOS logo ini terdengar sangat "berbahaya" namun aslinya tidak seseram kedengarannya. Dapat dilihat di atas prosesnya sangat mudah.

Bagian paling ***crucial*** adalah pada saat pembuatan *bootable flash drive* yang ada pada tulisan saya berjudul "[Update BIOS Lenovo di GNU/Linux Tanpa Menggunakan Windows]({{ site.url }}/blog/update-lenovo-bios-dari-linux){:target="_blank"}". Apabila pada proses tersebut tidak tepat, saya juga kurang begitu paham akan seperti apa laptop kita. Mungkin saja *bricked*.

Meskipun demikian, apabila berhasil, ada kepuasan tersendiri karena laptop akan terasa lebih *personal* dengan *custom BIOS logo* yang kita buat sendiri.



# Referensi

1. [reddit.com/r/unixporn/comments/84tdtm/bios_custom_bios_bootscreen_on_my_thinkpad_t440s/](https://www.reddit.com/r/unixporn/comments/84tdtm/bios_custom_bios_bootscreen_on_my_thinkpad_t440s/){:target="_blank"}
<br>Diakses tanggal: 2019/01/13

2. [iBSD - How to flash ThinkPad BIOS with a custom logo](https://www.youtube.com/watch?v=HfaJVyM1y-c){:target="_blank"}
<br>Diakses tanggal: 2019/01/13
