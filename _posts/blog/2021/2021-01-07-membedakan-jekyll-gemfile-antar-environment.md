---
layout: 'post'
title: "Membedakan Jekyll Gemfile antar Level Environment (Production atau Development)"
date: 2021-01-07 19:54
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

# Latar Belakang Masalah

Saat memindahkan proses build blog ini dari Netlify ke GitHub Pages, saya menyadari bahwa ada beberapa plugin yang membuat proses build blog ini sangat molor. Sekitar 40-60 detik.

Dengan waktu build yang selama itu, mungkin tidak akan terasa mengganggu apabila terjadi pada level production.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/zBFKZGjM/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 1 - Proses build di production dengan Travis-CI</p>

Namun, akan sangat mengganggu bagi saya sebagai developer apabila terjadi pada level development.

Waktu yang diperlukan untuk mengenerate blog menjadi static file menjadi sangat molor.

Bayangkan kalau kita harus menunggu 40-60 detik hanya karena menambah 1 huruf saja.

<pre>
Regenerating: 1 file(s) changed at 2021-01-07 21:15:48
              _posts/blog/2021/2021-01-07-membedakan-jekyll-gemfile-antar-environment.md
 Jekyll Feed: Generating feed for posts
              ...done in 37.638836748 seconds.
</pre>

Proses build yang molor ini juga dikarenakan prosesor saya sudah cukup tua, namun menolak untuk menyerah.

# Apa Penyebabnya?

Kalau saya menjalankan build dengan option `--profile`.

{% shell_user %}
bundle exec jekyll build --profile
{% endshell_user %}

<pre>
Build Process Summary:

| PHASE      |    TIME |
+------------+---------+
| RESET      |  0.0003 |
| READ       |  0.6375 |
| GENERATE   |  0.0299 |
| RENDER     | 37.7396 |
| CLEANUP    |  0.0516 |
| WRITE      |  0.4089 |
+------------+---------+
| TOTAL TIME | 38.8678 |


Site Render Stats:

| Filename                                                                           | Count |     Bytes |   Time |
+------------------------------------------------------------------------------------+-------+-----------+--------+
| <span class='is-warning'>sitemap.xml</span>                                                                        |     1 |    49.78K | <span class='is-warning'>18.826</span> |
| _layouts/post.html                                                                 |   353 |  7231.44K |  6.140 |
| _includes/sidebar_tail.html                                                        |   364 |  1608.70K |  2.849 |
| _includes/sidebar_head.html                                                        |   364 |   230.18K |  2.405 |
------------------------------------------------- dipotong --------------------------------------------------------
| _posts/blog/2020/2020-12-01-membuat-output-dari-form-dengan-ajax.md                |     1 |    21.98K |  0.045 |
| _posts/blog/2019/2019-12-08-search-dengan-ransack-dan-easyautocomplete-rails.md    |     1 |    22.73K |  0.045 |
| _posts/blog/2020/2020-10-29-defx-alternatif-file-explorer-selain-nerdtree.md       |     1 |    28.47K |  0.044 |
| _posts/blog/2020/2020-06-18-membuat-web-scraper-dengan-ruby-with-activerecord.md   |     1 |    29.93K |  0.043 |
+------------------------------------------------------------------------------------+-------+-----------+--------+
| TOTAL (for 50 files)                                                               |  4743 | 27739.29K | 42.704 |

                    done in 38.927 seconds.
 Auto-regeneration: disabled. Use --watch to enable.
</pre>

Nah! Saya dapat satu tersangkanya, yaitu plugin **jekyll-sitemap**.

Setelah saya mencoba mendisable plugin jekyll-sitemap, saya juga mencoba untuk mendisable beberapa plugin yang lain.

Saya mendapatkan plugin **jekyll-last-modified-at** juga memberikan sebab molornya waktu build blog ini.

{% highlight_caption Gemfile %}
<pre class="caption">
group :jekyll_plugins do
  gem 'rouge',                                 '~> 3.13.0'
  gem 'jekyll-feed',                           '~> 0.13.0'
  gem 'jekyll-seo-tag',                        '~> 2.6.1'
  gem 'jekyll-redirect-from',                  '~> 0.16.0'
  <mark>gem 'jekyll-sitemap',                        '~> 1.4.0'</mark>
  <mark>gem 'jekyll-last-modified-at',               '~> 1.3'</mark>
end
</pre>

Setelah mengetahui bahwa kedua plugin tersebut yang paling memberikan dampak terhadap sebab molornya proses generate blog ini, saya harus melakukan sesuatu terhadap kedua game tersebut.

Kalau saya tidak gunakan, rasanya tidak bisa. 😄

Saya perlukan plugin sitemap untuk mendhandle ketentuan SEO dan saya perlukan plugin last-modified-at untuk memberikan keterangan bahwa saya telah melakukan pembaharuan terhadap post tertentu.

# Pemecahan Masalah

Kalau di Ruby on Rails, pada Gemfile, kita dapat menempatkan gem pada group tertentu.

{% highlight_caption Gemfile %}
{% highlight ruby linenos %}
gem 'rails',                    '~> 5.2.3'
gem 'pg',                       '>= 0.18', '< 2.0'
gem 'puma',                     '~> 3.11'

group :development, :test do
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.4'
end

group :development do
  gem 'spring'
  gem 'spring-watcher-listen',    '~> 2.0.0'
end

group :test do
  gem 'capybara',                 '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end
{% endhighlight %}

Dapat dilihat, kalau terdapat 2 group, `:development` dan `:test`.

Sedangkan gem yang berada di luar, akan dijalankan disemua environment termasuk di `:production`.

Kalau di Ruby on Rails, apabila kita ingin membuat gem tertentu hanya dijalankan pada level production, kita hanya perlu membuat group `:production` dan memasukkan gem di dalamnya. Dengan begitu, gem tersebut hanya akan dijalankan apabila berada pada level production.

Kalau saya perhatikan file **Gemfile** yang dimiliki Jekyll hanya memiliki group `:jekyll_plugins`.

Saat tulisan ini dibuat, saya sudah mencari-cari solusi bagaimana agar Jekyll Gemfile dapat memiliki group pada masing-masing level environment. Hasilnya masih nihil.

Namun saya mendapatkan cara alternatif untuk mengakali harl tersebut.

Setidaknya ada 3 cara yang dapat kita lakukan.

1. **Local Plugin**<br> Pendefinisian local plugin path pada **plugin_dir** di file **_config.yml** & **_config-dev.yml**.<br>Namun, menggunakan option **plugin_dir** sepertinya sudah deprecated sejak Jekyll 3.5.0.<br> Karena sudah diganti dengan **plugins**. Lihat [issue #6195](https://github.com/jekyll/jekyll/issues/6195#issuecomment-312499884){:target="_blank"}.

2. **Gemfile Plugins**<br> Pendefisian plugin yang berbeda antar dua file Gemfile: **Gemfile** (production) & **Gemfile-dev** (development).

3. **Limit Number of Post Rendering**<br> Apabila kalian memiliki jumlah post yang banyak, kita dapat membatasi jumlah post yang dapat di-generate.<br> Dengan menggunakan option `--limit_posts`.

<br>
Dari ketiga cara di atas, saya menggunakan cara nomor 2 & 3.

## Gemfile Plugins

Karena saya tidak menemukan cara untuk membuat scope dalam Gemfile guna memberikan batasan plugin pada masing-masing level environment, maka kita akali dengan memisahkan Gemfile (membuat dua Gemfile) antar level environment.

**Gemfile**

Gemfile ini merupakan Gemfile default, yang akan dijalankan di level production.

{% highlight_caption Gemfile %}
{% highlight language linenos %}
group :jekyll_plugins do
  gem 'rouge',                                 '~> 3.13.0'
  gem 'jekyll-feed',                           '~> 0.13.0'
  gem 'jekyll-seo-tag',                        '~> 2.6.1'
  gem 'jekyll-redirect-from',                  '~> 0.16.0'
  gem 'jekyll-sitemap',                        '~> 1.4.0'
  gem 'jekyll-last-modified-at',               '~> 1.3'
end
{% endhighlight %}

Dua plugin terbawah, adalah plugin yang membuat proses build menjadi molor. Kedua plugin ini tentu saja tetap berada pada Gemfile yang akan dijalankan di level production.

**Gemfile-dev**

Gemfile ini akan kita panggil pada level development.

{% highlight_caption Gemfile %}
{% highlight language linenos %}
group :jekyll_plugins do
  gem 'rouge',                                 '~> 3.13.0'
  gem 'jekyll-feed',                           '~> 0.13.0'
  gem 'jekyll-seo-tag',                        '~> 2.6.1'
  gem 'jekyll-redirect-from',                  '~> 0.16.0'
end
{% endhighlight %}

Saya menghilangkan dua plugin terbawah yang ada pada file Gemfile.

Cara untuk memanggil Gemfile-dev pada level development, kita dapat menggunakan variabel `BUNDLE_GEMFILE`, seperti ini.

{% shell_user %}
BUNDLE_GEMFILE=Gemfile-dev bundle exec jekyll server
{% endshell_user %}

Kepanjangan yaa.

Untuk mempersingkat command yang panjang, dapat menggunakan alias shell.

Kalau saya, karena blog ini menggunakan **rake**, maka saya tinggal meracik task pada **Rakefile**.

{% highlight_caption Rakefile %}
{% highlight ruby linenos %}
# ...
# ...

# For Development Evironment
namespace :jekyll do
  desc 'Menjalankan Jekyll pada Environment Development'
  task :server do
    sh('BUNDLE_GEMFILE=Gemfile-dev bundle exec jekyll s -l -H 0.0.0.0')
  end

  namespace :server do
    desc 'Menjalankan Jekyll pada Environment Development dengan --incremental'
    task :inc do
      sh('BUNDLE_GEMFILE=Gemfile-dev bundle exec jekyll s -l -H 0.0.0.0 --incremental --watch')
    end
  end
end
{% endhighlight %}

{% shell_user %}
rake -T
{% endshell_user %}

<pre>
rake jekyll:server        # Menjalankan Jekyll pada Environment Development
rake jekyll:server:inc    # Menjalankan Jekyll pada Environment Development dengan --incremental --watch
</pre>

Nah, dengan begini command yang saya gunakan menjadi lebih singkat.

**Ketika baru pertama kali membuat post baru, saya menjalankan**:

{% shell_user %}
rake jekyll:server
{% endshell_user %}

**Ketika, proses build post baru telah selesai, saya menjalankan**:

{% shell_user %}
rake jekyll:server:inc
{% endshell_user %}






# Hasilnya

<pre>
Regenerating: 1 file(s) changed at 2021-01-07 20:19:30
              _posts/blog/2021/2021-01-07-membedakan-jekyll-gemfile-antar-environment.md
 Jekyll Feed: Generating feed for posts
              ...done in 9.767419585 seconds.
</pre>

Akan lebih cepat lagi kalau saya menggunakan `--incremental` dan `--watch`.

<pre>
Regenerating: 1 file(s) changed at 2021-01-07 20:25:39
              _posts/blog/2021/2021-01-07-membedakan-jekyll-gemfile-antar-environment.md
 Jekyll Feed: Generating feed for posts
              ...done in 1.772672945 seconds.
</pre>

{% box_info %}
<p markdown=1>**Incremental regeneration** adalah option yang dapat kita gunakan untuk mempercepat proses generate dengan hanya mengenerate file-file yang berubah sejak build versi sebelumnya.</p>
<p markdown=1>Teman-teman dapat membaca lebih jauh tentang **incremental regeneration** pada dokumentasi yang ada di Jekyllrb.com.</p>
<p markdown=1>[**Default Configuration - Incremental Regeneration**](https://jekyllrb.com/docs/configuration/incremental-regeneration/){:target="_blank"}.</p>
<p markdown=1>\*Fitur ini masih merupakan experimental feature.</p>
{% endbox_info %}




# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)




# Referensi

1. [stackoverflow.com/a/59762252/4862516](https://stackoverflow.com/a/59762252/4862516){:target="_blank"}
<br>Diakses tanggal: 2021/01/07
