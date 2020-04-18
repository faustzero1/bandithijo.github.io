---
layout: 'post'
title: "Membuat Navigasi Post (Next Prev) pada Jekyll"
date: 2020-04-18 13:20
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Jekyll']
pin:
hot:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Pendahuluan

Catatan kali ini mengenai Jekyll. Haha. Jarang-jarang saya menulis tentang Jekyll.

Kebetulan sedang iseng mendevelop blog untuk sebuah buletin yang terbit tiap hari Jum'at. Iseng saja saya bangun menggunakan Jekyll.

Karena blog tersebut adalah blog kedua yang saya buat dengan Jekyll. Maka saya akan mencoba memulai dengna tertib dan lebih rapi. Tidak seperti saat membuat blog ini yang lebih ke "asal jadi dulu". Ahahaha.

# Permasalahan

Post pada sebuah blog, pasti akan runut berdasarkan waktu dibuatnya.

Kalau berdasarkan *user experience*, setelah pembaca membaca artikel pada sebuah post sampai bawah, kalau ia tertarik, ia akan mencari artikel sebelumnya, atau daftar semua artikel, atau artikel yang memiliki topik yang sama (*related post*).

Maka dari itu, kita perlu untuk memasang, setidaknya menu navigasi untuk ke post sebelumnya atau ke post selanjutnya.

# Penyelesaian Masalah

Saya akan membuat sebuah file bernama `page-navigation.html` di dalam direktori `_includes`.

Tujuannya agar lebih modular. Maksudnya, kita dapat memasang page navigation di mana saja yang kita perlukan, tinggal dipanggil menggunakan `include`.

{% raw %}
```html
<!-- _inlcudes/page-navigation.html -->

<div class="page-navigation mt-5">
  <div class="row d-flex justify-content-between">
    <div class="col-6 text-left">
      {% if page.previous.url %}
        <a class="prev" href="{{page.previous.url}}">&laquo; {{page.previous.title}}</a>
      {% endif %}
    </div>
    <div class="col-6 text-right">
      {% if page.next.url %}
        <a class="next" href="{{page.next.url}}">{{page.next.title}} &raquo;</a>
      {% endif %}
    </div>
  </div>
</div>
```
{% endraw %}

Oh yaa, untuk class dari stylesheet di atas, saya menggunakan Bootstrap CSS Framework.

Kalau teman-teman menggunakan CSS framework yang lain atau membuat sendiri, silahkan dimodifikasi sendiri yaa.

Kelar!

Sudah deh, saya rasa segini saja catatannya.

Mudah banget yaa.

Selamat mencoba!

Terima kasih.

(^_^)





# Referensi

1. [blog.webjeda.com/related-post-jekyll/](https://blog.webjeda.com/related-post-jekyll/){:target="_blank"}
<br>Diakses tanggal: 2020/04/18

2. [talk.jekyllrb.com/t/how-to-link-to-next-and-previous-posts-for-same-blog-category/629](https://talk.jekyllrb.com/t/how-to-link-to-next-and-previous-posts-for-same-blog-category/629){:target="_blank"}
<br>Diakses tanggal: 2020/04/18
