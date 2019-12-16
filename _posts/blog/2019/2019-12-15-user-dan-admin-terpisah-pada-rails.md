---
layout: 'post'
title: "Membuat User dan Admin Terpisah pada Rails"
date: 2019-12-15 20:18
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

`Ruby 2.6.3` `Rails 5.2.4` `PostgreSQL 11.5`

# Prakata

Kali ini saya ingin mencatat mengenai web aplikasi yang memiliki tampilan frontend terpisah antara user dan admin. Tentu saja dengan menggunakan Rails.

Contoh mudahnya seperti aplikasi blog, Wordpress atau Blogspot.

Kedua aplikasi ini disebut CMS (*Content Management System*). Di mana web aplikasi ini mempunyai dua buah tampilan yang berbeda antara tampilan untuk pengunjung dan tampilan untuk author (penulis) atau admin.

# Eksekusi

Kali ini saya sedikit rajin.

Saya akan mencatat prosesnya dari awal project dibuat. Hehehe.

## Inisiasi Project

Saya akan membuat project baru menggunakan Rails 5.2.4 dengan PostgreSQL sebagai database engine.

```
$ rails _5.2.4_ new blog_spot -d postgresql
```

Kalau proses pembuatan sudah selesai, masuk ke dalam project.

```
$ cd blog_spot
```

Periksa spesifikasi versi Rails dan Ruby.

```
$ ruby -v
ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-linux]
```

```
$ rails -v
Rails 5.2.4
```

Selanjutnya create database dengan perintah berikut ini.

```
$ rails db:create
```
```
Created database 'blog_spot_development'
Created database 'blog_spot_test'
```

Lalu, jalankan Rails server untuk sekedar melihat apakah project berhasil dijalankan atau tidak.

```
$ rails s
```

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/QdHVbnLy/gambar-01.png" onerror="imgError(this);"}
<p class="img-caption">Gambar 1 - Default Welcome Page pada Rails Project</p>

Yay! Berhasil.

Entah mengapa saya suka melihat Default Rails Welcome Page ini. Dari sedikit web framework yang sudah saya coba seperti Codeigniter, Laravel, Django dan React. Rails memiliki tampilan Default Welcome Page yang menurut saya paling menarik.

## Pasang Devise

Devise adalah gem yang akan saya gunakan untuk menghandle authentication system.

Pasang pada `Gemfile`.

```ruby
...
...
gem 'devise', '~> 4.7', '>= 4.7.1'
```

Install Devise gem yang baru saja kita pasang.

```
$ bundle install
```

Jalankan generator yang disediakan oleh Devise untuk menginisiasi file config yang disediakan oleh Devise.

```
$ rails generate devise:install
```
<pre>
Running via Spring preloader in process 349251
     <span class="color-success">create</span>  config/initializers/devise.rb
     <span class="color-success">create</span>  config/locales/devise.en.yml
===============================================================================

Some setup you must do manually if you haven't yet:

  1. Ensure you have defined default url options in your environments files. Here
     is an example of default_url_options appropriate for a development environment
     in config/environments/development.rb:

       config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

     In production, :host should be set to the actual host of your application.

  2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:

       root to: "home#index"

  3. Ensure you have flash messages in app/views/layouts/application.html.erb.
     For example:

       &lt;p class="notice"&gt;&lt;%= notice %&gt;&lt;/p&gt;
       &lt;p class="alert"&gt;&lt;%= alert %&gt;&lt;/p&gt;

  4. You can copy Devise views (for customization) to your app by running:

       rails g devise:views

===============================================================================
</pre>

Hasil generate tersebut akan menghasilkan dua buah file yang dapat kita lihat pada output di atas.

Selanjutnya saya membuat model user dan admin dengan memanfaatkan generator yang disediakan oleh Devise.

Saya akan membuat untuk model admin terlebih dahulu.

```
$ rails g devise admin
```
<pre>
Running via Spring preloader in process 368446
      <span class="color-white">invoke</span>  active_record
      <span class="color-success">create</span>    db/migrate/20191216044109_devise_create_admins.rb
      <span class="color-success">create</span>    app/models/admin.rb
      <span class="color-white">invoke</span>    test_unit
      <span class="color-success">create</span>      test/models/admin_test.rb
      <span class="color-success">create</span>      test/fixtures/admins.yml
      <span class="color-success">insert</span>    app/models/admin.rb
       <span class="color-success">route</span>  devise_for :admins
</pre>

Kemudian untuk model user.

```
$ rails g devise user
```
<pre>
Running via Spring preloader in process 368446
      <span class="color-white">invoke</span>  active_record
      <span class="color-success">create</span>    db/migrate/20191216044641_devise_create_users.rb
      <span class="color-success">create</span>    app/models/user.rb
      <span class="color-white">invoke</span>    test_unit
      <span class="color-success">create</span>      test/models/user_test.rb
      <span class="color-success">create</span>      test/fixtures/users.yml
      <span class="color-success">insert</span>    app/models/user.rb
       <span class="color-success">route</span>  devise_for :users
</pre>

Lalu jalankan migration-nya.

```
$ rails db:migrate
```
```
== 20191216044109 DeviseCreateAdmins: migrating ===============================
-- create_table(:admins)
   -> 0.0167s
-- add_index(:admins, :email, {:unique=>true})
   -> 0.0134s
-- add_index(:admins, :reset_password_token, {:unique=>true})
   -> 0.0056s
== 20191216044109 DeviseCreateAdmins: migrated (0.0360s) ======================

== 20191216044641 DeviseCreateUsers: migrating ================================
-- create_table(:users)
   -> 0.0102s
-- add_index(:users, :email, {:unique=>true})
   -> 0.0077s
-- add_index(:users, :reset_password_token, {:unique=>true})
   -> 0.0064s
== 20191216044641 DeviseCreateUsers: migrated (0.0246s) =======================
```

Cek status dengan.

```
$ rails db:migrate:status
```
```
database: blog_spot_development

 Status   Migration ID    Migration Name
--------------------------------------------------
   up     20191216044109  Devise create admins
   up     20191216044641  Devise create users
```

Oke, migration untuk user dan model telah berhasil dimigrasikan ke skema database.

Dengan begini, sekarang saya sudah memiliki beberapa fitur yang disediakan oleh Devise, seperti:

1. Authentikasi
2. Registrasi
3. Edit
3. dll.

Devise juga mengenerate route untuk model admin dan user.

```ruby
# config/routes.rb

Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
end
```

Cek route yang tersedia pada Browser.

<pre class="url">
localhost:3000/rails/info/routes
</pre>

Selanjutnya, saya akan mulai dari controller.

## Controller

Saya akan menggunakan **Controller Namespaces and Routing**.[<sup>2</sup>](https://guides.rubyonrails.org/routing.html#controller-namespaces-and-routing){:target="_blank"}. Untuk memisahkan antara admin dan user dengan struktur direktori seperti ini.

<pre>
├─ app/
│  ├─ assets/
│  ├─ channels/
│  ├─ controllers/
│  │  ├─ <mark>admins/</mark>
│  │  │  └─ <mark>dashboard_controller.rb</mark>
│  │  ├─ concerns/
│  │  ├─ <mark>public/</mark>
│  │  │  └─ <mark>homepage_controller.rb</mark>
│  │  ├─ <mark>users/</mark>
│  │  │  └─ <mark>dashboard_controller.rb</mark>
│  │  ├─ <mark>admins_controller.rb</mark>
│  │  ├─ application_controller.rb
│  │  └─ <mark>users_controller.rb</mark>
│  ├─ ...
│  ...
├─ ...
...
</pre>

Kemudian isi dari file-file controller tersebut akan seperti ini.

Untuk Controller Namespaces pada Admins.

```ruby
# app/controllers/admins_controller.rb

class AdminsController < ApplicationController
  layout :admins
end
```

```ruby
# app/controllers/admins/dashboard_controller.rb

class Admins::DashboardController < AdminsController
  def index; end
end
```

Untuk Controller Namespaces pada Users.

```ruby
# app/controllers/users_controller.rb

class UsersController < ApplicationController
  layout :users
end
```

```ruby
# app/controllers/users/dashboard_controller.rb

class Users::DashboardController < UsersController
  def index; end
end
```

Saya juga membuat `homepage_controller.rb` untuk menghandle halaman Homepage yang saya letakkan pada direktori `public/`

```ruby
# app/controllers/public/homepage_controller.rb

class Public::HomepageController < ApplicationController
  def index; end
end
```

Langsung saja membuat action `:index`, yang nantinya akan digunakan untuk menampilkan text sederhana pada view template.

## Route

Kemudian, untuk routingnya akan seperti ini.

```ruby
# config/routes.rb

Rails.application.routes.draw do
  # Root
  root to: "public/homepage#index"

  # Public
  scope module: :public do
    resources :about
    resources :contact
  end

  # Admins
  devise_for :admins
  namespace :admins do
    root to: "dashboard#index"
    resources :dashboard, only: %w[index]
  end

  # Users
  devise_for :users
  namespace :users do
    root to: "dashboard#index"
    resources :dashboard, only: %w[index]
  end
end
```

Pada block Public, saya menggunakan `scope` karena ingin membuat url yang singkat, seperti ini.

<pre class="url">
localhost:3000/about
</pre>

Kalau menggunakan `namespace` maka url yang dihasilkan akan seperti ini.

<pre class="url">
localhost:3000/public/about
</pre>

Maka dari itu, saya menggunakan `scope` untuk controller yang berada pada module Public

Selanjutnya ke view template.

## View

Berikut ini struktur direktorinya.

<pre>
├─ app/
│  ├─ assets/
│  │  ├─ config/
│  │  ├─ images/
│  │  ├─ javascripts/
│  │  │  ├─ <mark>admins/</mark>
│  │  │  │  └─ <mark>custom.js</mark>
│  │  │  ├─ channels/
│  │  │  ├─ <mark>users/</mark>
│  │  │  │  └─ <mark>custom.js</mark>
│  │  │  ├─ <mark>admins.js</mark>
│  │  │  ├─ application.js
│  │  │  ├─ cable.js
│  │  │  └─ <mark>users.js</mark>
│  │  └─ stylesheets/
│  │     ├─ <mark>admins/</mark>
│  │     │  └─ <mark>custom.css</mark>
│  │     ├─ <mark>users/</mark>
│  │     │  └─ <mark>custom.css</mark>
│  │     ├─ <mark>admins.css</mark>
│  │     ├─ application.css
│  │     └─ <mark>users.css</mark>
│  ├─ channels/
│  ├─ controllers/
│  ├─ helpers/
│  ├─ jobs/
│  ├─ mailers/
│  ├─ models/
│  └─ views/
│     ├─ <mark>admins/</mark>
│     │  └─ <mark>dashboard/</mark>
│     │     └─ <mark>index.html.erb</mark>
│     ├─ layouts/
│     │  ├─ <mark>admins/</mark>
│     │  │  └─ <mark>_nav.html.erb</mark>
│     │  ├─ <mark>users/</mark>
│     │  │  └─ <mark>_nav.html.erb</mark>
│     │  ├─ <mark>admins.html.erb</mark>
│     │  ├─ application.html.erb
│     │  ├─ mailer.html.erb
│     │  ├─ mailer.text.erb
│     │  └─ <mark>users.html.erb</mark>
│     ├─ <mark>public/</mark>
│     │  └─ <mark>homepage/</mark>
│     │     └─ <mark>index.html.erb</mark>
│     └─ <mark>users/</mark>
│        └─ <mark>dashboard/</mark>
│           └─ <mark>index.html.erb</mark>
│
├─ ...
...
</pre>

Berikut ini isi dari file-file view tersebut.

Kita mulai dari `layouts/`.

```html
<!-- app/views/layouts/application.html.erb -->

<!DOCTYPE html>
<html>
  <head>
    <title>BlogSpot</title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <%= render 'layouts/users/nav' %>
    <%= yield %>
  </body>
</html>
```

```html
<!-- app/views/layouts/admins.html.erb -->

<!DOCTYPE html>
<html>
  <head>
    <title>Admin - BlogSpot</title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag    'admins', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'admins', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <%= render 'layouts/admins/nav' %>
    <%= yield %>
  </body>
</html>
```

```html
<!-- app/views/layouts/users.html.erb -->

<!DOCTYPE html>
<html>
  <head>
    <title>User - BlogSpot</title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag    'users', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'users', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <%= render 'layouts/users/nav' %>
    <%= yield %>
  </body>
</html>
```

Pada ketiga file view template di atas, saya menambahkan render partial untuk menu navigasi.

Saya juga mengarahkan `stylesheet_link_tag` dan `javascript_include_tag` pada path masing-masing sesuai struktur yang sudah dibuat sebelumnya di atas.

Oh ya, saya perlu untuk menambahkan configurasi tambahan untuk precompile additional assets, karena saya sudah membuat admins dan users.

Buka file `initializers/assets.rb`.

```ruby
# config/initializers/assets.rb

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w( admins.js admins.css users.js users.css )
```

*Uncomment* dan tambahkan `users.js` dan `users.css`.

*Bersambung...*





# Referensi

1. [github.com/plataformatec/devise](https://github.com/plataformatec/devise){:target="_blank"}
<br>Diakses tanggal: 2019/12/15

2. [guides.rubyonrails.org/routing.html#controller-namespaces-and-routing](https://guides.rubyonrails.org/routing.html#controller-namespaces-and-routing){:target="_blank"}
<br>Diakses tanggal: 2019/12/15
