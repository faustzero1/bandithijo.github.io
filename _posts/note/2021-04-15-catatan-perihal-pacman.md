---
layout: 'post'
title: "Catatan dalam Berinteraksi dengan Pacman"
date: 2021-04-15 22:23
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
description: "Bagi teman-teman yang menggunakan Arch Linux, pasti sudah tidak asing lagi mendengar nama 'Pacman'. Pacman adalah package manager yang digunakan oleh Arch Linux. Sebenarnya ada banyak sekali fitur-fitur yang dapat kita manfaatkan untuk mempermudah masalah atau kebutuhan yang terkadang kita perlukan. Karena kebutuhan atau masalah yang muncul tidak setiap waktu, maka beberapa parameter dari Pacman mungkin tidak sering kita gunakan dan terlupakan."
---

# Prakata

Bagi teman-teman yang menggunakan Arch Linux, pasti sudah tidak asing lagi mendengar nama "Pacman". Pacman adalah package manager yang digunakan oleh Arch Linux. Sebenarnya ada banyak sekali fitur-fitur yang dapat kita manfaatkan untuk mempermudah masalah atau kebutuhan yang terkadang kita perlukan. Karena kebutuhan atau masalah yang muncul tidak setiap waktu, maka beberapa parameter dari Pacman mungkin tidak sering kita gunakan dan terlupakan.

Catatan ini hadir, untuk mempermudah menyimpan beberapa catatan-catatan penggunaan parameter yang tidak sering kita gunakan tapi sangat diperlukan apabila kebutuhan/masalah itu datang.

# Penggunaan

## Download fresh database (Sinkronisasi)

Semacam update/mensikronisasikan daftar list package dengan mirror server.

{% shell_term $ %}
sudo pacman -Sy
{% endshell_term %}

Bisa dibilang, kalau di Debian/Ubuntu, padanannya dengan `apt-get update`.


## Download fresh database lagi (Sinkronisasi lagi)

Kalau kita sudah menjalankan `pacman -Sy`, dan menjalankannya lagi untuk kedua kalinya, database tidak akan didwonload lagi.

Kita dapat memaksa untuk mendownload database lagi dengan cara.

{% shell_term $ %}
sudo pacman -Syy
{% endshell_term %}


## Upgrade all out-of-date packages

Untuk memperbaharui package gunakan,

{% shell_term $ %}
sudo pacman -Syu
{% endshell_term %}

Bisa dibilang, kalau di Debian/Ubuntu, padanannya dengan `apt-get upgrade`.

Meskipun kita dapat menggunakan `$ sudo pacman -Su`, tapi tidak direkomendasikan. Karena local database tidak mendapatkan informasi package terbaru dari remote database yang ada di mirror server dengan perintah `-y`.

Maka dari itu, sangat direkomendasikan sebelum menjalankan perintah upgrade `-Su`, kita menggunakan perintah download fresh database `-Sy` terlebih dahulu. Kedua option ini dapat kita gabungkan, menjadi `-Syu`.

## Pacman Keyring

Kita dapat me-manage pacman keyring dengan menggunakan wrapper script yang bernama **pacman-keyring**.

Yang paling cukup sering saya lihat untuk melakukan refresh keys.

{% shell_term $ %}
sudo pacman-key --refresh-keys
{% endshell_term %}

<pre>
gpg: key FCF3C8CB5CF9C8D4: "Alexander Rødseth <rodseth@gmail.com>" not changed
gpg: key 9D893EC4DAAF9129: "Bruno Pagani <bruno.pagani@ens-lyon.org>" not changed
gpg: key 2E89012331361F01: "Evgeniy Alekseev <arcanis@archlinux.org>" 3 new signatures
gpg: key 2E89012331361F01: "Evgeniy Alekseev <arcanis@archlinux.org>" 11 signatures cleaned
gpg: key FC1B547C8D8172C8: "Levente Polyak (anthraxx) <levente@leventepolyak.net>" not changed
gpg: key 94657AB20F2A092B: 1 duplicate signature removed
gpg: key 94657AB20F2A092B: 1 signature reordered
gpg: key 94657AB20F2A092B: "Andreas Radke <andyrtr@archlinux.org>" 1 new user ID
gpg: key 94657AB20F2A092B: "Andreas Radke <andyrtr@archlinux.org>" 4 new signatures
gpg: key F6B1610B3ECDBC9F: "Andrew Crerar <andrew@crerar.io>" not changed
gpg: key B02854ED753E0F1F: "Anatol Pomozov <anatol.pomozov@gmail.com>" not changed
...
</pre>

Tunggu saja prosesnya dengan sabar, mungkin akan cukup memakan waktu.












{% comment %}
# Referensi

1. [](){:target="_blank"}
2. [](){:target="_blank"}
3. [](){:target="_blank"}
{% endcomment %}
