---
layout: 'post'
title: "Membuat Input Select yang Berbasis Rentang pada Rails"
date: 2020-01-27 11:46
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Rails']
pin:
hot:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prerequisite

`Ruby 2.6.3` `Rails 5.2.3` `PostgreSQL 11.5`

# Prakata

Catatan kali ini masih dengan Rails sebagai Fullstack.

Mengenai penggunaan Input Select yang mengambil data berupa Range (rentang) dari field yang berisi nilai di dalam database.

# Sekenario

Saya mempunyai sebuah tabel bernama Experience. Di dalam tabel ini terdapat field harga (*price*).

```ruby
# db/schema.rb

create_table "experiences", force: :cascade do |t|
  ...
  ...
  t.string "price"
  ...
  ...
end
```

Saya ingin membuat fitur search filter berdasarkan rentang harga tertentu.

Misalkan:

```
- RM 1   - RM 100
- RM 101 - RM 300
- RM 301 - RM 500
- RM 501 - RM 1000
```

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/Dz531bWD/gambar-01.png" onerror="imgError(this);"}


# Pemecahan Masalah

Kebetulan, saya menggunakan **Ransack**.

Ransack memiliki option pencarian untuk menghandle rentang, yaitu `_in`.

`_in`, *match any values in array*.

Selain array dapat jug aberupa tipe data range `x..y`.

Sekarang saya akan ke controller terlebih dahulu.

## Controller

Pada homepage_controller, saya akan buatkan sebuah instance variable `@search` untuk menampung object dari `params[:q]`.

```ruby
# app/controllers/homepage_controller.rb

class HomepageController < ApplicationController
  def index
    @search = Experience.ransack(params[:q])
  end

  ...
  ...
end
```

Kemudian, pada experiences_controller juga akan dibuatkan instance variable yang sama.

```ruby
# app/controllers/experiences_controller.rb

class ExperiencesController < ApplicationController
  # Memanggil method convert_string_into_range, hanya pada action index
  before_action :convert_string_into_range, only: [:index]

  def index
    @search = Experience.search(params[:search], params[:q])
    @experiences = @search.result(distinct: true)
  end

  ...
  ...

  private

  # Untuk mengkonversi nilai string ke dalam tipe data range
  def string_to_range(rangestr)
    rangestr&.split('..')&.inject { |s,e| s.to_i..e.to_i }
  end

  def convert_string_into_range
    unless (params[:q][:price_in] rescue nil).blank?
      params[:q][:price_in] = string_to_range(params.dig(:q, :price_in))
    end
  end
end
```

Selanjutnya, pada routes.

## Routes

Seperti biasa, kita memberikan route untuk action index dari homepage_controller.

```ruby
# config/routes.rb

Rails.application.routes.draw do
  root to: 'homepage#index'
  ...
  ...
end
```

Nah, kalo sudah, tinggal buat view template.

## View Template

Contoh blok html di bawah ini hanya sebagai dummy.

Hanya blok code ERB saja yang perlu dilihat.

```html
# app/views/homepage/index.html

<%= search_form_for @search, url: experiences_path do |f| %>
  <div class="position-relative">
    <div class="row column-search">
      ...
      ...
      ...

      <!-- Budget Range Input Selection -->
      <div class="col3">
        <label class="control-label" for="budget">Budget</label>
        <div class="form-group form-group-icon right">
          <%= f.select :price_in,
                       options_for_select(
                       [['Below RM100',     1..100],
                        ['RM101 - RM300',   101..300],
                        ['RM301 - RM500',   301..500],
                        ['RM501 and above', 501..1000]]),
                        { include_blank: "Choose a Budget Range" },
                        class: "form-control",
                        id: "search-budget" %>
          <i class='icon-dropdown right'></i>
        </div>
      </div>
      <!-- END Budget Range Input Selection -->

      <div class="col-2 align-self-center">
        <label class="control-label"></label>
        <%= f.button type: 'submit', class: "btn btn-primary" do %>
          <span class="icon-search"></span>
          <span>Search</span>
        <% end %>
      </div>
    </div>
  </div>
<% end %>
```

Pada contoh di atas, saya mempassing nilai dari form search ini ke dalam instance variable `@search` dan mengarahkan hasil outputnya pada halaman experience index `experiences_path`.

Kemudian pada `options_for_select`, index pertama, akan di gunakan sebagai display, dan index keduanya akan digunakan sebagai value yang akan dimasukkan ke dalam `params[:q][:price_in]`.

Bentuknya adalah string.

Misal, saya memilih `RM 101 - RM 300`.

```
Parameters: {"utf8"=>"✓", "q"=>{"price_in"=>"101..300"}}
```

hasil berupa string ini akan ditangkap oleh callback

```
before_action :convert_string_into_range, only: [:index]
```

Yang akan mengkonversi nilai string menjadi bentuk range.

**Mengapa harus dikonversi sdari string menjadi range?**

Karena Ransack option `_in` hanya dapat dipakai oleh inputan yang bertipe data range.

Oke, sepertinya sudah cukup.

Mudah-mudahan bermanfaat buat teman-teman.

Terima kasih

(^_^)



# Referensi

1. [apidock.com/rails/v4.2.7/ActionView/Helpers/FormOptionsHelper/options_for_select](https://apidock.com/rails/v4.2.7/ActionView/Helpers/FormOptionsHelper/options_for_select){:target="_blank"}
<br>Diakses tanggal: 2020/01/27

2. [github.com/activerecord-hackery/ransack/wiki/Basic-Searching#in](https://github.com/activerecord-hackery/ransack/wiki/Basic-Searching#in){:target="_blank"}
<br>Diakses tanggal: 2020/01/27
