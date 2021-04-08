---
layout: 'post'
title: "Rails UJS dan AJAX, serta Button Animation Loading"
date: 2021-04-01 14:00
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
description: "Catatan kali ini tentang bagaimana membuat sebuah fitur update value pada sebuah halaman tanpa perlu refresh halaman. Sekaligus membuat animasi loading pada link/button tersebut."
---

# Prerequisite

`Ruby 3.0.0` `Rails 6.1.3.1`

# Target

Memberikan informasi kepada pengguna melalui button atau link bahwa aplikasi sedang memproses inputan dari user.

Informasi yang diberikan dapat berupa tulisan "Processing..." atau icon dengan animasi berputar.

Sekaligus kita akan menggunakan AJAX, agar data yang baru langsung diload ke bagian yang tertentu dari halaman tanpa perlu refresh.

## Sedikit tentang Rails UJS

UJS adalah kependekan dari Unobtursive Javascript. Rails menggunakan UJS untuk menghandle Javascript ke DOM (*Document Object Model*).

Rails sudah menjelaskan dengan sangat bagus mengenai UJS pada [**Rails Guides - Working with JavaScript in Rails: Unobtrusive JavaScript**](https://guides.rubyonrails.org/working_with_javascript_in_rails.html#unobtrusive-javascript){:target="_blank"}.

> *We call this 'unobtrusive' JavaScript because we're no longer mixing our JavaScript into our HTML. We've properly separated our concerns, making future change easy. We can easily add behavior to any link by adding the data attribute. We can run all of our JavaScript through a minimizer and concatenator. We can serve our entire JavaScript bundle on every page, which means that it'll get downloaded on the first page load and then be cached on every page after that. Lots of little benefits really add up*.

Sejauh yang saya tahu, untuk memasang UJS pada Rails, kita menggunakan gem yang bernama **jquery-rails** untuk memudahkan integrasi dengan Rails.

Kemudian tinggal di importkan saja.

{% highlight_caption app/assets/javascript/application.js %}
{% highlight javascript linenos %}
//= require jquery
//= require jquery_ujs
{% endhighlight %}

Pada Rails 6, sudah di include-kan secara default.

{% highlight_caption app/javascript/packs/application.js %}
{% highlight javascript linenos %}
require("@rails/ujs").start()
{% endhighlight %}

Oke, langsung saja yaa. Kalau masih perlu penjelasan mengenai UJS bisa dicari-cari sendiri.

# Achievment

## Membuat Project Baru

Saya akan membuat project baru dengan nama **demo_rails_ujs**.

Saya menggunakan Rails 6.1.3.1 dengan Ruby 3.0.0

{% shell_term $ %}
rails new demo_rails_ujs
{% endshell_term %}

## Generate scaffold book

{% shell_term $ %}
rails g scaffold Book name:string description:text published_at:datetime
{% endshell_term %}

## Run migration

{% shell_term $ %}
rails db:migrate
{% endshell_term %}

## Run server

{% shell_term $ %}
rails s
{% endshell_term %}

Dan akses alamat,

{% pre_url %}
http://localhost:3000/books
{% endpre_url %}

Inputkan buku baru. Masukkan data asal saja.

## Buat link publish

Buka **app/views/books/show.html.erb**.

{% highlight_caption app/views/books/show.html.erb %}
{% highlight eruby linenos %}
<p id="notice"><%= notice %></p>

<p>
  <strong>Name:</strong>
  <%= @book.name %>
</p>

<p>
  <strong>Description:</strong>
  <%= @book.description %>
</p>

<p>
  <strong>Published at:</strong>
  <%= @book.published_at %>
</p>

<%= link_to 'Publish', publish_book_path(@book) %> |
<%= link_to 'Edit', edit_book_path(@book) %> |
<%= link_to 'Back', books_path %>
{% endhighlight %}

Tambahkan **link_to 'Publish'**, seperti pada baris 18.

Nantinya, apabila kita meng-klik link **Publish**, value dari **published_at** akan terupdate sesuai jam saat ini. Tapi tanpa perlu me-refresh halaman.

## Buat routes untuk publish

{% highlight_caption config/routes.rb %}
{% highlight ruby linenos %}
Rails.application.routes.draw do
  resources :books do
    member do
      patch :publish
    end
  end
end
{% endhighlight %}

## Modifikasi link publish

Kalau kita klik link publish saat ini, maka akan muncul pesan error,

**No route matches [GET] "/books/1/publish"**

Secara default, link_to memiliki method **:get**, sedangkan yang kita inginkan adalah method **:patch**.

Modifikasi lagi link_to publish tersebut.

{% highlight_caption app/views/books/show.html.erb %}
{% highlight eruby linenos %}
<!-- ... -->

<%= link_to 'Publish', publish_book_path(@book), method: :patch %> |
<%= link_to 'Edit', edit_book_path(@book) %> |
<%= link_to 'Back', books_path %>
{% endhighlight %}

Tambahkan attribute **method: :patch**. Attribute ini disediakan oleh Rails yang disebut dengan "Unobtrusive JavaScript" (UJS).

## Buat publish action pada books_controller

Kalau kita klik link publish lagi, maka akan muncul pesan,

**The action 'publish' could not be found for BooksController**

Error in imuncul karena belum tersedia action **publish** pada **books_controller.rb**.

{% highlight_caption app/controllers/books_controller.rb %}
{% highlight ruby linenos %}
class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy publish ]

  # def index, show, new, edit, dst...

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def publish
    @book.update(published_at: Time.zone.now)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:name, :description, :published_at)
    end
end
{% endhighlight %}

Pada callbacks **:set_book**, tabahkan **publish**.

Buat method **publish**, seperti pada baris 16-18.

Kalau kita, kil publish saat ini, yang terjadi pada log adalah,

Update berhasil, tapi,

**No template found for BooksController#publish, rendering head :no_content**

Tidak ada template untuk menampilkan hasilnya.

## Siapkan area tampilan

Buka lagi **app/views/books/show.html.erb** dan modifikasi pada bagian output value dari published_at.

{% highlight_caption app/views/books/show.html.erb %}
{% highlight eruby linenos %}
<!-- ... -->
<p>
  <strong>Published at:</strong>
  <span id="published-at"><%= @book.published_at %></span>
</p>

<%= link_to 'Publish', publish_book_path(@book), method: :patch, remote: true %> |
<%= link_to 'Edit', edit_book_path(@book) %> |
<%= link_to 'Back', books_path %>
{% endhighlight %}

Tambahkan tag span dengan attribute ID seperti pada baris ke 4.

Tambahkan attribute **remote: true** pada **link_to 'Publish'**.

## Buat file template javascript

Karena kita akan menggunakan AJAX, kita akan membuat file view dengan format **.js.erb**.

Buat file view template pada **app/views/books/**, dengan nama **publish.js.erb**.

Penamaan file ini sesuai dengan nama action yang kita buat pada **books_controller.rb**.

Kita akan isi dengan `alert();`.

{% highlight_caption app/views/books/publish.js.erb %}
{% highlight js linenos %}
alert("Hello Ruby on Rails!");
{% endhighlight %}

Klik link "Publish", dan akan muncul pop up alert.

Sekarang kita ganti dengan yang benar.

{% highlight_caption app/views/books/publish.js.erb %}
{% highlight js linenos %}
document.querySelector("#published-at").innerHTML = "<%= @book.published_at %>";
{% endhighlight %}

Jadinya akan seperti ini.

{% image https://i.postimg.cc/q738nrtH/gambar-01.gif | 01 %}

## Animation loading pada link/button

Pada gambar animasi di atas, dapat dilihat ketika link ditekan, tidak ada jeda waktu.

Kita tambahkan animasi text untuk memberikan user experience yang lebih baik.

Seperti text bertuliskan "Publishing..." ketika link "Publish" di-klik.

{% highlight_caption app/views/books/show.html.erb %}
{% highlight eruby linenos %}
<!-- ... -->

<%= link_to 'Publish', publish_book_path(@book), method: :patch, remote: true, data: { disable_with: "Publishing..." } %> |
<%= link_to 'Edit', edit_book_path(@book) %> |
<%= link_to 'Back', books_path %>
{% endhighlight %}

Tambahkan atribute **data: { disable_with: "..." }** ke **link_to "Publish"**, seperti pada baris ke 3.

Kemudian, berikan jeda waktu dengan **sleep** pada action **publish** di **books_controller**.

{% highlight_caption app/controllers/books_controller.rb %}
{% highlight ruby linenos %}
class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy publish ]

  # def index, show, new, edit, dst...

  def publish
    sleep 2
    @book.update(published_at: Time.zone.now)
  end

  private

  # ...
end
{% endhighlight %}

Hasilnya akan seperti ini,

{% image https://i.postimg.cc/YC3SsyJL/gambar-02.gif | 02 %}

Selesai!











<br>
# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Selanjutnya, saya serahkan kepada imajinasi dan kreatifitas teman-teman. Hehe.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)




# Referensi

1. [Rails Guides - Working with JavaScript in Rails: Unobtrusive JavaScript](https://guides.rubyonrails.org/working_with_javascript_in_rails.html#unobtrusive-javascript){:target="_blank"}
<br>Diakses tanggal: 2021/04/01

2. [GoRails - jQuery UJS and AJAX](https://gorails.com/episodes/jquery-ujs-and-ajax){:target="_blank"}
<br>Diakses tanggal: 2021/04/01

3. [GoRails - Button Loading Animations with jQuery UJS](https://gorails.com/episodes/button-loading-animations-with-jquery-ujs){:target="_blank"}
<br>Diakses tanggal: 2021/04/01
