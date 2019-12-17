---
layout: 'post'
title: "Membuat Tab Filter by Category dengan Ransack pada Rails"
date: 2019-12-07 17:45
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

Beberapa waktu yang lalu, saya pernah membangun project dengan menggunakan **Ransack** gem untuk menghandle [MetaSearch](https://github.com/activerecord-hackery/meta_search){:target="_blank"}.

Sedikit penjelasan mengenai Ransack,

Ransack sendiri pengertian singkatnya adalah **Object-based searching**.

Ditulis ulang dari MetaSearch yang dibuat oleh [Ernie Miller](http://twitter.com/erniemiller){:target="_blank"} dan didevelop/dimaintain selama bertahun-tahun oleh [Jon Atack](http://twitter.com/jonatack){:target="_blank"} dan [Ryan Bigg](http://twitter.com/ryanbigg){:target="_blank"} serta mendapatkan bantuan dari [sekelompok contributor](https://github.com/activerecord-hackery/ransack/graphs/contributors){:target="_blank"} yang hebat.

Ransack dapat membantu kita membuat [simple](http://ransack-demo.herokuapp.com/){:target="_blank"} dan [advanced](http://ransack-demo.herokuapp.com/users/advanced_search){:target="_blank"} search forms untuk Rails aplikasi kita.

Jika teman-teman mencari gem untuk menyederhanakan pembuatan query pada model dan controller, Ransack mungkin bukan gem yang tepat. Mungkin bisa mencoba [Squeel](https://github.com/activerecord-hackery/squeel){:target="_blank"}.

Ransack kompatibel dengan Rails versi 6.0, 5.2, 5.1, 5.0, dan pada Ruby 2.3 ke atas.

Alasan kenapa memilih Ransack, karena Ransack works out-of-the-box pada Active Record.

# Instalasi

Seperti biasa, tambahkan pada `Gemfile`.

```ruby
# Gemfile

...
...
gem 'ransack', '~> 2.3'
```

Setelah itu jangan lupa untuk menjalankan,

```
$ bundle install
```

Untuk menginstall Ransack pada web aplikasi kita.

# Penerapan

Pada catatan kali ini, saya tidak akan menuliskan tentang penggunaan Ransack untuk pencarian dengan menggunakan form `search_form_for`.

Namun, saya akan menuliskan penggunaan Ransack untuk membuat tab filter berdasarkan field tertentu. Misal, dalam kasus saya adalah nama negara (*country*).

Kira-kira seperti ini hasilnya.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/jSsxsCTt/gambar-01.png" onerror="imgError(this);"}
<p class="img-caption">Gambar 1 - Hasil dari filter pada tab All</p>

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/wj063HxJ/gambar-02.png" onerror="imgError(this);"}
<p class="img-caption">Gambar 2 - Hasil dari filter pada tab tertentu, berdasarkan negara</p>

Contoh di atas, sudah dapat kita perkirakan bahwa hasil dari object yang sudah difilter akan ditampilkan pada view `index.html.erb`.

## Controller

Nah, pada bagian controller, isinya sangat orisinil seperti yang dicontohkan pada halaman readme dari Ransack.

```ruby
# app/controllers/careers_controller.rb

class CareersController < ApplicationController
  def index
    @q = Career.ransack(params[:q])
    @careers = @q.result(distinct: true).page(params[:page]).per(10)
  end

  ...
  ...
  ...
end
```

Pada model dan route, tidak perlu kita tambahkan apa-apa.

Selanjutnya, tinggal bermain pada view template.

Pada view template, saya mem-*passing* nilai dari `params[:q][:country_cont]` yang dikirimkan oleh view ke controller.

Dapat teman-teman perhatikan, terdapat object `country_cont` pada params tersebut, dapet dari mana?

`country` adalah salah satu field di dalam tabel careers.

```
# careers table
+--------------------+-------------------------------------------+-----------+-----------+
| position_name      | description                               | city      | country   |
|--------------------+-------------------------------------------+-----------+-----------|
| Technology Planner | Responsibilities and Duties:              | Singapore | Thailand  |
|                    | - Neutra stumptown literally.             |           |           |
|                    | - Goth squid yolo etsy cliche kogi beard. |           |           |
```

`_cont` adalah **predicate** yang disediakan oleh Ransack yang berarti **Contains value**.


## View

Untuk view template style dari tab, sesuaikan dengan style yang teman-teman gunakan.

Yang saya berikan di bawah, hanya contoh saja.

```html
<!-- app/views/careers/index.html.erb -->

<nav class="nav">
  <% if (params.has_key?(:q)) %>
    <%= link_to 'All', careers_path, class: "nav-link" %>
    <%= link_to 'Singapore', careers_path(q: {country_cont: 'Singapore'}),
                             class: "nav-link #{'active' if params[:q][:country_cont] == 'Singapore'}" %>
    <%= link_to 'Malaysia',  careers_path(q: {country_cont: 'Malaysia'}),
                             class: "nav-link #{'active' if params[:q][:country_cont] == 'Malaysia'}" %>
    <%= link_to 'Thailand',  careers_path(q: {country_cont: 'Thailand'}),
                             class: "nav-link #{'active' if params[:q][:country_cont] == 'Thailand'}" %>
  <% else %>
    <%= link_to 'All', careers_path, class: "nav-link active" %>
    <%= link_to 'Singapore', careers_path(q: {country_cont: 'Singapore'}),
                             class: "nav-link" %>
    <%= link_to 'Malaysia',  careers_path(q: {country_cont: 'Malaysia'}),
                             class: "nav-link" %>
    <%= link_to 'Thailand',  careers_path(q: {country_cont: 'Thailand'}),
                             class: "nav-link" %>
  <% end %>
</nav>
```

Hmmm, kurang beautiful yaa...

Wkwkwkwk

Mungkin bisa disederhanakan lagi seperti ini.

```html
<!-- app/views/careers/index.html.erb -->

<nav class="nav">
    <%= link_to 'All', careers_path, class: "nav-link #{params.has_key?(:q) ? '' : 'active'}" %>
    <%= link_to 'Singapore', careers_path(q: {country_cont: 'Singapore'}),
                             class: "nav-link #{'active' if params.has_key?(:q) && params[:q][:country_cont] == 'Singapore'}" %>
    <%= link_to 'Malaysia',  careers_path(q: {country_cont: 'Malaysia'}),
                             class: "nav-link #{'active' if params.has_key?(:q) && params[:q][:country_cont] == 'Malaysia'}" %>
    <%= link_to 'Thailand',  careers_path(q: {country_cont: 'Thailand'}),
                             class: "nav-link #{'active' if params.has_key?(:q) && params[:q][:country_cont] == 'Thailand'}" %>
</nav>
```

Dah!

Lumayanlah yaa.

Sebenarnya kita masih dapat membuatnya menjadi lebih dinamis, dengan mengambil data country dari model.

Yuk kita lakukan, agar kode di view template kita lebih *compact*.

Buat instance variable baru untuk daftar negara-negara pada controller.

```ruby
# app/controllers/careers_controller.rb

class CareersController < ApplicationController
  def index
    @q = Career.ransack(params[:q])
    @careers = @q.result(distinct: true).page(params[:page]).per(10)

    @country_list = Career.all.pluck(:country).uniq.sort
  end

  ...
  ...
  ...
end
```

Sekarang kita memiliki instance variable `@country_list` yang dapat kita gunakan pada view template.

```html
<!-- app/views/careers/index.html.erb -->

<nav class="nav">
  <%= link_to 'All', careers_path, class: "nav-link #{params.has_key?(:q) ? '' : 'active'}" %>
  <% @country_list.each do |country| %>
    <%= link_to country, careers_path(q: {country_cont: country}),
                         class: "nav-link #{'active' if params.has_key?(:q) && params[:q][:country_cont] == country}" %>
  <% end %>
</nav>
```

Nah, gimana? Asik kan?

Wkwkwk

Selanjutnya, untuk menampilkan hasil dari index listnya, seperti ini.

```html
<!-- app/views/careers/index.html.erb -->

...
...

<div class="row no-gutters mb-5">
  <!-- Available Position -->
  <% @careers.each do |career| %>
   <div class="col-sm-12">
     <div>
       <div>
         <h6><%= career.position_name.upcase %></h6>
         <div>
           <i class="icon-location"></i>
           <%= career.city.titleize %>, <%= career.country.titleize %>
         </div>
       </div>
       <div>
         <%= link_to "View Detail", career_path(career), class: "btn btn-primary" %>
       </div>
     </div>
   </div>
  <% end %>
  <!-- END Available Position -->
</div>
```

Selesai!

Apabila berhasil, apabila kita klik tab buttonnya, maka akan menghasilkan list yang sudah terfilter berdasarkan country.

Seperti ilustrasi pada Gambar 1 dan Gambar 2 di atas.

Namun, ada hal yang masih kurang memuaskan.

Saya masih belum dapat membuat URL nya menjadi lebih cantik.

<pre class="url">
http://localhost:3000/careers<mark>?q%5Bcountry_cont%5D=Malaysia</mark>
</pre>

Mungkin akan saya cari pada kesempatan yang lain.

Atau teman-teman punya rekomendasi untuk membuat URL menjadi lebih cantik, boleh tulis pada komentar di bawah yaa.

# Update

## Nice URL Form

Oke, akhirnya saya berhasil untuk membuat bentuk dari URL menjadi lebih bagus.

Kira-kira akan saya buat seperti ini.

<pre class="url">
http://localhost:3000/careers<mark>?country=Malaysia</mark>
</pre>

Caranya sangat mudah, saya hanya perlu bermain pada router dan controller.

Pertama-tama definiskan url form yang diinginkan pada `routes.rb`.

```ruby
# config/routes.rb

  ...
  ...

  get 'careers?country=:country', to: 'careers#index', as: 'career_country'
```

Pendefinisan routing ini, akan menghasilkan sebuah path baru untuk kita, yaitu `career_country_path`.

```
career_country_path GET    (/careers?country=:country(.:format)    careers#index
```

Selanjutnya akan saya gunakan pada controller.

Pada instance variable `@q`, ubah object params yang ditangkap  dari `:q` menjadi `:country`.

```ruby
# app/controllers/careers_controller.rb

class CareersController < ApplicationController
  def index
    @q = Career.ransack(country_cont: params[:country])
    @careers = @q.result(distinct: true).page(params[:page]).per(10)

    @country_list = Career.all.pluck(:country).uniq.sort
  end

  ...
  ...
  ...
end
```

Langkah terakhir, tinggal menggunakan path yang sudah didefinisikan di atas ke view template.

Serta merubah beberapa properti untuk `.active` class pada button tab yang aktif.

```html
<!-- app/views/careers/index.html.erb -->

<nav class="nav">
  <%= link_to 'All', careers_path, class: "nav-link #{params.has_key?(:country) ? '' : 'active'}" %>
  <% @country_list.each do |country| %>
    <%= link_to country, career_country_path(country: country),
                         class: "nav-link #{'active' if params[:country] == country}" %>
  <% end %>
</nav>
```

Selesai.

Sekarang bentuk dari url menjadi lebih bagus.

Oke, sepertinya segini saja.

Mudah-mudahan bermanfaat buat teman-teman.

Terima kasih.

(^_^)


# Referensi

1. [github.com/activerecord-hackery/ransack](https://github.com/activerecord-hackery/ransack){:target="_blank"}
<br>Diakses tanggal: 2019/12/07

2. [github.com/activerecord-hackery/meta_search](https://github.com/activerecord-hackery/meta_search){:target="_blank"}
<br>Diakses tanggal: 2019/12/07

3. [ransack-demo.herokuapp.com/](http://ransack-demo.herokuapp.com/){:target="_blank"}
<br>Diakses tanggal: 2019/12/07

4. [ransack-demo.herokuapp.com/users/advanced_search](http://ransack-demo.herokuapp.com/users/advanced_search){:target="_blank"}
<br>Diakses tanggal: 2019/12/07
