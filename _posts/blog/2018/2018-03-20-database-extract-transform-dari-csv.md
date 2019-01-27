---
layout: 'post'
title: 'Melakukan Extract & Transform dari .CSV ke dalam Tabel Operasional ERD'
date: 2018-03-20
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Database', 'Tools']
pin:
---

# TUGAS 1

| Mata Kuliah | **Data Warehouse & Data Mining** |
| Nama | **Rizqi Nur Assyaufi** |
| NIM | **15.01.157** |
| Kelas | **TI2-B** |

>## Soal
>**Buatlah tutorial melakukan Extract dan Transform dari data .CSV ke dalam tabel operasional dalam bentuk ERD.**
>
>Tutorial boleh dalam bentuk Video Youtube atau laporan makalah atau artikel Blog.
>
>Materi tutorial silakan gunakan file yang disertakan.
>
>Jika sudah selesai, segera kumpulkan disini.

>## File Attachment
>1. [pasar_2014.csv](https://drive.google.com/open?id=1Cqyc-D1e_8NawsbcFSxevO9WvyzsGBcU)
>2. [pasar_data.sql](https://drive.google.com/open?id=17N-iWrWR3m9S11sbX9BTcaJP5qesB6EX)

<hr>

# Jawaban
Pada tulisan ini saya menggunakan aplikasi manajemen database berbasis GUI yang bernama [**MySQL Workbench**](https://dev.mysql.com/downloads/workbench/) pada sistem operasi [**Arch Linux**](https://www.archlinux.org/).

![Gambar 1]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/9kkmzr9i5/gambar_01.png"}

## Step 1: Membuat Connection
Apabila belum terdapat connection, kita dapat terlebih dahulu membuatnya dengan menekan icon (**+**) seperti yang ada pada Gambar di bawah.

![Gambar 2]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/yqll6k87h/gambar_02.png"}

<br>
Nanti akan terbuka _window_ baru, seperti gambar di bawah.

![Gambar 3]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/60yp9xrct/gambar_03.png"}

Isi pada bagian _text input_ berlabel **Connection Name :** dengan nama koneksi yang kalian inginkan. Sebagai contoh, saya mengisikan `localhost 3306`.

<br>
Lakukan tes koneksi dengan mengklik tombol **Test Connection** seperti yang ada pada gambar di bawah.

![Gambar 4]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/8iagh6ge5/gambar_04.png"}

<br>
Apabila berhasil, akan memunculkan _window_ seperti gambar di bawah ini.

![Gambar 5]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/e6gr83065/gambar_05.png"}

Pilih **OK**, maka akan terbuat satu buah _MySQL Connection_ yang bernama **localhost 3306**.

![Gambar 6]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/4lx4l7ijx/gambar_06.png"}

Pada sistem operasi Arch Linux, akan terdapat _window_ yang berisi pemberitahuan bahwa versi _server_ yang sedang digunakan adalah versi 10, sedangkan yang didukung oleh MySQL Workbench adalah veri 5.1, 5.5, 5.6, 5.7. Kita dapat mengabaikan pesan ini dan memilih **Continue Anyway**.

![Gambar 7]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/iflha9qkt/gambar_07.png"}

<br>
Akan terbuka sebuah _tab_ baru dengan tampilan seperti di bawah.

![Gambar 8]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/5o7b3s3y5/gambar_08.png"}

## Step 2: Membuat Schema
Selanjutnya, kita akan mebuat _database schema_, dengan cara melakukan **klik kanan pada area kosong** di sisi _sidebar_ sebelah kiri pada _tab Schemas_.

![Gambar 9]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/kk5ubd7n1/gambar_09.png"}

<br>
Kemudian, pada area tengah, akan terbuka _tab_ baru seperti di bawah.

![Gambar 10]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/3wec8w00t/gambar_10.png"}

<br>
Isi _text input_ **Name :** sesuai yang diinginkan.

![Gambar 11]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/otakdjqbx/gambar_11.png"}

<br>
Apabila telah diberikan nama, pilih tombol **Apply**, maka akan terbuka _window_ baru seperti di bawah.

![Gambar 12]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/jun1z19od/gambar_12.png"}

Pilih **Apply > Close**.

<br>
Akan terbuat _database scheme_ dengan struktur seperti gambar di bawah.

![Gambar 13]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/6qhhmc9wt/gambar_13.png"}

## Step 3: Membuat Tabel-tabel
Selanjutnya kita akan memasukkan **SQL Script** untuk membuat tabel-tabel secara otomatis.

Pilih **File > Open SQL Script...**

Cari file **pasar_data.sql** yang telah disertakan bersama tugas. Apabila belum ada, bisa mengunduhnya terlebih dahulu di [sini](https://drive.google.com/open?id=17N-iWrWR3m9S11sbX9BTcaJP5qesB6EX).

Apabila sudah, nanti akan terbuka _tab_ baru di area tengah, seperti pada gambar di bawah.

![Gambar 14]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/85j2b2qfh/gambar_14.png"}

<br>
Selanjutnya, kita akan mengeksekusi SQL Script yang sudah kita masukkan.

Tapi sebelunya, kita perlu untuk membuat _database schema_ yang kita buat sebelumnya, untuk dijadikan _default schema_.

Caranya, pada _sidebar_ kiri, pada bagian _tab Schemas_ **klik kanan pada nama schema**, kemudian pilih **Set as Default Schema**, seperti contoh di bawah.

![Gambar 15]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/wm185jyvx/gambar_15.png"}

<br>
Kemudian, eksekusi SQL script dengan melakukan klik pada tombol bergambar petir. Seperti gambar di bawah.

![Gambar 16]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/dtpd1za7h/gambar_16.png"}

<br>
Perhatikan pada bagian bawah, terdapat _Output Panel_, akan terdapat pesan seperti di bawah ini.

![Gambar 17]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/8iagha3kd/gambar_17.png"}

<br>
Apabila, telah berhenti memberikan _output_, sekarang kita pergi ke _sidebar_ sebelah kiri, dan lakukan _refresh_ agar menampilkan _update_ terbaru dari _database scheme_.

Caranya dengan klik kanan pada area kosong dan pilih **Refresh All**.

![Gambar 18]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/j549mp3zx/gambar_18.png"}

<br>
Hasilnya akan seperti gambar di bawah.

![Gambar 19]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/gnsiffzj1/gambar_19.png"}

## Step 4: Ekstrak dan Transform Data
Terdapat 5 buah tabel:

1. detil_komoditas
2. komoditas
3. pasar
4. satuan
5. transaksi

Kita tidak dapat memasukkan data hasil ekstrak dan transform secara acak. Kita perlu membaca _relationship tables_ (relasi antar tabel). Untuk itu kita memerlukan ERD (_Entity Relationship Diagram_).

### 4.1 Entity Relationship Diagram
Caranya, pergi ke menu **Database > Reverse Engineer...**.

![Gambar 20]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/3wec8y56l/gambar_20.png"}

<br>
Kemudian, masukkan **MySQL Connection** yang telah kita buat pada Step 1, ke dalam **Stored connection**. Pada contoh saya `localhost 3306`.

![Gambar 21]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/azm7ok2wd/gambar_21.png"}

Selanjutnya pilih **Next**.

<br>
![Gambar 22]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/moq7cj9al/gambar_22.png"}

Pilih **Next**.

<br>
Pilih _Database Scheme_ yang kita buat.

![Gambar 23]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/wm185m41p/gambar_23.png"}

Pilih **Next**.

<br>
![Gambar 24]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/jun1z3eu5/gambar_24.png"}

Pilih **Next**.

<br>
![Gambar 25]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/uu89apcz1/gambar_25.png"}

Pilih **Execute > Next > Close**.

<br>
Nanti akan terbuka _tab EER Diagram_.

![Gambar 26]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/4lx4lc8b1/gambar_26.png"}

![Gambar 27]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/495qf781p/gambar_27.png"}

<br>
Dari pembacaan relasi antar tabel di atas, dapat kita urutkan tabel mana yang akan kita kerjakan terlebih dahulu.

1. Tabel `pasar`
2. Tabel `komoditas`
3. Tabel `satuan`
4. Tabel `detil_komoditas`
5. Tabel `transaksi`

### 4.2 Mengekstrak CSV
Kita akan melakukan ekstraksi file `pasar_2014.csv` ke dalam bentuk struktur tabel.

Caranya, kembali ke _tab localhost 3306_ (di bagian atas sebelah kiri, disebelah _icon Home_). Kemudian pada _sidebar_ kiri, pada _database schema_ yang kita buat, klik kanan dan pilih **Table Data Import Wizard**.

![Gambar 28]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/dtpd21n31/gambar_28.png"}

<br>
Nanti akan terbuka _window_ baru seperti di bawah.

![Gambar 29]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/5o7b3we9p/gambar_29.png"}

Cari file **pasar_2014.csv** yang telah disediakan bersama soal. Atau kalian dapat mengunduhnya di [sini](https://drive.google.com/open?id=1Cqyc-D1e_8NawsbcFSxevO9WvyzsGBcU).

Kalo sudah, pilih **Next >**.

<br>
Berikan nama tabel dari file **.csv** yang ingin kita ekstraksi.

![Gambar 30]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/pvkqw7r6l/gambar_30.png"}

Pilih **Next >**.

<br>
Periksa bagian **Columns :**, apakah sudah sesuai dengan kategori dari masing-masing kolom / _fields_.

![Gambar 31]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/fy9q35bv1/gambar_31.png"}

Pilih **Next >**.

<br>
![Gambar 32]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/dtpd21ust/gambar_32.png"}

Pilih **Next >**.


<br>
Nah, kalo sudah menampilkan seperti di bawah, proses import data artinya telah sukses.

![Gambar 33]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/aa3fcaa3h/gambar_33.png"}

Pilih **Next >**.

<br>
Selanjutnya periksa banyaknya data yang telah berhasil diimport, harus sesuai dengan banyaknya data yang ada pada file **pasar_2014.csv**, yaitu sebanyak **18.940** records.

![Gambar 34]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/v6zngy0el/gambar_34.png"}

Pilih **Finish**.

<br>
Kemudian, kembali ke _sidebar_ sebelah kiri. Belum terdapat tabel **data** yang baru saja kita buat dari hasil ekstrak file **pasar_2014.csv**. Kita perlu melakukan **Refresh All** pada _database schema_. Setelah melakukan _refresh_, akan muncul tabel **data** seperti gambar di bawah.

![Gambar 35]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/dtpd22pnx/gambar_35.png"}

<br>
Kita akan melihat hasil ekstrak dari file .csv yang sudah kita _import_. Dengan cara melakukan klik pada _icon_ di samping.

![Gambar 36]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/xbk0i1hgt/gambar_36.png"}

<br>
Akan memunculkan hasil seperti di bawah.

![Gambar 37]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/tf6om36rx/gambar_37.png"}

### 4.3 Transform Hasil Exstrak
Selanjutnya kita akan melakukan transformasi dari tabel data yang seelunya kita ekstrak dari file **pasar_2014.csv**.

Untuk melakukan transform data, kita berpindah saja ke _tab_ **Query 1**. Di sini kita akan mengetikkan perintah-perintah SQL untuk melakukan transformasi tabel **data**.

![Gambar 38]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/6dq3gbc99/gambar_38.png"}

<br>
Selanjutnya kita akan melakukan transformasi dari tabel **data** berurut sesuai dengan hasil pembacaan relasi tabel ERD.

#### 4.3.1 Tabel Pasar
Kita akan mentransformasi _fields_ **namapasar** dari tabel **data**, dengan _queries_ seperti di bawah ini.
```
SELECT @nomor:=@nomor+1 as id, namapasar
FROM data,(SELECT @nomor:=0)r
GROUP BY namapasar;
```
Kemudian **Excute** dengan menekan tombol bergambar petir.

<br>
Akan menghasilkan tabel hasil transformasi dari tabel data seperti gambar di bawah.

![Gambar 39]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/60ypa4m9p/gambar_39.png"}

<br>
Kemudian, _export_ ke dalam format **.csv**, dengan menekan tombol **Export**.

![Gambar 40]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/kk5ubjuu5/gambar_40.png"}

berikan nama, misal **data_pasar.csv**, karena kita akan memasukkan ke dalam tabel **pasar**.

<br>
Buka tabel **pasar**, atau _view_ tabel **pasar**. Klik tombol **Import** untuk mengambil file **data_pasar.csv** yang tadi sudah kita _export_.

![Gambar 41]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/lz7f0abct/gambar_41.png"}

<br>
Akan memunculkan hasil seperti gambar di bawah.

![Gambar 42]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/pvkqw9oml/gambar_42.png"}

<br>
Kita perlu menghapus baris pertama karena bukan berisi _record_ yang kita perlukan.

![Gambar 43]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/738vspn3h/gambar_43.png"}

<br>
Dan akan menghasilkan isi tabel seperti gambar di bawah.

![Gambar 44]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/5o7b3ztq5/gambar_44.png"}

Apabila seperti di atas, artinya _records data_ yang kita perlukan sudah tepat.

<br>
Selanjutnya kita perlu melakukan **Apply**. Klik tombol **Apply** pada pojok kanan bawah.

![Gambar 45]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/p61yjxb8d/gambar_45.png"}

<br>
Akan terbuka _window_ seperti di bawah yang berisi _queries_ untuk memasukkan data ke dalam tabel **data**.

![Gambar 46]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/4yoirn0wd/gambar_46.png"}

Pilih **Apply**.

Apabila berhasil dan tidak ada _error_, pilih **Close**. Data yang kita _import_ tadi akan masuk ke dalam tabel **pasar**.

Apabila gagal, maka kita perlu meninjau kembali data yang kita dapat dari hasil _queries_ yang kita buat saat melakukan transformasi dari tabel **data**, apakah sudah sesuai dengan relasi dari tabel yang kita tuju.

><p class="title-quote">[ ! ] Perhatian</p>
>Untuk tabel selanjutnya, proses **Export** dan **Import** sama seperti tabel **pasar**, sehingga tidak saya tuliskan kembali.
>
>Selanjutnya saya hanya akan menuliskan _query syntax_ nya saja untuk melakukan transformasi tabel **data** ke bentuk yang diperlukan oleh tabel tujuan.

#### 4.3.2 Tabel Komoditas
Kita akan mentransformasi _fields_ **komoditas** dari tabel **data**, dengan _queries_ seperti di bawah ini.
```
SELECT @nomor:=@nomor+1 as id, komoditas
FROM data,(SELECT @nomor:=0)r
GROUP BY komoditas;
```
Kemudian **Excute** dengan menekan tombol bergambar petir.

Proses **Export** dan **Import** sama seperti tabel **pasar**, hanya saja proses _import_ dilakukan di tabel **komoditas**.

#### 4.3.3 Tabel Satuan
Kita akan mentransformasi _fields_ **satuan** dari tabel **data**, dengan _queries_ seperti di bawah ini.
```
SELECT @nomor:=@nomor+1 as id, satuan
FROM data,(SELECT @nomor:=0)r
GROUP BY satuan;
```
Kemudian **Excute** dengan menekan tombol bergambar petir.

Proses **Export** dan **Import** sama seperti tabel **pasar**, hanya saja proses _import_ dilakukan di tabel **satuan**.

#### 4.3.4 Tabel Detil Komoditas
Kita akan mentransformasi _fields_ **detilkomoditas** dari tabel **data** yang berelasi dengan tabel **komoditas**, dan **satuan** dengan _queries_ seperti di bawah ini.
```
SELECT
@nomor:=@nomor+1 as id,
data.detilkomoditas,
komoditas.id_komoditas,
satuan.id_satuan

FROM
data,
komoditas,
satuan

WHERE
data.komoditas=komoditas.nama_komoditas
AND
data.satuan=satuan.nama_satuan;
```
Kemudian **Excute** dengan menekan tombol bergambar petir.

Proses **Export** dan **Import** sama seperti tabel **pasar**, hanya saja proses _import_ dilakukan di tabel **detil_komoditas**.

#### 4.3.5 Tabel Transaksi
Kita akan mentransformasi _fields_ **tanggal**, **harga**, **jumlahterjual** dari tabel **data** yang berelasi dengan tabel **detil_komoditas** dan tabel **pasar** dengan _queries_ seperti di bawah ini.
```
SELECT
detil_komoditas.id_detil_komoditas,
pasar.id_pasar,
data.tanggal,
data.harga,
data.jumlahterjual

FROM
data,
detil_komoditas,
pasar

WHERE
data.detilkomoditas=detil_komoditas.nama_detil_komoditas
AND
data.namapasar=pasar.nama_pasar;
```
Kemudian **Excute** dengan menekan tombol bergambar petir.

Proses **Export** dan **Import** sama seperti tabel **pasar**, hanya saja proses _import_ dilakukan di tabel **transaksi**.

<br>
Maka proses ekstrak dan transformasi dari file pasar_2014.csv ke dalam tabel operasional ERD telah selesai.

![Gambar 27]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/495qf781p/gambar_27.png"}
