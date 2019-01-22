---
layout: 'post'
title: '02 Print Function dan Strings'
date: 2018-03-28
permalink: '/python/:title'
author: 'BanditHijo'
license: true
comments: false
toc: true
category: 'python'
tags:
pin:
---

<img class="post-body-img" src="/assets/img/logo/logo_blank_banner.png" data-echo="https://s20.postimg.cc/rjj46uizh/banner_python_00.png" alt="banner">

# Print() Function
Seperti yang sudah saya _mention_ sedikit di _post_ sebelumnya, **print()** _function_ ini digunakan utnuk menampilkan _output_ ke dalam _console_. _Console_ disini tergantung dari sistem operasi yang kita gunakan. Dalam sistem operasi Windows dikenal dengan sebutan Command Prompt (CMD.exe) sedangkan dalam sistem operasi GNU/Linux dikenal dengan sebutan Terminal.

Saat kita belajar tentang suatu bahasa pemrograman, biasanya kita diajarkan untuk menampilkan _output_ dari _program_ sederhana yang kita buat pada _console_. Maka dari itu dalam proses belajar Python ini kita akan banyak menggunakan fungsi print().

print() function juga dapat kita gunakan sebagai "_debugging tool_" sederhana, yang dapat membantu kita mengetahui apakah _program_ yang kita buat telah sesuai dengan hasil yang kita harapkan atau tidak.

"_Debugging_" adalah istilah khusus dalam topik pemrograman yang merujuk pada kegiatan mencari, menghapus, dan memperbaiki _error_ dan kesalahan yang ada pada _program_.

Untuk menggunakan fungsi print(), kita akan gunakan pada pembahasan kali ini bersama dengan tipe data **Strings**.

# Strings
String adalah salah satu dari jenis **tipe data** yang berarti _text_ atau tulisan. Beberapa jenis tipe data yang lain seperti: Integer, Boolean, Float, Double, Constant, dll. akan kita pelajari pada materi **variable**.

Sebuah tipe data string, memiliki ciri-ciri sebuah kata atau kalimat yang di awali dan di akhiri dengan dengan tanda petik. Baik itu petik satu `'...'` maupun petik dua `"..."`.

# Penerapan

## Print: Single Line Print
Sekarang kita akan menampilkan sebuah **Strings** dengan nilai "Saya adalah Python Developer." ke dalam _console_ dengan bantuan fungsi **print()**.

Contoh string dengan satu petik.
```python
print('Saya adalah Python Developer.')
```
```
Saya adalah Python Developer.
```

Contoh string dengan dua petik
```python
print("Saya adalah Python Developer.")
```
```
Saya adalah Python Developer.
```

Kedua bentuk string di atas tidak menghasilkan _output_ yang berbeda. Kamu dapat menggunakan `'` atau `"`.

Hal yang harus diperhatikan adalah **tanda petik tersebut harus digunakan secara berpasangan**. Maksudnya adalah, apabila kamu mengawali sebuah string dengan `'` maka kamu harus menutup string tersebut dengan tanda `'` juga. Begitu juga untuk tanda `"`.

**Bagaimana cara menampilkan tanda petik di dalam sebuah string ?**
```python
print("Ibu berkata, 'Budi adalah seorang Python Developer'")
print('Ibu berkata, "Budi adalah seorang Python Developer"')

print("Sekarang adalah hari Jum'at")
print('Sekarang adalah hari Jum"at')
```
```
Ibu berkata, 'Budi adalah seorang Python Developer'
Ibu berkata, "Budi adalah seorang Python Developer"

Sekarang adalah hari Jum'at
Sekarang adalah hari Jum"at
```

### Escape Character

_Escape character_ adalah karakter yang di awali dengan tanda \ (baca: _backslash_), dimana untuk masing-masing _escape character_ memiliki makna sendiri-sendiri.

Misalnya kita ingin menulis sebuah kalimat yang di dalamnya terdapat kata yang menggunakan tanda apostrof (`'`), seperti: Jum'at, AlQur'an, dll.
```python
print('Sekarang adalah hari Jum'at')
```
```
  File "<stdin>", line 1
    print('Sekarang adalah hari Jum'at')
                                     ^
SyntaxError: invalid syntax
```
Terjadi kesalahan berupa **_invalid syntax_** dengan pointer menunjuk pada huruf **t**.

Kita dapat memperbaiki kesalah ini dengan mengganti satu petik `'` yang mengapit kalimat tersebut dengan dua petik `"`.
```python
print("Sekarang adalah hari Jum'at")
```
```
Sekarang adalah hari Jum'at
```
Namun, ini bukan penyelesaian dengan menggunakan _escape character_, karena bahasan kita adalah _escape character_ maka kita akan menggunakan cara yang sesuai dengan topik ini. Seperti ini cara memperbikinya.
```python
print('Sekarang adalah hari Jum\'at')
```
```
Sekarang adalah hari Jum'at
```
Yaitu dengan menambahkan tanda `\` tepat sebelum tanda `'`, sehingga menjadi seperti ini `\'`.

Dapat diartikan bahwa tanda `\` akan membuat tanda `'` yang seharusnya merupakan sintaks untuk membuka dan menutup sebuah string, menjadi terabaikan dan hanya akan ditampilkan berupa `'`.

Contoh lain,
```python
print("Ibu berkata, "Budi adalah seorang Python Developer"")
```
```
  File "<stdin>", line 1
    print("Ibu berkata, "Budi adalah seorang Python Developer"")
                            ^
SyntaxError: invalid syntax
```
Cara memperbaiki dengan menggunakan _escape character_.
```python
print("Ibu berkata, \"Budi adalah seorang Python Developer\"")
```
```
Ibu berkata, "Budi adalah seorang Python Developer"
```

<br>
**Tabel _Escape Character_**

| Karakter | Kegunaan |
| -------- | -------- |
| \newline | Ignored |
| \\\ | Backslash (\\) |
| \\' | Single quote (') |
| \\" | Double quote (") |
| \a | ASCII Bell (BEL) |
| \b | ASCII Backspace (BS) |
| \f | ASCII Formfeed (FF) |
| \n | ASCII Linefeed (LF) |
| \r | ASCII Carriage Return (CR) |
| \t | ASCII Horizontal Tab (TAB) |
| \v | ASCII Vertical Tab (VT) |
| \ooo | ASCII character with octal value ooo |
| \xhh... | ASCII character with hex value hh... |

### Concatenation

Ketika ketia berbicara tentang string dan print function, akan sangat bermanfaat apabila kita juga mengetahui tentang **concatenation**. _Concatenation_ apabila diartikan secara bahasa adalah **rangkaian**.

<br>
**Concatenation pada String**

Kamu dapat menggunakan tanda `,` atau tanda `+` untuk merangkai dua buah string atau lebih, menjadi satu buah string yang utuh. Apabila kamu mengunakan `,`, kamu akan mendapatkan satu buah spasi di antara keduanya.
```python
print('Nama :','Devika')
```
```
Nama : Devika
```

Sebaliknya, apabila menggunakan tanda `+`, string tersebut akan dirangkai tanpa disertakan spasi di antara keduanya.
```python
print('Nama :'+'Devika')
```
```
Nama :Devika
```

<br>
**Concatenation pada Integer atau Float**

Jika kamu menggunakan `+` untuk merangkai/menggabungkan **integer & integer**, **float & float** atau **integer & float**, maka yang terjadi adalah **operasi aritmatika** berupa **penjumlahan**.
```python
print(10+4)        # int + int
print(5.2+4.1)     # float + float
print(14+2.5)      # int + float
```
```python
14                 # int
9.3                # float
16.5               # float
```

<br>
**Concatenation Tingkat Lanjut**

Kamu **dapat** merangkai **string** dengan **integer** maupun **float** menggunakan `,`.
```python
print('Jumlah item yang dibeli : ',10)
```
```
Jumlah item yang dibeli : 10
```

<br>
Kamu **tidak dapat** merangkai **string** dengan **integer** atau **float** menggunakan `+`.
```python
print('Jumlah item yang dibeli : '+10)
```
```
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: must be str, not int
```
Terjadi kesalahan (_error_) yang mengatakan **TypeError: must be str not int**. Karena nilai paling depan berupa string, sehingga apabila menggunakan `+` untuk merangkai dengan nilai kedua yang berupa integer, akan mengalami kegagalan. Dalam Matematika, operasi penjumlahan, integer dapat dijumlahkan dengan integer atau float, namun tidak dapat dijumlahkan dengan string.

<br>
Kamu juga dapat menggunakan _concatenation_ untuk dapat dirangkaikan dengan variabel.
```python
nama = 'Devika'

print('Nama :',nama)
print('Nama : '+nama)
```
```
Nama : Devika
Nama : Devika
```
<br>
```python
jmlh_kucing = 5

print(jmlh_kucing+10)
print(jmlh_kucing,10)
```
```
15
5 10
```
Masih banyak lagi contoh kasus yang tidak dapat saya tuliskan di sini. Pokoknya kalo mau merangkai sesuatu, gunakan _concatenation_.

**_catatan: merangkai tidak sama dengan menggabungkan_**

<br>
## Print: Multi Line Print

Untuk melakukan print() pada banyak baris, kita dapat melakukannya dengan sangat mudah. Kita cukup mengapitnya dengan tanda petik tiga `'''...'''` atau `"""..."""`. Hal ini sama seperti saat kita memberikan komentar pada banyak baris. Aturan mengenai cara pemberian komentar pada baris kode, akan kita bahas pada materi selanjutnya.

Berikut ini adalah cara menampilkan print() pada banyak baris.

```python
print('''baris ke-1
baris ke-2
baris ke-3

baris ke-5
baris ke-6
baris ke-7''')
```
```
baris ke-1
baris ke-2
baris ke-3

baris ke-5
baris ke-6
baris ke-7
```

Atau,

```python
print('''
|-------------------------------------|
|         --- PYTHON MOTEL ----       |
|-------------------------------------|
|  TIPE KAMAR  | KAMAR |    HARGA     |
|-------------------------------------|
| (1) VIP      |   1   | Rp 1.000.000 |
| (2) Menengah |   1   | Rp   700.000 |
| (3) Ekonomi  |   1   | Rp   500.000 |
|-------------------------------------|
''')
```
```

|-------------------------------------|
|         --- PYTHON MOTEL ----       |
|-------------------------------------|
|  TIPE KAMAR  | KAMAR |    HARGA     |
|-------------------------------------|
| (1) VIP      |   1   | Rp 1.000.000 |
| (2) Menengah |   1   | Rp   700.000 |
| (3) Ekonomi  |   1   | Rp   500.000 |
|-------------------------------------|

```

Saya lebih sering menggunakan tanda petik `'` daripada `"`. Kapan menggunakan petik satu dan kapan harus petik dua, tergantung dari konten pada string. Apakah mengandung karakter petik (apostrof) seperti: Jum'at, AlQur'an, dsb. Seperti yang sudah dicontohkan pada pembahasan di awal.

<br>
## Strings: f-strings

Python mendukung banyak cara untuk melakukan _formatted strings_. _Formatted strings_ di sini artinya, "membentuk strings". Jadi kita dapat membentuk _output_ strings sesuai dengan yang kita inginkan. Metode-metode tersebut antara lain seperti menggunakan [**%-formatting**](https://docs.python.org/3.4/library/string.html#format-examples), [**str.format**](https://docs.python.org/3.4/library/string.html#format-string-syntax), dan [**string.Template**](https://docs.python.org/3.4/library/string.html#template-strings).

<br>
**Penggunaan print() dengan %-format**

```python
kata1 = 'Python'
kata2 = 'Keren'

print('%s memang %s !' %(kata1, kata2))
```
```
Python memang Keren !
```

<br>
**Penggunaan print() dengan str.format**

```python
kata1 = 'Python'
kata2 = 'Keren'

print('{0} memang {1} !'.format(kata1, kata2))
```
```
Python memang Keren !
```

<br>
**Penggunaan string.Template**

```python
from string import Template

kalimat = Template('$siapa memang $kenapa !')
kalimat.substitute(siapa = 'Python', kenapa = 'Keren')
```
```
Python memang Keren !
```

<br>
Setiap metode memiliki kelebihan masing-masing. Tetapi, juga memiliki kelemahan yang membuat metode-metode tersebut rumit untuk digunakan dalam prakteknya.

Kemudian pada Python 3, pada [**PEP 498**](https://www.python.org/dev/peps/pep-0498) (_Python Enhancement Proposals_), mengusulkan mekanisme performatan string yang baru, yang bernama: _Literal String Interpolation_. Yang nantinya, format string ini akan disebut sebagai **f-string**, penamaan ini diambil dari karakter awalan yang digunakan untuk mengaktifkan format string ini, atau dapat juga disebut sebagai **formatted strings**. **f-strings** menyediakan cara untuk menanamkan ekspresi di dalam string dengan menggunakan sintaks yang minimal.

<br>
**Penggunaan f-strings pada single line print()**

```python
namaDepan = 'Devika'
namaBelakang = 'Marina '

print(f'Nama lengkap, {namaDepan} {namaBelakang}')
```
```
Nama lengkap, Devika Marina
```

Kalo kita bongkar kodenya, untuk f-strings pada single line print sendiri penulisannya sama seperti string biasa, namun dengan penambahan huruf `f` sebelum tanda petik pada string, baik petik satu `'` atau petik dua `"`. Kemudian, variable dapat kita sisipkan ke dalam string, dengan mengapit variable tersebut menggunakan tanda kurung kurawal `{namaVariable}`.

```python
f'Nama lengkap, {namaDepan} {namaBelakang}'

f"Nama lengkap, {namaDepan} {namaBelakang}"
```

<br>
**Penggunaan f-strings pada multi line print()**

```python
namaDepan = 'Devika'
namaBelakang = 'Marina'
bahasa = 'Python'
textEditor = 'Vim'
sistemOperasi = 'GNU/Linux'

print(f'''
Hi, perkenalkan nama saya adalah {namaDepan} {namaBelakang}.
Saya adalah seorang WEB Developer yang menggunakan bahasa pemrograman {bahasa} untuk menyelesaikan proyek-proyek yang saya kerjakan.
Tentu saja, sebagai seorang programmer tidak lepas dari aplikasi yang selalu menemani saya setiap saat, yaitu text editor.
Saya menggunakan text editor yang tidak umum digunakan oleh kebanyakan developer wanita, yaitu {textEditor}.
Yang berjalan di atas sistem operasi {sistemOperasi}.
Alasan saya memilih {textEditor} adalah karena efisiensi.
Menurut saya, mempelajari {textEditor} adalah sebuah investasi yang berharga.

Hormat saya,
{namaDepan} {namaBelakang}
''')
```
```

Hi, perkenalkan nama saya adalah Devika Marina.
Saya adalah seorang WEB Developer yang menggunakan bahasa pemrograman Python untuk menyelesaikan proyek-proyek yang saya kerjakan.
Tentu saja, sebagai seorang programmer tidak lepas dari aplikasi yang selalu menemani saya setiap saat, yaitu text editor.
Saya menggunakan text editor yang tidak umum digunakan oleh kebanyakan developer wanita, yaitu Vim.
Yang berjalan di atas sistem operasi GNU/Linux.
Alasan saya memilih Vim adalah karena efisiensi.
Menurut saya, mempelajari Vim adalah sebuah investasi yang berharga.

Hormat saya,
Devika Marina

```

Bagaimana, sangat mudah sekali bukan penggunaan **f-strings** ini?

Sintaksnya *minimal*, tidak sulit untuk diketik, tidak sulit untuk dibaca. Dengan kemudahan sintaks seperti ini tentu saja memudahkan kita dalam berekspresi dengan kode program.

Saya rasa, untuk saat ini, pembahasan mengenai *strings* cukup seperti ini dulu. Mari kita lanjutkan ke topik yang lain yaa.

<br>
# Referensi

1. [https://docs.python.org/3.4/library/string.html](https://docs.python.org/3.4/library/string.html)
<br>Diakses tanggal: 2018/03/28

2. [https://www.python.org/dev/peps/pep-0498](https://www.python.org/dev/peps/pep-0498)
<br>Diakses tanggal: 2018/03/28


<!-- NEXT PREV BUTTON -->
<div class="post-nav">
<a class="btn-blue-l" href="/python/01-hal-yang-harus-dipersiapkan"><img style="width:20px;" src="/assets/img/logo/logo_ap.png"></a>
<a class="btn-blue-c" href="/python/"><img style="width:20px;" src="/assets/img/logo/logo_menu.png"></a>
<a class="btn-blue-r" href="/python/03-matematika-dasar"><img style="width:20px;" src="/assets/img/logo/logo_an.png"></a>
</div>

