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
tags: ['Tips', 'Rails']
pin:
hot:
contributors: []
description:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prerequisite

`Ruby 2.6.3` `Rails 5.2.4` `PostgreSQL 11.5`

# Prakata

Kali ini saya ingin mencatat mengenai web aplikasi yang memiliki tampilan frontend terpisah antara user dan admin. Tentu saja dengan menggunakan Rails.

Contoh mudahnya seperti aplikasi blog, Wordpress atau Blogspot.

Kedua aplikasi ini disebut CMS (*Content Management System*). Di mana web aplikasi ini mempunyai dua buah tampilan yang berbeda antara tampilan untuk pengunjung dan tampilan untuk author (penulis) atau admin.

Nah, kegunaan pemisahan User dengan Admin pada catatan kali ini, nantinya dapat dimanfaatkan untuk membuat web aplikasi seperti CMS.

# Eksekusi

Kali ini saya sedikit rajin.

Saya akan mencatat prosesnya dari awal project dibuat. Hehehe.

## Inisiasi Project

Saya akan membuat project baru menggunakan Rails 5.2.4 dengan PostgreSQL sebagai database engine.

{% shell_user %}
rails _5.2.4_ new blog_spot -d postgresql
{% endshell_user %}

Kalau proses pembuatan sudah selesai, masuk ke dalam project.

{% shell_user %}
cd blog_spot
{% endshell_user %}

Periksa spesifikasi versi Rails dan Ruby.

{% shell_user %}
ruby -v
{% endshell_user %}

<pre>
ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-linux]
</pre>

{% shell_user %}
rails -v
{% endshell_user %}

<pre>
Rails 5.2.4
</pre>

Selanjutnya create database dengan perintah berikut ini.

{% shell_user %}
rails db:create
{% endshell_user %}

```
Created database 'blog_spot_development'
Created database 'blog_spot_test'
```

Lalu, jalankan Rails server untuk sekedar melihat apakah project berhasil dijalankan atau tidak.

{% shell_user %}
rails s
{% endshell_user %}

{% image https://i.postimg.cc/QdHVbnLy/gambar-01.png | 1 | Default Welcome Page pada Rails Project %}

Yay! Berhasil.

Entah mengapa saya suka melihat Default Rails Welcome Page ini. Dari sedikit web framework yang sudah saya coba seperti Codeigniter, Laravel, Django dan React. Rails memiliki tampilan Default Welcome Page yang menurut saya paling menarik.

## Devise Gem

Devise adalah gem yang akan saya gunakan untuk menghandle authentication system.

Pasang pada `Gemfile`.

{% highlight_caption Gemfile %}
{% highlight ruby linenos %}

# ...
# ...
gem 'devise', '~> 4.7', '>= 4.7.1'
{% endhighlight %}

Install Devise gem yang baru saja kita pasang.

{% shell_user %}
bundle install
{% endshell_user %}

Jalankan generator yang disediakan oleh Devise untuk menginisiasi file config yang disediakan oleh Devise.

{% shell_user %}
rails generate devise:install
{% endshell_user %}

<pre>
Running via Spring preloader in process 349251
     <span class="is-success">create</span>  config/initializers/devise.rb
     <span class="is-success">create</span>  config/locales/devise.en.yml
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

{% shell_user %}
rails g devise admin
{% endshell_user %}

<pre>
Running via Spring preloader in process 368446
      <span class="is-white">invoke</span>  active_record
      <span class="is-success">create</span>    db/migrate/20191216044109_devise_create_admins.rb
      <span class="is-success">create</span>    app/models/admin.rb
      <span class="is-white">invoke</span>    test_unit
      <span class="is-success">create</span>      test/models/admin_test.rb
      <span class="is-success">create</span>      test/fixtures/admins.yml
      <span class="is-success">insert</span>    app/models/admin.rb
       <span class="is-success">route</span>  devise_for :admins
</pre>

Kemudian untuk model user.

{% shell_user %}
rails g devise user
{% endshell_user %}

<pre>
Running via Spring preloader in process 368446
      <span class="is-white">invoke</span>  active_record
      <span class="is-success">create</span>    db/migrate/20191216044641_devise_create_users.rb
      <span class="is-success">create</span>    app/models/user.rb
      <span class="is-white">invoke</span>    test_unit
      <span class="is-success">create</span>      test/models/user_test.rb
      <span class="is-success">create</span>      test/fixtures/users.yml
      <span class="is-success">insert</span>    app/models/user.rb
       <span class="is-success">route</span>  devise_for :users
</pre>

Lalu jalankan migration-nya.

{% shell_user %}
rails db:migrate
{% endshell_user %}

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

{% shell_user %}
rails db:migrate:status
{% endshell_user %}

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

{% highlight_caption config/routes.rb %}
{% highlight ruby linenos %}
Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
end
{% endhighlight %}

Cek route yang tersedia pada Browser.

<pre class="url">
http://localhost:3000/rails/info/routes
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
│  │  │  ├─ <mark>about_controller.rb</mark>
│  │  │  ├─ <mark>contact_controller.rb</mark>
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

{% highlight_caption app/controllers/admins_controller.rb %}
{% highlight ruby linenos %}
class AdminsController < ApplicationController
  layout :admins
end
{% endhighlight %}

{% highlight_caption app/controllers/admins/dashboard_controller.rb %}
{% highlight ruby linenos %}
class Admins::DashboardController < AdminsController
  def index; end
end
{% endhighlight %}

Untuk Controller Namespaces pada Users.

{% highlight_caption app/controllers/users_controller.rb %}
{% highlight ruby linenos %}
class UsersController < ApplicationController
end
{% endhighlight %}

{% highlight_caption app/controllers/users/dashboard_controller.rb %}
{% highlight ruby linenos %}
class Users::DashboardController < UsersController
  def index; end
end
{% endhighlight %}

Karena saya ingin membuat tampilan login yang berbeda antara Admin dengan User. Saya perlu mengaturnya pada `application_controller.rb`.[<sup>3</sup>](https://github.com/plataformatec/devise/wiki/How-To:-Create-custom-layouts){:target="_blank"}

{% highlight_caption app/controllers/application_controller.rb %}
{% highlight ruby linenos %}
class ApplicationController < ActionController::Base
  layout :layout_by_resource

  private

  def layout_by_resource
    if devise_controller? && resource_name == :admin
      'admins_devise'
    else
      'users'
    end
  end
end
{% endhighlight %}

Saya juga membuat `homepage_controller.rb` untuk menghandle halaman Homepage yang saya letakkan pada direktori `public/`

{% highlight_caption app/controllers/public/homepage_controller.rb %}
{% highlight ruby linenos %}
class Public::HomepageController < ApplicationController
  def index; end
end
{% endhighlight %}

Serta halaman About dan Contact.

{% highlight_caption app/controllers/public/about_controller.rb %}
{% highlight ruby linenos %}
class Public::AboutController < ApplicationController
  def index; end
end
{% endhighlight %}

{% highlight_caption app/controllers/public/contact_controller.rb %}
{% highlight ruby linenos %}
class Public::ContactController < ApplicationController
  def index; end
end
{% endhighlight %}

Langsung saja membuat action `:index`, yang nantinya akan digunakan untuk menampilkan text sederhana pada view template.

## Route

Kemudian, untuk routingnya akan seperti ini.

{% highlight_caption config/routes.rb %}
{% highlight ruby linenos %}
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
{% endhighlight %}

Pada block Public, saya menggunakan `scope` karena ingin membuat url yang singkat, seperti ini.

<pre class="url">
http://localhost:3000/about
</pre>

Kalau menggunakan `namespace` maka url yang dihasilkan akan seperti ini.

<pre class="url">
http://localhost:3000/public/about
</pre>

Maka dari itu, saya menggunakan `scope` untuk controller yang berada pada module Public

Selanjutnya ke view template.

## View

Berikut ini struktur direktorinya.

<pre>
├─ app/
│  ├─ assets/
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
│     │  ├─ <mark>admins_devise.html.erb</mark>
│     │  ├─ application.html.erb
│     │  ├─ mailer.html.erb
│     │  ├─ mailer.text.erb
│     │  └─ <mark>users.html.erb</mark>
│     ├─ <mark>public/</mark>
│     │  ├─ <mark>about/</mark>
│     │  │  └─ <mark>index.html.erb</mark>
│     │  ├─ <mark>contact/</mark>
│     │  │  └─ <mark>index.html.erb</mark>
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

{% highlight_caption app/views/layouts/application.html.erb %}
{% highlight eruby linenos %}
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
{% endhighlight %}

{% highlight_caption app/views/layouts/admins.html.erb %}
{% highlight eruby linenos %}
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
{% endhighlight %}

{% highlight_caption app/views/layouts/users.html.erb %}
{% highlight eruby linenos %}
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
{% endhighlight %}

Saya membuat halaman login yang berbeda antara Admin dengan User.

Halamn login untuk User akan menggunakan template dari Devise, sedangkan Admin, akan saya custom sendiri. Seperti di bawah ini.

{% highlight_caption app/views/layouts/admins_devise.html.erb %}
{% highlight eruby linenos %}
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

    <!-- Admin Custom Sign In -->
    <% if controller_name == 'sessions' %>
      <h2>Hello, Admin</h2>
    <% elsif controller_name == 'registrations' %>
      <h2>Become an Admin</h2>
    <% end %>
    <div>
    <% if controller_name == 'sessions' %>
      <%= form_for(resource, as: resource_name, url: session_path(resource_name)) do |f| %>
        <%= f.email_field :email, autofocus: true, autocomplete: "email", class: "", placeholder: "Email" %>
        <%= f.password_field :password, autocomplete: "current-password", class: "", placeholder: "Password" %>
        <%= f.submit "Sign In", class: "" %>
      <% end %>
    <% elsif controller_name == 'registrations' %>
      <%= form_for(resource, as: resource_name, url: registration_path(resource_name)) do |f| %>
        <%= f.email_field :email, autofocus: true, autocomplete: "email", class: "", placeholder: "Email" %>
        <%= f.password_field :password, autocomplete: "current-password", class: "", placeholder: "Password" %>
        <%= f.submit "Sign Up", class: "" %>
      <% end %>
    <% end %>
    </div>
    <div>
      <% unless controller_name == 'registrations' %>
        <%= link_to "Become an Admin", new_admin_registration_path, class: "" %>
      <% end %>
    </div>
    <!-- END Admin Custom Sign In -->

  </body>
</html>
{% endhighlight %}

Pada keempat file view template di atas, saya menambahkan render partial untuk menu navigasi.

Saya juga mengarahkan `stylesheet_link_tag` dan `javascript_include_tag` pada masing-masing direktori asset (`application`, `users`, `admins`) yang nantinya akan saya tambahkan setelah selesai dengan strukturl html.

Oke, selanjutnya file render partial untuk menu navigasi.

{% highlight_caption app/views/layouts/admins/_nav.html.erb %}
{% highlight eruby linenos %}
<nav>
  <% unless controller_name == 'homepage' && action_name == 'index' %>
      <%= link_to "Homepage", root_path %> |
  <% end %>
  <%= link_to "About", about_index_path, class: "#{'active' if controller_name == 'about'}" %> |
  <%= link_to "Contact", contact_index_path, class: "#{'active' if controller_name == 'contact'}" %> |
  <% if admin_signed_in? %>
    <%= link_to "Admin Dashboard", admins_root_path, class: "#{'active' if controller_name == 'dashboard'}" %> |
    <%= link_to "Log Out", destroy_admin_session_path, method: :delete %>
  <% else %>
    <%= link_to "Log In", admin_session_path, class: "#{'active' if controller_name == 'sessions'}" %>
    | <%= link_to "User?", user_session_path %>
  <% end %>
</nav>
{% endhighlight %}

{% highlight_caption app/views/layouts/users/_nav.html.erb %}
{% highlight eruby linenos %}
<nav>
  <% unless controller_name == 'homepage' && action_name == 'index' %>
      <%= link_to "Homepage", root_path %> |
  <% end %>
  <%= link_to "About", about_index_path, class: "#{'active' if controller_name == 'about'}" %> |
  <%= link_to "Contact", contact_index_path, class: "#{'active' if controller_name == 'contact'}" %> |
  <% if user_signed_in? %>
    <%= link_to "User Dashboard", users_root_path, class: "#{'active' if controller_name == 'dashboard'}" %> |
    <%= link_to "Log Out", destroy_user_session_path, method: :delete %>
  <% elsif admin_signed_in? %>
    <%= link_to "Admin Dashboard", admins_root_path, class: "#{'active' if controller_name == 'dashboard'}" %> |
    <%= link_to "Log Out", destroy_admin_session_path, method: :delete %>
  <% else %>
    <%= link_to "Log In", user_session_path, class: "#{'active' if controller_name == 'sessions'}" %>
    | <%= link_to "Admin?", admin_session_path %>
  <% end %>
</nav>
{% endhighlight %}

Selanjutnya Homepage.

{% highlight_caption app/views/public/homepage/index.html.erb %}
{% highlight eruby linenos %}
<header>
  <h1>Homepage</h1>
</header>

<div>
  <p>
    => <%= controller_name %>#<%= action_name %>
  </p>
</div>
{% endhighlight %}

Halaman About dan Contact.

{% highlight_caption app/views/public/about/index.html.erb %}
{% highlight eruby linenos %}
<header>
  <h1>About</h1>
</header>

<div>
  <p>
    => <%= controller_name %>#<%= action_name %>
  </p>
</div>
{% endhighlight %}

{% highlight_caption app/views/public/contact/index.html.erb %}
{% highlight eruby linenos %}
<header>
  <h1>Contact</h1>
</header>

<div>
  <p>
    => <%= controller_name %>#<%= action_name %>
  </p>
</div>
{% endhighlight %}

Kemudian, halan Dashboard untuk Admin dan User.

{% highlight_caption app/views/admins/dashboard/index.html.erb %}
{% highlight eruby linenos %}
<header>
  <h1>DashBoard Admin</h1>
</header>

<div>
  Admin: <%= current_admin.email %>
</div>
{% endhighlight %}

{% highlight_caption app/views/users/dashboard/index.html.erb %}
{% highlight eruby linenos %}
<header>
  <h1>DashBoard User</h1>
</header>

<div>
  User: <%= current_user.email %>
</div>
{% endhighlight %}

Sekarang tinggal Stylesheet dan Javascript.

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
│  ├─ ...
│  ├─ ...
...
</pre>

Mengikuti struktur direktori di atas.

## Javascript Assets

Pada `javascripts/application.js` tambahkan `user.js`. Karena saya akan menggunakan sebagai satu kesatuan assets.

{% highlight_caption app/assets/javascripts/application.js %}
{% highlight javascript linenos %}
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require users
{% endhighlight %}

Lalu pada masing-masing file Javascript untuk Admin dan User, tambahkan `rails-ujs` agar Devise dapat Logout.

Kalau tidak menambahkan ini, Devise akan mengalami routing error saat melakukan Logout.

{% highlight_caption app/assets/javascripts/admins.js %}
{% highlight javascript linenos %}
//= require rails-ujs
{% endhighlight %}

{% highlight_caption app/assets/javascripts/users.js %}
{% highlight javascript linenos %}
//= require rails-ujs
{% endhighlight %}

Untuk `admins/custom.js` dan `users/custom.js` digunakan untuk Javascript buatan kita sendiri. Namun karena masih kosong, jadi tidak saya contohkan.

## Stylesheet Assets

Pada `stylesheets/application.css` tambahkan `user.css`. Karena saya akan menggunakan sebagai satu kesatuan assets.

Saya menghapus `*=require ` file yang lain agar file stylesheet tidak saling tumpang tindih dan dipanggil dimana-mana.

{% highlight_caption app/assets/stylesheets/application.css %}
{% highlight css linenos %}
/*
 *= require users
 */
{% endhighlight %}

Kemudian pada `admins.css` dan `users.css` saya akan mengarahkan asset pada `custom.css` di masing-masing direktori.

File `custom.css` inilah yang nantinya akan digunakan apabila ingin mengkostumisasi style pada Admin atau User view.

{% highlight_caption app/assets/stylesheets/admins.css %}
{% highlight css linenos %}
@import 'admins/custom.css';
{% endhighlight %}

{% highlight_caption app/assets/stylesheets/users.css %}
{% highlight css linenos %}
@import 'users/custom.css';
{% endhighlight %}

Selanjutnya, isi dari `../admins/custom.css` dan `../users/custom.css`.

Untuk contoh kali ini, saya membuat style antar Admin dan User menjadi terlihat serupa.

Namun, pada project yang sesungguhnya, kedua file ini akan memiliki isi yang berbeda, sesuai dengan keperluan.

{% highlight_caption app/assets/stylesheets/admins/custom.css %}
{% highlight css linenos %}
h1,h2 {
  color: #c52f24;
}

div {
  margin: 5px;
}

a {
  color: #c52f24;
  text-decoration: none;
  border-bottom: 1px dotted #c52f24;
}

nav {
  margin: 5px;
}

.active {
  font-weight: bold;
}
{% endhighlight %}

{% highlight_caption app/assets/stylesheets/users/custom.css %}
{% highlight css linenos %}
h1,h2 {
  color: #c52f24;
}

div {
  margin: 5px;
}

a {
  color: #c52f24;
  text-decoration: none;
  border-bottom: 1px dotted #c52f24;
}

nav {
  margin: 5px;
}

.active {
  font-weight: bold;
}
{% endhighlight %}

Selanjutnya, saya perlu untuk menambahkan konfigurasi tambahan untuk **Precompile Additional Assets**, karena saya sudah membuat custom assets untuk admins dan users.

Buka file `config/initializers/assets.rb`.

{% highlight_caption config/initializers/assets.rb %}
{% highlight ruby linenos %}
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w( admins.js admins.css users.js users.css )
{% endhighlight %}

*Uncomment* dan tambahkan `users.js` dan `users.css`.

Oke, saya rasa, sudah semuanya.

Sekarang web aplikasi siap untuk di jalankan.

<pre>
$ <b>rails s</b>
</pre>

Kira-kira, seperti inilah hasilnya.

{% image https://i.postimg.cc/15mvFB1T/gambar-02.gif | 2 | Public Page %}

{% image https://i.postimg.cc/NjLbJ0Mk/gambar-03.gif | 3 | User Login, Register Dashboard %}

{% image https://i.postimg.cc/pXsqJj2d/gambar-04.gif | 4 | Admin Login dan Register %}

Selesai!

Kerangka untuk membuat Web Aplikasi yang memiliki Halaman Public, Admin Dashboard dan User Dashboard sudah selesai.

Teman-teman dapat melihat source codenya pada halaman GitHub [di sini](https://github.com/bandithijo/blog_spot){:target="_blank"}.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)









# Referensi

1. [github.com/plataformatec/devise](https://github.com/plataformatec/devise){:target="_blank"}
<br>Diakses tanggal: 2019/12/15

2. [guides.rubyonrails.org/routing.html#controller-namespaces-and-routing](https://guides.rubyonrails.org/routing.html#controller-namespaces-and-routing){:target="_blank"}
<br>Diakses tanggal: 2019/12/15

3. [github.com/plataformatec/devise/wiki/How-To:-Create-custom-layouts](https://github.com/plataformatec/devise/wiki/How-To:-Create-custom-layouts){:target="_blank"}
<br>Diakses tanggal: 2019/12/15
