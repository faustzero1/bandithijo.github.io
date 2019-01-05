---
layout: 'post'
title: 'Menjalankan Python Virtualenv Versi Python yang Spesifik'
date: 2019-01-05 12:07
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags:
pin:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="#" alt="banner"> -->

# Latar Belakang Masalah

Saat akan belajar salah satu

# Solusi

1. Install Python 3.6 dari AUR
```
$ yay python3.6
```
2. Buat virtualenv dari versi python 3.6
    <pre>
$ virtualenv -p python3.6 <mark>venv</mark></pre>
`venv` adalah nama dari virtual environment.
```
Running virtualenv with interpreter /usr/bin/python3.6
Using base prefix '/usr'
New python executable in /home/bandithijo/git/test/venv/bin/python3.6
Also creating executable in /home/bandithijo/git/test/venv/bin/python
Installing setuptools, pip, wheel...done.
```
Apabila menampilkan `done` artinya proses pembuatan virtual environment telah berhasil.

    Proses pembuatan virtual environment ini membutuh kan akses internet.
3. Aktivasi virtual environment.
```
$ cd venv
```
```
$ source bin/activate
```
Nanti akan ada tanda-tanda pada Terminal kalian apabila kalian mengunakan Theme tertentu yang menampilkan bahwa kita saat ini telah berada pada virtual environment.

    Seperti ini.
    <pre>
<mark>(venv)</mark>
~/venv
$_</pre>
Lakukan pengecekan versi Python.
```
$ python -V
```
```
Python 3.6.7
```
Yak, kita sudah berada pada versi Python yang saya inginkan, yaitu versi 3.6.


# Pesan Penulis

Masih banyak fitur-fitur dari Scrcpy yang belum sempat saya tuliskan di sini. Silahkan bereksplorasi lebih dalam dan lebih jauh, merujuk pada daftar referensi yang saya sertakan di bawah.


# Referensi

1. [https://www.reddit.com/r/archlinux/comments/7ozxtx/how_to_manage_python_versions/](https://www.reddit.com/r/archlinux/comments/7ozxtx/how_to_manage_python_versions/){:target="_blank"}
<br>Diakses tanggal: 2019/01/05

