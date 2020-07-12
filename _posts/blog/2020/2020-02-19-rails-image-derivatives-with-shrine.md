---
layout: 'post'
title: "Membuat Image Derivatives dengan Shrine pada Rails"
date: 2020-02-19 14:22
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
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prerequisite

`Ruby 2.6.3` `Rails 5.2.3` `PostgreSQL 11.5`

# Prakata

Pada catatan kali ini saya akan mendokumentasikan proses implementasi image processing dengan Shrine gem pada aplikasi Ruby on Rails.

## Shrine itu apa yaa?

Definisi sederhananya, Shrine adalah *file attachment toolkit* untuk aplikasi Ruby.

Aplikasi Ruby artinya Shrine tidak hanya dapat digunakan oleh aplikasi yang dibuat dengan *Ruby web framework* seperti Ruby on Rails, melainkan dapat pula digunakan pada *Ruby web framework* yang lain seperti Sinatra, Hanami, Roda, Cuba, Grape.

## Kenapa memilih menggunakan Shrine?

Shrine memiliki beberapa keuntungan diantaranya:

1. Modular design, dimana kita dapat memilih fungsi apa yang akan kita pakai cukup dengan menggunakan *plugin*
2. Memory friendly, streming upload dan download menjadi tidak masalah, meskipun dengan file berukuran besar
3. Cloud storage, dukungan penyimpanan files yang berada di local disk, AWS S3, Google Cloud, Cloudinary dan lainnya
4. Persistence integrations, bekerja dengan baik pada Sequel, ActiveRecord, ROM, Hanami dan Mongoid serta lainnya
5. Flexible processing, mengenerate thumbnail eagerly atau onthe-fly dengan menggunakan imageMagick atau libvips
6. [dst](https://github.com/shrinerb/shrine){:target="_blank"}

<br>
Nah, pada catatan kali ini, saya akan membahas spesifik mengenai poin ke 5, **Flexible processing** atau lebih khusus ke **File processing**, atau lebih khusus lagi adalah **Image Processing**  yang akan digunakan untuk menggenerate *set of thumbnails*, atau dalam kata lain *image derivatives* (turunan gambar) dari gambar dengan ukuran asli yang diupload oleh user.

# Sekenario

Misal, pada Web aplikasi yang saya buat, saya mengizinkan user untuk dapat mengupload gambar (*image*).

Namun, ternyata pengguna mengupload gambar dengan ukuran yang besar-besar, tentunya hal ini akan berpengaruh ke page load dari halaman web aplikasi kita.

Untuk mengakali ini, saya memanfaatkan fungsi *image processing* yang dapat dikonfigurasi di dalam Shrine untuk menggenerate *set of thumbnails* sesuai kebutuhan, misal dalam 3 ukuran (small, medium dan large).

# Pemecahan Masalah

## Pemasangan Shrine

Saya sudah memasang Shrine ke dalam Gemfile aplikasi saya.

```ruby
# Gemfile

gem "shrine", "~> 3.0"
```

## Pemasangan Image Processing

Selanjutnya, saya akan memasang dependensi untuk Shrine dapat melakukan image procesing, yaitu ImageMagick.

Pada catatan kali ini saya tidak menjelaskan mengenai penggunaan libvips.

**Pada Arch Linux**

```
$  sudo pacman -S imagemagick
```

Untuk distribusi yang lain, silahkan mencari paket ImageMagick yang tersedia pada repository distro masing-masing.

Selanjutnya tambahkan `image_processing` pada Gemfile.

```ruby
# Gemfile

gem 'image_processing', '~> 1.8'
```

Install gem yang baru saja kita pasang.

```
$ bundle install
```

## Konfigurasi Initializer Shrine

Tambahkan plugin **derivatives** pada Shrine initializer.

```ruby
# config/initializers/shrine.rb

...
...
...

Shrine.plugin ...
Shrine.plugin ...
Shrine.plugin ...
Shrine.plugin :derivatives
Shrine.plugin :default_url
```

Saya juga menambahkan plugin **default_url** agar image yang belum memiliki turunan, dapat menggunakan original image.

## Models

Selanjutnya saya akan menambahkan fungsi untuk *eager processing* atau *derivatives processing* pada model image uploader.

```ruby
# app/models/image_uploader.rb

require "image_processing/mini_magick"

class ImageUploader < Shrine
  # Image validation
  Attacher.validate do
    validate_max_size 2.megabyte, message: "is too large (max is 2 MB)"
    validate_mime_type_inclusion ['image/jpg', 'image/jpeg', 'image/png']
  end

  # Eager processing / derivatives processing
  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original).saver(quality: 90)
    {
      large:  magick.resize_to_limit!(800, 800),
      medium: magick.resize_to_limit!(500, 500),
      small:  magick.resize_to_limit!(300, 300),
    }
  end

  # Fallback to original
  Attacher.default_url do |derivative: nil, **|
    file&.url if derivative
  end
end
```

Saya rasa, pada blok *eager processing / derivatives processing* sudah dapat dipahami yaa.

Kalau ingin memodifikasi ukurannya, dapat dilakukan pada blok tersebut.

Saye memilih menggunakan ImageMagick sebagai backend processing karena lebih familiar.

Namun, saya sempat membaca kalau libvips dapat memproses lebih ringan dan lebih cepat. Saya akan coba pada kesempatan yang lain.

Model `image_uploader.rb` ini tentunya akan dipanggil pada model-model yang memiliki field `image_data:text` atau dengan nama yang lain namun berakhiran `_data:text`, caranya dengan menambahkan include seperti di bawah ini.

```ruby
# app/models/nama_model.rb

class NamaModel < ApplicationRecord
  ...
  ...
  # Contoh dengan field image_data
  include ImageUploader::Attachment(:image)
  # Atau, dengan nama field yang berbeda
  include ImageUploader::Attachment(:header_image)
  ...
  ...
end
```

## Controller

Selanjutnya, pada controller yang menggunakan image uploader, saya akan menambahkan method `.image_derivatives!`.

Misal, saya memiliki posts controller.

```ruby
# app/controllers/admin/posts_controller.rb

class Admin::PostsController < AdminsController
  def index
    ...
  end

  def show
    ...
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    # Calls derivatives processor
    @post.image_derivatives! if @post.image.present?
    if @post.save
      redirect_to admin_post_path(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      # Calls derivatives processor
      @post.image_derivatives! if @post.image.present?
      @post.save
      redirect_to admin_post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    ...
  end

  def delete_image_attachment
    ...
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :image)
  end
end
```

**Gimana kalau field `image_data` berada pada tabel yang berelasi?**

```ruby
# app/controllers/admin/experiences_controller.rb

class Admin::ExperiencesController < AdminsController

  def index
    ...
  end

  def show
    ...
  end

  def new
    @experience = Experience.new
    @experience.build_photo
  end

  def create
    @experience = Experience.new(experience_params)
    # memanggil attribute image_data yang ada pada tabel photos
    @experience.photo.image_experience_derivatives! if @experience.photo.image_experience.present?

    if @experience.save
      redirect_to admin_experience_path(@experience)
    else
      @experience.build_photo
      render :new
    end
  end

  def edit
    @experience = Experience.find(params[:id])
  end

  def update
    @experience = Experience.find(params[:id])

    if @experience.update(experience_params)
      # memanggil attribute image_data yang ada pada tabel photos
      @experience.photo.image_experience_derivatives! if @experience.photo.image_experience.present?
      @experience.save
      redirect_to admin_experience_path(@experience)
    else
      render :edit
    end
  end

  def destroy
    ...
  end

  private

  def experience_params
    params.require(:experience).permit(..., ..., ...)
  end
end
```

## Views

Setelah gambar selesai diupload, gambar akan disimpan pada `image_data` atau nama apa saja `<attachment>_data` dalam catatan saya ini, berupa gambar.

Sekarang cara memanggilnya pada view template.

Perhatikan bagian `image_tag`.

```erb
<!-- app/views/public/posts/index.html.erb -->

<!-- Post list -->
<% @posts.each do |post| %>
  <div class="row">
    <div class="col-md-3">
      <%= link_to public_post_path(post) do %>
        <%= image_tag (post.image.present? ? post.image_url(:small) : "img-default.jpg"), class: "w-100 h-100" %>
      <% end %>
    </div>
    <div class="col-md-9">
      <span class="text-normal"><%= post.created_at.strftime("%B %e, %Y") %></span>
      <%= link_to public_post_path(post) do %>
        <h6><%= post.title.titleize %></h6>
      <% end %>
      <p class="text-normal">
        <% html = post.content %>
        <%= strip_tags(html).truncate(150) %>
        <%= link_to "more..", public_post_path(post), class: "text-primary" %>
      </p>
    </div>
  </div>
<% end %>
<!-- END Post list -->
```

Saya menggunakan bentuk `image_tag` seperti ini,

```erb
<%= image_tag (post.image.present? ? post.image_url(:small) : "img-default.jpg") %>
```

Terlihat bahwa saya menggunakan pengkondisian satu baris.

```
Apabila image.present?
Bernilai Benar, maka tampilkan image_url(:small)
Bernilai Salah, maka tampilkan img-default.jpg
```

Saya sudah menambahkan plugin **default_url** pada Shrine initializer, yang berguna untuk, memberikan *fallback* image ke original image, apabila post tersebut, belum memiliki gambar yang sudah di derivatives (diturunkan).

Bisa saja, tidak perlu menambahkan plugin **default_url**, namun pada `image_tag` akan menjadi 3 kondisi seperti ini,

```erb
<%= image_tag (post.image_url(:small) || post.image_url || "img-default.jpg") %>
```

Atau teman-teman dapat pula membuat view helper sendiri untuk menghandlenya.

<br>
Nah, contoh blok kode di atas adalah untuk membuat tampilan thumbnail dari artikel list yang ad di posts#index. Karena itu, saya menggunakan ukuran `:small`.

Berdasarkan image turunan yang saya definikan di dalam model image_uploader, terdapat 3 ukuran, `:small`, `:medium`, dan `:large`.

Tinggal dikondisikan saja, ukuran-ukuran mana saja yang akan digunakan pada template.

Misal pada bagian detail artikel, saya menggunakan ukuran `:medium`. Lalu apabila gambar diklik, gambar akan menampilkan ukuran `:large`.

# Tambahan

Misalkan, aplikasi yang kita buat sudah terdapat gambar-gambar yang sudah diupload.

**Bagaimanakan kita dapat membuat gambar turunan dari semua gambar yang sudah terlanjur berada di dalam server?**

Nah, tinggal dibuatkan saja *script* yang akan menjalankan proses tersebut.

Saya akan buat direktori baru bernama `script` dan membuat file baru bernama `derivatives_bomb.rb`.

Namanya sengaja saya buat keren. Biar sedikit memprovokasi.

```ruby
# script/derivatives_bomb.rb

# WHAT IS THIS?
# This script is for adding derivatives in existing photos purposes
# Existing photos means, photos that had been on server before image
# derivatives had implemented
# If there are any questions about this script, Please take a look on
# https://shrinerb.com/docs/changing-derivatives
#
# HOW TO USE?
# Run this script on Terminal.
# $ rails runner scripts/derivatives_bomb.rb

# Model-model yang memiliki image_data di dalam fieldnya
normal_targets = ['User', 'Post']
normal_targets.each do |model|
  puts "\n#{model}s image derivating process starting..."
  progress = 'Progress ['
  i = 0
  (model.constantize).find_each do |photo|
    i = i + 1
    if i % 1 == 0
      progress << "|"
      print "\r"
      print progress + " #{i} / #{(model.constantize).all.size} %]"
      $stdout.flush
      sleep 0.05
    end

    attacher = photo.image_attacher
    next unless attacher.stored?
    attacher.create_derivatives
    begin
      attacher.atomic_persist
    rescue Shrine::AttachmentChanged,
      ActiveRecord::RecordNotFound
      attacher.delete_derivatives
    end
  end
  puts " DONE!"
end

# Model yang field image_data nya berada pada tabel yang berelasi
# Misal, tabel experiences yang menyimpan data foto pada tabel photos
puts "\nExperiences image derivating process starting..."
progress = 'Progress ['
i = 0
Experience.find_each do |exp|
  i = i + 1
  if i % 1 == 0
    progress << "|"
    print "\r"
    print progress + " #{i} / #{Experience.all.size} %]"
    $stdout.flush
    sleep 0.05
  end

  # photo_image field
  attacher = exp.photo.photo_experience_attacher
  next unless attacher.stored?
  attacher.create_derivatives
  begin
    attacher.atomic_persist
  rescue Shrine::AttachmentChanged,
    ActiveRecord::RecordNotFound
    attacher.delete_derivatives
  end
end
puts " DONE!"

puts """
d8888b.  .d88b.  d8b   db d88888b db
88  `8D .8P  Y8. 888o  88 88'     88
88   88 88    88 88V8o 88 88ooooo YP
88   88 88    88 88 V8o88 88~~~~~
88  .8D `8b  d8' 88  V888 88.     db
Y8888D'  `Y88P'  VP   V8P Y88888P YP
"""
```

Cara menjalankannya sangat mudah,

```
$ rails runner script/derivatives_bomb.rb
```

Tunggu prosesnya sampai selesai.

```
Running via Spring preloader in process 135133

Users image derivating process starting...
Progress [|||||||||| 10 / 10 %] DONE!

Posts image derivating process starting...
Progress [|||||||||||||||||||| 20/20 %] DONE!

Experiences image derivating process starting...
Progress [|||||||||||||||||||||||||||||| 30 / 30 %] DONE!

d8888b.  .d88b.  d8b   db d88888b db
88  `8D .8P  Y8. 888o  88 88'     88
88   88 88    88 88V8o 88 88ooooo YP
88   88 88    88 88 V8o88 88~~~~~
88  .8D `8b  d8' 88  V888 88.     db
Y8888D'  `Y88P'  VP   V8P Y88888P YP
```

Ahahaha.

Yah, bagaimanapun script ini masih jauh dari sempurna. Masih remah-remah biskuit selamet.

Namun, cukup berguna bagi saya.

# Pesan Penulis

Catatan ini masih jauh dari kata sempurna.

Karena keterbatasan waktu, ilmu dan pemahaman yang saya miliki.

Apabila terdapat kendala dalam mengaplikasikan Shrine image processing ini, teman-teman dapat merujuk pada sumber-sumber dokumentasi resmi yang saya sertakan di bawah.

Sepertinya cukup segini saja.

Mudah-mudahan dapat bermanfaat bagi teman-teman yang memerlukan.

Terima kasih.

(^_^)




# Referensi

1. [github.com/shrinerb/shrine](https://github.com/shrinerb/shrine){:target="_blank"}
<br>Diakses tanggal: 2020/02/19

2. [github.com/janko/image_processing](https://github.com/janko/image_processing){:target="_blank"}
<br>Diakses tanggal: 2020/02/19

3. [shrinerb.com/docs/processing](https://shrinerb.com/docs/processing){:target="_blank"}
<br>Diakses tanggal: 2020/02/19

4. [shrinerb.com/docs/changing-derivatives](https://shrinerb.com/docs/changing-derivatives){:target="_blank"}
<br>Diakses tanggal: 2020/02/19
