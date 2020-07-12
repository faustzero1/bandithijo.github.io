---
layout: 'post'
title: 'Mengganti Password User dari Home Direktori yang Terenkripsi'
date: 2019-06-17 13:18
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

<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
<p>Lakukan <i>backup</i> data sebelum melakukan proses di bawah.</p>
<p>Segala bentuk kerugian, seperti kehilangan data maupun rusaknya perangkat yang kalian gunakan, bukan merupakan tanggung jawab penulis.</p>
<p><i>Do with Your Own Risk!</i></p>
</div>

# Prakata

Sudah merupakan sebuah keharusan sebagai *system administrator* untuk menerapkan penggantian *password* secara berkala.

Kedengarannya memang aneh kalau laptop pribadi sering berganti-ganti *password* secara berkala.

Saya adalah salah satu dari orang yang aneh tersebut.

Alasannya bukan karena menerapkan jadwal khusus untuk berganti *password* secara berkala, namun karena seringnya berkontribusi dalam menjawab pertanyaan teman-teman pada group Telegram, yang terkadang perlu untuk menampilkan demonstrasi berupa video dengan menampilkan *screenkey*. Hal ini menyebabkan *password* user saya terekspose karena saya lupa untuk menonaktifkannya.

# Permasalahanan

Karena Home direktori saya adalah direktori yang terenkripsi (menggunakan eCryptfs), disinilah letak tantangannya. Karena tentu saja prosedur untuk mengganti *password* menjadi tidak biasa.

Teman-teman dapat melihat catatan proses enkripsi Home direktori yang saya lakukan di sini, "[Mengenkripsi Home Direktori pada GNU/Linux]({{ site.url }}/blog/mengenkripsi-home-direktori-pada-gnu-linux){:target="_blank"}".

# Pemecahan Masalah

Setelah saya melakukan *research* kecil-kecilan, ternyata proses penggantian *password* pada Home direktori yang terenkripsi menggunakan eCryptfs tidaklah begitu sulit.

Saya akan bagi dalam dua langkah, agar lebih mudah untuk dipahami.

1. Mengganti *password* Home direktori yang terenkripsi dengan eCryptfs
2. Mengganti *password* username

Langkah di atas, memang tidak harus berurutan, namun saya merekomendasikan untuk mengerjakan tahap pertama lebih dahulu.

## Mengganti Password Home Direktori Terenkripsi

Memang kita dapat melakukannya pada *user* yang sedang kita aktif (*active session*).

Di awal saya mencoba pun, saya menggunakan *user* yang sedang aktif.

Namun, **saya sangat merekomendasikan untuk *logout* terlebh dahulu, dan menggunakan akun root**.

1. *Logout* terlebih dahulu.

2. Masuk ke TTY shell. Bisa TTY2 - TTY6. Pilih saja yang kosong.

    Dengan cara <kbd>CTRL</kbd>+<kbd>ALT</kbd>+<kbd>F2</kbd> untuk TTY2

3. Login dengan **root**.

4. Jalankan perintah di bawah ini untuk mengganti *password* Home direktori yang terenkripsi dengan eCryptfs.

    <pre>
# ecryptfs-rewrap-passphrase /home/.ecryptfs/<mark>bandithijo</mark>/.ecryptfs/wrapped-passphrase</pre>

    Jangan lupa mengganti <mark>bandithijo</mark>, dengan username yang teman-teman gunakan.

    Apabila berhasil, akan mengeluarkan *output* seperti di bawah ini.
```
Old wrapping passphrase: _
```

    Masukkan Terlebih dahulu *password* lama, kemudian baru dua kali *password* baru.

5. Dengan begini, proses mengganti *passphrase* dari Home direktori yang terenkripsi dengan eCryptfs telah selesai.

    **Jangan *logout* dulu, karena kita akan lanjut ke tahap berikutnya**.

## Mengganti Password User

Setelah sebelumnya kita berhasil mengganti *passphrase*/*password* dari Home direktori, langkah selanjutnya, kita akan mengganti *password* dari user yang kita gunakan.

Ini penting mengingat cara kerja dekripsi dari Home direktori menggunakan eCryptfs adalah dengan memanfaatkan PAM, maka kita perlu menyamakan *password* user dengna *passphrase* untuk dekripsi Home direktori.

Caranya tentu saja sudah sangat familiar.

<pre>
# passwd <mark>bandithijo</mark>
</pre>

Jangan lupa mengganti <mark>bandithijo</mark> dengan username kalian.

Dengan begini tahapan mengganti *password* user dari Home direktori yang terenkripsi telah selesai.

Lakukan pengujian, apakah kalian bisa masuk ke desktop, dan lihat apakah Home direktori berhasil di-dekripsi secara otomatis.



# Pesan Penulis

Tulisan ini bukan merupakan tandingan dari dokumentasi eCryptfs. Silahkan merujuk pada dokumentasi eCryptfs resmi yang sudah saya sertakan pada bagian referensi di bawah.

Dapat pula teman-teman yang menggunakan Arch Linux, merujuk pada Arch Wiki eCryptfs yang sudah saya sertakan di bawah.

Sepertinya seperti ini saja.

Terima Kasih.



# Referensi

1. [wiki.archlinux.org/index.php/ECryptfs#Mounting_2](https://wiki.archlinux.org/index.php/ECryptfs#Mounting_2){:target="_blank"}
<br>Diakses tanggal: 2019/06/17


