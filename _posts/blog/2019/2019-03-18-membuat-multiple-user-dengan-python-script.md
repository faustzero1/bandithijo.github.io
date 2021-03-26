---
layout: 'post'
title: 'Membuat Multiple User pada GNU/Linux dengan Python Script'
date: 2019-03-18 20:40
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Python', 'Script']
pin:
hot:
contributors: []
description: "Catatan ini mengenai cara membuat user dalam jumlah banyak sekaligus menggunakan Python script."
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Kemarin, 2019/03/17, ada salah satu anggota group Telegram BGLI (Belajar GNU/Linux Indonesia) menanyakan perihal ini.

{% image https://i.postimg.cc/N0n68vqS/gambar-01.png | 1 | Pertanyaan oleh: <b>./XiongXong @sandy147</b> %}

Sebelumnya saya tidak pernah mencobanya. Jadi tidak pernah terpikirkan sebelumnya.

Mungkin saja, untuk kebutuhan membuat username anggota dari kursusan, seperti NolSatu yang saya ikuti pertengahan 2018 kemarin. Membuat 50 user di dalam sebuah sistem. Kalau manual, memang berasa tekor juga.

Karena sepintas saya membayangkan bagaimana caranya untuk dapat menyelesaikan "permasalahan" ini. Lantas, saya pun iseng mencoba menyelesaikannya.

Berhubung saya tidak terlalu mengerti banyak tetang Shell script, saya mengkombinasikan dengan Python yang juga baru mengerti sedikit-sedikit.

# Eksekusi

## Algoritma

Alur program yang terpikirkan oleh saya adalah seperti ini:

1. Meminta inputan kepada user, berapa banyak jumlah user baru yang ingin dibuat.
2. Mengulang-ulang perintah pembuatan user baru sesuai dengan jumlah yang diinputkan oleh user.


{% image https://i.postimg.cc/0jQVk0v1/gambar-02.png | 2 %}

## Ngoding

Command atau perintah inti untuk membuat user baru beserta direktori home pada sistem operasi GNU/Linux, adalah:

{% shell_user %}
sudo useradd -m -g users -G <groups1,groups2,groups3,dst> <username>
{% endshell_user %}

Nah, langsung saja kita kodingin.

{% highlight_caption createmultipleuser.py %}
{% highlight python linenos %}
#!/usr/bin/env python3

import os

userDibuat = int(input('Masukkan jumlah user yang ingin dibuat: '))

print(userDibuat)

for user in range(1, userDibuat+1):
    username = input(f'Masukkan USERNAME untuk user ke-{user} : ')
    os.system(
        f'''
        sudo useradd -m -g users -G sudo,storage,power,input,network {username}
        ''')
    print('Username:', username, 'Berhasil ditambahkan !')

print('>> SELESAI MAS BROH !')
{% endhighlight %}

Simpan script dengan sembarang nama, jangan lupa berikan ekstensi `.py`.

Saya memberikan nama `createmultipleuser.py`.

Lalu jalankan dengan menggunakan sudo permission karena kita akan menggunakan perintah `useradd` di dalam script.

{% shell_user %}
sudo python createmultipleuser.py
{% endshell_user %}

```
Masukkan jumlah user yang ingin dibuat: 3
3
Masukkan USERNAME untuk user ke-1 : aiman
Username: aiman Berhasil ditambahkan !
Masukkan USERNAME untuk user ke-2 : budiman
Username: budiman Berhasil ditambahkan !
Masukkan USERNAME untuk user ke-3 : seniman
Username: seniman Berhasil ditambahkan !
>> SELESAI MAS BROH !
```

## Pengecekan

Untuk melakukan pengecekan apakah user-user baru sudah berhasil dibuat atau tidak.

{% shell_user %}
awk -F'[/:]' '{if ($3 >= 1000 && $3 != 65534) print $1}' /etc/passwd
{% endshell_user %}

<pre>
bandithijo
<mark>aiman
budiman
seniman</mark>
</pre>

Cek pula, apakah direktori home dari masing-masing user yang baru, sudah berhasil dibuat.

{% shell_user %}
tree -dL 1 /home
{% endshell_user %}

<pre>
/home
├── <mark>aiman</mark>
├── bandithijo
├── <mark>budiman</mark>
└── <mark>seniman</mark>
</pre>

Mantap, maka proses pembuatan *multiple user* dengan Python script ini telah selesai.

Untuk menghapusnya, dapat menggunakan.

{% shell_user %}
sudo userdel -rf <username>
{% endshell_user %}

# Pesan Penulis

Saya benar-benar menikmati proses dalam mempelajari bahasa pemrograman Python karena dapat sembari saya manfaatkan dan pergunakan dalam aktifitas sehari-hari untuk memecahkan keinginan, ide-ide, maupun permasalahan-permasalahan yang muncul dalam menggunakan sistem operasi GNU/Linux.

Kalau temen-temen sedang belajar pemrograman juga, yuk! jangan malu-malu untuk mencoba menyelesaikan masalah-masalah sederhana yang ada di sekitar kita.

Saya sendiri masih level Taman Kanak-kanak, hehe.

Sepertinya seperti ini saja.

Terima kasih.

# Referensi

1. [BanditHijo.Com/Arch - Step 6: Create User, Password, and Hostname]({{ site.url }}/arch/step-6-create-user-password-and-hostname#61-user-and-password){:target="_blank"}
<br>Diakses tanggal: 2019/03/18
