---
layout: 'post'
title: '06 Perulangan Menggunakan For'
date: 2018-03-31 02:00
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
Setelah sebelunya kita membahas perulangan menggunakan **while** (*while loop*), perulangan selanjutnya yang akan kita bahas adalah perulangan menggunakan **for** (*for loop*).

Prinsip dari pengulangan menggunakan *for loop* adalah perulangan yang berdasarkan sesuatu.

```python
for setiapHal in halIni:    # kondisi
    jalankanPernyataanIni   # pernyataan
```

# Penerapan

Misalkan, di dalam sebuah tim basket terdapat 5 anggota. Kita akan memberikan setiap anggotanya botol air. Kira-kira bentuk kodenya akan seperti ini.

```python
timBasket = ['Irvan', 'Ichsan', 'Wisnu', 'Cebe', 'Bly']

for anggota in timBasket:
    print('Berikan botol air ke',anggota)
```
```bash
Berikan botol air ke Irvan    # timBasket[0]
Berikan botol air ke Ichsan   # timBasket[1]
Berikan botol air ke Wisnu    # timBasket[2]
Berikan botol air ke Cebe     # timBasket[3]
Berikan botol air ke Bly      # timBasket[4]
```
## Bongkar Kode

Saya rasa, temen-temen pasti sudah paham mengenai konsep dari perulangan, seperti yang sudah dibahas pada materi *while loop*.

*for loop* pun juga digunakan untuk menyelesaikan permasalahan yang membutuhkan perulangan agar lebih efisien. *for loop* biasanya digunakan untuk melakukan perulangan yang banyaknya telah diketahui sebelumnya.

Seperti contoh di atas. Kita telah mengetahui banyaknya indeks pada variable `timBasket` berjumlah lima. Sehingga, kita sudah mengetahui bahwa perulangan akan bermula dari indeks ke 0 dan berhenti pada indeks ke 4.

<br>
**Contoh lain**

Terdapat contoh lain dari penggunaan *for loop* yang pernah saya temui. Seperti ini.

Misalkan, kita ingin membuat perualngan sebanyak 10 kali, sambil menampilkan *output* dari urutan perulangan yang sudah terjadi ke dalam *console*.

```python
for x in range(1,11):
    print(x)
```
```
1
2
3
4
5
6
7
8
9
10
```

range() adalah sebuah *built-in function* dalam Python yang berguna untuk menghasilkan sebuah *object* dalam tipe data integer yang berurutan dari *start* sampai *stop* dengan *step* tertentu.

Rumus dari fungsi *range* adalah,
```python
range(start, stop, step)
```
Dapat kita lihat bahwa fungsi range() memiliki 3 buah *parameter*. *Parameter* adalah syarat yang diperlukan oleh sebuah fungsi agar dapat melakukan tugasnya. Pembahasan lebih lanjut mengenai *parameter* akan kita bahas pada materi yang lain.

Secara *default*, range() memiliki nilai *parameter start* = 0. Dan memiliki minimal 1 *parameter* yang harus kita penuhi. Hal ini membuat kita dapat menuliskan fungsi range() seperti ini.

```python
for x in range(4):
    print(x)
```
Artinya, `range(start=0, stop=4, step=0)`. Sehingga akan menghasilkan output berupa.
```
0
1
2
3
```

Atau,

```python
for x in range(20, 31):
    print(x)
```
```
20
21
22
23
24
25
26
27
28
29
30
```

Atau,

```python
for x in (1, 13, 2):
    print(x)
```
```
1
3
5
7
9
11
```
Atau,

Misalkan kita ingin menghitung berapakah total hasil penjumlahan yang ada pada sebuah list.

```python
daftarHarga = [1500, 2300, 5200, 7600]
total = 0

for hargaSatuan in daftarHarga:
    total = total + hargaSatuan

print(total)
```
```
16600
```
Mudah kan ?

Lebih asik lagi, kalo soal matematika, Python gak kalah deh. *For youth info*, ada cara yang lebih cepat untuk menghitung total dari suatu list seperti di atas. Yaitu dengan menggunakan *built-in function* yang bernama **sum()**.

```python
daftarHarga = [1500, 2300, 5200, 7600]

total = sum(daftarHarga)

print(total)
```
```
16600
```

Meskipun *out of topic* pada *post* ini, yang seharusnya kita hanya membahasa *for loop*, tetapi gak papa, sekedar informasi saja.

Jadi, mas Bro. Jangan khawatir kalo nilai matematika kamu jelek. Biar Python yang mengerjakan urusan matematika kamu. Hohoho.

<br>
Saya rasa, cukup seperti ini dulu, pembahasan kita mengenai *for loop*.

Masih ada pembahasan mengenai *for loop* yang belum ter- *cover* oleh *post* ini. Seperti: *nested for*, bagaimana melakukan *for loop* dengan banyak variable, dll.

Mungkin akan saya tambahkan lain waktu.



<!-- NEXT PREV BUTTON -->
<div class="post-nav">
<a class="btn-blue-l" href="/python/05-perulangan-while"><img style="width:20px;" src="/assets/img/logo/logo_ap.png"></a>
<a class="btn-blue-c" href="/python/"><img style="width:20px;" src="/assets/img/logo/logo_menu.png"></a>
<a class="btn-blue-r" href="/python/"><img style="width:20px;" src="/assets/img/logo/logo_an.png"></a>
</div>

