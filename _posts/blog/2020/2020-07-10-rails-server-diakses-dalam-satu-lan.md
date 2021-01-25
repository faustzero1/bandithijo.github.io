---
layout: 'post'
title: "Rails Server Dapat Diakses oleh Perangkat dalam Satu LAN"
date: 2020-07-10 01:03
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
resume: "Kita dapat membuat Rails aplikasi yang kita bangun di local environment sistem kita membuka akes broadcast ke local network. Sehingga, semua perangkat yang berada pada satu network yang sama, dapat mengakses Rails aplikasi yang ada di local sistem kita."
---

# Sekenario Masalah

Saya sedang membangun atau memodifikasi layout dari sebuah web.

Selain mendesain untuk tampilan desktop, saya juga perlu mendesain untuk tampilan mobile.

Agar saya dapat merasakan secara langsung, seperti apa layout yang saya sedang kerjakan, lebih baik kalau saya dapat langsung membukanya secara langsung di *smartphone*.

# Pemecahan Masalah

Rails sudah menyediakan fitur untuk menjalankan server dengan mengganti Host yang kita definisikan.

Kita sama-sama tahu kalau *ip address* untuk broadcast di dalam *network* adalah `0.0.0.0`.

Sedangkan, Jekyll server menjalankan host secara default berada pada ip `127.0.0.1`, yang mana ini adalah *localhost*, sehingga hanya dapat diakses oleh kita sendiri dari Browser kita.

Maka, kita perlu mengganti ip address tersebut menjadi ip address untuk *broadcast*.

Caranya sangat mudah.

## Definisikan Host


Cukup tambahkan option `-b` atau `--binding=` diikuti dengan *broadcast ip address*.

{% shell_user %}
bundle exec rails s -b 0.0.0.0
{% endshell_user %}

Nah dengan begini, kita dapat mengakses dari semua perangkat dalam satu jaringan yang sama dengan sistem localhost kita.

Misal, sistem kita memiliki ip `192.168.1.5`.

Maka, kita akses dari smartphone dengan tujuan `192.168.1.5:3000`.

Voila!

{% image https://i.postimg.cc/KzvdYqxr/gambar-01.png | 1 | Tampilan Desktop dan Mobile %}

Tampilan mobile dari web yang sedang kita kerjakan, dapat kita ekplorasi secara langsung dari smartphone.

Enak banget kan!



# Pesan Penulis

Catatan ini bukan merupakan tutorial, saya hanya ingin sharing tentang informasi yang saya dapat dan saya pergunakan selama membangun web aplikasi menggunakan Ruby on Rails.

Maka dari itu, apabila teman-teman ingin mendapatkan penjelasan yang lebih baik, silahkan mengunjungin dokumentasi dari Ruby on Rails. Tentunya akan lebih *up to date* dari yang saya tulis di sini.

Saya rasa hanya ini yang dapat saya tuliskan saat ini.

Mudah-mudahan dapat bermanfaat untuk teman-teman.

Terima kasih.

(^_^)








# Referensi

1. [guides.rubyonrails.org/command_line.html](https://guides.rubyonrails.org/command_line.html){:target="_blank"}
<br>Diakses tanggal: 2020/07/10

2. [github.com/thoughtbot - Binding to 0.0.0.0 in Rails](https://github.com/thoughtbot/til/blob/master/docker/binding-to-0-0-0-0-in-rails.md){:target="_blank"}
<br>Diakses tanggal: 2020/07/10
