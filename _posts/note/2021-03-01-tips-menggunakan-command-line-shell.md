---
layout: 'post'
title: "Tips Menggunakan Command Line Shell"
date: 2021-03-01 00:35
permalink: '/note/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'note'
tags: ['Tips']
wip: true
pin:
contributors: []
---

# Prakata

Menggunakan Command Line Shell mungkin merupakan mimpi buruk bagi sebagian orang.

Untuk teman-teman yang masih merasa seperti itu, jangan khawatir, kalian hanya belum terbiasa saja.

Saya pun, terkadang juga masih sering lupa, perintah-perintah apa saja yang pernah saya gunakan.

Terlebih lagi, kalau perintah tersebut tidak sering saya gunakan, bisa dipastikan minggu depan, saya pasti sudah lupa.

Untuk itu, saya mempublikasikan catatan untuk teman-teman pembaca Blog BaditHijo, agar dapat sama-sama kita manfaatkan.

Terima kasih telah menjadi pembaca setia dan menemani saya sampai saat ini.


# Tips & Tricks

## Megecek lokasi direktori saat ini

Current Working Directory atau biasa disingkat dengan **cwd**, adalah lokasi/path lengkap, yang menunjukkan keberadaan kita saat ini.

Kita dapat menggunakan perintah,

{% shell_cmd $ %}
pwd
{% endshell_cmd %}

{% pre_url %}
/home/bandithijo/app/blog/
{% endpre_url %}

**pwd** adalah abreviation dari print name of current/working directory.

## Kembali ke direktori sebelumnya

Misalkan kita berada pada,

{% pre_url %}
/home/bandithijo/app/blog/
{% endpre_url %}

Dan kita ingin mundur satu level ke direktori **app**, maka kita dapat menggunakan cara ini,

{% shell_cmd $ %}
cd ..
{% endshell_cmd %}

Sekarang, kita sudah berada pada direktori **app**.
{% pre_url %}
/home/bandithijo/app/
{% endpre_url %}

## Keluar dan masuk, lagi dari dan ke direktori saat ini

Cara cepatnya untuk keluar satu level dan masuk lagi ke direktori yang sama, dapat menggunakan,

{% shell_cmd $ %}
cd -
{% endshell_cmd %}



{% comment %}
# Referensi

1. [openbsdhandbook.com/openbsd_for_linux_users/](https://www.openbsdhandbook.com/openbsd_for_linux_users/){:target="_blank"}
{% endcomment %}
