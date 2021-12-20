---
layout: 'post'
title: "Membuat Go To Next dan Previous Post Menu pada Blog Post yang Dibangun dengan Rails"
date: 2021-02-13 18:07
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
description: "Mungkin teman-teman pernah melihat sebuah blog yang memiliki fitur go to next dan previous post? Nah, kita akan membuat fitur yang sama seperti itu, apabila teman-teman memiliki web aplikasi dalam bentuk blog yang dibangun menggunakan Ruby on Rails."
---

# Prerequisite

`Ruby 2.7.2` `Rails 6.1.2` `PostgreSQL 12.5` `RSpec 4.0.0`

# Latar Belakang Masalah

Catatan kali ini, saya akan membahas Ruby on Rails dari sisi front-end.

Apabila kita memiliki sebuah fitur blog pada web aplikasi yang kita bangun menggunakan Ruby on Rails, mungkin akan cukup praktis kalau kita dapat menavigasikan halaman blog post dengan go to next & previous post pada halaman di mana saat ini kita berada.

{% image https://i.postimg.cc/yYhJHBtq/gambar-01.gif | 01 %}

Contohnya seperti gambar di atas, bagian yang saya beri kotak merah.

# Pemecahan Masalah

Untuk mengimplementasikan fitur go to next & previous post di atas, sangat mudah sekali.

Kita hanya perlu bermain di Model dan juga View template.

## ActiveRecord

Misal, saya memiliki sebuah model bernama **article**.

Saya akan membuat business logic pada **article** model, seperti di bawah ini.

{% highlight_caption app/models/article.rb %}
{% highlight ruby linenos %}
class Article < ApplicationRecord
  belongs_to :user

  # For go to next & prev feature
  def next
    self.class.where('id > ?', id).order(id: :asc).limit(1).first
  end

  def prev
    self.class.where('id < ?', id).order(id: :desc).limit(1).first
  end
end
{% endhighlight %}

Nah, method tersebut tinggal kita gunakan saja.


## ActionController

Anggaplah controllernya bernama **articles_controller**.

Pada Blog post untuk menampilkan halaman dari artikel biasanya terdapat pada action **show**.

{% highlight_caption app/controllers/articles_controller.rb %}
{% highlight ruby linenos %}
class ArticlesController < ApplicationController

  # ...

  def show
    @article = Article.find(params[:id])
  end

  # ...

end
{% endhighlight %}

Sekarang tinggal menggunakannya pada view template.

## ActionView

Mengikuti dari **articles_controller** dengan action **show**, artinya kita akan memiliki susunan dari halaman template seperti ini.

<pre>
.
├─ app/
│  ├─ ...
│  └─ views/
│     ├─ articles/
│     │  ├─ ...
│     │  └─ <mark>show.html.erb</mark>
...   ...
</pre>

Nah, tinggal kita gunakan instance variable dari **@article** yang telah kita definisikan di **articles_controller**.

{% highlight_caption app/views/articles/show.html.erb %}
{% highlight eruby linenos %}

<!-- ... -->

<!-- For go to next & prev feature -->
<div class="page-navigation mt-5">
  <div class="row d-flex justify-content-between">
    <div class="col-6 text-left">
      <%= link_to "Sebelumnya", article_path(@article.next) if @article.next %>
    </div>
    <div class="col-6 text-right">
      <%= link_to "Selanjutnya", article_path(@article.prev) if @article.prev %>
    </div>
  </div>
</div>
{% endhighlight %}

\*Abaikan nama class **d-flex** dan **justify-content-between**, saya menggunakan Bootstrap 4.

Method **.next** dan **.prev** adalah method yang kita definisikan pada **article** model.

Kalau ingin menggunakan tooltip, dapat menggunakan cara seperti ini.

{% highlight_caption app/views/articles/show.html.erb %}
{% highlight ruby linenos %}

<!-- ... -->

<!-- For go to next & prev feature -->
<div class="page-navigation my-3 mx-3">
  <div class="row d-flex justify-content-between">
    <div class="col-6 text-left">
      <% if @article.prev %>
        <%= link_to article_path(@article.prev), data: {toggle: "tooltip", placement: "top"}, title: @article.prev.title do %>
          <%= "Sebelumnya" %>
        <% end %>
      <% end %>
    </div>
    <div class="col-6 text-right">
      <% if @article.next %>
        <%= link_to article_path(@article.next), data: {toggle: "tooltip", placement: "top"}, title: @article.next.title do %>
          <%= "Selanjutnya" %>
        <% end %>
      <% end %>
    </div>
  </div>
</div>
{% endhighlight %}

Selesai!




<br>
# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Selanjutnya, saya serahkan kepada imajinasi dan kreatifitas teman-teman. Hehe.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)




# Referensi

1. [stackoverflow.com/questions/1275963/rails-next-post-and-previous-post-links-in-my-show-view-how-to](https://stackoverflow.com/questions/1275963/rails-next-post-and-previous-post-links-in-my-show-view-how-to){:target="_blank"}
<br>Diakses tanggal: 2021/02/13

2. [gorails.com/forum/setting-up-next-post-and-previous-post](https://gorails.com/forum/setting-up-next-post-and-previous-post){:target="_blank"}
<br>Diakses tanggal: 2021/02/13
