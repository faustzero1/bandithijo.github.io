---
layout: 'post'
title: "Mengenal Single Table Inheritance dengan Devise pada Rails (Contoh 2)"
date: 2020-02-22 06:46
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

`Ruby 2.6.3` `Rails 5.2.4` `PostgreSQL 11.5`

# Prakata

**Apa itu Single Table Inheritance?**

Dapat didefinisikan sebagai tabel induk yang mewariskan sifat-sifatnya pada tabel anakan yang berelasi dengannya.

Ahahaha (^_^) definisi macam apa itu.

Abaikan.

Pada saat mengimplementasikan Single Table Inheritance (STI), saya menemukan lebih dari satu cara pada Rails. Maka dari itu, tulisan ini akan saya bagi dalam beberapa contoh.

Catatan kali ini adalah contoh kedua.

Teman-teman dapat melihat contoh pertama [di sini](/blog/rails-single-table-inheritance-contoh-1){:target="_blank"}

Kira-kira seperti ini ERD-nya.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/T1bRRy6Q/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 1 - ERD Single Table Inheritance antara user model dengan participants dan sponsors model</p>

Dari diagram di atas, saya hanya membuat satu buah tabel, yaitu users.

Tabel users ini hasil generate dari Devise.

Yak! Pada catatan kali ini, saya akan mencatat bagaimana membuat Single Table Inheritance (STI) dengan Devise.

# Sekenario

Saya berencana membuat sebuah website untuk registrasi sebuah event.

Dimana user yang mendaftar akan langsung diarahkan untuk mendaftar sebagai participant atau menjadi sponsor.

Menurut saya, ini adalah contoh yang pas untuk memnggunakan STI.

Dimana model user akan menurunkan sifatnya pada model participant dan sponsor.

# Pemecahan Masalah

Saya akan memulai dari pemasangan Devise

## Migrations

Saya akan membuat tabel users dengan menggunakan generator yang dimiliki oleh Devise.

```
$ rails g devise user
```

Generator di atas juga akan sekalian membuatkan kita model user.

```ruby
# db/migrations/20200221021307_devise_create_users.rb

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ...
      ...

      t.timestamps null: false
    end

    ...
    ...
  end
end
```

Nah, sebenarnya bisa saya modifikasi migration ini, dengan menambahkan field `:name` dan `:type`.

Namun, saya memilih untuk membuat migration untuk memanbahkan field name dan type secara satu persatu.

Tidak ada alasan, hanya untuk berlatih saja membuat migration.

```
$ rails g migration add_name_and_name_to_users
```

Kemudian, tambahkan manual `add_column` untuk `:name` dan `:type`.

```ruby
# db/migrations/20200221021551_add_name_type_to_users

class AddNameAndTypeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :type, :string
  end
end
```

Setelah itu, jalankan semua migration di atas.

```
$ rails db:migrate
```

## Models

Kemudian buat dua model untuk participant dan sponsor.

```
$ rails g model participant
$ tails g model sponsor
```

Karena saya sudah menambahkan field `:type` pada tabel users, maka kedua model ini yang akan mendapat turunan sifat dari model user dengan mengambil dari nama class dari masing-masing model.

Modifikasi kedua model ini dengan mengganti inheritance-nya dari class `ApplicationRecord` menjadi class `User`.

```ruby
# app/models/participant.rb

class Participant < User
end
```

```ruby
# app/models/sponsor.rb

class Sponsor < User
end
```

## Routes

Kemudian, pada routes untuk `:users` juga ganti menjadi dua buah untuk masing-masing model.

```ruby
# config/routes.rb

Rails.application.routes.draw do
  ...
  devise_for :participants
  devise_for :sponsors
end
```

## Views & Controller

Untuk views template, saya perlu membuat homepage dan halaman dashboard ketika user sudah melakukan sign up dan sign in.

Halaman authentikasi seperti sign up dan sign in, bisa di generate dari Devise.

Oke, langsung saya mulai dari membuat Homepage.

Saya akan mulai dengan mengenerate page controller dengan action index.

```
$ rails g controller Pages index
```

```ruby
# app/controllers/pages_controller.rb

class PagesController < ApplicationController
  def index; end
end
```

Kemudian, pada routes definisikan pages menjadi root.

Letakkan di paling atas.

```ruby
# config/routes.rb

Rails.application.routes.draw do
  root to: 'pages#index'

  devise_for :participants
  devise_for :sponsors
end
```

Selanjutnya buat dashboards controller  untuk tempat participant dan sponsor mendarat setelah sign up atau sign in.

```
$ rails g controller dashboard/dashboard index
```

```ruby
# app/controllers/dashboard/dashboard_controller.rb

class Dashboard::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index; end
end
```

Nah, saya akan mendifinisikan apabila user mengakses halaman `/dashboard`, maka, user akan langsung diarahkan sebagai participant terlebih dahulu.

```ruby
# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  devise_group :user, contains: [:participant, :sponsor]
end
```

Urutan di dalam array menjadi penentu, scope mana yang akan diprioritaskan apabila user mengakses halaman `/dashboard` apabaila belum melakukan sing up atau sign in.

Kemudian atur routenya.

```ruby
# config/routes.rb

Rails.application.routes.draw do
  root to: 'pages#index'

  devise_for :participants
  devise_for :sponsors

  namespace :dashboard do
    root to: 'dashboard#index'
  end
end
```

Selanjutnya untuk view dari Devise.

Nah, ada banyak cara yang dapat dilakukan. Mulai dari mengenerate view untuk masing-masing scope, atau mengcopy paste saja view template hasil view generate.

Saya memilih untuk mengenerate kedua scope.

```
$ rails g devise:views participant
$ rails g devise:views sponsor
```

Lalu mengedit bagian registrations new dan edit untuk menambahkan field `:name`.

```erb
<!-- app/views/participants/registrations/new.html.erb -->

<h2>Participant Sign up</h2>

<%= form_for(resource, as: resource_name, url: registration_path(resource_name)) do |f| %>
  <%= render "devise/shared/error_messages", resource: resource %>

  <div class="field">
    <%= f.label :name %><br />
    <%= f.text_field :name, autofocus: true %>
  </div>

  ...
  ...

<% end %>

<%= render "devise/shared/links" %>
```

```erb
<!-- app/views/sponsors/registrations/new.html.erb -->

<h2>Sponsors Sign up</h2>

<%= form_for(resource, as: resource_name, url: registration_path(resource_name)) do |f| %>
  <%= render "devise/shared/error_messages", resource: resource %>

  <div class="field">
    <%= f.label :name %><br />
    <%= f.text_field :name, autofocus: true %>
  </div>

  ...
  ...

<% end %>

<%= render "devise/shared/links" %>
```

Selanjutnya, tinggal memberikan ijin (permit) kepada `:name` saat melakukan sign up.

Saya akan tambahkan saja pada application controller.

```ruby
# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  devise_group :user, contains: [:participant, :sponsor]
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # If you have extra params to permit, append them to the sanitizer.
  def configure_permitted_parameters
    added_attrs = [:email, :password, :password_confirmation, :remember_me, :name]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource_or_scope)
    resource_or_scope.is_a?(User) ? dashboard_root_path : root_path
  end

  # The path used after sign in.
  def after_sign_in_path_for(resource_or_scope)
    resource_or_scope.is_a?(User) ? dashboard_root_path : root_path
  end
end
```

Saya juga menambahkan redirect path apabila user sudah melakukan sign up atau sign in untuk diarahkan ke halaman dashboard.

Nah selesai!

Sepertinya segini saja.

Untuk contoh proyeknya dapat dilihat di repo github [di sini](https://github.com/bandithijo/strong_sample_01){:target="_blank"}.

Mudah-mudahan catatan yang sederhana ini dapat bermanfaat bagi teman-teman yang memerlukan.

Terima kasih.

(^_^)


# Referensi

1. [vsmedia.co.uk/single-table-inheritance-sti-devise/](https://vsmedia.co.uk/single-table-inheritance-sti-devise/){:target="_blank"}
<br>Diakses tanggal: 2020/02/21

2. [guides.rubyonrails.org/routing.html#controller-namespaces-and-routing](https://guides.rubyonrails.org/routing.html#controller-namespaces-and-routing){:target="_blank"}
<br>Diakses tanggal: 2020/02/21

3. [api.rubyonrails.org/classes/ActiveRecord/Inheritance.html](https://api.rubyonrails.org/classes/ActiveRecord/Inheritance.html){:target="_blank"}
<br>Diakses tanggal: 2020/02/21
