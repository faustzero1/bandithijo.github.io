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
contributors: []
resume:
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

{% image https://i.postimg.cc/T1bRRy6Q/gambar-01.png | 1 | ERD Single Table Inheritance antara user model dengan participants dan sponsors model %}

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

{% shell_user %}
rails g devise user
{% endshell_user %}

Generator di atas juga akan sekalian membuatkan kita model user.

{% highlight_caption db/migrations/20200221021307_devise_create_users.rb %}
{% highlight ruby linenos %}
class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      # ...
      # ...

      t.timestamps null: false
    end

    # ...
    # ...
  end
end
{% endhighlight %}

Nah, sebenarnya bisa saya modifikasi migration ini, dengan menambahkan field `:name` dan `:type`.

Namun, saya memilih untuk membuat migration untuk memanbahkan field name dan type secara satu persatu.

Tidak ada alasan, hanya untuk berlatih saja membuat migration.

{% shell_user %}
rails g migration add_name_and_name_to_users
{% endshell_user %}

Kemudian, tambahkan manual `add_column` untuk `:name` dan `:type`.

{% highlight_caption db/migrations/20200221021551_add_name_type_to_users %}
{% highlight ruby linenos %}
class AddNameAndTypeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :type, :string
  end
end
{% endhighlight %}

Setelah itu, jalankan semua migration di atas.

{% shell_user %}
rails db:migrate
{% endshell_user %}

## Models

Kemudian buat dua model untuk participant dan sponsor.

Kita dapat memanfaatkan rails generator untuk membuat kedua model (**participant** dan **sponsor**) dengan turunan dari model **user**.

{% shell_user %}
rails g model participant --parent=User
{% endshell_user %}

{% shell_user %}
rails g model sponsor --parent=User
{% endshell_user %}

Karena saya sudah menambahkan field `:type` pada tabel users, maka kedua model ini yang akan mendapat turunan sifat dari model user dengan mengambil dari nama class dari masing-masing model.

Kalau kita buka, kedua model tersebut, class dari kedua model tersebut sudah merupakan turunan dari model **user**.

{% highlight_caption app/models/participant.rb %}
{% highlight ruby linenos %}
class Participant < User
end
{% endhighlight %}

{% highlight_caption app/models/sponsor.rb %}
{% highlight ruby linenos %}
class Sponsor < User
end
{% endhighlight %}

## Routes

Kemudian, pada routes untuk `:users` juga ganti menjadi dua buah untuk masing-masing model.

{% highlight_caption config/routes.rb %}
{% highlight ruby linenos %}
Rails.application.routes.draw do
  ...
  devise_for :participants
  devise_for :sponsors
end
{% endhighlight %}

## Views & Controller

Untuk views template, saya perlu membuat homepage dan halaman dashboard ketika user sudah melakukan sign up dan sign in.

Halaman authentikasi seperti sign up dan sign in, bisa di generate dari Devise.

Oke, langsung saya mulai dari membuat Homepage.

Saya akan mulai dengan mengenerate page controller dengan action index.

{% shell_user %}
rails g controller Pages index
{% endshell_user %}

{% highlight_caption app/controllers/pages_controller.rb %}
{% highlight ruby linenos %}
class PagesController < ApplicationController
  def index; end
end
{% endhighlight %}

Kemudian, pada routes definisikan pages menjadi root.

Letakkan di paling atas.

{% highlight_caption config/routes.rb %}
{% highlight ruby linenos %}
Rails.application.routes.draw do
  root to: 'pages#index'

  devise_for :participants
  devise_for :sponsors
end
{% endhighlight %}

Selanjutnya buat dashboards controller  untuk tempat participant dan sponsor mendarat setelah sign up atau sign in.

{% shell_user %}
rails g controller dashboard/dashboard index
{% endshell_user %}

{% highlight_caption app/controllers/dashboard/dashboard_controller.rb %}
{% highlight ruby linenos %}
class Dashboard::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index; end
end
{% endhighlight %}

Nah, saya akan mendifinisikan apabila user mengakses halaman `/dashboard`, maka, user akan langsung diarahkan sebagai participant terlebih dahulu.

{% highlight_caption app/controllers/application_controller.rb %}
{% highlight ruby linenos %}
class ApplicationController < ActionController::Base
  devise_group :user, contains: [:participant, :sponsor]
end
{% endhighlight %}

Urutan di dalam array menjadi penentu, scope mana yang akan diprioritaskan apabila user mengakses halaman `/dashboard` apabaila belum melakukan sing up atau sign in.

Kemudian atur routenya.

{% highlight_caption config/routes.rb %}
{% highlight ruby linenos %}
Rails.application.routes.draw do
  root to: 'pages#index'

  devise_for :participants
  devise_for :sponsors

  namespace :dashboard do
    root to: 'dashboard#index'
  end
end
{% endhighlight %}

Selanjutnya untuk view dari Devise.

Nah, ada banyak cara yang dapat dilakukan. Mulai dari mengenerate view untuk masing-masing scope, atau mengcopy paste saja view template hasil view generate.

Saya memilih untuk mengenerate kedua scope.

{% shell_user %}
rails g devise:views participant
{% endshell_user %}

{% shell_user %}
rails g devise:views sponsor
{% endshell_user %}

Lalu mengedit bagian registrations new dan edit untuk menambahkan field `:name`.

{% highlight_caption app/views/participants/registrations/new.html.erb %}
{% highlight eruby linenos %}
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
{% endhighlight %}

{% highlight_caption app/views/sponsors/registrations/new.html.erb %}
{% highlight eruby linenos %}
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
{% endhighlight %}

Selanjutnya, tinggal memberikan ijin (permit) kepada `:name` saat melakukan sign up.

Saya akan tambahkan saja pada application controller.

{% highlight_caption app/controllers/application_controller.rb %}
{% highlight ruby linenos %}
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
{% endhighlight %}

Saya juga menambahkan redirect path apabila user sudah melakukan sign up atau sign in untuk diarahkan ke halaman dashboard.

Nah selesai!

Sepertinya segini saja.

Untuk contoh proyeknya dapat dilihat di repo github [di sini](https://github.com/bandithijo/strong_sample_01){:target="_blank"}.

Mudah-mudahan catatan yang sederhana ini dapat bermanfaat bagi teman-teman yang memerlukan.

Terima kasih.

(^_^)

# Tambahan

1. [**Membuat Relasi dengan Hanya Salah Satu Type pada Single Table Inheritance Model di Rails**](/blog/relasi-dengan-salah-satu-type-pada-sti-pada-rails){:target="_blank"}


# Referensi

1. [vsmedia.co.uk/single-table-inheritance-sti-devise/](https://vsmedia.co.uk/single-table-inheritance-sti-devise/){:target="_blank"}
<br>Diakses tanggal: 2020/02/21

2. [guides.rubyonrails.org/routing.html#controller-namespaces-and-routing](https://guides.rubyonrails.org/routing.html#controller-namespaces-and-routing){:target="_blank"}
<br>Diakses tanggal: 2020/02/21

3. [api.rubyonrails.org/classes/ActiveRecord/Inheritance.html](https://api.rubyonrails.org/classes/ActiveRecord/Inheritance.html){:target="_blank"}
<br>Diakses tanggal: 2020/02/21
