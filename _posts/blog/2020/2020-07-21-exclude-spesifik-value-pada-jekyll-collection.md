---
layout: 'post'
title: "Exclude Spesifik Value pada Jekyll Collection"
date: 2020-07-21 20:30
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

Saya memiliki collection berupa daftar **dotfriends** `site.data.dotfriends` yang memiliki attribute:

{% highlight_caption _data/dotfriends.yml %}
{% highlight yaml linenos %}
- nama: 'Rizqi Nur Assyaufi'
  github: 'bandithijo'

- nama: 'Sucipto'
  github: 'suciptoid'

- nama: 'Agung Setiawan'
  github: 'agungsetiawan'

# ...
# ...
{% endhighlight %}

<pre class="url">
Daftar dotfriends

- Rizqi Nur Assyaufi (bandithijo)
- Sucipto (suciptoid)
- Agung Setiawan (agungsetiawan)
- ...
- ...
</pre>

Untuk menampilkan collection di atas, saya menggunakan cara seperti ini.

{% highlight_caption _pages/daftar_dotfriends.html %}
{% highlight liquid linenos %}
{% raw %}
<h1>Daftar dotfriends</h1>
<ul>
{% for friend in site.data.dotfriends %}
  <li>{{ friend.nama }} ({{ friend.github }}</li>
{% endfor %}
</ul>
{% endraw %}
{% endhighlight %}

Namun, Saya tidak ingin menampilkan nama saya pada collection **dotfriends** tersebut.

# Pemecahan Masalah

Nah, untuk mengecualikan (*exclude*) nama saya "Rizqi Nur Assyaufi" di dalam collection **site.data.dotfriends**.

## 1. contains

{% highlight_caption _pages/daftar_dotfriends.html %}
{% highlight liquid linenos %}
{% raw %}
<h1>Daftar dotfriends</h1>
<ul>
{% for friend in site.data.dotfriends %}
  {% unless friend.nama contains 'Rizqi Nur Assyaufi' %}
    <li>{{ friend.nama }}</li>
  {% endunless %}
{% endfor %}
</ul>
{% endraw %}
{% endhighlight %}

Baris ke 4, adalah negasi dari kondisi **if** (**unless**) untuk nama yang mengandung "Rizqi Nur Assyaufi". Kondisi inilah yang membuat nama saya tidak ikut ditampilkan.

## 2. offset

{% highlight_caption _pages/daftar_dotfriends.html %}
{% highlight liquid linenos %}
{% raw %}
<h1>Daftar dotfriends</h1>
<ul>
{% for friend in site.data.dotfriends offset: 1 %}
  <li>{{ friend.nama }}</li>
{% endfor %}
</ul>
{% endraw %}
{% endhighlight %}

Baris ke 3, `offset: 1`, saya meletakkan nama saya pada index pertama di dalam collection. Sehingga saya dapat menggunakan `offset` untuk mengecualikannya.

<br>
Hasilnya akan seperti ini,

<pre class="url">
Daftar dotfriends

- Sucipto (suciptoid)
- Agung Setiawan (agungsetiawan)
- ...
- ...
</pre>





<br>
Selesai!!!

Saya rasa hanya ini yang dapat saya tuliskan saat ini.

Mudah-mudahan dapat bermanfaat untuk teman-teman.

Terima kasih.

(^_^)








# Referensi


1. [How can I exclude a specific Collection in "related-products.liquid"?](https://community.shopify.com/c/Shopify-Design/How-can-I-exclude-a-specific-Collection-in-quot-related-products/td-p/238708){:target="_blank"}
<br>Diakses tanggal: 2020/07/21

2. [shopify.github.io/liquid/tags/iteration/](https://shopify.github.io/liquid/tags/iteration/){:target="_blank"}
<br>Diakses tanggal: 2020/07/21
