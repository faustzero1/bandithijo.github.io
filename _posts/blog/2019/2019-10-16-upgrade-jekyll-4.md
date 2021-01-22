---
layout: 'post'
title: "Mudah Mengupgrade Jekyll 4"
date: 2019-10-16 07:12
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

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Jekyll 4.0.0 akhirnya dirilis pada tanggal 20 Agustus 2019.

Mengenai fitur-fitur serta perbaikan apa saja yang dibawa oleh Jekyll 4.0.0 ini, bisa teman-teman baca sendiri yaa pada halaman Jekyll News [di sini](https://jekyllrb.com/news/2019/08/20/jekyll-4-0-0-released/){:target="_blank"}.

Langsung saja, saya akan menceritakan proses upgrade BanditHijo.com dari Jekyll 3.8.6 ke 4.0.0.

# Proses Upgrade

Saya akan menceritakan runut berdasarkan kronologi yang saya lakukan.

## Upgrade Jekyll

Untuk dapat menggunakan Jekyll 4.0.0, minimal saya harus memiliki Ruby versi 2.4.0.

Cara mengeceknya.

{% shell_user %}
ruby -v
{% endshell_user %}

```
ruby 2.6.2p47 (2019-03-13 revision 67232) [x86_64-linux]
```

{% box_info %}
<p>Seharusnya saat tulisan ini dibuat, versi Ruby yang paling terbaru adalah,
<pre>
ruby 2.6.5p114 (2019-10-01 revision 67812) [x86_64-linux]
</pre>
Namun, karena satu dan lain hal, salah satunya untuk kebutuhan deploy di Netlify, saya hanya dapat menggunakan Ruby versi,
<pre>
ruby 2.6.2p47 (2019-03-13 revision 67232) [x86_64-linux]
</pre></p>
{% endbox_info %}

Selanjutnya tinggal upgrade Jekyll gem.

{% shell_user %}
gem update jekyll
{% endshell_user %}

## Edit Gemfile

Langkah selanjutnya, saya perlu mengedit Gemfile yang ada di dalam root project.

{% shell_user %}
vim Gemfile
{% endshell_user %}

Hal yang paling utama adalah, mengganti versi dari `jekyll` gem, menjadi versi 4.0.0.

{% highlight_caption Gemfile %}
{% highlight ruby linenos %}
# ...

gem 'jekyll', '~> 4.0.0'

# ...
{% endhighlight %}

Selanjutnya, upgrade plugin gem.

{% highlight_caption Gemfile %}
{% highlight ruby linenos %}
# ...
# ...

group :jekyll_plugins do
  gem 'rouge',                          '~> 3.3'
  gem 'jekyll-toc',                     '~> 0.9.1'
  gem 'jekyll-feed',                    '~> 0.12.1'
  gem 'jekyll-sitemap',                 '~> 1.3.1'
  gem 'jekyll-seo-tag',                 '~> 2.6.1'
  gem 'jekyll-pwa-plugin',              '~> 2.2'
  gem 'jekyll-last-modified-at',        '~> 1.1.0'
end
{% endhighlight %}

Perlu diperhatikan, karena saya menggunakan cukup banyak plugin pendukung, maka untuk dapat mengupgrade versi jekyll pada BanditHijo.com ini sangat bergantung pada dependensi dari plugin-plugin gem tersebut.

Maksud saya, apabila ada salah satu atau beberapa dari plugin tersebut yang membatasi pengunannya hanya pada jekyll versi 3.0, maka project BanditHijo.com belum dapat diupgrade ke jekyll versi 4.0. Karena belum semua plugin menambahkan jekyll 4.0 pada gemspec mereka.

Karena masalah dependensi tersebut, menjadi salah satu yang mendasari mengapa saya molor dan menunggu untuk mengupgrade versi Jekyll pada BanditHijo.com.

Setelah itu, jalankan perintah Bundle Update.

{% shell_user %}
bundle update
{% endshell_user %}

Dengan begini, proses update versi Jekyll yang ada di project BanditHijo.com telah selesai.

# Tambahan

Sebelumnya, saya menggunakan plugin [**jekyll-netlify**](https://github.com/jayvdb/jekyll-netlify/){:target="_blank"}, yang saya manfaatkan untuk mengeset environment `site.environment=production` pada Netlify.

Karena ada beberapa bagian pada template yang perlu saya pisahkan antara *development* dan *production*, misalnya Google Analytics dan Disqus Comments.

Namun sepertinya gem ini belum mengupgrade gemspec mereka, jadi dengan senang hati saya *takedown* dari daftar Gemfile yang digunakan BanditHijo.com.

Kemudian, saya mendapati bahwa untuk Jekyll, kita sudah dapat mengeset **Environment variables** pada Netlify. Seingat saya, diawal-awal saya menggunakan Netlify, memang belum bisa, maka dari itu saya menggunakan bantuan gem jekyll-netlify.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/dVH7Tggr/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 1 - Netlify Deploy Environment Variables</p>

Yay! Dengan begini, mendeploy Jekyll project pada Netlify sudah sangat enak sekali.

Sekian cerita proses upgrade Jekyll 4 ini.

Mudah-mudahan dapat bermanfaat buat teman-teman.

Terima kasih (^_^)v



# Referensi

1. [Upgrading from 3.x to 4.x](https://jekyllrb.com/docs/upgrading/3-to-4/){:target="_blank"}
<br>Diakses tanggal: 2019/10/16

2. [Jekyll 4.0.0 Released](https://jekyllrb.com/news/2019/08/20/jekyll-4-0-0-released/){:target="_blank"}
<br>Diakses tanggal: 2019/10/16
