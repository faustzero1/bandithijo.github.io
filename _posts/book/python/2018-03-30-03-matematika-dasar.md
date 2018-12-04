---
layout: 'post'
title: '03 Matematika Dasar'
date: 2018-03-30 01:00
permalink: '/python/:title'
author: 'BanditHijo'
license: true
comments: false
toc: true
category: 'python'
tags:
pin:
---

<img class="post-body-img" src="https://s20.postimg.cc/rjj46uizh/banner_python_00.png" alt="banner">

# Intro
Matematika adalah topik yang cukup populer, sehingga kita perlu juga untuk mempelajari operasi matematika dasar dengan menggunakan Python. Beruntungnya, kita mempelajari bahasa pemrograman Python, dimana bahasan matematika sangat populer, khususnya ilmu terapan dari matematika seperti statistik, metode numerik, aljabar linier, dll. Sehingga membuat matematika dalam bahasa pemrograman Python menjadi sangat sederhana.

Namun, karena topik pembicaraan kita adalah operasi matematika dasar di dalam bahasa pemrograman Python, tentu saja kita tidak akan membahas tentang hal-hal tersebut saat ini.

Oke, langsung saja kita mulai.

# Penjumlahan
Kamu dapat melakukan operasi penjumlahan dengan menggunakan operator matematika berupa tanda tambah `+`. Operasi matematika dapat dilakukan dengan menjumlahkan integer dengan integer, float dengan float, maupun integer dengan float.
```python
1+3                 # int + int
1+(2.1+3.2)         # int + (float + float)
1+2.3               # int + float
```
```bash
4                   # int
6.3                 # float
3.3                 # float
```

# Pengurangan
Untuk dapat melakukan operasi matematika berupa pengurangan, kamu dapat menggunakan tanda `-`.
```python
8-15                # int - int
10-(4.3-1.2)        # int - (float - float)
8-4.5               # int - float
```
```bash
-7                  # int
6.9                 # float
3.5                 # float
```

# Perkalian
Untuk dapat melakukan operasi matamatika berupa perkalian, kamu dapat menggunakan tanda `*`.
```python
8*17                # int * int
3*(5.2*7.6)         # int * (float * float)
16*2.5              # int * float
```
```bash
136                 # int
118.56              # float
40                  # int
```

# Pembagian
Untuk dapat melakukan operasi matematika berupa pembagian, kamu dapat menggunakan tanda `/`. Hasil keluaran (_output_) dari operasi pembagian berupa tipe data float.
```python
12/4                # int / int
20/(6.4/3.2)        # int / (float / float)
33/6.5              # int / float
```
```bash
3.0                 # float
10.0                # float
5.076923076923077   # float
```

# Pemangkatan
Untuk dapat melakukan operasi matematika berupa pemangkatan atau exponen dalam aljabar, kamu dapat menggunakan tanda `**`.
```python
4**4                # int ** int
3.2**2.3            # float ** float
4**3.2              # int ** float
```
```bash
256                 # int
14.515932837559118  # float
84.44850628946526   # float
```

# Akar Kuadrat
Untuk dapat melakukan operasi matematika berupa akar kuadrat (_square root_), terlebih dahulu kamu harus melakukan _import_ terhadap _module_ bernama **math**. Kemudian, cara menggunakannya dengan memasukkan nilai yang akan di akar kuadratkan ke dalam tanda kurung `math.sqrt(...)`.
```python
import math

math.sqrt(9)        # int
math.sqrt(144)      # int
math.sqrt(255)      # int
math.sqrt(9.3)      # float
```
```bash
3.0                 # float
12.0                # float
15.968719422671311  # float
3.0495901363953815  # float
```

<br>
Saya rasa cukup sampai di sini dulu pembahasan mengenai operasi matematika dasar.

Benar-benar sangat sederhana bukan ?

Matematika sangat diperlukan ketika kita membuat program yang memerlukan perhitungan, maka akan sangat memudahkan kita apabila untuk melakukan operasi matematika kita dapat menuliskan sintaks kodenya secara sederhana seperti yang ada dalam bahasa pemrograman Python.


<!-- NEXT PREV BUTTON -->
<div class="post-nav">
<a class="btn-blue-l" href="/python/02-print-function-dan-strings"><img style="width:20px;" src="/assets/img/logo/logo_ap.png"></a>
<a class="btn-blue-c" href="/python/"><img style="width:20px;" src="/assets/img/logo/logo_menu.png"></a>
<a class="btn-blue-r" href="/python/04-variabel-dan-tipe-data"><img style="width:20px;" src="/assets/img/logo/logo_an.png"></a>
</div>
