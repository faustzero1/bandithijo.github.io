---
layout: 'post'
title: "Autcomplete Tag dengan ActsAsTaggable, Select2, dan simple_form pada Rails"
date: 2019-12-07 11:47
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Rails', 'Javascript']
pin:
hot:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prerequisite

`Ruby 2.6.3` `Rails 5.2.3` `PostgreSQL 11.5`

# Prakata

Membuat *tagging system* pada Blog mungkin sudah menjadi sebuah keharusan. Rasanya tidak lengkap apabila sebuah Blog tidak memiliki fitur *tagging*. Seperti makan nasi goreng tidak pakai telur. Hihihi.

Di [bandithijo.com](https://bandithijo.com) saja juga saya berikan *tagging system* agar pembaca dapat dengan mudah menyortir bahan bacaan sesuai topik yang ingin mereka cari.

Nah, pada catatan kali ini, saya akan membahas mengenai,

"Membuat Autcomplete Tag dengan ActsAsTaggable, Select2 dan Simple Form pada Rails".


# Sekenario

Kali ini yang akan saya bahas adalah membuat inputan tag, pada sisi admin.

Misal, si admin ingin membuat artikel baru, dan menambahkan tag.

Namun ada tag apa saja yang sudah pernah dibuat oleh admin?

Tentu saja kita ingin mengetahui tag-tag apa yang sudah pernah dibuat sebelumnya, dan dapat menggunakan lagi tag tersebut.

Nah, atas dasar permasalah tersebut, catatan ini saya buat.

Kira-kira, tampilan jadinya akan seperti ini.


![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/8kKFvCr4/gambar-01.png" onerror="imgError(this);"}
<p class="img-caption">Gambar 1 - Multiple tag</p>

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/vmsDygpY/gambar-02.png" onerror="imgError(this);"}
<p class="img-caption">Gambar 2 - Autcomplete tag suggestion</p>

Nah, dari ilustrasi gambar tersebut, saya rasa pasti sudah paham kan yaa.

# Instalasi

Sebagai langkah awal, kita perlu memasang semua gem yang diperlukan pada `Gemfile`.

```ruby
# Gemfile
...
...
gem 'acts-as-taggable-on',      '~> 6.0'
gem 'simple_form',              '~> 5.0', '>= 5.0.1'
gem 'select2-rails',            '~> 4.0', '>= 4.0.3'

```

Versi dari gem di atas, adalah versi dari gem saat catatan ini ditulis.

**ActsAsTaggable** gem, akan saya gunakan untuk membuat *tagging system*, agar praktis, hehe.

**Select2** gem, akan saya gunakan untuk menghandle *front end insterface* bagian autocomplete dan tampilan dari tag.

**simple_form** gem, akan saya gunakan untuk mempermudah saya dalam membuat form. Karena ada beberapa keterbatasan dari form yand disediakan oleh Rails. Terkhusus untuk mengakomodir pembuatan autocomplete tag ini.


Setelah menambahkan gem, jangan lupa untuk menginstallnya.

```
$ bundle install
```

Setelah itu kita perlu melakukan langkah-langkah *post installation* terhadap masing-masing gem.

## ActsAsTaggable

Kita perlu melakukan generate migration untuk ActsAsTaggable.

```
$ rails acts_as_taggable_on_engine:install:migrations
```

Lalu, jalankan migrationnya.

```
$ rails db:migrate
```

Dari migration tersebut, akan dibuatkan 2 buah skema baru, yaitu tabel **taggings** dan **tags**.

## Simple Form

Selanjutnya, untuk simple_form, jalankan juga generator yang sudah disediakan oleh simple_form.

```
$ rails generate simple_form:install
```

Karena saya menggunakan **Bootstrap**, maka saya perlu menambahkan option `--bootstrap`.

```
$ rails generate simple_form:install --bootstrap
```

## Select2 Rails

Sekedar informasi, sebelum menggunakan select2_rails gem, saya sudah menggunakan chosen gem, namun tidak sesuai harapan. Dan sepertinya sudah tidak disarankan lagi untuk menggunakan chosen.

Dokumentasi resmi dari Select2 juga sangat bagus. Saya akan sertakan alamatnya pada bagian referensi di bawah.

Untuk proses *post installation*, kita hanya perlu memanggil library ini pada web aplikasi kita.

Tambahkan select2_rails pada javascript assets.

```javascript
// app/assets/javascripts/application.js

...
...
...
//= require select2
```

Tambahkan select2_rails pada stylesheet assets.

```sass
// app/assets/stylesheets/application.scss

...
...
...
@import "select2";
@import "select2-bootstrap";
```

Kalau yang menggunakan `application.css`.

```css
/* app/assets/stylesheets/application.css */

/*
 ...
 ...
 ...
 *= require select2
 *= require select2-bootstrap
 */
```

Nah, selanjutnya tinggal mengaplikasikan ke dalam project.

# Penerapan

Proses pengaplikasian ke dalam project akan sangat tergantung dari project yang teman-teman miliki.

Cara yang saya berikan di bawah ini hanya ilustrasi yang saya lakukan pada project yang saya buat.

Sebagai ilustrasi saya memiliki sebuah aplikasi blog dengan model article dan author.

## Model

Saya akan mulai dari membuat relasi antara model tag dengan article.

Model tag ini tidak langsung dibuat oleh ActsAsTaggable. Karena memang tidak diperlukan.

Namun, kita perlu membuat model ini agar kita dapat membuat object pada controller.

```ruby
# app/models/tag.rb

class Tag < ApplicationRecord
  has_many :taggings
  has_many :articles, through: :taggings
end
```
Selanjutnya, pada model article.

Saya akan menambahkan relasi dan mendefinisikan object yang akan digunakan oleh ActsAsTaggable.

```ruby
# app/models/article.rb

class Article < ApplicationRecord
  ...
  ...
  has_many   :taggings
  has_many   :tags, through: :taggings

  acts_as_taggable_on :tags

  ...
  ...
end
```

Sebenarnya, apabila object tag kita bernama tag, cukup gunakan,

```ruby
  acts_as_taggable
```

Kecuali, kita ingin mengeset nama yang lain untuk object tag ini.

```ruby
  acts_as_taggable_on :article_tags
```

Namun, untuk tujuan catatan ini, saya lebih baik menuliskannya saja.



## Controller

Setelah membuat relasi dan mendefinisikan object tag, kita akan punya object tag yang dapat kita panggil di dalam articles controller.

Karena kita akan menggunakan form pada action `:new` dan `:edit`, maka saya perlu membuat instance variable dari object tag yang nantinya akan digunakan untuk menampilkan autocomplete tag suggestion yang tersedia dalam populasi object tags.

```ruby
# app/controllers/articles_controller.rb

class ArticlesController < ApplicationController
  def index
    ...
  end

  def show
    ...
  end

  def new
    @article = Article.new
    @tag_list = ActsAsTaggableOn::Tag.all.where('name like ?', '#%')
  end

  def create
    ...
  end

  def edit
    @article = Article.find(params[:id])
    @tag_list = ActsAsTaggableOn::Tag.all.where('name like ?', '#%')
  end

  def update
    ...
  end

  def destroy
    ...
  end

  private

  def article_params
    params.require(:article).permit(:title, :author_id, , :post, tag_list: [])
  end
end
```

Jangan lupa untuk memberikan permit pada object `:tag_list` berupa `tag_list: []`.

Karena params tersebut akan mengembalikan nilai berupa array.

```ruby
tag_list: ["#rubyonrails", "#rubyconf", "#rspec"]
```

Nah, sekarang tinggal membuat form pada view template.

## View

Pada tahapan ini saya menggunakan 2 buah gem untuk membantu saya mengurusi masalah *front end*. Yaitu, simple_form dan select2_rails.

Pertama, saya akan membuat form dulu dengan bantuan `simple_form`.

Karena yang memerlukan from ini adalah action `:new` dan `:edit`, maka saya akan membuatnya menjadi render partial template.

```html
<!-- app/views/articles/new.html.erb -->

<%= simple_form_for(@article, url: { action: :create }, html: { id: 'form' } ) do |f| %>
  <%= render 'form', f: f, article: @article, tag_list: @tag_list %>
<% end %>
```

```html
<!-- app/views/articles/edit.html.erb -->

<%= simple_form_for(@article, url: { action: :update }, html: { id: 'form' } ) do |f| %>
  <%= render 'form', f: f, article: @article, tag_list: @tag_list %>
<% end %>
```

Kemudian formnya akan seperti ini.

```html
<!-- app/views/articles/_form.html.erb -->

<div class="form-row">
  <div class="form-group">
    <label>Title</label>
    <%= f.text_field :title, class: "form-control",
                             placeholder: "e.g. Ruby on Rails",
                             autofocus: true %>
  </div>

  <!-- Autcomplete Tag Suggestion Here -->
  <div class="form-group">
    <label>Title</label>
    <%= f.input :tag_list, class: 'form-control',
                           collection: tag_list,
                           value_method: :name,
                           label: false,
                           input_html: {multiple: true} %>
  </div>
  <!-- END Autcomplete Tag Suggestion Here -->

  <div class="form-group">
    <label>Post</label>
    <%= f.text_area :post, class: "form-control",
                           rows: '15',
                           placeholder: "Write your post here..." %>
  </div>
  <div class="form-group">
    <%= f.submit "Publish", class: "btn btn-primary" %>
  </div>
</div>
```

Kemudian pada bagian bawah dari file `_form.html.erb` ini, kita akan menambahkan javascript library dari Select2.

```html
<!-- app/views/articles/_form.html.erb -->

...
...
...

<script>
  // Autocomplete Tag Suggestion
  $(document).ready(function() {
    $("#article_tag_list").select2({
      tags: true,
      placeholder: 'e.g. #RubyOnRails'
    });
  });
</script>
```

Untuk mendapatkan id `#article_tag_list` dapat menggunakan fitur inspect yang ada pada Browser dan lakukan inspeksi terhadap kolom input.

`tags: true` digunakan agar kita dapat menambahkan tag baru selain yang sudah ada pada autocomplete tag suggestion.

Selesai!

Kita tidak perlu melakukan konfigurasi apapun pada route.

Sepertinya segini dulu deh.

Untuk bahan referensi lebih jauh, silahkan membaca dokumentasi dari masing-masing library yang sudah saya sertakan pada daftar referensi di bawah.

Mudah-mudahan dapat bermanfaat buat teman-teman.

Terima kasih.

(^_^)


# Referensi

1. [github.com/mbleigh/acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on){:target="_blank"}
<br>Diakses tanggal: 2019/12/07

2. [github.com/plataformatec/simple_form](https://github.com/plataformatec/simple_form){:target="_blank"}
<br>Diakses tanggal: 2019/12/07

3. [github.com/argerim/select2-rails](https://github.com/argerim/select2-rails){:target="_blank"}
<br>Diakses tanggal: 2019/12/07

4. [select2.org/](https://select2.org/){:target="_blank"}
<br>Diakses tanggal: 2019/12/07

5. [select2.github.io/select2/](https://select2.github.io/select2/){:target="_blank"}
<br>Diakses tanggal: 2019/12/07

6. [select2.github.io/select2-bootstrap-theme/4.0.3.html](https://select2.github.io/select2-bootstrap-theme/4.0.3.html){:target="_blank"}
<br>Diakses tanggal: 2019/12/07
