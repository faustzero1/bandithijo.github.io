---
layout: 'post'
title: 'Memasang WhatsApp Desktop pada GNU/Linux'
date: 2018-04-25 21:11
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tools', 'Tips']
pin:
hot:
contributors: []
description:
---

<!-- BANNER OF THE POST -->
<img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="https://s20.postimg.cc/tbrdrb9t9/banner_post_07.png" onerror="imgError(this);" alt="banner">

# Latar Belakang

Memegang *smartphone* adalah hal yang jarang sekali saya lakukan. Tangan saya setiap saat selalu berada di atas keyboard. Dampaknya, setiap pesan yang masuk melalui aplikasi *messenger* tidak segera dapat saya baca dan balas. Waktu-waktu dimana saya baru akan memegang *smartphone* adalah ketika urusan saya di atas keyboard telah selesai. Hahaha.

**Smartphone-nya di mode *silent*, bang ?**

Nah, justru ndak saya silent loh. Saya suarakan dan getar juga. Yaa mohon maklum saja yaa, kalo sudah asik, suka gak bisa teralihkan dengan yang lain.

# Permasalahan

Mayoritas teman-teman yang mempunyai urusan dengan saya belum menggunakan platform *messenger* yang saya gunakan. Aplikasi yang ~~seperti~~ berjalan secara *native* pada distribusi sistem operasi GNU/Linux, yaitu **Telegram**. Kebanyakan masih menggunakan **WhatsApp** dan sebagian kecil menggunakan **Line**.

Sebenarnya, WhatsApp menyediakan layanan [WhatsApp-Web](https://web.whatsapp.com/){:target="_blank"} untuk pengguna Linux -- sedangkan untuk Windows dan macOS, mereka memberikan aplikasi *native desktop*.

{% image https://s20.postimg.cc/cd9zmy9lp/gambar_02.png | 1 %}

Namun, saya merasa kurang praktis karena sebagian besar saya beraktifitas menggunakan browser yang saya tidak ingin diganggu oleh hal-hal lain selain pekerjaan yang sedang saya kerjakan.


# Solusi

Pada tahun 2016 - 2017 saya masih sempat menggunakan aplikasi *unofficial* yang bernama **Whatsie**. Namun, proyek ini sudah lama ditutup dan tidak diteruskan kembali. Aplikasi ini menyerupai aplikasi *native desktop* WhatsApp yang berajalan pada sistem operasi Windows dan macOS.

Beberapa waktu lalu saya menemukan sebuah aplikasi yang mirip dengan Whatsie. Aplikasi yang berbasis Whatsapp Web dan dibangun menggunakan [Electron](http://electron.atom.io/){:target="_blank"} juga. Aplikasi ini bernama **Whatsapp-Desktop** yang dikelola oleh **Enrico204** yang semula dikelola oleh **bcalik**.

{% image https://s20.postimg.cc/ujj3orbst/gambar_01.png | 2 | User Interface dari Whatsapp-Desktop %}

Whatsapp-Desktop ini juga mempunyai *tray icon* dan memiliki notifikasi yang terintegrasi dengan sistem.

# Instalasi

Proses instalasi menggunakan *package manager* pada distribusi sistem operasi GNU/Linux yang kalian miliki dapat merujuk pada *official page* dari halaman GitHub Whatssapp-Desktop, [di sini](https://github.com/Enrico204/Whatsapp-Desktop){:target="_blank"}.

Namun pada dokumentasi ini saya hanya akan menuliskan proses instalasi menggunakan *build from source*.

<br>
Langkah awal, kita membutuhkan *package manager* bernama [**Yarn**](https://yarnpkg.com){:target="_blank"}. Yarn merupakan *package manager* untuk Java Script.

{% shell_cmd $ %}
sudo pacman -S yarn
{% endshell_cmd %}

Lakukan pengetesan apakah yarn sudah berhasil dipasang atau belum.

{% shell_cmd $ %}
yarn --version
{% endshell_cmd %}

```
1.6.0
```

<br>
Pasang juga paket **Git** karena kita akan memerlukannya untuk melakukan *repository cloning*.

{% shell_cmd $ %}
sudo pacman -S git
{% endshell_cmd %}

Lakukan pengetesan apakah git sudah berhasil di pasang atau belum.

{% shell_cmd $ %}
git --version
{% endshell_cmd %}

```
git version 2.17.0
```

<br>

{% box_perhatian %}
<p markdown=1>Untuk distribusi sistem operasi yang lain dapat melakukan instalasi `yarn` dan `git` menggunakan *package manager* masing-masing.</p>
{% endbox_perhatian %}

<br>
Setelah `yarn` dan `git` berhasil terpasang, langkah selanjutnya melakukan *cloning* terhadap repositori Whatsapp-Desktop.

{% shell_cmd $ %}
mkdir -p ~/app/whatsapp
cd ~/app/whatsapp
git clone https://github.com/Enrico204/Whatsapp-Desktop.git
cd Whatsapp-Desktop
{% endshell_cmd %}

Kita dapat melihat isi dari direktori hasil *repository cloning*.

{% shell_cmd $ %}
ls -al
{% endshell_cmd %}

```
app
assets
debian
.git
.gitignore
.prepare-release.sh
ISSUE_TEMPLATE.md
LICENSE
clean.js
flatpak.config.json
it.enrico204.whatsapp-desktop.appdata.xml
package.json
packager.json
readme.md
whatsapp-desktop.spec
whatsappdesktop.desktop
yarn.lock
```

<br>
Sekarang, tinggal melakukan kompilasi saja menggunakan **Yarn**.

Masih pada direktori yang sama -- direktori hasil *repository cloning* Whatsapp-Desktop.

{% shell_cmd $ %}
yarn install
{% endshell_cmd %}

Tunggu proses ini hinggal selesai.

Selanjutnya,

{% shell_cmd $ %}
yarn run build:linux
{% endshell_cmd %}

Pada tahap ini, apabila telah selesai maka, akan terdapat sebuah direktori baru bernama `dist`.

Untuk menjalankan Whatsapp-Desktop, kita cukup menjalankan file bernama `WhatsApp` yang terdapat di dalam direktori `dist/WhatsApp-linux-x64`.

```
dist
└── WhatsApp-linux-x64
    └── WhatsApp
```

Sekarang, tinggal kita buatkan *application launcher* nya saja.

{% shell_cmd $ %}
touch ~/.local/share/applications/whatsapp-desktop.desktop
{% endshell_cmd %}

Buka file `whatsapp-desktop.desktop` yang baru saja kita buat menggunakan *text editor* favorit kalian dan copy paste kode di bawah.

{% highlight_caption $HOME/.local/share/applications/whatsapp-desktop.desktop %}
{% pre_caption %}
#!/usr/bin/env xdg-open
[Desktop Entry]
Name=Whatsapp-Desktop
Comment=A simple & beautiful desktop client for WhatsApp Web.
Exec=<mark>/home/bandithijo/app/whatsapp/Whatsapp-Desktop/dist/WhatsApp-linux-x64/WhatsApp</mark>
Icon=whatsapp
Terminal=false
Type=Application
StartupNotify=true
StartupWMClass=whatsapp
Keywords=WhatsApp;Whats;
Categories=Network;InstantMessaging;
X-GNOME-UsesNotifications=true
{% endpre_caption %}

Perhatikan pada bagian `Exec=`, berisi lokasi dimana file `WhatsApp` tersimpan. Pada kasus saya, saya menyimpan direktori *cloning* dari Whatsapp-Desktop berada pada lokasi `/home/bandithijo/app/whatsapp`, kamu harus menyesuaikan lokasi ini dengan lokasi dimana kamu menyimpan hasil *clone* Whatsapp-Desktop dari GitHub.

# Referensi

1. [github.com/Enrico204/Whatsapp-Desktop/blob/master/readme.md](https://github.com/Enrico204/Whatsapp-Desktop/blob/master/readme.md){:target="_blank"}
<br>Diakses tanggal: 2018/04/25

2. [yarnpkg.com/en/docs](https://yarnpkg.com/en/docs){:target="_blank"}
<br>Diakses tanggal: 2018/04/25
