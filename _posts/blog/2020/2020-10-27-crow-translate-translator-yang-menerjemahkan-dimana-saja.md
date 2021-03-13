---
layout: 'post'
title: "Crow-translate, Translator Online yang Dapat Menerjemahkan Di Mana Saja"
date: 2020-10-27 05:41
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Ulasan']
pin:
hot:
contributors: []
description: "Aplikasi translator ini sangat convenient untuk digunakan. Karena kita dapat menerjemahkan kata/kalimat apa saja yang kita temui di desktop, selama kata/kalimat tersebut dapat diseleksi."
---

# Latar Belakang

Minggu kemarin, saya baru saja memperkenalkan tentang aplikasi **translate-shell** (artikelnya dapat dibaca [di sini](/blog/translate-shell-translator-cli-mudah){:target="_blank"}).

Sebenarnya, sebelum memutuskan untuk menggunakan **translate-shell**, saya lebih dulu memutuskan untuk menggunakan **crow-translate**. Namun, karena aplikasi ini menggunakan Qt library dan harus melakukan kompilasi terlebih dahulu, saya jadi mengurungkan niat untuk memasang. Karena, beberapa library Qt memerlukan kompilasi terlebih dahulu. Oleh karena itu, kemarin saya memutuskan untuk menggunakan translate-shell terlebih dahulu.

Namun, saya sering mengdapati kendala berupa,

{% pre_url %}
<b>[WARNING] Connection timed out. Retrying IPv4 connection.</b>
{% endpre_url %}

Saya belum mengerti, apa yang sebenarnya menyebabkan warning ini muncul. Asumsi saya saat ini adalah koneksi internet IndiHome saya.

{% box_info %}
<p markdown="1">Ternyata, setelah saya coba kulik, masalah tersebut di atas berhubungan dengan variable **user-agent**. Mungkin value dari user-agent yang saya pergunakan sudah tidak lagi valid. Sehingga saya putuskan untuk menghapus, dan masalah "connection timed out" sudah hilang.</p>
{% endbox_info %}

Masalah tersebut yang akhirnya mengantarkan saya untuk memutuskan menggunakan crow-translate.

Seingat saya, tahun 2017, saya pernah juga menggunakan crow-translate, namun saat itu prioritas saya adalah mencari kamus yang dapat digunakan secara offline, sehingga saya tidak terlalu memberikan apresiasi dan atensi kepada crow-translate. Saat itu, atensi saya jatuh pada **GoldenDict** (vlognya dapat ditonton [di sini](/vlog/review-goldendict-pt1){:target="_blank"}).

# Tentang Crow-translate

Crow-translate adalah translator yang simple dan ringan yang dibuat dengan bahasa C++/Qt yang dapat membantu kita dalam mentranslasikan dan membunyikan (speak) suatu teks menggunakan Google, Yandex, dan Bing translate API.

## Fitur Unggulan

Berikut ini adalah fitur-fitur unggulan yang dibawa oleh crow-translate:

1. Menerjemahkan dan membunyikan teks dari layar atau dari teks yang diseleksi
2. Dapat menerjemahkan 125 bahasa yang berbeda
3. Konsumsi memory resource yang rendah (~20MB)
4. Shortcut yang dapat dikostumisasi dengan bebas
5. Memiliki option-option pada CLI yang kaya
6. D-BUS API
7. Tersedia untuk GNU/Linux & Windows

# Instalasi

Untuk teman-teman yang menggunakan distribusi sistem operasi Arch Linux, paket **crow-translate** dapat ditemukan di AUR (Arch User Repository).

{% shell_user %}
yay -S crow-translate
{% endshell_user %}

Untuk yang menggunakan selain Arch Linux, dapat menyesuaikan sendiri yaa.

# Keboard Shortcut

Kita dapat dengan mudah mengganti keyboard shortcut sesuai dengan pada bagian **settings**.

## Global

Keyboard shortcut ini dapat kita langsung panggil di dalam desktop --mungkin akan terjadi *collision* dengan beberapa default keyboard shortcut dengan aplikasi lain.

| Key                                             | Deskripsi                               |
| ----------------------------------------------- | ----------------------------------------|
| <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>E</kbd> | Terjemahkan teks yang diseleksi         |
| <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>S</kbd> | Bunyikan teks yang diseleksi            |
| <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>F</kbd> | Bunyikan terjemahan teks yang diseleksi |
| <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>G</kbd> | Berhenti membunyikan                    |
| <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>C</kbd> | Tamapilkan window utama                 |
| <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>O</kbd> | Terjemahkan teks di area layar          |

## Di Main Window

| Key                                               | Deskripsi                               |
| ------------------------------------------------- | --------------------------------------- |
| <kbd>Ctrl</kbd> + <kbd>Enter</kbd>                | Terjemahkan                             |
| <kbd>Ctrl</kbd> + <kbd>R</kbd>                    | Tukar bahasa                            |
| <kbd>Ctrl</kbd> + <kbd>Q</kbd>                    | Tutup window                            |
| <kbd>Ctrl</kbd> + <kbd>S</kbd>                    | Speak source / pause text speaking      |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>S</kbd> | Speak translation / pause text speaking |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> | Salin terjemahan ke Clipboard           |



# Demonstrasi

{% image https://i.postimg.cc/L8Hwc0zz/gambar-01.gif | 1 %}








# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)

# Referensi

1. [github.com/crow-translate/crow-translate](https://github.com/crow-translate/crow-translate){:target="_blank"}
<br>Diakses tanggal: 2020/10/27
