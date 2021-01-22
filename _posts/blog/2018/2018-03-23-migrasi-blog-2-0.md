---
layout: 'post'
title: 'Migrasi Blog 2.0'
date: 2018-03-23
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Jekyll', 'Ulasan']
pin:
hot: true
contributors: []
resume:
---

# Latar Belakang

## CMS

### WordPress

Website: [wordpress.com](https://www.wordpress.com){:target="_blank"}

![gambar8]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/jf83v1r3x/gambar_08.png" onerror="imgError(this);"}{:class="myImg"}

"Migrasi Blog 2.0". Ya, sesuai judul dari post ini, **BanditHijo (R)-Chive**, bukan yang pertama kali saya migrasikan. Pertama kali saya menulis blog, saya memilih menggunakan WordPress sebagai _platform_ yang saya percayakan untuk menampung tulisan-tulisan saya. Saya perkirakan mungkin sejak 2010 saya mulai membuat _post_ pertama saya dengan WordPress.

Dengan menggunakan WordPress, saya belajar mengenal berbagai macam hal yang berkaitan dengan teknologi web, seperti pengguaan CMS (_Content Management System_), belajar mengenal _shared hosting_ dan _custom domain_.

Dengan WordPress, tidak begitu kesulitan bagi saya untuk memodifikasi WordPress _theme_ yang saya unduh dari _official website_ karena sebelum-sebelumnya saya memang sudah mengenal HTML dan CSS sejak masih SMA.

### Blogspot

Website: [blogger.com](https://www.blogger.com){:target="_blank"}

![gambar9]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/l712pxv19/gambar_09.png" onerror="imgError(this);"}{:class="myImg"}

Singkat cerita, tahun 2012, saya berkeinginan untuk mencoba _platform_ lain. Saya memutuskan untuk berpindah _platform_ dari WordPress dan beralih menggunakan Blogger atau yang lebih dikenal dengan Blogspot, sebuah CMS yang dipayungin oleh Google. Saya cukup lama menggunakan Blogspot, hingga 2018 Maret, tepat dimana saya pun bermigrasi untuk yang kedua kalinya.

## Static Site Generator

Sejak 2017, saya mendengar beberapa teman-teman di komunitas GNU/Linux, menulis artikel-artikel mereka menggunakan _Static Site Generator_. Saya pun tertarik dan mulai mencari tahu sendiri dengan modal percakapan yang pernah saya tangkap, yaitu "menggunakan Hexo". Saya pun mencoba mencari tahu _platform_ _static site generator_ yang bernama Hexo. Dan mulai saat inilah keinginan untuk bermigrasi ke _platform_ lain dimulai. Terlebih lagi dengan menggunakan _statis site generator_ kita dapat meletakkan _source_ dari blog kita di GitHub dan membuatnya menjadi GitHub _page_ yang berdomain `username.github.io`.

Ketertarikan saya dengan _Static Site Generator_ karena :
1. Kita dapat memproduksi tulisan dengan cepat sekaligus memiliki _layout_ yang sudah otomatis rapi, karena ditulis menggunakan Markdown _format_.
2. Saya berkesempatan untuk membuat template saya sendiri dari nol.
3. Dengan _static site generator_ saya dapat menggunakan GitHub sebagai _hosting_ dan berganti _sub domain_, yang menurut saya `username.github.io` lebih keren ketimbang `username.blogspot.com` atau `username.wordpress.com`. Hehe =)
4. Semua orang ~~tidak~~ dapat membuatnya dengan mudah.

### Hexo

Language: JavaScript

Templates: EJS, Pug, Haml, Swig, Nunjucks, Mustache, Handlebars, Twig, Marko

Website: [hexo.io](https://hexo.io/){:target="_blank"}

![gambar10]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/8seapmb8t/gambar_10.png" onerror="imgError(this);"}{:class="myImg"}

_Static Site Generator_ ini, adalah yang pertama kali memperkenalkan saya tentang konsep dari _Static Site Generator_. Saya belajar dari berbagai macam sumber, mulai dari YouTube, hingga artikel-artikel di internet. Proses saya belajar memakan waktu lama, hahaha, saya juga tidak begitu mengerti kenapa saya sangat malas dikala itu. Hingga 2018 Januari, saya memutuskan untuk serius mendalami Hexo.

Untuk proses produksi, seperti penerbitan tulisan saya tidak mengalami kendala, karena saya sudah terbiasa menulis menggunakan format Markdown. Konvensi lain seperti pengaturan _page_, _post_, _draft_, _assets_, dll, tidak membuat saya kebingungan. Namun, begitu sampai tahap "_Build your own theme from scratch_", inilah tahap dimana saya mulai kebingungan dengan _layout convention_ yang dimiliki oleh Hexo. Saya yakin, saya kebingungan karena ini pertama kalinya saya mengenal _layout formating_ menggunakan EJS (_Embedded JavaScript_). Karena kesulitan ini saya mencoba untuk beralih mencoba _static site generator_ lain, yaitu Hugo.

### Hugo

Language: Go

Templates: Go

Website: [gohugo.io](https://gohugo.io/){:target="_blank"}

![gambar11]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/gxwcnsex9/gambar_11.png" onerror="imgError(this);"}{:class="myImg"}

Selain Hexo, saya juga sudah mengenal nama lain, yaitu Hugo, namun karena saya belum pernah sama sekali belajar bahasa pemrograman Go, saya pikir akan sulit, sehingga saya memutuskan untuk tetap menggunakan Hexo.

2018 Maret 18, tepat siang hari, setelah semalaman saya mengalami frustasi dengan Hexo, saya pun langsung berpindah menggunakan Hugo, mencari tutorial-tutorial di YouTube yang dapat saya pelajari dengan cepat. Sekitar jam 10 malam, saya sudah berhasil membuat template saya sendiri. Rasa senang pun menggerogoti, sambil bersantai-santai mencari literatur-literatur yang saya bisa jadikan rujukan untuk menambah pengetahuan saya membuat Hugo _layout_ yang menggunakan Go _template_. Hingga, akhirnya menemukan sebuah website yang menampilkan statistik terhadap _static site generator_ yang populer, [staticgen.com](https://www.staticgen.com/){:target="_blank"} - _Top Open-Source Static Site Generators_. Website ini menggambarkan statistik bahwa Hugo menduduki peringkat kedua setelah Jekyll, _static site generator_ yang menggunakan bahasa pemrograman Ruby. Lantas saya pun penasaran, karena sebelumnya pun saya sudah pernah belajar Ruby. Saya berfikir, kenapa tidak menggunakan Ruby yang sudah pernah saya pelajari, mungkin akan lebih mudah ketimbang melanjutkan menggunakan Hugo yang menggunakan bahasa Go, yang belum pernah saya pelajarin dasarnya. Tepat tengah malam 2018 Maret 19, saya pun mencari tahu tentang Jekyll.

### Jekyll

Language: Ruby

Templates: Liquid

Website: [jekyllrb.com](https://jekyllrb.com/){:target="_blank"}

![gambar12]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/oqn0frsm5/gambar_12.png" onerror="imgError(this);"}{:class="myImg"}

Karena sudah mengenal _static site generator_ dari Hexo dan Hugo, saya tidak begitu kesulitan untuk beradaptasi menggunakan Jekyll dalam memproduksi konten. Terlebih lagi saat membuat Jekyll _layout_, Jekyll menggunakan [Liquid](https://shopify.github.io/liquid/){:target="_blank"}, dimana Liquid ini hampir mirip seperti [Jinja](http://jinja.pocoo.org/){:target="_blank"} _template_ dalam mengambil _variable_ atau _filters_ yang diperlukan, sehingga saya tidak membutuhkan waktu lama untuk mengerti dan beradaptasi.

Seperti ini contoh penggunaan Liquid.

**Tags**
{% raw %}
```
{% if user %}
  Hello {{ user.name }}!
{% endif %}
```
{% endraw %}

**Filters**
{% raw %}
```
{{ "adam!" | capitalize | prepend: "Hello " }}
```
{% endraw %}

**Variabels**
{% raw %}
```
{{ page.title }}
{{ page.content }}
{{ page.url }}
{{ page.date }}
```
{% endraw %}

Tepat tengah malam, _layout_ yang saya _develop_ sudah berhasil dan sesuai dengan yang saya inginkan. Saya juga dengan mudah memahami struktur dan konvensi-konvensi dalam Jekyll _layout_. Saya merasa Jekyll _layout_ memberikan saya kebebasan yang sangat banyak untuk saya mengatur sendiri mau seperti apa struktur direktori dan penamaan dari _layout_ yang saya bangun. Mungkin karena aspek ini, saya dapat memahami mengapa Jekyll ada diperingkat teratas pada statistik **staticgen.com**.

# Template yang Saya Gunakan

## Old Template
Dari cerita-cerita di atas, saya berkali-kali menyinggung kata "_layout_". Kenapa saya begitu bersikeras untuk membangun _layout_ saya sendiri ? Karena dengan membangun _layout_ sendiri, kita dapat dengan mudah memodifikasinya, karena kita memahami dengan baik bagaimana struktur dari _layout_ yang kita bangun.

Saya mengadopsi desain dari blog lama saya, yang menggunakan template buatan [StyleShout](https://www.styleshout.com/){:target="_blank"}. Yang menurut saya, desain _template_ ini mirip dengan _default template_ Blogspot di awal-awal kemunculannya, hal ini sangat membuat saya bernostalgia dan betah berlama-lama memandangi _template_ ini.

![gambar1]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/62rxouut9/gambar_01.png" onerror="imgError(this);"}{:class="myImg"}

Sederhana dan _old school_ sekali bukan?

Saya memiliki kesan yang sangat baik terhadap bentuk desain _template_ seperti ini. Namun sayangnya, _template_ ini belum menggunakan prinsip _responsive design_. Sehingga sangat kaku dan tidak fleksibel apabila diakses menggunakan _smartphone_ atau _tablet_. Hal tersebut dikarenakan _template_ ini sebagian besar mengguanakn _element_ gambar untuk membangun tampilannya, mulai dari _header_ hingga _footer_.

## New Template
Atas dasar kecintaan saya terhadap warna, desain, dan _layout_ dari template sebelumnya, saya memutuskan untuk mencoba meniru desain dari _template_ tersebut. Tentunya sudah menggunakan prinsip _responsive design_. Dari cerita di atas, saya berhasil membuat _template_ ini dengan menggunakan Go _template_, namun saya kurang mengerti untuk mengembangkannya lebih jauh, sehingga saya memutuskan untuk mencoba Jekyll yang menggunakan Liquid untuk membangun _layout_. Dan, jadilah _layout_ yang saya inginkan. Hampir menyerupai _template_ buatan StyleShout.

**HomePage**
![gambar3]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/ttrb6yfkt/gambar_03.png" onerror="imgError(this);"}{:class="myImg"}

**Blog (Post List)**
![gambar4]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/iu63vcwvh/gambar_04.png" onerror="imgError(this);"}{:class="myImg"}

**Page**
![gambar2]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/fnbkbqrv1/gambar_02.png" onerror="imgError(this);"}{:class="myImg"}

**Post**
![gambar5]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/y8mrg0on1/gambar_05.png" onerror="imgError(this);"}{:class="myImg"}

**Mobile Device Wide**
![gambar6]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/966fxw8wt/gambar_06.png" onerror="imgError(this);"}{:class="myImg"}

<br>
Hohoho, sejujurnya saya sangat menyukai _layout_ ini. Karena saya bisa melakukan apa saja, meletakkan apa saja, dan memindahkan apa saja.

Struktur dari _layout_ ini adalah :
```
├── _drafts
│
├── _includes
│   ├── _sidebar
│   │   ├── sidebar_1.html
│   │   ├── sidebar_2.html
│   │   ├── sidebar_3.html
│   │   └── sidebar_toc.html
│   │
│   ├── analytics.html
│   ├── disqus.html
│   ├── footer.html
│   ├── head.html
│   ├── header.html
│   ├── scripts.html
│   └── sidebar.html
│
├── _layouts
│   ├── baseof.html
│   ├── default.html
│   ├── home.html
│   ├── page.html
│   └── post.html
│
├── _posts
│   ├── blog
│   │   └── 2016-12-04-post.md
│   │
│   └── opini
│       └── 2016-12-04-opini.md
│
├── _site
├── .sass-cache
│
├── assets
│   ├── css
│   │   ├── github-markdown.css
│   │   └── style.css
│   │
│   ├── img
│   │   ├── favicon
│   │   │   └── favicon.png
│   │   └── logo
│   │       └── logo_bandithijo.png
│   │
│   └── js
│       ├── jquery.min.js
│       └── toc.js
│
├── pages
│   ├── about.md
│   ├── blog.md
│   └── conact.md
│
├── _config.yml
├── 404.html
├── Gemfile
├── Gemfile.lock
└── index.html
```

Seperti yang kalian dapat lihat dari struktur di atas, bahwa _template_ ini hanya menggunakan satu buah _element_ gambar untuk dijadikan sebagai logo, dan _element_ lain dikerjakan oleh CSS3. Dengan ini diharapkan dapat membuat _template_ menjadi lebih cepat saat dimuat oleh _browser_.

_Layout_ yang saya buat ini juga sudah saya obrak-abrik mengikuti kemauan saya, mungkin saja struktur dari _layout_ ini tidak mengikuti aturan atau _convention_ yang ada. Tapi saya senang karena dengan Jekyll, saya bisa mengeksplorasi Jekyll sebebas yang saya mau.

Mungkin soal _layout_ ini akan saya buatkan _post_ tersendiri. Agar lebih mendalam, karena judul dari _post_ ini hanya sekedar memberi tahu bahwa BanditHijo (R)-Chive sudah menggunakan _static site generator_ juga untuk membangun blog.

# Akhir Kata
Rumah baru sudah nyaman, sekarang tinggal mengukir kenangan-kenangan di dalamnya.

Saya benar-benar merasakan kemudahan dalam memproduksi tulisan-tulisan dengan menggunakn Markdown _format_ yang nantinya akan di _generated_ oleh Jekyll untuk menjadi sebuat _static site_. Kemudian saya _push_ ke GitHub agar bisa _Online_.

Terima kasih, untuk teman-teman yang sudah mampir dan membaca sepenggal kisah mengenai proses migrasi blog saya =)

# Ucapan Terima Kasih
Berikut ini adalah nama-nama yang telah menginspirasi saya untuk bermigrasi menggunakan _static site generator_ :

1. [sucipto.net](https://sucipto.net/){:target="_blank"}
2. [epsi-rns.github.io](http://epsi-rns.github.io){:target="_blank"}
3. [raniaamina.github.io](https://raniaamina.github.io/){:target="_blank"}
