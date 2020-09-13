---
layout: 'post'
title: "Custom Template GitHub Page untuk GitHub Repositori dengan Jekyll"
date: 2020-09-12 17:37
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Jekyll']
pin:
hot:
contributors: []
---

# Latar Belakang

Kalau teman-teman berkunjung ke ["HelloDev Online Meetup: 💎 Ruby for Beginner"](https://bandithijo.github.io/hellodev_ruby_meetup/).

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/PrCmDq3W/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}

Kemudian, memperhatikan URL-nya.

<pre class="url">
https://bandithijo.github.io/hellodev_ruby_meetup
</pre>

Saya menggunakan domain yang saya dengan blog ini. Namun, halaman tersebut tidak berada pada repositori yang sama dengan repositori blog ini. Source dari halaman tersebut berada pada repositori yang berbeda.

Blog ini ada pada repo ini:

<pre class="url">
github.com/bandithijo/bandithijo.github.io
</pre>

Sedangkan, halaman pengumuman tersebut, berada pada repositori ini:

<pre class="url">
github.com/bandithijo/hellodev_ruby_meetup
</pre>

![gambar_7]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/dV81Qds3/gambar-07.png" onerror="imgError(this);"}{:class="myImg"}

<br>
Sebenarnya, GitHub Page sudah menyediakan beberapa template default apabila kita mengaktifkan memilih "Theme" pada pengaturan yang ada pada masing-masing repositori --lihat gambar di bawah.

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/d3LTGWBs/gambar-02.png" onerror="imgError(this);"}{:class="myImg"}

Namun, terkadang, theme yang disediakan kurang sesuai "feel"-nya dengan konten yang ingin kita tampilkan.

![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/BZXN0sWV/gambar-03.png" onerror="imgError(this);"}{:class="myImg"}

# Solusinya

Kita dapat membuat custom template sendiri untuk GitHub Page dari repositori project.

Kali ini saya akan memanfaatkan Jekyll dengan cara yang minimalis sebagai framework yang akan membantu saya untuk membuat GitHub Page dari repositori tersebut.

Kenapa saya bisa menyebut "minimalis"? Karena, kita hanya menggunakan komponen-komponen yang sedikit.

Seperti ini saja yang kita perlukan untuk membuat custom theme dengan Jekyll untuk GitHub Page dari project kita.

<pre>
📁 project_repositori/
├── 📁 assets/
│   ├── 📁 css/
│   │   └── 📄 style.css
│   └── 📁 javascript/
├── 📄 _config.yml
├── 📄 .gitignore
├── 📄 Gemfile
├── 📄 Gemfile.lock
├── 📁 _layouts/
│   └── 📄 default.html
└── 📄 README.md
</pre>

Saya akan menjelaskan langkah demi langkah di bawah ini.

Nah, GitHub Page dengan Jekyll yang akan kita buat ini akan membaca konten dari file **README.md**.

Sehingga, isi yang ada pada GitHub repo README dengan single page yang kita buat akan sama.

## 1. Inisialisasi Gemfile

Buat file bernama **Gemfile**.

<pre>
$ <b>touch Gemfile</b>
</pre>

File Gemfile ini yang akan kita gunakan untuk memberikan spesifikasi gem apa saja yang akan kita gunakan. Kita akan mendefinisikan gem Jekyll pada file Gemfile ini.

## 2. Definisikan Gem yang Diperlukan

Buka **Gemfile** dan isikan seperti di bawah ini saja.

{% highlight ruby linenos %}
source 'https://rubygems.org'
gem 'jekyll', '~> 4.1.1'
{% endhighlight %}

**Penting!** Pastikan teman-teman sudah menginstall gem **bundler** sebelumnya.

Kemudian, install dengan menjalankan perintah.

<pre>
$ <b>bundle install</b>
</pre>

## 3. Definisikan _config.yml

Selanjutnya adalah mendifinisikan isi dari file **_config.yml**.

Buat file bernama **_config.yml**.

<pre>
$ <b>touch _config.yml</b>
</pre>

Kemudian, isi dan modifikasi seperti di bawah ini, sesuai dengan kepentingan kalian.

{% highlight yaml linenos %}
# PENGGUNAAN:
# -----------------------------------------------------------------------------
# - Instalasi gem yang diperlukan
#   $ bundle
#
# - Jalankan Jekyll server
#   $ bundle exec jekyll s
# -----------------------------------------------------------------------------

title: 'HelloDev Online Meetup: 💎 Ruby for Beginner'

defaults:
  -
    scope:
      path: 'README.md'
    values:
      permalink: 'index.html'
{% endhighlight %}

Isikan `title:` sesuai kepentingan kalian.

Scope `defaults:` adalah bagian yang penting, yang akan membaca file **README.md** kita dan akan dikenali sebagai file **index.html**. Sehingga kita tidak perlu membuat file **index.html** di project repositori kita. Cukup file **README.md** saja yang juga akan dibaca oleh GitHub.

## 4. Buat Default Template

**_layouts** direktori ini akan berisi template **default.html**. Template yang akan kita gunakan sebagai tampilan dari single page yang akan kita buat.

<pre>
project_repositori/
...
...
├── ...
├── ...
├── 📁 _layouts/
│   └── 📄 default.html
└─ ...
</pre>

Buat **_layouts** direktori.

<pre>
$ <b>mkdir _layouts</b>
</pre>

Kemudian, masuk ke dalam direktori **layouts** dan buat file **default.html**.

<pre>
$ <b>cd _layouts</b>
$ <b>touch default.html</b>
</pre>

Kemudian isikan file **default.html** seperti di bawah ini. Sesuaikan dengan kebutuhan kalian.

{% highlight html linenos %}
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="theme-color" content="#ffffff">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
    <link rel="stylesheet" href="{{ "{{ '/assets/css/style.css?v=' | append: site.github.build_revision | relative_url " }}}}">
    <title>{{ "{{ site.title " }}}}</title>
  </head>
  <body>
    <div id="page-ctn" contenteditable="false">
      <main id="content" class="markdown-body" role="main">
        {{ "{{ content " }}}}
      </main>
    </div>
  </body>
</html>
{% endhighlight %}

Bagian `{{ "{{ content " }}}}`, adalah bagian yang akan dijadikan tempat untuk merender isi dari file **README.md** di repositori project kita.

Bagian `{{ "{{ site.title " }}}}`, nilainya akan diambil dari `title` yang kita isikan pada file **_config.yml**.

## 5. Buat Direktori Assets

Direktori **assets** akan kita gunakan untuk menyimpan stylesheet dan javascript.

<pre>
📁 project_repositori/
├── 📁 assets/
│   ├── 📁 css/
│   │   └── 📄 style.css
│   └── 📁 javascript/
...
...
└── ...
</pre>

Saya memberikan nama stylesheet dengan **style.css**.

Nah, sekarang mau seperti apa tampilan dari single page, tinggal kita atur di dalam stylesheet ini.

Kalau ingin mengikuti style seperti yang yang saya buat, pada gambar di atas, teman-teman dapat mendownload **style.css** tersebut [**di sini**](https://raw.githubusercontent.com/bandithijo/hellodev_ruby_meetup/master/assets/css/style.css){:target="_blank"}.

## 6. Inisialisasi Gitignore

Jangan lupa untuk membuat file **.gitignore**.

Ada beberapa file dan direktori yang tentunya tidak kita inginkan ikut ke dalam GitHub repositori kita.

Isinya seperti di bawah.

```
.jekyll-cache/
.jekyll-metadata
_site/
.~lock.main.fodp#
.~lock.*
```

Silahkan tambahkan sesuai kebutuhan kalian.

# Let's Run!

Semua kebutuhan di atas sudah dibuat dan dipenuhi, selanjutnya tinggal menjalankan Jekyll server.

<pre>
$ <b>bundle exec jekyll s -l</b>
</pre>

Saya menambahkan `-l` agar halaman akan "auto reload" tanpa perlu kita refresh kalau ada perubahan.

Hasilnya, dapat kita lihat pada browser di alamat.

<pre class="url">
http://localhost:4000
</pre>

Kalau konfigurasinya sudah benar, maka akan menampilkan isi dari halaman **README.md** yang ada di project direktori kita.

![gambar_4]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/NfGdzTsR/gambar-04.png" onerror="imgError(this);"}{:class="myImg"}


# Tips

## Membuat Collapsible

Kalau teman-teman ke bagian TOPICS, akan melihat bagian yang dapat "collapsible", seperti di bawah ini.

![gambar_5]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/RFRc7sny/gambar-05.png" onerror="imgError(this);"}{:class="myImg"}

Kemudian, saat di klik, maka akan terbuka, seperti di bawah ini.

![gambar_6]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/0jy7cYYQ/gambar-06.png" onerror="imgError(this);"}{:class="myImg"}

**Bagaimana cara membuatnya?**

Mudah sekali, tinggal ikuti format seperti ini.

{% highlight html linenos %}
<details markdown="1">
  <summary style="cursor:pointer;">...</summary>
</details>
{% endhighlight %}

Saya menggunakan `markdown="1"` agar Markdown sintaks yang ada di dalam HTML dapat dirender.

Contohnya seperti ini.

{% highlight html linenos %}
<details markdown="1">
  <summary style="cursor:pointer;">Topik yang akan dibicarakan meliputi: *<i>click to open</i></summary>

01. **Introduction to Ruby Lang**
    - [x] Sedikit tentang Ruby?
    - [x] Is Ruby dead programming language?
    - [x] Kenapa memilih Ruby?
    - [x] Apa yang baru dari Ruby 2.7?
    - [x] Tips memasang Ruby untuk developer?
    - [x] Bagaimana menulis kode & menjalankannya?<br>
          (dengan Text Editor & IRB: comment, variable, puts, p, & print)
...
...

</details>
{% endhighlight %}

**Penting!** Untuk memberikan 1 baris kosong tepat di atas `</details>`.




# Pesan Penulis

Sebagai catatan, Jekyll menggunakan bahasa template yang bernama **Liquid**.

Kira-kira seperti ini ciri-ciri tag dari Liquid.

{% highlight markdown linenos %}
{{ "{% if jekyll.environment == 'production' " }}%}
  <meta name="google-site-verification" content="{{ "{{ site.google_verify " }}}}">
{{ "{% endif " }}%}
{% endhighlight %}

Apabila teman-teman ingin memodifikasi lebih jauh, silahkan merujuk kepada dokumentasi bahasa Liquid atau Dokumentasi dari Jekyll untuk melihat bagaimana cara menggunakan Liquid tag.

Sepertinya, segini dulu yang saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)
