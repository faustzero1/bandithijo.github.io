---
layout: 'post'
title: "Barrier, Mengoperasikan Banyak Komputer hanya dengan Sebuah Mouse dan Keyboard"
date: 2020-01-05 18:22
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Tools', 'Ulasan']
pin:
hot:
contributors: []
resume: "Mungkin gak sih mengoperasikan banyak komputer hanya dengan satu keyboard dan mouse? Sangat mungkin! Kita dapat menggunakan tools bernama Barrier. Barrier ini mirip dengan aplikasi berbayar Synergy. Kita dapat membuat 1 komputer menjadi server dan komputer-komputer lain sebagai client. Dengan begini, kita dapat mengontrol kursor dan keyboard hanya dari komputer server."
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Mungkin teman-teman pernah dihadapkan pada situasi di mana, di depan kita, terdapat banyak komputer maupun laptop, yang mungkin bisa memiliki sistem operasi yang sama, maupun berbeda.

Setidaknya dua komputer/laptop saja yang kita perlukan untuk menyelesaikan pekerjaan kita, sudah cukup membuat repot karena kita harus berpindah mouse dan keyboard.

Artinya, semakin banyak komputer/laptop, semakin banyak mouse dan keyboard yang perlu kita gunakan untuk mengoperasikan komputer-komputer/laptop-laptop tersebut.

Saat masih menggunakan MacbookPro, beberapa tahun silam, saya pernah mencari-cari tools yang dapat mempermudah saya untuk berpindah-pindah cursor di antara dua laptop. Dalam pencarian ini, saya menemukan aplikasi yang bernama **Synergy**.[<sup>1</sup>](#referensi)

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/qqPyBc24/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 1 - Synergy</p>

Synergy adalah aplikasi pembantu yang didevelop oleh Symless, yang dapat kita gunakan untuk berbagi mouse dan keyboard dengan banyak komputer  dengan usaha yang minim, yaitu, dengan menggerakkan cursor ke arah di mana posisi mesin yang lain kita tempatkan (*mapping*).

Synergy dapat dioperasikan pada sistem operasi macOS, Microsoft Windows, dan GNU/Linux. Cukup memerlukan jaringan Ethernet atau WiFi dan **tanpa memerlukan hardware tambahan**.

# Permasalahan

Sayangnya, Synergy tidak memiliki versi trial. Yang mengizinkan kita untuk terlebih dahulu mencoba. Namun, Synergy menjamin kalau aplikasi ini akan langsung berjalan dengan baik.

# Pemecahan Masalah

Lantas, baru-baru saja, saya menemukan alternatif dari Synergy namun bersifat open source.

**Barrier** adalah hasil *forked* dari *codebase* Synergy veri 1.9.[<sup>2</sup>](#referensi)

# Instalasi

Proses instalasinya juga cukup mudah.

Barrier sudah menyediakan aplikasi GUI untuk Windows, macOS dan GNU/Linux.

Saya hanya akan menjelaskan proses instalasi untuk GNU/Linx.

Untuk sistem operasi Windows dan macOS, dapat langsung mengunduh file instalasi pada halaman berikut ini.

[Download Barrier New Stable Release](https://github.com/debauchee/barrier/releases){:target="_blank"}

Untuk GNU/Linux, Barrier sudah terdapat pada repositori distro masing-masing.

<a href="https://repology.org/project/barrier/versions">
<img src="https://repology.org/badge/vertical-allrepos/barrier.svg" style="margin:0;" onerror="imgError(this);">
</a>

Karena saya menggunakan Arch, maka saya menggunakan AUR helper.

{% shell_user %}
yay barrier
{% endshell_user %}

Terdapat dua tipe, Barrier GUI dan Barrier Headless

```
2 aur/barrier-headless 2.3.2-1 (+31 2.24%)
    Open-source KVM software based on Synergy (client and server CLI binaries)

1 aur/barrier 2.3.2-1 (+31 2.24%)
    Open-source KVM software based on Synergy (GUI)
```

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/m21vg70q/gambar-02.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 2 - Proses instalasi Barrier dengan Yay</p>

Saya mencoba memasang yang GUI, untuk mendapatkan *user experience* GUI terlebih dahulu.

Bagi yang ingin memasang sendiri dari source code, dapat merujuk ke panduan yang disertakan pada wiki Barrier [di sini](https://github.com/debauchee/barrier/wiki/Building-on-Linux).

Nah, kalo sudah dipasang, saat pertama kali dijalankan, kita akan dihadapkan pada tampilan window seperti ini.

![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/brW4Rv23/gambar-03.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 3 - Welcome Page dari Barrier</p>

![gambar_4]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/sfLFzT07/gambar-04.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 4 - Window Utama untuk Memilih Sebagai Client atau Server</p>

Pada contoh di atas, saya menggunakan ThinkPad X61 (GNU/Linux) sebagai server, dan ThinkPad X260 (Windows 10) sebagai client.

Server artinya, mesin yang kita setup sebagai server akan kita gunakan mouse dan keyboardnya untuk menjelajah ke mesin-mesin lain yang di setup sebagai client.

![gambar_5]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/VN7RQVLC/gambar-05.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 5 - Konfigurasi Layout yang ada di Server</p>

Nah, sepertinya segini saja dulu.

Untuk lebih lengkapnya silahkan merujuk pada dokumentasi dari Barrier.

Demonstrasi video menyusul yaa.

Terima kasih.

(^_^)





# Referensi

1. [symless.com/synergy](https://symless.com/synergy){:target="_blank"}
<br>Diakses tanggal: 2020/01/05

2. [github.com/debauchee/barrier](https://github.com/debauchee/barrier){:target="_blank"}
<br>Diakses tanggal: 2020/01/05
