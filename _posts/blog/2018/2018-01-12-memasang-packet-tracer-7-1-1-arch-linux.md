---
layout: 'post'
title: 'Memasang Cisco Packet Tracer 7.1.1 pada Arch Linux'
date: 2018-01-12
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags:
pin:
---

<img class="post-body-img" src="https://4.bp.blogspot.com/-BowYWqgwdWY/WmHgRqi8cFI/AAAAAAAAG6E/Q3vgYPF4blEWr4CfCfepG8ld3zXlghOjQCEwYBhgL/s1600/Default%2BHeader%2BTemplate%2BPost%2B2X.png" alt="banner">

# Latar Belakang
Oktober 2017, saya menglami kepanikan dikarenakan aplikasi penunjang perkuliahan Jaringan Komunikasi 2 (CCNA 2) yaitu [Cisco Packet Tracer](https://www.netacad.com/courses/packet-tracer-download/){:target="_blank"} versi 7.1.1, yang secara tiba-tiba tidak dapat dibuka di sistem saya (Arch Linux).

Berbagai macam cara saya kerahkan mulai dari memasang menggunakan sumber dari _source tarball_ yang langsung didapat dari _upstream_ (netacad.com) secara _reguler_, hingga mencoba-coba berganti versi JDK & OpenJDK. Namun kesemua usaha saya tidak ada yang membuahkan hasil.

Lantas saya mencoba mencari di [AUR](https://aur.archlinux.org/){:target="_blank"} (_Arch User Repository_) ternyata sudah tersedia Cisco Packet Tracer 7.1.1 dengan nama paket [`packettracer`](https://aur.archlinux.org/packages/packettracer){:target="_blank"}. Namun proses instalasinya tidak biasa. Karena kita harus membuat _package_ sendiri dengan bantuan PKGBUILD. Ini adalah pertama kalinya saya memasang sebuah paket dengan menggunakan PKGBUILD.

# Prasyarat
Karena bahan untuk melakukan proses instalasi ini adalah _tarball_ Cisco Packet Tracer yang kita dapatkan langsung dari _upstream_, sehingga syarat utama yang diperlukan adalah **anda harus memiliki akses ke dalam situs netacad.com**. Untuk dapat mendownload Cisco Packet Tracer versi paling baru (7.1.1).

# Instalasi
Meskipun proses instalasi Cisco Packet Tracer 7.1.1 ini tidak biasa, namun ternyata sangat mudah dilakukan. Meskipun awalnya saya juga ragu-ragu, tapi begitu menjalani tahapan demi tahapan, rasanya siapa saja bisa melakukan proses instalasi seperti ini. Langsung saja kita ke langkah-langkahnya.

1. **Download Snapshot from AUR**

    Kita perlu mendownload “_snapshot_”, _snapshot_ ini berisi bahan-bahan untuk proses instalasi, di dalamnya sudah termasuk PKGBUILD, semacam resep untuk meracik bahan-bahan yang tersedia. Hehe

    _Download snapshot_ dari Cisco Packet Tracer 7.1.1 yang tersedia di AUR pada tautan ini [[Download Snapshot](https://aur.archlinux.org/cgit/aur.git/snapshot/packettracer.tar.gz){:target="_blank"}].

    Nanti akan terdownload satu buah file bernama `packettracer.tar.gz`.

2. **Extract Snapshot**

    Kita perlu mengekstrak isi dari _snapshot_. Buka Terminal dan pergi ke direktori tempat dimana _snapshot_ dari Cisco Packet Tracer 7.1.1 yang sudah kita download tadi tersimpan. Kemudian lakukan _command_ di bawah untuk mengekstrak isi dari _snapshot_.
    ```
    $ tar -zxf packettracer.tar.gz
    ```

    Setelah proses ekstraksi berhasil, maka akan terbuat satu buah direktori bernama `packettracer` dengan PKGBUILD beserta file-file lain di dalamnya.

3. **Download Latest Cisco Packet Tracer from NetAcad**

    Meskipun kita sudah memiliki bahan-bahan dan resep (PKGBUILD) untuk melakukan instalasi, namun satu bahan yang menjadi bahan utama dalam proses instalasi ini masih belum kita tersedia di dalam direktori packettracer. Untuk itu kita perlu mendownload Packet Tracer versi terbaru (7.1.1) dan memasukkannya ke dalam direktori packettracer ini.

    <div class="blockquote-red">
    <div class="blockquote-red-title">[ ! ] Perhatian</div>
    Saya tidak dapat menyediakan link untuk mendownload Cisco Packet Tracer versi terbaru. Karena netacad hanya diperuntukkan bagi yang memiliki akses ke dalam NetAcad. Silahkan melakukan download dengan account NetAcad masing-masing yaa. <a href="http://netacad.com/">NetAcad.com</a>
    </div>

    <div class="blockquote-blue">
    <div class="blockquote-blue-title">[ i ] Informasi</div>
    <!-- <h2 style="color: #444d56;border&#45;bottom: 1px dashed #BE7000;margin&#45;top:0;margin&#45;bottom:10px;padding&#45;bottom:10px;">[ i ] Informasi</h2> -->
    Kabar gembira! Bagi teman-teman yang belum mempunyai akun netacad untuk mendownload Cisco Packet Tracer, dapat terlebih dahulu membaca instruksi yang diberikan oleh mas <b>fathurhoho</b> pada tautan berikut ini >> <a href="https://ngonfig.net/akun-netacad.html" target="_blank"><b>Cara Mendaftar Akun Netacad</b></a>
    </div>

    Setelah Cisco Packet Tracer 7.1.1 selesai didownload, jangan lupa masukkan ke dalam direktori packettracer (direktori hasil ekstrak _snapshot_ packettracer.tar.gz)

4. **Create the Package**

    Bahan-bahan yang diperlukan sudah lengkap, sekarang saatnya meracik bahan-bahan dengan resep menjadi satu buah paket siap instal. Caranya dengan mengetikkan _command_ di bawah.
    ```
    $ makepkg
    ```

    Perintah di atas, akan meracik bahan-bahan dengan resep yang kita miliki dan menghasilkan satu buah file bernama `packettracer.pkg.tar.xz`.

5. **Install the Package**

    Sekarang kita sudah memiliki sebuah paket yang siap kita pasang ke dalam sistem Arch Linux. Untuk melakukan proses instalasi terdapat dua cara, dengan `makepkg -i` atau dengan menggunakan `sudo pacman -U`, namun saya lebih familiar terhadap _command_ yang kedua.
    ```
    $ sudo pacman -U packettracer.pkg.tar.xz
    ```

<br>
Ikuti proses instalasi hingga sampai akhir. Maka proses instalasi Cisco Packet Tracer 7.1.1 dengan menggunakan PKGBUILD dari AUR telah selesai.

# Upgrade

Mungkin akan timbul pertanyaan bagaimana nanti apabila sudah keluar versi packet tracer yang baru?

Tidak masalah. Proses upgradenya tetap sama mudahnya seperti proses instalasinya.

Proses upgrade 7.1.1 ke 7.2 tidak sempat di dokumentasikan. Sebagai gantinya pada upgrade 7.2.1 saya sudah membuatkan video dokumentasinya.

{% youtube Soox7yWWRqo %}

# Referensi
1. [https://aur.archlinux.org/packages/packettracer](https://aur.archlinux.org/packages/packettracer){:target="_blank"}
<br>Diakses tanggal : 2018/01/19
2. [https://www.netacad.com/courses/packet-tracer-download](https://www.netacad.com/courses/packet-tracer-download/){:target="_blank"}
<br>Diakses tanggal : 2018/01/19
3. [https://ngonfig.net/akun-netacad.html](https://ngonfig.net/akun-netacad.html){:target="_blank"}
<br>Diakses tanggal : 2018/08/20
