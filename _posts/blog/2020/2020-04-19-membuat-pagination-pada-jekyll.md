---
layout: 'post'
title: "Membuat Pagination pada Jekyll"
date: 2020-04-19 07:39
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Jekyll']
pin:
hot:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Pendahuluan

*Pagination* mungkin menjadi fitur yang diperlukan apabila kita memiliki koleksi post yang sangat banyak.

Tujuannya untuk memudahkan kita mencari sesuatu, misal judul artikel. Bayangkan apabila kita memiliki ratusan judul artikel, namun kita harus melihatnya satu persatu dalam satu halaman. Akan lebih mudah kalo kita pangkas, misal 10-20 judul artikel perhalaman. Tentu akan lebih mudah untuk kita sortir judul mana yang ingin kita baca apabila kita hanya mencari diantar 10-20 judul artikel.

Namun, seperti yang teman-teman ketahui, di blog ini saya tidak memasang *pagination*. Seharusnya saya memasang *pagination* pada halaman blog list atua vlog list. Tapi tidak saya lakukan. Saya memilih untuk menggelontorkan saja dengan gamblang seluruh daftar judul artikel yang saya punya. Tunjuannya untuk memotivasi diri sendiri, bahwa saya sudah menghasilkan tulisan sebanyak ini. Dengan begitu, saya akan tetap termotivasi untuk kembali menulis. Hahaha. Alasan macam apa itu.

Nah, sekedar mencatat dan *sharing*, saya akan berbagi catatan mengenai "Bagaimana memasang *pagination* pada Jekyll".

# Penerapan

*Pagination* biasanya akan dipasangkan pada halaman yang menampilkan sebuah *collection*. *Collection* dalam hal ini adalah *posts*.

Dengan jumlah *posts* yang banyak, tentu saja apabila kita melakukan pengulangan *for* (*for loop*), maka akan menghasilkan daftar *posts* yang banyak sekali seperti yang teman-teman bis alihat pada blog ini di halaman [/blog](/blog){:target="_blank"} dan halaman [/vlog](/vlog){:target="_blank"}.

Langkah pertama, pasang gem `jekyll-paginate` pada `Gemfile`.

```ruby
# Gemfile

group :jekyll_plugins do
  ...
  ...
  gem "jekyll-paginate", "~> 1.1"
end
```

Install gems.

<pre>
$ <b>bundle install</b>
</pre>

Kemudian, enablekan pada `_config.yml`.

```yaml
# _config.yml

plugins:
  - ...
  - ...
  - jekyll-paginate

```

Misalnya, pada kasus ini, saya akan memasangkan *pagination* pada halaman blog.

Namun, sebelumnya, kita buat terlebih dahulu logic dari *pagination*-nya. Saya akan menggunakan *layout partial* saja agar lebih modular.

Saya akan buat file bernama `pagination.html` di direktori `_includes`.

{% raw %}
```liquid
<!-- _includes/pagination.html -->

<!-- Pagination -->
{% if paginator.total_pages > 1 %}
<nav aria-label="Page navigation example">
  <small>
    <ul class="pagination">
      {% if paginator.previous_page %}
        <li class="page-item">
          <a class="page-link" href="{{ paginator.previous_page_path | prepend: site.baseurl | replace: '//', '/' }}">&laquo;</a>
        </li>
      {% else %}
        <li class="page-item disabled">
          <span class="page-link">&laquo; Prev</span>
        </li>
      {% endif %}

      {% for page in (1..paginator.total_pages) %}
        {% if page == paginator.page %}
          <li class="page-item active">
            <span class="page-link">{{ page }}</span>
          </li>
        {% elsif page == 1 %}
          <li class="page-item">
            <a class="page-link" href="/">{{ page }}</a>
          </li>
        {% else %}
          <li class="page-item">
            <a class="page-link" href="{{ site.paginate_path | prepend: site.baseurl | replace: '//', '/' | replace: ':num', page }}">{{ page }}</a>
          </li>
        {% endif %}
      {% endfor %}

      {% if paginator.next_page %}
        <li class="page-item">
          <a class="page-link" href="{{ paginator.next_page_path | prepend: site.baseurl | replace: '//', '/' }}">&raquo;</a>
        </li>
      {% else %}
        <li class="page-item disabled">
          <span class="page-link">&raquo; Next</span>
        </li>
      {% endif %}
    </ul>
  </small>
</nav>
{% endif %}
<!-- END Pagination -->
```
{% endraw %}

Class di atas, saya menggunakan Bootstrap CSS Framework agar lebih mudah.

Nah, selanjutnya kita akan pasangkan pada halaman yang akan menampilkan *pagination* ini.

Dalam contoh kasus ini, halaman /blog.

Kita perlu memodifikasi *for loop* yang digunakan untuk menampilkaan daftar *post*.

Kalau secara normal seperti ini.

{% raw %}
```liquid
<!-- pages/blog.html -->

---
layout: page
title: Blog
permalink: /blog/
---

<ul>
{% for post in site.posts %}
  <li><a href="{{ post.url }}">{{ post.date | date: '%y/%m/%d' }} : {{ post.title }}</a></li>
{% endfor %}
</ul>
```
{% endraw %}

Nah, karena sekarang, kita akan menggunakan *pagination*, maka kita akan mengambil daftar *post* yang ada di *paginator* bukan di *site*.

{% raw %}
```liquid
<!-- pages/blog.html -->

---
layout: page
title: Blog
permalink: /blog/
---

<ul>
{% for post in paginator.posts %}
  <li><a href="{{ post.url }}">{{ post.date | date: '%y/%m/%d' }} : {{ post.title }}</a></li>
{% endfor %}
</ul>
```
{% endraw %}

Untuk mengatur jumlah post yang ditampilkan dalam satu halaman, kita perlu mendefinisikannya pada `_config.yml`.

```yaml
# _config.yml

plugins:
  - ...
  - ...
  - jekyll-paginate

paginate: 10
paginate_path: /page:num/
```

Bentuk *path* dari *pagination* di atas akan berupa.

<pre class="url">
http://localhost:4000/blog/page2/
</pre>

Kita dapat memodifikasi sesuai keinginan. Kalau saya, lebih *prefer* menggunakan bentuk seperti ini.

```yaml
paginate_path: /page/:num/
```

<pre class="url">
http://localhost:4000/blog/page/2/
</pre>

<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
<p>
Untuk membuat <i>pagination</i> kita harus memiliki <code>index.html</code> bukan <code>index.md</code>. Karena <i>pagination</i> hanya dapat bekerja pada file bertipe <code>.html</code>.
</p>
</div>

Kelar!

Sepertinya segini saja yang dapat saya catat.

Apabila belum jelas, silahkan merujuk pada referensi yang saya berikan.

Terima kasih.

(^_^)






# Referensi

1. [jekyllrb.com/docs/pagination/](https://jekyllrb.com/docs/pagination/){:target="_blank"}
<br>Diakses tanggal: 2020/04/19

2. [blog.webjeda.com/jekyll-pagination/](https://blog.webjeda.com/jekyll-pagination/){:target="_blank"}
<br>Diakses tanggal: 2020/04/19
