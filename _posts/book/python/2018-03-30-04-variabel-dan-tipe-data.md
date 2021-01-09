---
layout: 'post'
title: '04 Variabel dan Tipe Data'
date: 2018-03-30 02:00
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

# Intro
Hampir di setiap program Python yang nanti kamu tulis, kamu akan menggunakan **variable**. Variable dapat diibaratkan sebuah ember yang digunakan untuk menampung data. Variable dalam Python dapat menampun bermacam-macam data. Data yang ditampung dapat berupa string, integer, float, boolean, array, function, dan mungkin masih banyak lagi.

Variable membantu program dapat lebih dinamis dan dapat membantu programmer mereferensikan sebuah nilai yang panjang di dalam sebuah wadah, ketimbang harus mengetik nilai yang panjang berulang kali.

Kamu dapat membuat variable dengan nama apapun kecuali nama yang sama dengan nama sintaks dan function pada Python. Hal ini dapat menyebabkan sebuah konflik. Variable juga tidak dapat ditulis dengan awalan angka dan simbol, kecuali simbol `_` (baca: _underscore_).

Sebagai contoh, kamu tidak dapat memberikan nama sebuah variable dengan nama `print` karena akan terjadi konflik dengan `print()` function.

```python
print = print('Ini tidak dapat dilakukan !')
```

Apabila ini dilakukan, maka hasil dari `print('Ini tidak dapat dilakukan !')` tetap akan tampil pada _console_.

```
Ini tidak dapat dilakukan !
```

Namun, saat kita akan memanggil atau menggunakan variable yang bernama `print`.

```python
print(print)
```
```
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'NoneType' object is not callable
```

Akan terjadi kegagalan.

# Variable dengan 1 Nilai

## String
Nah sekarang yang benernya. Kita sudah mempelajari print() function pada materi pertama. Sekarang, Yuk! Kita coba kombinasikan print() function dengan variable.

```python
namaDepan = 'Devika'
print(namaDepan)
```
```
Devika
```

Kamu juga tidak dapat mengisi nilai dari sebuah variable seperti di bawah ini.

```python
namaLengkap = Devika Marina
```
```
  File "<stdin>", line 1
    namaLengkap = Devika Marina
                              ^
SyntaxError: invalid syntax
```

`Devika Marina` bukan merupakan tipe data yang tepat. Apabila kamu bermaksud membuat `Devika Marina` menjadi sebuah string, maka kamu harus menuliskannya dengan mengawali dan mengakhiri dengan tanda petik (`'...'` atau `"..."`).

```python
namaLengkap = 'Devika Marina'
print(namaLengkap)
```
```
Devika Marina
```

Atau, kamu dapat menerapkan _concatenation_ yang sudah kita pelajari pada materi pertama.

```python
namaLengkap = 'Devika Marina'   # string
umur        = '18'              # string
print('Nama Lengkap :',namaLengkap)
print('Umur         :',umur)
```
```
Nama Lengkap : Devika Marina
Umur         : 18
```

## Integer atau Float
Selain bernilai string, variable juga dapat bernilai integer maupun float.

```python
jmlhRoda   = 10         # integer
jmlhSolar  = 100.0      # float

print('Banyak Roda     : ',jmlhRoda)
print('Kapasitas Solar : ',jmlhSolar)
```
```
Banyak Roda     : 10
Kapasitas Solar : 100.0
```

## Boolean
Variable dapat pula bertipe data boolean, yaitu **True** atau **False**. Penulisan nilai boolean harus di awali dengan huruf besar.

```python
sudahMenikah = True     # boolean
jomblo       = False    # boolean

sudahMenikah
jomblo
```
```
True
False
```

# Variable dengan Banyak Nilai

## Tuples
**Tuple** adalah variable yang berisi / bernilai bermacam-macam data / tipe data yang dipisahkan oleh tanda koma `,` yang membuatnya mirip dengan **list** (list, dalam bahasa pemrograman lain disebut array). Namun, yang menjadikan tuple berbeda dengan list adalah tuple memiliki sifat **immutable** yang artinya kekal atau tidak dapat diubah-ubah.

```python
perangkatKeras = 'Keyboard', 'Mouse', 'Monitor'

print(perangkatKeras[0])
print(perangkatKeras[1], perangkatKeras[2])
```
```
Keyboard
Mouse Monitor
```
Pada contoh di atas, saya menggunakan contoh pemanggilan isi dari variable tuple dengan menggunakan urutan dari indeksnya. `[0]` dibaca **indeks ke nol**.

Indeks pada bahasa pemrograman Python dimulai dari 0, selanjutnya diikuti 1, 2, 3, 4, 5, dst...

Contoh lain,

```python
mobil1, mobil2, mobil3 = 'Kijang', 'Avanza', 'Innova'

print(mobil1, mobil2, mobil3)
print(mobil2)
```
```
Kijang Avanza Innova
Avanza
```

Contoh lain,

```python
x, y, z = 120, 90, 45

print(x)
print(x, y, z)
```
```
120
120 90 45
```

Contoh lain, kamu dapat melihat isi dari sebuah tuple dengan cara seperti ini.

```python
timInti = [15, 11, 10, 9, 1, 6, 5, 7, 8, 22, 4]

print(timInti)
print(timInti[9])
```
```
(15, 11, 10, 9, 1, 6, 5, 7, 8, 22, 4)
22
```

Kamu dapat menuliskan sebuah variable tuple dengan mengawali dengan tanda kurung `(` dan menutupnya dengan `)`.

Seperti ini `(..., ..., ...)`. Namun, tidak menggunakan tanda kurung `(...)` juga tidak masalah. Seperti ini `..., ..., ...`

Sehingga secara _default_, apabila kamu mendeklarasikan sebuah variable yang memiliki banyak nilai dan dipisahkan dengan tanda koma, maka Python akan mengenalinya sebagai variable dengan tipe data tuple.

## Python Lists
Selanjutnya kita memiliki variable yang lebih populer dibandingkan tuple, yaitu Python list.

**Lists** adalah variable struktur data yang berisi / bernilai bermacam-macam data / tipe data yang dipisahkan dengan tanda koma `,` yang membuatnya mirip dengan **tuple**. Namun, yang membedakannya denga tuple adalah kita mendeklarasikan sebuah variable bertipe data list dengan mengapit data tersebut menggunakan tanda kurung kotak `[..., ..., ...]`.

```python
timInti = [15, 11, 10, 9, 1, 6, 5, 7, 8, 22, 4]

print('Anggota Tim Inti : ',timInti)
print('Penjaga Gawang   : ',timInti[4])
```
```
Anggota Tim Inti : [15, 11, 10, 9, 1, 6, 5, 7, 8, 22, 4]
Penjaga Gawang   : 1
```

Python list ini **tidak bersifat immutable** sehingga memungkinkan kita untuk dapat memodifikasinya, seperti: _append_, _extend_, _insert_, _count_, _remove_, _reverse_, _sort_, dll.

Nanti akan ada pembahasan tersendiri untuk modifikasi Python list.

## Dictionary
**Python Dictionary** adalah sebuah variable struktur data yang hampir mirip dengan array. _Dictionary_ kalo diartikan secara bahasa akan bermakna **kamus**. Ya! Persis selayaknya kamus, yang isinya terdapat kata kunci dan setiap kata kunci memiliki arti yang dapat lebih dari satu arti.

Dictionary tidak diurutkan berdasarkan sesuatu. Karakteristik yang khas dari Python dictionary adalah memiliki **kunci** dan **nilai** (`kunci:nilai`). Setiap kunci berbentuk unik dan hanya satu. Sedangkan nilainya dapat mengandung lebih dari satu data / tipe data, baik dalam bentuk tipe data apapun seperti: string, integer, float, tuple, list, bahkan dictionary juga.

Untuk mendeklarasikan sebuah variable dengan tipe struktur data dictionary, kita perlu mengawalinya dengan menggunakan tanda kurung kurawal`{` dan menutupnya dengan `}`.

```python
nomorPunggung = {'Cebe':10, 'Bly':11, 'Davy':4, 'Haris':9}

print(nomorPunggung)
```
```
{'Cebe': 10, 'Bly': 11, 'Davy': 4, 'Haris': 9}
```

Apabila kita ingin mengetahui berapakah nomor punggung dari Davy, maka kita cukup memanggil kuncinya saja.

```python
print(nomorPunggung['Davy'])

print('Berapakah nomor punggung Davy ?',nomorPunggung['Davy'])
```
```
4
Berapakah nomor punggung Andi ? 4
```

Perlu diperhatikan, pemanggilan kunci berupa string, haruslah sama persis dengan kunci yang sudah di deklarasikan di dalam variable dictionary. Namanya saja kunci, kalo kuncinya tidak sama, maka pintu tidak akan dapat dibuka.

Selain kunci yang berbentuk string, kunci dapat pula berupa integer.

```python
juaraLomba = {1:'Irvan', 2:'Ichsan', 3:'Wisnu', 4:'Gigon', 5:'Dika'}

print(juaraLomba[3])
print(Pemenang Kejuaraan Lari : ',juaraLomba[3])
```
```
Wisnu
Pemenang Kejuaraan Lari : Wisnu
```

Contoh di atas, adalah contoh dictionary yang memiliki satu nilai. Berikut ini adalah dictionary yang dapat meiliki nilai (_value_) lebih dari satu.

Misalkan, kita memiliki daftar identitas yang berisi nama, tinggi badan, warna kulit. Kemudian kita akan membuat nama sebagai kunci.

```python
identitas = {'Irvan':[172,'Putih'], 'Ichsan':[170,'Cokelat'], 'Wisnu':[168,'Kuning']}

print(identitas['Irvan'])
print(identitas['Wisnu'][0])
```
```
[172, 'Putih']
168
```
Dalam contoh di atas, saya menggunakan Python list sebagai nilai. Seperti yang sudah saya sebutkan di atas, nilai dapat berupa apa saja. Asik sekali bukan ?

Untuk modifikasi dictionary akan saya tulis pada pembahasan yang lain.

# Variable yang Mengandung Proses
Variable tidak melulu mengandung nilai-nilai. Variable juga dapat kita manfaatkan untuk menyimpan proses.

```python
penjumlahan = 25 + 45        # int + int
pengurangan = 32.6 - 13.8    # float - float
perkalian   = 21 * 3.5       # int * float

print(penjumlahan)
print(pengurangan)
print(perkalian)
```
```bash
70          # int
18.8        # float
73.5        # float
```

Sepertinya, pembahasan mengenai variable kita cukupkan sampai disini dulu.


<!-- NEXT PREV BUTTON -->
{% assign btn-next = "/python/03-matematika-dasar" %}
{% assign btn-menu = "/python/" %}
{% assign btn-prev = "/python/05-perulangan-while" %}
<div class="post-nav">
<a class="btn-blue-l" href="{{ btn-next }}"><img class="btn-img" src="/assets/img/logo/logo_ap.png"></a>
<a class="btn-blue-c" href="{{ btn-menu }}"><img class="btn-img" src="/assets/img/logo/logo_menu.svg"></a>
<a class="btn-blue-r" href="{{ btn-prev }}"><img class="btn-img" src="/assets/img/logo/logo_an.png"></a>
</div>
