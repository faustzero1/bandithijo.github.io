---
layout: 'post'
title: "Menangani Redirect ke Website Lain pada Jekyll"
date: 2020-07-06 15:08
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
resume:
---

# Sekenario Masalah

Saya memiliki sebuah URL yang cukup panjang dan tidak begitu mudah untuk diingat maupun ditulis.

<pre class="url">
https://covid19-indo-harian.herokuapp.com
</pre>

Dampaknya adalah membuat orang kesulitan untuk berkunjung kembali.

Maka, saya pun mencari solusi untuk membuat URL tersebut menjadi lebih *catchy*.

Seperti ini,

<pre class="url">
https://bandithijo.github.io/covid19
</pre>

Cukup *catchy* kan? Gak juga yaa? Hehehe

Pokoknya lumayan mudah diingat lah yaa. Karena cukup mengakses URL dari blog ini dan menambahkan `/covid19`.

**Emang bisa begitu, bang?**

Bisa banget, mas Bro! Caranya juga sangat mudah.

# Pemecahan Masalah

Kita akan menggunakan **jekyll-redirect-from** gem.

Pasang pada `Gemfile`.

{% highlight_caption  Gemfile %}
{% highlight ruby linenos %}
# If you have any plugins, put them here!
group :jekyll_plugins do
  ...
  ...
  gem 'jekyll-redirect-from',                  '~> 0.16.0'
end
{% endhighlight %}

Kemudian install dulu,

<pre>
$ <b>bundle install</b>
</pre>

Selanjutnya, definisikan pada `_config.yml`

```
plugins:
  ...
  ...
  - jekyll-redirect-from
```

Setelah semua konfigurasi gem di atas selesai, kita akan membuat sebuah page yang akan digunakan sebagai halaman *redirect*.

Beri nama sesuai nama permalink.

Misal, dalam kasus saya, permalinknya mau seperti ini `/covid19/`, maka nama file pagenya adalah `covid19.html`.

Kemudian buka file page tersebut. Dan isikan hanya bagian **front matter** saja.

{% highlight_caption covid19.html %}
{% highlight yaml linenos %}
---
permalink: '/covid19/'
redirect_to: 'https://covid19-indo-harian.herokuapp.com/'
---
{% endhighlight %}

Selesai!

Dokumentasi lebih lengkap dapat teman-teman baca pada halaman README dari **jekyll-redirect-from** gem di GitHub. Alamat URL nya sudah saya berikan pada bagian referensi di bawah.

# Tambahan

## Membuat Redirecting Layout

Kalau hanya menggunakan cara di atas, maka halaman redirect kita akan putih polos saja.

Tentu ini akan "berbahaya" apabila respon yang diberikan oleh web server tujuan ternyata lambat. Pengunjung dapat kabur meninggalkan halaman redirecting yang putih polos.

Maka dari itu, kita dapat menyiasati dengan menghias halaman redirecting kita.

Buat layout dengan nama `_layouts/redirect.html`.

{% highlight_caption _layouts/redirect.html %}
{% highlight html linenos %}
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Redirecting to {{ page.redirect.to }}</title>
    <meta http-equiv="refresh" content="0; URL={{ page.redirect.to }}">
    <link rel="canonical" href="{{ page.redirect.to }}">
  </head>
  <body>
    <h3>Redirecting...</h3>
  </body>
</html>
{% endhighlight %}

Saya hanya mencontohkan sederhana, namun teman-teman dapat bermain-main dengan layout ini, seperti memberikan gif loading dan sebagainya.

Perhatikan bagian `page.redirect.to`, adalah variabel yang saya pergunakan pada front matter dari page yang saya pergunakan untuk membuat page redirect.

# Sekedar Simpan

Sebelum menggunakan **jekyll-redirect-from** gem, saya sempat mencoba menggunakan cara manual dengan mengisi file page untuk redirect seperti di bawah ini.

{% highlight_caption covid19.html %}
{% highlight html linenos %}
---
permalink: '/covid19/'
---

<!DOCTYPE html>
<meta charset="utf-8">
<title>Redirecting to https://example.com/</title>
<meta http-equiv="refresh" content="0; URL=https://example.com/">
<link rel="canonical" href="https://example.com/">
{% endhighlight %}

Namun, sayangnya tidak dapat digunakan pada GitHub Page.

Mungkin cara ini bisa menjadi alternatif untuk teman-teman yang ingin menggunakannya pada SSG selain Jekyll. Meskipun saya belum pernah mencobanya.

Sekian, mudah-mudahan dapat bermanfaat.

Terima kasih (^_^)



# Referensi

1. [docs.github.com/en/enterprise/2.13/user/articles/redirects-on-github-pages](https://docs.github.com/en/enterprise/2.13/user/articles/redirects-on-github-pages){:target="_blank"}
<br>Diakses tanggal: 2020/07/06

2. [github.com/jekyll/jekyll-redirect-from](https://github.com/jekyll/jekyll-redirect-from){:target="_blank"}
<br>Diakses tanggal: 2020/07/06

