---
layout: 'post'
title: 'Memperbaiki Trash OSX'
date: 2013-07-16
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['OSX', 'Tips']
pin:
---

<p class="notif-post">Post ini sudah tidak up to date !</p>

<!-- BANNER OF THE POST -->
<img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="https://1.bp.blogspot.com/-Jrz4qxlN9JQ/UeVCPh-mUCI/AAAAAAAABOs/XXW6t3UxH-s/s1600/Default+Header+Template+Post+14.jpg" alt="banner">

# Latar Belakang
Beberapa hari yang lalu, teman saya yang bernama Ichsan mengalami permasalahan pada Trash OS X nya. Trash tidak berfungsi sebagaimana mestinya. Setiap mendelete file / folder selalu diminta untuk memasukkan password dan setelah itu file / folder tidak muncul pada folder Trash.
Apabila anda mempunyai permasalahan yang sama, saya akan mencoba memberikan tutorial bagaimana cara memperbaikinya.

# Analisis
Menurut ilmu sotoy ane, dilihat dari gejalanya tiap kali delete file, diminta masukin password dulu. Ini biasanya gejala pada permission. Hahaha entah temen gue abis ngapain sampai2 trash permissionnya aja "ngaco".

# Checking Status
1. Kita harus melihat dulu, apakah benar "ngaco" nya trash ini karena permasalahan permission. Caranya dengan melihat folder **.Trash** kita yang ada pada Home directory user kita.

    Kalau benar permissionnya yang ngaco, di attribut folder trash kita akan ada **tanda / icon lingkaran merah (dilarang)**. Kalo **normalnya tidak ada** attribut icon seperti lingkaran merah itu, hanya folder biru polos saja.

2. Karena .Trash folder ini di hidden dan terdapat pada Home directory kita (/Users/nama-user-anda/.Trash (. pada awal file name ini berfungsi untuk meng-hidden suatu file / folder).

3. Untuk melihat status dari .Trash ini gunakan aplikasi **Cloak** saja biar gak usah ribet2. Kalo belum punya, berikut ini adalah link downloadnya. Aplikasi ini sangat ringan. Dan kecil sizenya. Donwload [di sini](https://www.macupdate.com/app/mac/31354/cloak%22]https://www.macupdate.com/app/mac/31354/cloak){:target="_blank"}.

4. Buka Cloak, dan lihat di Home directory anda, jangan lupa untuk men-check list dulu "Show Invisible Item"  di status bar Cloak di bagian bawah, agar file-file yang hidden dapat terlihat.

5. Perhatikan folder .Trash anda, apabila normal akan tampak seperti screeshot yang saya berikan. Namun apabila tidak normal, akan terdapat icon attribut kecil bergambar "tanda lingkaran dilarang berwarna merah".

    ![gambar1]({{ site.lazyload.logo_blank }}){:data-echo="https://3.bp.blogspot.com/-2-w-ahuuL1I/UeUyQWGLQ6I/AAAAAAAABNo/QcCtS-YzpJg/w701-h491-no/Screen+Shot+2013-07-16+at+6.40.08+PM.png"}

6. Apabila benar terdapat icon attribut dilarang berwarna merah, berarti benar, .Trash anda bermasalah dengan permission aksesnya. Silahkan ikuti step selanjutnya. Namun apabila tidak, hehe saya belum bisa menganalisis lebih jauh mengapa ke-ngacoan itu bisa terjadi.

# Repair Permission Access
1. Langkah selanjutnya, buka Terminal anda, Applications > Utilities > Terminal

2. Lalu ketikkan (copy aja biar gak ribet) command di bawah ini.
```
$ sudo chmod 755 ~/.Trash
```

3. Tekan enter dan masukkan password user anda. Kalo user-nya gak ada password, bisa langsung enter saja (sepertinya. Soalnya user saya selalu berpassword, jadi belum pernah coba klo user nya gak di password).

    ![gambar2]({{ site.lazyload.logo_blank }}){:data-echo="https://4.bp.blogspot.com/-8pQyn-S6yLA/UeU0ihAQgNI/AAAAAAAABOA/oWavVRiUMsg/w664-h480-no/Screen+Shot+2013-07-16+at+6.54.09+PM.png"}

4. Lalu check lagi apakah permission pada .Trash folder sudah menjadi milik kita atau belum, dengan membuka kembali aplikasi Cloak, klo Cloak masih terbuka, close dulu lalu open lagi agar ter-refresh tampilan file folder yang sudah kita rubah tadi.

5. Kalau sudah tidak ada icon attribute dilarang berwarna merah, berarti langkah "chmod" berhasil.

6. Selanjutnya, kita akan meng-HAPUS folder .Trash ini. Buka kembali Terminal anda, dan ketikkan command di bawah, atau copy paste saja biar gak ribet.
```
$ sudo rm -rv ~/.Trash
```

7. Tekan <kbd>Return</kbd>, masukkan password apabila diminta.

8. Setelah itu cek kembali pada aplikasi Cloak (Cloak nya di reopen, supaya ke refresh tampilan folder2 yang sudah kita ubah) apakah folder .Trash sudah terdelete atau belum. Kalau berhasil maka folder .Trash sudah tidak terdapat di Home directory anda.

9. Langkah selanjutnya RESTART komputer anda. Karena kita akan melakukan verify & repair disk pada Disk Utility di Recovery Mode.

10. Saat restart dan bunyi jrenggggg !!! tekan tahan (tekan berulang2 klo gak yakin) tombol Option, setelah masuk pilihan booting hardisk, pilih recovery mode (Ini berlaku untuk Mesin Mac yang tidak dapat DVD installer dari pabrik. Klo yang dapet DVD installer harus masukin DVD 1 OS X installer dulu sebelum restart, lalu lakukan step di atas dan pilih OS X installernya.

11. Setelah berhasil masuk ke recovery mode, carilah Disk Utility.
><p class="title-quote">[ ! ] Perhatian</p>
>Mac dengan installer DVD, disk utilitynya ada di toolbar di atas. Tool > Disk Utility
>
>Mac tanpa DVD installer, disk utility ada pada windows yang terpampang di awal Recovery Mode

12. Selanjutnya lakukan "Verify & Repair Disk". Dimulai dari Hardisk anda terlebih dahulu. Setelah selesai, dilanjutnya pada partisi nya. Ilustrasi seperti screenshot yang saya berikan.

    ![gambar3]({{ site.lazyload.logo_blank }}){:data-echo="https://2.bp.blogspot.com/-xF3iMU0yYBI/UeU5Wwz-A-I/AAAAAAAABOY/FK8XnVKCLvQ/w733-h648-no/Screen+Shot+2013-07-16+at+7.09.04+PM.png"}

13. Setelah selesai melakukan Verify & Repair Disk pada Recovery Mode, silahkan restart.

14. Setelah kembali lagi ke desktop, sekarang silahkan coba untuk mendelete sebuah file / folder.

Apakah berhasil ? Karena cara ini berhasil saya lakukan pada OS X Mountain Lion teman saya. Akhirnya file2 yang di delete bisa kita lihat pada Trash icon di dock kembali. Hehehehe

><p class="title-quote">[ ! ] Perhatian</p>
>Apabila anda melakukan Verify & Repair Disk pada Normal Mode, tombol Repair tidak akan bisa di tekan. Jadi harus pada keadaan Recovery Mode.
