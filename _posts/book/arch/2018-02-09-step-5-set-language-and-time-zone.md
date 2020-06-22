---
layout: 'post'
title: 'Step 5: Set Language and Time Zone'
date: 2018-02-09 06:00
permalink: '/arch/:title'
author: 'BanditHijo'
license: true
comments: false
toc: true
category: 'arch'
tags:
pin:
---


# STEP 5 : Set Language and Time Zone

## 5.1 Locale

Konfigurasi _locale_ dimaksudkan untuk menginformasikan kepada aplikasi yang berjalan pada sistem operasi kita bahwa kita menggunakan _locale_ \(yang kita pilih\) tersebut.

_locale_, sejauh yang saya gunakan adalah untuk mengatur _language_ \(bahasa\), _first day in calendar_, _date and time default format_, _paper format_, _currency format_, _distance format_, dan lain sebagainya.

Untuk memilih _locale_, terlebih dahulu kita perlu membuka akses _locale_ yang masih ter-_disable_ pada _file_ `/etc/locale.gen`. Dalam hal ini saya akan mengaktifkan / _uncommenting_ `en_US.UTF-8`.

```
# vim /etc/locale.gen
```

_Scroll_ ke bawah dan cari baris yang mengandung isi `en_US.UTF-8 UTF-8`, lalu hilangkan tanda `#` yang ada di depan baris tersebut.

<pre>
...
...

#en_SG.UTF-8 UTF-8
#en_SG ISO-8859-1
<mark>en_US.UTF-8 UTF-8</mark>
#en_US ISO-8859-1
#en_ZA.UTF-8 UTF-8
...
...
</pre>

Kamu dapat juga memilih bahasa **Indonesia**, dengan _scrolling_ ke bawah dan hilangkan tanda `#` pada `id_ID.UTF-8 UTF-8`. Namun, saya pribadi lebih _prefer_ hanya menggunakan **English** saja.

Kemudian _generate_ `locale` dengan perintah.

```
# locale-gen
```
```
Generating locales...
    en_US.UTF-8... done
Generating complete.
```

Mengeset _locale_ yang sudah kita _generate_ ke dalam _file_ `/etc/locale.conf`.

```
# locale > /etc/locale.conf
```

Konfigurasi lebih jauh mengenai `locale`, seperti _firstday in week_, _paper format_, dll., akan saya tambahkan pada kesempatan yang lain.

## 5.2 Time zone

Untuk mengatur _time zone_, gunakan `tzselect` dan ikuti alur perintahnya.

Misal, **\(4\) Asia → \(15\) Indonesia → \(3\) Borneo \(east, south … \) → \(1\) Yes**.

```
# tzselect
```

Kemudian, kita perlu untuk membuat _symlink_ untuk mengeset `localtime`.

```
# ln -sf /usr/share/zoneinfo/Asia/Makassar /etc/localtime
```

Saya berada pada waktu lokal WITA, jadi saya pilih _localtime_ Makassar. Kamu dapat menggantinya dengan _localtime_ Jakarta untuk WIB.

Selanjutnya adalah _hardware clock_. Bagaimanapun juga _hardware clock_ akan menggunakan UTC. Sehingga kita perlu megesetnya dengan cara sebagai berikut.

```
# hwclock --systohc --utc
```

Sampai sini, proses konfigurasi _locale_ dan _time zone_ telah selesai. Kita dapat melangkah ke _step_ selanjutnya.



<!-- NEXT PREV BUTTON -->
{% assign btn-next = "/arch/step-4-set-up-bootloader" %}
{% assign btn-menu = "/arch/" %}
{% assign btn-prev = "/arch/step-6-create-user-password-and-hostname" %}
<div class="post-nav">
<a class="btn-blue-l" href="{{ btn-next }}"><img class="btn-img" src="/assets/img/logo/logo_ap.png"></a>
<a class="btn-blue-c" href="{{ btn-menu }}"><img class="btn-img" src="/assets/img/logo/logo_menu.svg"></a>
<a class="btn-blue-r" href="{{ btn-prev }}"><img class="btn-img" src="/assets/img/logo/logo_an.png"></a>
</div>
