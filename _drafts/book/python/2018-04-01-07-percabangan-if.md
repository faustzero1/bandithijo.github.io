---
layout: 'post'
title: '07 Percabangan Menggunakan If'
date: 2018-04-01 01:00
permalink: '/python/:title'
author: 'BanditHijo'
license: true
comments: false
toc: true
category: 'python'
tags:
pin:
---

<!-- BANNER OF THE POST -->
<img class="post-body-img" src="https://s20.postimg.org/t9oqaz11p/banner_python_00.png" alt="banner">

# Intro

Percabangan adalah salah satu logika paling dasar yang akan kita gunakan untuk membuat program yang memerlukan kondisi.

Maksud dari percabangan **if** adalah untuk menilai apakah sebuah pernyataan telah sesuai dengan kondisi yang ditentukan. Apabila benar, maka pernyataan yang ada di dalam blok kode percabangan if, akan dijalankan.

```bash
if kondisiBenar:            # kondisi yang menjadi syarat
    jalankanPernyataanIni   # pernyataan
```

Sebaliknya, percabangan if tidak menyediakan tempat untuk kondisi yang bernilai salah, sehingga apabila kondisi bernilai salah, maka program tidak akan berbuat apa-apa.

# Penerapan

Contoh sederhananya, kita akan membandingkan tinggi badan dari seorang calon Bintara dengan persyaratan tinggi badan untuk dapat diterima di akademi kepolisian.

**Calon Bintara Pertama**

```python
syaratTinggi = 170
calonBintara = 175

if calonBintara > syaratTinggi:
    print('Selamat! Kamu Lulus Uji Tinggi Badan.')
```
```
Selamat! Kamu Lulus Uji Tinggi Badan.
```

**Calon Bintara Kedua**

```python
syaratTinggi = 170
calonBintara = 169

if calonBintara > syaratTinggi:
    print('Selamat! Kamu Lulus Uji Tinggi Badan.')
```
```

```

# Bongkar Kode

Pada kode **Calon Bintara** ini, terdapat dua buah variable dengan tipe data _integer_.

```python
syaratTinggi = 170
calonBintara = ...
```

Kita anggap variable `syaratTinggi` sebagai "syarat lulus" yang nilainya tidak berubah, yaitu `170`. Variable `calonBintara` adalah variable yang nilainya berubah-ubah sesuai data tinggi badan calon bintara.

Kemudian, masuk ke baris selanjutnya, yaitu percabangan if.

```python
if calonBintara > syaratTinggi:
```




<!-- NEXT PREV BUTTON -->
<div class="post-nav">
<a class="btn-blue-l" href="/python/06-perulangan-for"><</a>
<a class="btn-blue-c" href="/python/"><img style="width:20px;" src="/assets/img/logo/logo_menu.png"></a>
<a class="btn-blue-r" href="/python/">></a>
</div>

