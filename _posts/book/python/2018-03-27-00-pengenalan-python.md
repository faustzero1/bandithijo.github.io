---
layout: 'post'
title: '00 Berkenalan dengan Python'
date: 2018-03-27 01:00
permalink: '/python/:title'
author: 'BanditHijo'
license: true
comments: false
toc: true
category: 'python'
tags:
pin:
---

<img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="https://s20.postimg.cc/rjj46uizh/banner_python_00.png" alt="banner">

# Pre-Class

Hello, mas Bro!

Selamat datang di kelas **Belajar Python Dasar**. Pada kelas ini, kita akan berkenalan dengan hal-hal dasar yang perlu kamu ketahui tentang bahasa pemrograman Python.

Selayaknya orang yang sedang belajar sebuah bahasa, kita memerlukan pengetahuan tentang kata-kata, struktur kata agar menjadi sebuah kalimat, bentuk-bentuk kalimat, dll. Dalam mempelajari bahasa pemrograman pun demikian. Kita akan mengenal apa itu _variable_, tipe data, kondisi, perulangan, _function_, dll.

Saya menulis _post_ ini juga sembari belajar bahasa pemrograman Python. Saya belajar dari banyak sekali literatur dalam bahasa Inggris. Tapi saya menuliskan dokumentasi belajar bahasa pemrograman Python dasar berbahasa Indonesia ini khusus untuk kamu.

_Post_ ini pun adalah tulisan pertama saya bertema bahasa pemrograman. Sebelumnya, saya sama sekali tidak pernah menulis tentang topik bahasa pemrograman, karena tidak percaya diri. Namun, ini adalah langkah kecil saya untuk memberanikan diri menulis topik bahasa pemrograman. Jadi, apapun latar belakang kamu, berapapun umur kamu, tidak ada kata terlambat untuk belajar mengetahui hal yang baru.

Yuk ! kita belajar sama-sama.

<br>
# Apa yang Dapat Dilakukan Python?

Saya akan menampilkan daftar-daftar _success stories_ yang saya ambil dari [Python.org](https://www.python.org/about/success/).

<pre style="width:100%; height:200px; border-radius:4px; resize:none; white-space:wrap;">
Software Development
    * Accessibility
    * Assistive Technologies
    * Code Generation
    * Computer Graphics
    * Configuration
    * Cross-platform Development
    * Databases
    * Data Mining
    * Documentation Development
    * Email
    * Embedded Systems
    * Functional Testing
    * Game Development
    * Groupware
    * High Availability
    * Java and Python
    * Legacy System Integration
    * Network Development
    * Product Development
    * Python on Windows
    * Rapid Application Development
    * Real Time
    * Reuse
    * RSS aggregator
    * Scalability
    * Systems Administration
    * Testing
    * Unit Testing
    * Unix/Linux Developers
    * User Interface
    * Visual Effects
    * Web Development
    * Web2.0
    * XML

Arts
    * Film

Business
    * Apparel Industry
    * Aviation
    * Business Information
    * Customer Relationship Management (CRM)
    * Collaboration Support
    * Content Management
    * Document Management
    * Energy Efficiency
    * E-Commerce
    * Enterprise Resource Planning (ERP)
    * Financial Services
    * Fortune 500
    * GIS and Mapping
    * Hosting
    * Human Resources
    * Knowledge Management
    * Manufacturing
    * Product Development
    * Project Management
    * Quality Control, Six Sigma, Lean Manufacturing
    * Relational Online Analytical Processing (ROLAP)
    * Risk Management
    * ROI Case Study

Education
    * Post Secondary

Government
    * Administration
    * Homeland Security
    * Public Safety
    * Traffic Control, Urban Infrastructure

Scientific
    * Biology
    * Bioinformatics
    * Computational Chemistry
    * Data Visualization
    * Drug Discovery
    * GIS and Mapping
    * Scientific Programming
    * Simulation
    * Weather

Engineering
    * Energy Efficiency
    * GIS and Mapping
    * Lighting
    * Marine
    * Simulation
</pre>

Dapat kita lihat, Python hampir ada pada semua bidang yang sudah berkaitan dengan teknologi.


Python adalah bahasa pemrograman yang memiliki banyak sekali kegunaan. Hampir semua yang dapat dilakukan bahasa pemrograman lain, Python dapat melakukannya.

Python mampu mengolah dan memproses GPU sama seperti bahasa pemrograman yang lain. Sebagian besar **modul** pengolahan data, sebenarnya adalah sebuah **Python wrapper** yang dibuat untuk berinteraksi dengan bahasa C/C++.

**Module** adalah sekumpulan Python _scripts_ yang memiliki kegunaan spesifik yang dapat kita manfaatkan dengan cara melakukan _import_ ke dalam program Python yang kita buat.

Cara melakukan _import_ terhadap suatu _module_ seperti ini.
```python
import Math
```

**Kegunaannya untuk apa ?**

Karena biasanya seorang _programmer_ dalam menyelesaikan sebuah masalah memiliki banyak sekali hal yang harus dipikirkan, dengan menggunakan modul maka tidak perlu lagi menulis ulang sebuah _function_ untuk melakukan suatu hal. Kita cukup memanggil dan menggunakan modul yang sudah tersedia ke dalam program Python yang kita kerjakan.

**Python wrapper** adalah sebuah pembungkus kode Python di atas bahasa pemrograman lain. Misalnya, apabila kamu memiliki Python _wrapper_ untuk C++ artinya seseorang telah menulis beberapa kode Python yang dapat berinteraksi dengan bahasa C++, sehingga kamu dapat menggunakannya selayaknya menggunakan kemampuan bahasa C++ tanpa benar-benar perlu mengetahui atau memahami bahasa C++.

Karena hal tersebut, Python dapat digunakan untuk membuat berbagai macam hal, seperti: membuat game, melakukan analisis data, mengontrol robot dan perangkat keras, mengautomatisasi sebuah pekerjaan,  membuat aplikasi _desktop_ dengan _console_ maupun GUI, atau bahkan membuat sebuat website. Asik bukan ?

Masih banyak lagi contoh-contoh penerapan Python yang tentunya apabila saya menuliskanya di sini, akan menjadi sebuah perkenalan yang panjang. Teman-teman bisa mencarinya sendiri di _search engine_ dan artikel maupun video-video terkait dengan penerapan Python.

<br>
# Apakah Python Sulit Dipelajari?

Menurut saya, Python adalah bahasa pemrograman yang mudah dan ramah untuk dipelajari. Kenapa ? karena sintaks (kata dan struktur penulisan) yang sangat sederhana dan _simple_ untuk dapat dibaca dan dimengerti, hampir semua sintaksnya dapat dipahami bahkan apabila kamu belum mengerti satupun bahasa pemrograman.

**Masa sih ?**

Mari saya tunjukkan buktinya.

```python
garasi = "Toyota", "Honda", "Suzuki", "Daihatsu", "Ford"

for mobil in garasi:
    print(mobil)
```

akan menghasilkan Output:
```
Toyota
Honda
Suzuki
Daihatsu
Ford
```

Gimana ? Kira-kira sudah kebayang cara baca kodenya ?

Mari kita bongkar kodenya.
```python
garasi = "Toyota", "Honda", "Suzuki", "Daihatsu", "Ford"
```
`garasi` adalah sebuah variabel, **variabel adalah tempat untuk menampung data**, nanti akan kita pelajari pada materi khusus tentang variable.

Nah, dalam program sederhana ini, nama variabelnya adalah `garasi`, yang menampung merek-merek mobil bernama: Toyota, Honda, Suzuki, Daihatsu, Ford.

Lalu kita begerak menuju baris selanjutnya.
```python
for mobil in garasi:
```
Sudah dapat ditebak, bahwa baris ini menyatakan sebuah **kondisi**, lebih tepatnya kondisi perulangan. Dapat dibaca seperti ini, **untuk setiap mobil yang ada di garasi**.

Apabila kondisi tersebut sesuai dengan data yang ada (nama `mobil` yang ada dalam variabel `garasi`), maka
```python
print(mobil)
```
Kita akan menampilkan setiap `mobil` yang ada pada `garasi` ke _console_.

**print()** adalah sebuah _built-in function_ atau fungsi bawaan dari Python yang berguna untuk menampilkan _output_ berupa _text_ ke dalam _console_, _console_ disini dapat diartikan _command prompt_ (CMD.exe) pada Windows, atau Terminal pada Linux.

Gimana ? Jawaban kalian mirip-mirip dengan ini ?

Saya bisa mengartikan bahwa sintaks dan struktur dari bahasa Python ini mudah untuk dipahami karena mudah untuk dibaca.

Apabila teman-teman tertarik untuk belajar dasar-dasar bahasa pemrograman Python, yuk ! kita belajar bersama-sama.

<br>
# Referensi

1. [https://www.python.org/about/success/](https://www.python.org/about/success/)
<br>Diakses tanggal: 2018/03/27

<!-- NEXT PREV BUTTON -->
<div class="post-nav">
<a class="btn-blue-l disabled" href="#"><img style="width:20px;" src="/assets/img/logo/logo_ap.png"></a>
<a class="btn-blue-c" href="/python/"><img style="width:20px;" src="/assets/img/logo/logo_menu.svg"></a>
<a class="btn-blue-r" href="/python/01-hal-yang-harus-dipersiapkan"><img style="width:20px;" src="/assets/img/logo/logo_an.png"></a>
</div>
