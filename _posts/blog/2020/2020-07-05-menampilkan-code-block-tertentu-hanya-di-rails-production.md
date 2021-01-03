---
layout: 'post'
title: "Menampilkan Code Block Tertentu Hanya di Production pada Rails"
date: 2020-07-05 08:14
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
---

# Sekenario Masalah

Kasus kali ini adalah, saya ingin menampilkan code block tertentu hanya perlu dirender pada saat di level production. Karena tidak begitu diperlukan di level development.

Misal, seperti code block untuk Disqus komentar, code block untuk analytics script, dan lain-lain.

# Penyelesaian Masalah

Saya yakin terdapat banyak sekali cara untuk memecahkan masalah ini, namun saya memilih untuk menggunakan cara ini.

Bungkus code block yang hanya ingin ditampilkan pada level production dengan kondisi seperti di bawah ini.

{% highlight_caption %}
{% highlight erb linenos %}
<% if Rails.env.production? %>
  # Block code yang ingin ditampilan di production
  # Tidak akan ditampilkan di development
<% end %>
{% endhighlight %}

Selesai!

Dengan begini, code block tersebut hanya akan di-render pada saat di level production.

Mudah-mudahan bermanfaat yaa.

Terima kasih (^_^)








# Referensi

1. [stackoverflow.com/questions/4632747/rails-best-way-to-display-code-only-in-production](https://stackoverflow.com/questions/4632747/rails-best-way-to-display-code-only-in-production){:target="_blank"}
<br>Diakses tanggal: 2020/07/05

