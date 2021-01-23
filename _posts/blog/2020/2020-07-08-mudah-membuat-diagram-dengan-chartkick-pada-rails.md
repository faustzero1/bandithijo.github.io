---
layout: 'post'
title: "Mudah Membuat JavaScript Diagram dengan ChartKick pada Rails"
date: 2020-07-08 11:32
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Rails']
pin:
hot:
contributors: []
resume:
---

# Sekenario Masalah

Saya membuat sebuah *side project* untuk melakukan *scraping* data dan dicatat perhari.

Ketika data sudah mulai berkembang, maka diperlukan grafik untuk mempermudah dalam melakukan penilaian terhadap data yang telah dikumpulkan.

# Pemecahan Masalah

Untuk membuat atau menambahkan grafik, JavaScript library yang terkenal adalah **Chart.JS**.

Nah, pada Ruby on Rails, sudah ada yang membuatkan librarynya bernama **ChartKick**.

Dengan menggunakan ChartKick, kita hanya perlu memanggil dengan satu baris sintaks saja. Enak banget kan!

# Instalasi ChartKick

Pasang gem di `Gemfile`.

{% highlight_caption Gemfile %}
{% highlight ruby linenos %}
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

...
...
gem 'chartkick',                          '~> 3.3', '>= 3.3.1'
{% endhighlight %}

Kemudian install.

{% shell_user %}
bundle install
{% endshell_user %}

# Konfigurasi

**Rails 6 / Webpacker**

{% shell_user %}
yarn add chartkick chart.js
{% endshell_user %}

Kemudian tambahkan pada `app/javascript/packs/application.js`,

{% highlight_caption app/javascript/packs/application.js %}
{% highlight javascript linenos %}
require("chartkick")
require("chart.js")
{% endhighlight %}

**Rails 5 / Sprockets**

Cukup menambahkan pada `app/assets/javascripts/application.js`,

{% highlight_caption app/assets/javascripts/application.js %}
{% highlight javascript linenos %}
//= require chartkick
//= require Chart.bundle
{% endhighlight %}

Konfigurasi di atas akan mengeset ChartKick untuk menggunakan **Chart.JS**.

Apabila teman-teman ingin menggunakan JavaScript chart library yang lain, seperti **Google Charts** dan **Highcharts**, dapat mengunjungi dokumentasi dari ChartKick [di sini](https://chartkick.com/#installation){:target="_blank"}.

Sekarang tinggal implementasi.

# Contoh-contoh Chart

Kita dapat langsung membuat chart dengan cara seperti ini.

<br>
**Line Chart (Grafik Garis)**

{% highlight_caption %}
{% highlight erb linenos %}
<%= line_chart a: 2, b: 5, c: 3, d: 15, e: 6, f: 12, g: 3 %>
{% endhighlight %}

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/sxLgvFk5/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}

<br>
**Area Chart**

{% highlight_caption %}
{% highlight erb linenos %}
<%= area_chart a: 2, b: 5, c: 3, d: 15, e: 6, f: 12, g: 3 %>
{% endhighlight %}

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/Y0CTThyx/gambar-02.png" onerror="imgError(this);"}{:class="myImg"}

<br>
**Column Chart (Grafik Batang Berdiri)**

{% highlight_caption %}
{% highlight erb linenos %}
<%= column_chart a: 2, b: 5, c: 3, d: 15, e: 6, f: 12, g: 3 %>
{% endhighlight %}

![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/QCYvDh2Z/gambar-03.png" onerror="imgError(this);"}{:class="myImg"}

<br>
**Bar Chart (Grafik Batang Tidur)**

{% highlight_caption %}
{% highlight erb linenos %}
<%= bar_chart a: 2, b: 5, c: 3, d: 15, e: 6, f: 12, g: 3 %>
{% endhighlight %}

![gambar_4]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/ZK01cvNb/gambar-04.png" onerror="imgError(this);"}{:class="myImg"}

<br>
**Pie Chart (Grafik Lingkaran)**

{% highlight_caption %}
{% highlight erb linenos %}
<%= pie_chart a: 2, b: 5, c: 3, d: 15, e: 6, f: 12, g: 3 %>
{% endhighlight %}

![gambar_5]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/G3XWGxHg/gambar-05.png" onerror="imgError(this);"}{:class="myImg"}

<br>
Dan masih banyak lagi chart yang tidak dapat saya tampilkan di blog ini, silahkan teman-teman mengunjungi halaman depan dari **ChartKick**.


# Options

Kita juga dapat menambahkan option-option lain agar grafik yang kita tampilkan lebih informatif.

Dapat pula ditambahkan tombol download yang nanti akan disimpan dalam bentuk file gambar.

Contohnya seperti ini.

{% highlight_caption %}
{% highlight erb linenos %}
<%= area_chart({a: 2, b: 5, c: 3, d: 15, e: 6, f: 12, g: 3},
                title: "Grafik Area",
                xtitle: "X Title",
                ytitle: "Y Title",
                colors: ["#B10000"],
                download: {
                  filename: "Grafik Area.png",
                  background: "#ffffff"
                },
                dataset: {
                  borderWidth: 1
                }) %>
{% endhighlight %}

![gambar_6]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/T1BQQ181/gambar-06.png" onerror="imgError(this);"}{:class="myImg"}

<br>
Dan masih banyak lagi option-option yang dapat digunakan, silahkan teman-teman mengunjungi dokumentasi dari ChartKick.

# Implementasi

Nah, setelah teman-teman mengenal bentuk-bentuk dari chart dan option-option yang dapat digunakan, selanjutnya kita akan memasangkan dengan data yang ada di database kita.

Untuk implementasi ke dalam Rails, ada bermacam-macam.

Sekenarionya, saya memiliki model `Case`. Saya mau mengambil data total `:positif_covid` setiap harinya berdasarkan tanggal `:fetched_at`.

## Langsung diletakkan di view template

{% highlight_caption app/views/cases/index.rb %}
{% highlight erb linenos %}
<%= line_chart Case.group_by_day(:fetched_at).sum(:positif_covid) %>
{% endhighlight %}


## Melalui Controller

Definisikan instance variable di controller.

{% highlight_caption app/controllers/case_controller.rb %}
{% highlight ruby linenos %}
  def index
    ...
    ...
    @data_positif_covid = Case.group_by_day(:fetched_at).sum(:positif_covid)
  end
{% endhighlight %}

{% box_info %}
<p>Saya menggunakan method <code>.group_by_day()</code> yang disediakan oleh <b><a href="https://github.com/ankane/groupdate" target="_blank">groupdate</a></b> gem.</p>
{% endbox_info %}

Kemudian, tinggal dipakai di view template.

{% highlight_caption app/views/cases/index.rb %}
{% highlight erb linenos %}
<%= line_chart @data_positif_covid %>
{% endhighlight %}

Nah, contoh-contoh lain, mengenai bagaimana cara mengambil data yang kita miliki, dapat teman-teman lihat pada dokumentasi **ChartKick**, baik di official websitenya maupun dari halaman README GitHubnya.

# Pesan Penulis

Catatan ini bukan merupakan tutorial, saya hanya ingin memberikan gambaran betapa mudahnya memasang grafik ke dalam Rails menggunakan ChartKick gem.

Maka dari itu, apabila teman-teman ingin mendapatkan penjelasan yang lebih baik, silahkan mengunjungin dokumentasi ChartKick. Tentunya akan lebih *up to date* dari yang saya tulis di sini.

Saya juga memanfaatkan gem ini untuk menampilkan grafik seperti yang saya lakukan di [bandithijo.github.io/covid19](https://bandithijo.github.io/covid19){:target="_blank"}

Saya rasa hanya ini yang dapat saya tuliskan saat ini.

Mudah-mudahan dapat bermanfaat untuk teman-teman.

Terima kasih.

(^_^)







# Referensi

1. [chartkick.com/](https://chartkick.com/){:target="_blank"}
<br>Diakses tanggal: 2020/07/08

2. [github.com/ankane/chartkick](https://github.com/ankane/chartkick){:target="_blank"}
<br>Diakses tanggal: 2020/07/08

3. [chartjs.org/](https://www.chartjs.org/){:target="_blank"}
<br>Diakses tanggal: 2020/07/08
