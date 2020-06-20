---
layout: 'post'
title: "Belajar Membuat Web Scraper dengan Ruby bagian 02 (POSTGRESQL: COPY FROM CSV)"
date: 2020-06-16
permalink: '/vlog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'vlog'
tags: ['Tips', 'Ruby']
pin:
voice: true
---

<div style="margin-top:30px;"></div>

{% include youtube_embed.html id="qdFkae_mYbE" %}

# Deskripsi

Pada vlog kali ini saya sedang belajar membuat web scraper menggunakan bahasa pemrograman Ruby.

Web scraper kali ini saya gunakan untuk mengambil daftar dosen Universitas Mulia Balikpapan yang ada di website resmi dari Biro Akademik Universitas Mulia Balikpapan baak.universitasmulia.ac.id/dosen/

Namun output kali ini dimasukkan ke dalam file CSV lalu diimport ke dalam tabel Postgresql dengan perintah COPY FROM.
