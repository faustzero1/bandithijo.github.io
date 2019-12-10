---
layout: 'post'
title: "Membuat Fitur Search dengan Ransack dan EasyAutocomplete pada Rails"
date: 2019-12-08 17:02
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

Pada artikel sebelumnya, ["Membuat Tab Filter by Category dengan Ransack pada Rails"](/blog/tab-filter-by-category-dengan-ransack-rails){:target="_blank"}, saya sudah pernah membahas mengenai Ransack gem. Namun, bukan dimanfaatkan untuk pencarian, melainkan untuk mengakali dalam membuat fungsi tab yang akan menghasilkan index list yang sudah difilter berdasarkan hasil dari field tertentu. Wkwkwk.

Nah, kali ini saya akan menuliskan catatan yang memanfaatkan Ransack gem dengan benar (mungkin). (^_^)

Yaitu, membuat fitur pencarian yang diimplementasikan pada `text_field` dan akan menampilkan *autocomplete suggestion* dari populasi data dari suatu field.

Misal, dalam project yang saya kerjakan adalah field location dan nama dari experience. Jadi, *autocomplete suggestion* nya akan menampilkan data dari 2 field. Atau mungkin bisa disebut *autocomplete suggestion based on category*.

Kira-kira, hasilnya akan seperti ini.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/PxTsjZ4z/gambar-01.png" onerror="imgError(this);"}
<p class="img-caption">Gambar 1 - Autocomplete suggestion pada input field pencarian</p>

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/KzfXvzpX/gambar-02.gif" onerror="imgError(this);"}
<p class="img-caption">Gambar 2 - Ilustrasi bergerak dari autocomplete suggestion pada pencarian</p>

Nah, pada implementasi fitur ini, saya menggunakan bantuan JQuery plugin yang bernama [**EasyAutocomplete**](http://easyautocomplete.com/){:target="_blank"}. Saya menggunakan tipe [**categories**](http://easyautocomplete.com/guide#sec-categories){:target="_blank"}.

# Instalasi

## Ransack

Proses instalasi Ransack gem, sama seperti gem-gem pada umumnya. Gabungkan dengan formasi gem yang teman-teman miliki di `Gemfile`.

```ruby
...
...
...

gem 'ransack', '~> 2.3'
```

Jangan lupa untuk diinstall.

```
$ bundle install
```

Setelah selesai, selanjutnya saya akan memasang EasyAutocomplete JQuery plugin.

## EasyAutocomplete

Proses instalasi ini ada banyak varian, namun untuk catatan kali ini, saya memilih untuk memasang secara manual.

Download langsung dari EasyAutocomplete official website, [di sini](http://easyautocomplete.com/download){:target="_blank"}.

Versi yang paling up-to-date pada saat catatan ini dibuat adalah EasyAutocomplete 1.3.5.

Hasil dari download ini berupa file terkompresi **EasyAutocomplete-1.3.5.zip**.

Kalau kita buka, akan seperti ini.

```
EasyAutocomplete-1.3.5/
 ├─ easy-autocomplete.css
 ├─ easy-autocomplete.min.css
 ├─ easy-autocomplete.themes.css
 ├─ easy-autocomplete.themes.min.css
 ├─ jquery.easy-autocomplete.js
 ├─ jquery.easy-autocomplete.min.js
 └─ maps/
```

Nah, tinggal saya distribusikan ke dalam Rails project. Tapi tentu saja tidak semua.

Gunakan yang diperlukan saja.

Saya memilih,

1. `easy-autocomplete.css`
2. `jquery.easy-autocomplete.js`

Kemudian saya distribusikan ke dalam direktori `vendor/` yang ada di Rails project saya.

<pre>
.
├─ app/
├─ bin/
├─ config/
├─ db/
├─ lib/
├─ log/
├─ node_modules/
├─ public/
├─ storage/
├─ test/
├─ tmp/
├─ vendor/
│  └─ assets/
│     ├─ javascripts/
│     │  └─ <mark>easy-autocomplete.css</mark>
│     └─ stylesheets/
│        └─ <mark>jquery.easy-autocomplete.js</mark>
├─ config.ru
├─ Gemfile
├─ Gemfile.lock
├─ package.json
├─ Rakefile
└─ README.md
</pre>

Nah, setelah file javascript dan stylesheet tersebut saya distribusikan, saya dapat mulai mengimplementasikan fungsi pencarian dengan menggunakan Ransack.

Saya akan mulai dari controller.

# Controller

Karena saya akan menampilkan hasil dari pencarian pada halaman experience index. Maka, saya akan membuat pemanggilan object pada Experiences controller.

```ruby
# app/controllers/experiences_controller.rb

class ExperiencesController < ApplicationController
  def index
    # Default for Ransack
    @search = Experience.search(params[:search], params[:q])
    @experiences = @search.result(distinct: true).page(params[:page]).per(10)

    # For Autocomplete Suggestion in Search Feature
    @experience_locations = Experience.ransack(location_cont: params[:q]).result(distinct: true).select('experiences.location')
    @experience_names = Experience.ransack(name_cont: params[:q]).result(distinct: true)
    respond_to do |format|
      format.html {}
      format.json {
        @experience_locations = @experience_locations.limit(10)
        @experience_names = @experience_names.limit(10)
      }
    end
  end

  def show
    @experience = Experience.friendly.find(params[:id])
  end
end
```
Terlihat pada action `:index`, saya membuat dua buah instance variable yang bernama `@experience_locations` dan `@experience_names` yang kemudian saya masukkan ke dalam blok `respond_to` untuk ditampilkan dalam format JSON.

Populasi data dalam format JSON inilah yang nantinya akan digunakan oleh EasyAutocomplete dalam menampilkan autocomplete suggestion data.

Selanjutnya, saya akan membuat script dengan Javascript untuk menghandle dimana data akan ditampilkan pada view template serta format tampilannya akan seperti apa.

Saya akan membuat file `topsearch.js` pada directory `app/assets/javascripts/`.

Dan menambahkannya pada `app/assets/javascripts/application.js`.

```javascript
// app/assets/javascripts/application.js

...
...
...
//= require topsearch
```

Kenapa saya namakan `topsearch` karena feature ini diletakkan pada navigation bar yang posisinya ada di bagian atas, dan akan digunakan di setiap halaman pada web aplikasi.

```javascript
// app/assets/javascripts/topsearch.js

document.addEventListener("turbolinks:load", function() {
  $input = $("[data-behavior='autocomplete']")

  var options = {
    getValue: "name",
    url: function(phrase) {
      return "/experiences.json?q=" + phrase;
    },
    categories: [
      {
        listLocation: "experience_locations",
        header: "<i class='icon-location'></i> Locations",
      },
      {
        listLocation: "experience_names",
        header: "<i class='icon-trip_planner2'></i> Experiences",
      },
    ],
    list: {
      onChooseEvent: function() {
        var name = $input.getSelectedItemData().name
        $input.val(name).ready(function() {
          document.getElementById("search").focus()
        })
      }
    },
    theme: "bandithijo-plate"
  }
  $input.easyAutocomplete(options)
});
```
Sebenarnya, saya tidak benar-benar mengerti tentang Javascript. Tapi saya yakin, teman-teman lebih mengerti daripada saya.

Bisa teman-teman perhatikan di atas.

Saya membuat variable `options` yang berisi,

Variable `$input` berisi variable `$("[data-behavior='autocomplete']")`.

`data-behavior` adalah properties pada view template yang akan saya tambahkan pada text input berupa `search_field_tag`.

`listLocation:` berisi `"experience_locations"` dan `"experience_names"` yang berasal dari instance variable yang saya buat sebelumnya pada experiences controller.

`header:` berisi title dari category. Dalam kasus saya, "Locations" dan "Experiences". Saya dapat pula menuliskan dalam html form, misal menambahkan bootstrap icon seperti ilustrasi pada Gambar 1 dan Gambar 2.

`theme:` adalah tema dari stylesheet yang dapat saya pilih apabila teman-teman menambahkan file `easy-autocomplete.themes.css` pada direktori `vendor/assets/stylesheets/`. Namun, dalam hal ini, saya meng-*custom* sendiri tema yang saya pergunakan dan saya beri nama `bandithijo-plate`. Saya modifikasi dari tema bawaan EasyAutocomplete yang bernama "easy-autocomplete.eac-plate" yang ada di dalam file `easy-autocomplete.theme.css`.

Kemudian tinggal saya panggil dengan `$input.easyAutocomplete(options)`.

Apabila kita coba di Browser, akan seperti ini hasilnya.

![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/9XBGF43f/gambar-03.png" onerror="imgError(this);"}
<p class="img-caption">Gambar 3 - Hasil pencarian dalam bentuk JSON.</p>

Sekarang saya buat form pencariannya di view template.

# View

Form pencarian yang saya mau, bukan hanya terletak pada halaman tertentu. Melainkan, pada navigation bar. Yang artinya, dapat saya gunakan pada setiap halaman.

Nah, karena saya menggunakan Bootstrap Navigation Bar, pasti sudah paham, kalau ada contoh template yang menyediakan input field untuk pencarian. Tinggal dimodifikasi saja sesuai dengan sintaks ERB.

Class pada contoh di bawah, hanya ilustrasi yaa.

```html
<!-- app/views/layouts/navigation_bar.html.erb -->

...
...

<%= form_tag experiences_path, local: true, method: :get, class: "form-group" do %>
  <%= search_field_tag :search, params[:search] || nil, class: "form-control", placeholder: "Where are you going?", data: {behavior: "autocomplete"} %>
<% end %>

...
...
```

Form pencarian di atas, akan dialamatkan ke experiences index, maka dari itu target alamatnya adalah `experiences_path`.

Menggunakan `search_field_tag` dari Ransack, dengan `params[:search]` yang akan di-*passing* ke experiences controller.

Kemudian, properties `data: {behavior: "autocomplete"}` adalah lokasi dari EasyAutocomplete akan menampilkan autocomplete suggestion yang sudah saya defisinikan pada `topsearch.js` sebelumnya, `data-behavior="autocomplete"`

Untuk mengambil nilai JSON yang sudah saya buat pada controller, saya menggunakan JSON Builder.

Kemudian, saya membuat file bernama `index.json.jbuilder` pada `app/view/experiences/`, berdampingan dengan `index.html.erb` pada viewe template dari experiences.

Isinya seperti ini.

```ruby
# app/views/experiences/index.json.jbuilder

json.experience_locations do
  json.array!(@experience_locations) do |experience|
    json.name experience.location
    json.url public_experiences_path(q: {location_cont: experience.location})
  end
end

json.experience_names do
  json.array!(@experience_names) do |experience|
    json.name experience.name
    json.url public_experiences_path(q: {name_cont: experience.name})
  end
end
```

Dapat dilihat pada blok kode di atas, bahwa saya memanggil instance variable `@experience_locations` dan `@experience_names` yang sudah saya definisikan sebelumnya pada experiences controller.

`location_cont` dan `name_cont` adalah predicates `_cont` yang disediakan oleh Ransack yang berarti "*Contains value*".

Nah, langkah terakhir tinggal membuat blok kode untuk menampilkan hasil pencarian pada `index.html.erb`.

Untuk detailnya dapat teman-teman olah sendiri.

```html
<!-- app/views/experience/index.html.erb -->

<% @experiences.each do |experience| %>

  ...
  ...

  <h5 class="black-medium mb-0"> <%= experience.name.titleize %> </h5>

  ...
  ...

<% end %>
```

Selesai!

Mudah-mudahan bermanfaat.

Mungkin pada kesempatan yang lain, akan saya buatkan demo projectnya dan membuat GitHub reponya.

Atau dapat juga saya menuliskan cara lain dengan memanfaatkan JQuery plugin yang lain, seperti [Select2](https://select2.org/){:target="_blank"}.

Sepertinya menarik, kalo lebih banyak pilihan.

Oke, sepertinya hanya segini saja yang dapat saya tuliskan.

Terima kasih.

(^_^)







# Referensi

1. [easyautocomplete.com/](http://easyautocomplete.com/){:target="_blank"}
<br>Diakses tanggal: 2019/12/07

2. [github.com/activerecord-hackery/ransack](https://github.com/activerecord-hackery/ransack){:target="_blank"}
<br>Diakses tanggal: 2019/12/07
