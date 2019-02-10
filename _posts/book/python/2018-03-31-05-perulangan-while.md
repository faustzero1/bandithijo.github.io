---
layout: 'post'
title: '05 Perulangan Menggunakan While'
date: 2018-03-31 01:00
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
<img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="https://s20.postimg.cc/rjj46uizh/banner_python_00.png" alt="banner">

# Intro
Kamu pernah merasa jenuh untuk melakukan pekerjaan yang berulang-ulang ? Untungnya dalam bahasa pemrograman kita dapat membuat proses perulangan itu berjalan secara otomatis. Pada dasarnya, kita hanya perlu mengatur dan menentukan kapan perulangan itu dimulai dan kapan harus berhenti berulang, bahkan kita bisa menentukan pola perulangannya.

# Penerapan

Misalnya kita ingin menampilkan nama-nama pemain basket yang ada di dalam tim inti.

```python
timInti = ['Irvan', 'Ichsan', 'Wisnu', 'Cebe', 'Bly']

print(timInti[0])
print(timInti[1])
print(timInti[2])
print(timInti[3])
print(timInti[4])
```
```
Irvan
Ichsan
Winsu
Cebe
Bly
```

Ini adalah cara menampilkan isi dari variable Python list dengan cara manual. Dapat kita lihat bersama, bahwa kita melakukan print() _function_ sebanyak lima kali.

Dalam bahasa pemrograman Python, teradapat dua cara perulangan (_loop_) yang dapat kita gunakan untuk menyelesaikan masalah mengenai perulangan. **while** dan **for**. Kedua-duanya memiliki tujuan akhir yang sama, yaitu untuk menyelesaikan masalah perulangan. Keduanya juga dapat dipakai secara bergantian. Tergantung pada preferensi masing-masing dari programmer atau efisiensi. Pada umumnya _for loop_ selalu lebih efisien dibandingkan dengan _while loop_, namun tidak selalu.

Pada topik ini, kita akan terlebih dahulu membahas mengenai _while loop_.

Ide dari _while loop_ adalah, ketika sesuatu kondisi sesuai dengan fakta yang ada, lakukan sesuatu sesuai dengan yang telah ditentukan.

```python
umurBalita = 1                             # fakta

while umurBalita <= 5:                     # kondisi
    print('Umur Balita =',umurBalita)     # pernyataan 1
    umurBalita += 1                        # pernyataan 2
```
```
Umur Balita = 1
Umur Balita = 2
Umur Balita = 3
Umur Balita = 4
Umur Balita = 5
```

## Bongkar Kode

Ayo kita _breakdown_ kode di atas sama-sama.

<br>
Untuk baris pertama,
```
umurBalita = 1
```
Pasti kamu sudah paham maksud dari baris ini adalah kita mendeklarasikan / memberikan nilai sebesar `1` (tipe data: integer) kepada variable `umurBalita`.

<br>
Untuk baris kedua,
```
while umurBalita <= 5:
```
Ini adalah bentuk sebuah kondisi perbandingan. Mungkin, kita dapat membacanya seperti ini, **saat `umurBalita` kurang dari sama dengan `5`, maka ?**.

Kemudian, kita sudah mempunya variable `umurBalita` yang bernilai `1` yang akan dibandingkan dengan kondisi pada baris kedua `umurBalita <= 5`.

```
Apakah 1 <= 5 ?
```

Apakah perbandingan ini bernilai benar ?

Benar! 1 lebih kecil daripada 5.

Apabila kondisi yang menjadi syarat bernilai **benar** / **True**, maka pernyataan yang ada di dalam kondisi tersebut akan di jalankan.

<br>
Untuk baris ketiga dan keempat,
```python
...
...
    print('Umur Balita =',umurBalita)
    umurBalita += 1
```
Nah, ini adalah dua buah pernyataan yang ada di dalam blok _while loop_ pada baris kedua. Pada baris sebelumnya sudah menghasilkan kondisi yang bernilai **True**, maka kedua baris ini akan di jalankan secara berurutan dimulai dari atas.
```python
print('Umur Balita =',umurBalita)
```
Teman-teman pasti sudah paham baris ini digunakan untuk apa dan akan menghasilkan _output_ seperti apa. Ya, print() digunakan untuk menampilkan _output_ ke dalam _console_.

Kemudian, pernyataan kedua,
```python
umurBalita += 1
```
Ini adalah bentuk pendeklarasian variable yang mengandung proses di dalamnya. Seperti yang sudah disinggung pada materi tentang variable pada _post_ sebelumnya. Bentuk operasi penjumlahan seperti di atas, dapat kita uraikan menjadi bentuk seperti ini.
```python
umurBalita = umurBalita + 1
```
Pada awal dari kode, variabel `umurBalita` sudah di deklarasikan bernilai `1`. Yang berarti variable ini adalah variable dengna tipe data integer. Sehingga dapat kita baca seperti ini.
```python
1 = 1 + 1
```
Maka setelah melewati pernyataan ini, variabel `umurBalita` akan berubah nilainya, dari semula bernilai `1`, akan berubah menjadi `2`.

Kemudian, setelah semua pernyataan yang ada di dalam blok kode_ while loop_ telah habis di baca oleh Python _interpreter_, maka pembacaan akan di mulai kembali ke baris yang menyatakan perulangan, yaitu baris yang mengandung sintaks _while loop_.

Pada saat ini, variable `umurBalita` sudah berubah nilainya menjadi `2`. Kemudian, akan dibandingkan dengan kondisi yang telah ditentukan, `umurBalita <= 5`, hasil dari perbandingna ini adalah **True**, maka pernyataan di dalam blok kode _while loop_ akan di jalankan persis sama seperti sebelumnya.

Proses yang berulang ini akan berhenti sampai, kondisi yang sudah ditentukan oleh _while loop_ mendapatkan nilai **False**. Yaitu, dimana variable `umurBalita` sudah mencapai nilai `6`. Maka tahap ini, kondisi akan bernilai False. Apabila telah mencapai kondisi yang salah, maka pernyataan di dalam blok kode _while loop_, tidak akan dijalankan.

Untuk memudahkan kita melihat apa yang dilakukan oleh Python _interpreter_ dalam melakukan proses perulangan, mungkin kita bisa buatkan tabel perulangannya.

**Tabel Perulangan**

| umurBalita | print('Umur Balita =',umurBalita) | umurBalita += 1 |
| :---: | :---: | :---: |
| 1 | Umur Balita = 1 | 2 |
| 2 | Umur Balita = 2 | 3 |
| 3 | Umur Balita = 3 | 4 |
| 4 | Umur Balita = 4 | 5 |
| 5 | Umur Balita = 5 | 6 |
| 6 | - | - |

Nah, gimana kalo dengan tabel perulangan seperti di atas ?

Dengan menggunakan tabel perulangan seperti ini akan lebih mudah untuk kita mendapatkan gambaran bagaimana proses perulangan dari kode perulangan seperti _while loop_ dan _for loop_.

<br>
**Contoh kasus lain**

_While loop_ juga akan dapat membantu dalam kasus-kasus seperti ini, misalkan, kalian memiliki sebuah alat, robot, atau mesin yang dapat mendeteksi sesuatu, misalkan hujan.

```python
while diluarHujan:
    print('Di luar hujan! Segera angkat Jemuran !')
```

Jadi, rumus dari _while loop_, dapat kita tuliskan secara sederhana seperti ini.

```python
while True:
    do something
```

Kode di atas akan menghasilkan perulangan tanpa batas (_infinite loop_). Kalo kamu terjebak dalam kondisi seperti ini di _console_, kamu dapat menghentikan proses perulangan ini dengan menekan kombinasi tombol <kbd>Ctrl</kbd> + <kbd>C</kbd>.

Kita juga dapat mengatur kapan perulangan harus dimulai, berhenti, dan bagaimana cara berulangnya. Saya akan mengambil contoh kode perulangan umur balita di atas.

```python
umurBalita = 1                          # awalan

while umurBalita <= 5:                  # akhiran (kondisi)
    print('Umur Balita =',umurBalita)
    umurBalita += 1                     # langkah
```
Apabila kita tidak menentukan awalan, maka perulangan tidak akan berjalan.

Apabila kita tidak menentukan kondisi, maka perulangan tidak akan berjalan.

Apabila kita tidak mengatur langkah dari perulangan, maka perulangan tidak akan pernah berhenti karena kondisi selalu bernilai **True**.

Ketentuan di atas sangat tergantun dari kebutuhan perulangan yang akan kita buat. Jadi tidak harus selalu seperti contoh di atas.

<br>
Saya rasa, untuk saat ini, pembahasa perulangan menggunakan **while** cukup seperti ini dulu.



<!-- NEXT PREV BUTTON -->
<div class="post-nav">
<a class="btn-blue-l" href="/python/04-variabel-dan-tipe-data"><img style="width:20px;" src="/assets/img/logo/logo_ap.png"></a>
<a class="btn-blue-c" href="/python/"><img style="width:20px;" src="/assets/img/logo/logo_menu.svg"></a>
<a class="btn-blue-r" href="/python/06-perulangan-for"><img style="width:20px;" src="/assets/img/logo/logo_an.png"></a>
</div>

