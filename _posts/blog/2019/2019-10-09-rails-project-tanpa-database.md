---
layout: 'post'
title: "Membuat Rails Project tanpa Database"
date: 2019-10-09 18:57
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Rails']
pin:
hot:
contributors: []
description: "Catatan kali ini mengenai cara membuat Ruby on Rails project tanpa menggunakan database."
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Hello, Mas Bro!

Kita *conference pers* sebentar yaa.

Cukup lama juga tidak mengupdate tulisan di blog ini. Selain karena alasan pekerjaan juga karena sudah kehabisan kesabaran dengan proses *build time* dari Jekyll Blog ini yang semakin molor. Sekitar <u>+</u> 59 menitan. Mungkin saja penyebab hal ini dikarenakan blog ini memiliki artikel yang sudah cukup banyak.

Jujur saja, hal ini menghambat proses saya dalam menulis. Namun, masalah ini sudah berhasil saya ~~akalin~~ atasin. Mungkin, setelah ini akan saya posting bagaimana cara saya mengatasi masalah ini.

# Latar Belakang Masalah

Oke, kembali ke topik bahasan mengenai "Membuat Rails Project tanpa Database". Atau dapat pula saya gunakan kalimat "tanpa menggunakan Active Record".

Artikel ini akan menjadi tulisan yang sederhana.

Dalam membuat sebuah project, mungkin saja dalam kasus yang sedang kita hadapi, kita tidak memerlukan database. Misalnya, membuat aplikasi yang semua data-datanya diambil dari API (*Application Program Interface*). Tentu akan lebih efektif kalo project yang kita buat, tidak perlu menyertakan database, karena kita tidak memerlukannya.

# Pemecahan Masalah

**Apakah Rails dapat melakukan ini?**

Tentu saja! Bahkan caranya sangat mudah.

Rails menyertakan fitur ini sejak Rails 5.2.

Untuk dapat membuat Rails project tanpa menyertakan default database (sqlite) ikuti cara di bawah ini.

Saat akan menginisialisasi project baru, lakukan perintah di bawah ini.

{% shell_user %}
rails new ProjectMahal --skip-active-record
{% endshell_user %}

Atau, kalau ingin menggunakan versi Rails tertentu, misal: Rails 5.1.3

Dapat menggunakan cara di bawah ini.

{% shell_user %}
rails _5.1.3_ new ProjectMahal --skip-active-record
{% endshell_user %}

Nah, mudah sekali kan?

Apabila dikemudian hari ingin menggunakan database, silahkan mengikuti blog post selanjutnya mengenai, "[Menambahkan Database pada Rails Project](/blog/menambahkan-database-pada-rails-project){:target="_blank"}".

Terima kasih. (^_^)v


# Referensi

1. [Ruby on Rails 5.2 Release Notes (edgeguides)](https://edgeguides.rubyonrails.org/5_2_release_notes.html){:target="_blank"}
<br>Diakses tanggal: 2019/10/09

2. [The Rails Command Line (edgeguides)](https://edgeguides.rubyonrails.org/command_line.html){:target="_blank"}
<br>Diakses tanggal: 2019/10/09
