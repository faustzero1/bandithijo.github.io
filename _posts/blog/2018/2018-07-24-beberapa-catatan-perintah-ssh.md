---
layout: 'post'
title: 'Beberapa Catatan Kaki Mengenai Perintah-perintah SSH'
date: 2018-07-30 21:56
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Network', 'ssh']
pin:
hot:
contributors: []
description:
---

<!-- BANNER OF THE POST -->
<img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="https://s20.postimg.cc/dwqipcfgd/banner_post_18.png" onerror="imgError(this);" alt="banner">

# Pendahuluan
Sudah hampir dua minggu ini saya terpilih sebagai peserta untuk mengikuti kelas yang membahas tentang *Cloud Computing*. Ini merupakan bidang yang sangat baru pertama kali saya sentuh. Sebelumnya, memang saya sering membaca (meski hanya judul) di beberapa blog GNU/Linux yang membahas tentang teknologi-teknologi yang digunakan dalam *cloud computing*. Meskipun sama-sama dalam bidang teknologi, namun jujur saja, istilah-istilah yang digunakan sangat asing buat saya pahami.

# Keresahan
Di kelas yang saya ikuti, saya menemukan beberapa penerapan perintah-perintah `ssh` yang saya rasa perlu untuk mendokumentasikannya. Saya khawatir akan sangat membuang-buang waktu lagi apabila saya harus melakukan *research* kembali jika suatu saat nanti saya membutuhkannya. Jadi, kenapa tidak saya tulis.

# Catatan Kaki
Berikut ini adalah beberapa perintah-perintah SSH yang saya gunakan. Belum dapat saya jelaskan secara detail masing-masing fungsinya dan penjabaran masing-masing parameter yang digunakan.

## SSH Tunneling dengan Keybase Login & Spesifik Port

{% pre_url %}
ssh -i .ssh/{private-key} {user}@{server-address} -p {port}
{% endpre_url %}

{% shell_user %}
ssh -i .ssh/id_rsa bandithijo@dev.bandithijo.com -p 2200
{% endshell_user %}

Atau,

{% shell_user %}
ssh -i .ssh/id_rsa bandithijo@10.1.41.200.1 -p 2200
{% endshell_user %}

## SSH Tunneling dengan Keybase Login, Spesifik Port & Dynamic Port Forwarding
Nah, kalo ini saya gunakan untuk *Dynamic Port Forwarding*, kegunannya untuk mengakses server agar dapat kita akses dari *web browser* kita.

{% pre_url %}
ssh -D {proxy-port} -i .ssh/{private-key} {user}@{server-address} -p {port}
{% endpre_url %}

{% shell_user %}
ssh -D 8080 -i .ssh/id_rsa bandithijo@dev.bandithijo.com -p 2200 -q
{% endshell_user %}

Atau,

{% shell_user %}
ssh -D 8888 -i .ssh/id_rsa bandithijo@10.1.41.200 -p 2200 -q
{% endshell_user %}

*port* 8080 dapat diganti dengan nilai berapapun, asalkan *port* tersebut tidak digunakan oleh service yang lain.

Setelah itu, untuk mengaksesnya dari *web browser*, saya menggunakan perintah di bawah.

<br>
**Firefox**

1. Pilih menu **Preferences** > *find in Preferences*, isikan "Proxy"
2. Nanti akan keluar **Network Proxy**, pilih **Settings...**
3. Pilih **Manual proxy configuration** > SOCKS Host: **localhost** Port: **8080**, samakan nilai port dengan nilai *dynamic port forwarding* yang kalian berikan pada saat SSH tunneling port forwarding di atas.
4. Pilih bullet **SOCKS v5**
5. Optional untuk mencentang **Proxy DNS when using SOCKS v5**
6. Pastikan Server kalian sudah mengaktifkan service HTTP

<br>
**Chromium / Google Chrome**

Pada *browser* Chromium atau Google Chrome, cukup menjalankan perintah di bawah ini pada Terminal.

**Google Chrome**

{% shell_user %}
google-chrome-stable --proxy-server="socks5://localhost:8080"
{% endshell_user %}

**Chromium**

{% shell_user %}
chromium --proxy-server="socks5://localhost:8080"
{% endshell_user %}

## SSH Tunneling dengan Username yang Terdaftar pada Server

{% shell_user %}
ssh -l banditbiru dev.bandithijo.com
{% endshell_user %}

Atau,

{% shell_user %}
ssh -l banditbiru 10.1.41.200
{% endshell_user %}

Perintah di atas akan membawa kita langsung memasuki user **banditbiru** di server. Tentu saja perintah ini dapat dilakukan setelah kita memasukkan **public key** kita ke dalam file `/home/banditbiru/.ssh/authorized_keys` di server pada user **banditbiru**.

## Generate Private & Public Key SSH

Saya menggunakan beberapa bentuk format perintah `ssh-keygen` untuk mengenerate key. Berikut ini adalah beberapa bentuk format yang saya gunakan dalam pelatihan.

### Generate Key untuk User Biasa

Yang sederhana,

{% shell_user %}
ssh-keygen
{% endshell_user %}

Atau agak kompleks,

{% shell_user %}
ssh-keygen -t rsa -b 4096
{% endshell_user %}

Yang lebih kompleks,

{% shell_user %}
ssh-keygen -t rsa -b 4096 -C "bandithijo@rumah"
{% endshell_user %}

Hasil dari perintah di atas adalah dua buah file dengan nama yang sama, namun yang tidak memiliki ekstensi disebut sebagai **Private Key** dan yang memiliki ekstensi **.pub** disebut sebagai **Public Key**.

{% shell_user %}
ls -l $HOME/.ssh/
{% endshell_user %}

<pre>
/home/bandithijo/.ssh/
├── authorized_keys
├── <mark>id_rsa</mark>
├── <mark>id_rsa.pub</mark>
└── known_hosts
</pre>

Sebagai catatan, apabila kita melakukan perintah `ssh-keygen` pada user biasa, maka otomatis file *private* dan *public key* akan diletakkan pada direktori `.ssh/` milik user biasa tersebut. Seperti contoh di atas, terletak pada direktori `.ssh` milik user **bandithijo**.

### Generate Key untuk Root dari User Biasa

Kita dapat mengenerate key untuk user root melalui user biasa, dengan cara menambahkan `sudo` pada awal perintah `ssh-keygen`.

{% shell_user %}
sudo ssh-keygen
{% endshell_user %}

Apabila seperti di atas, maka file *private* dan *public key* akan terdapat pada direktori `.ssh/` milik root, yaitu `/root/.ssh/`.

{% shell_user %}
sudo ls -l /root/.ssh/
{% endshell_user %}

<pre>
/root/.ssh/
├── authorized_keys
├── <mark>id_rsa</mark>
├── <mark>id_rsa.pub</mark>
└── known_hosts
</pre>

Tentu saja, apabila *private* dan *public key* yang kita generate berada pada direktori `/root/`, maka untuk mengakses SSH Gateway kita juga harus mengawalinya dengan menambahkan perintah `sudo` di awal baris perintah.

{% shell_user %}
sudo ssh -l bandithijo dev.bandithijo.com
{% endshell_user %}

Atau,

{% shell_user %}
sudo ssh -l bandithijo 10.1.41.200
{% endshell_user %}

{% box_pertanyaan %}
<p><b>Apakah private dan public key dapat kita rename?</b></p>
Tentu saja kita dapat mengganti nama dari file <i>private</i> dan <i>public key</i> tersebut, namun sangat direkomendasikan untuk memberikan nama yang sama diantara keduanya. Agar tetap berpasangan.. So sweet kan gaes ^_^, mereka aja berpasangan, kamu kapan ?
{% endbox_pertanyaan %}

## Menampilkan Public Key

{% pre_url %}
cat $HOME/.ssh/{nama_public_key}.pub
{% endpre_url %}

{% shell_user %}
cat $HOME/.ssh/id_rsa.pub
{% endshell_user %}

## Menyimpan public key di server target

{% pre_url %}
ssh-copy-id -i ~/.ssh/id_rsa.pub <username@ipaddress>
{% endpre_url %}

{% shell_term $ %}
ssh-copy-id -i ~/.ssh/id_rsa.pub bandithijo@192.168.1.7
{% endshell_term %}

# Pesan Penulis

Oke, saya rasa untuk saat ini, cukup seperti ini saja. Saya tidak berhenti menulis, mungkin lain kali kamu datang lagi, tulisan di halaman ini sudah bertambah dengan perintah-perintah SSH yang lain.

Terima kasih. ^_^

# Referensi
1. [wiki.archlinux.org/index.php/Secure_Shell](https://wiki.archlinux.org/index.php/Secure_Shell){:target="_blank"}
<br>Diakses tanggal: 18/07/24
