---
layout: 'post'
title: "Navigation Bar Global Menu Preferences pada Rails"
date: 2019-12-21 10:23
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

Sebenarnya saya kurang memahami harus memberikan judul seperti apa untuk catatan kali ini.

Tapi, mudah-mudahan judul yang saya berikan saat ini, dapat mewakili isi dari tulisan yang ingin saya dokumentasikan.

Mungkin saya akan mulai dengan memberikan ilustrasi gambar.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/jdv4sB52/gambar-01.gif" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 1 - Navigation Bar dengan Menu Language dan Currency Preferences</p>

Nah, sudah sedikit terbayang kan.

Jadi, dropdown menu tersebut mempunyai fungsi seperti ini:

1. Dapat mengganti language dan currency di setiap halaman.
2. Berfungsi pada user maupun guest
3. Apabila guest melakukan registrasi, maka language atau currency yang mereka pilih juga akan ikut tersimpan.

# Permasalahan

Awalnya saya berfikir, "Bagaimana bisa mengganti language dan currency yang merupakan field atau entitas dari tabel users pada setiap halaman?"

Selama ini, saya hanya melakukan action edit pada controller dan view yang bersangkutan dengan dimana field atau entitas tersebut berada.

Misal, pada halaman edit user. Di dalamnya terdapat input field untuk mengganti language dan currency.

Sedangkan, fungsi navbar ini harus dapat melakukan update data saat language dan currency dipilih pada semua halaman di dalam web.

Bagi Junior Rails Developer seperti saya yang masih anak kemarin sore, ini merupakan hal yang sangat baru.

Saking bersemangatnya, rasanya seperti ada tablet Redoxon yang di larutkan di dalam dada. Wkwkwk

# Pemecahan Masalah

Sebagai sekenario, saya sudah memiliki tabel `users` dengan field `locales:string` untuk menyimpan data language dan field `rate:string` untuk menyimpan data currency.

## Schema

{% highlight_caption db/schema.rb %}
{% highlight ruby linenos %}
create_table "users", force: :cascade do |t|
  # ...
  # ...
  # ...
  t.string "locale", default: "en"
  t.string "rate", default: "MYR"
  # ...
  # ...
  # ...
end
{% endhighlight %}

## Controller

Karena `locale` dan `rate` terdapat pada tabel `users` maka kita akan menambahkan kedua controller tersebut untuk users.

Saya akan menggunakan struktur seperti yang pada catatan sebelum-sebelumnya, yaitu "Controller Namespaes and Routing".[<sup>1</sup>](#referensi) dengan tujuan untuk memisahkan Admin dan User.

Oh ya, pada catatan kali ini, `application_controller.rb` yang akan menghandle users. Tidak seperti catatan sebelumnya yang saya pisahkan. Tujuannya agar proses pencatatan menjadi lebih ringkas. Wkwkwk

Masukkan kedua controller yang akan kita buat ke dalam direktori `users/` agar nantinya mudah untuk di-*maintain*.

Kira-kira seperti ini struktur file dan direktorinya.

<pre>
├─ app/
│  ├─ assets/
│  ├─ channels/
│  ├─ controllers/
│  │  ├─ admins/
│  │  ├─ concerns/
│  │  ├─ <mark>users/</mark>
│  │  │  ├─ <mark>locales_controller.rb</mark>
│  │  │  └─ <mark>rates_controller.rb</mark>
│  │  ├─ admins_controller.rb
│  │  └─ application_controller.rb
│  ├─ ...
│  ...
├─ ...
...
</pre>

Berikut ini isi dari file-file tersebut.

{% highlight_caption app/controllers/users/locales_controller.rb %}
{% highlight ruby linenos %}
class Users::LocalesController < ApplicationController
  before_action :authenticate_user!

  def update
    if current_user.update(locale_param)
      redirect_to request.referer, notice: t('navbar.locale_updated')
    else
      redirect_to request.referer, notice: t('navbar.locale_failed_updated')
    end
  end

  private

  def locale_param
    params.permit(:locale)
  end
end
{% endhighlight %}

{% highlight_caption app/controllers/users/rates_controller.rb %}
{% highlight ruby linenos %}
class Users::RatesController < ApplicationController
  before_action :authenticate_user!

  def update
    if current_user.update(rate_param)
      redirect_back request.referer, notice: t('navbar.rate_updated')
    else
      redirect_back request.referer, notice: t('navbar.rate_failed_updated')
    end
  end

  private

  def rate_param
    params.permit(:rate)
  end
end
{% endhighlight %}

Oh iya, karena catatan kali ini berhubungan dengan bahasa (*locale*), maka saya akan menyinggung sedikit penggunaan **Rails Internationalization (I18n) API** [<sup>2</sup>](#referensi) untuk fungsi language preferences.

Pada dua controller di atas. Saya sudah menggunakan helper i18n pada object `:notice`, `t('...')`, yang nantinya akan memberikan notifikasi apakah proses perubahan berhasil atau tidak.

Oke langsung saja, saya buat dulu file `en.yml`.

{% highlight_caption config/locales/en.yml %}
{% highlight yaml linenos %}
en:
  navbar:
    rate_updated: "Your currency rate has been updated"
    rate_failed_update: "Failed to update your currency rate"
    locale_updated: "Your default language has been updated"
    locale_failed_update: "Failed to update your default language"
{% endhighlight %}

Karena saya juga menggunakan bahasa Mandarin, maka saya akan buat juga file `ch.yml`.

{% highlight_caption config/locales/ch.yml %}
{% highlight yaml linenos %}
en:
  navbar:
    rate_updated: "您的货币汇率已更新"
    rate_failed_update: "无法更新您的货币汇率"
    locale_updated: "您的默认语言已更新"
    locale_failed_update: "无法更新您的默认语言"
{% endhighlight %}

Selanjutnya, saya akan mendifinisikan dimana **translation load path**, **permit available locale**, dan **default locale** yang digunakan di `config/initializers/locale.rb`.

{% highlight_caption config/initializers/locale.rb %}
{% highlight ruby linenos %}
# Where the I18n library should search for translation files
I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]

# Permitted locales available for the application
I18n.available_locales = ['en', 'ch']

# Set default locale to something other than :en
I18n.default_locale = 'en'
{% endhighlight %}

Selanjutnya, saya akan mengkonfigurasi locale pada `application_controller.rb` untuk menangani semua permintaan terhadap locale.

Oh ya, sekalian untuk rate preferences juga.

{% highlight_caption app/controllers/application_controller.rb %}
{% highlight ruby linenos %}
class ApplicationController < ActionController::Base
  before_action :set_rate
  around_action :set_locale

  private

  def set_rate
    @rate = params[:rate]
  end

  def set_locale(&action)
    locale = current_user.try(:locale) || params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    current_user ? {locale: I18n.locale} : {locale: I18n.locale, rate: @rate}
  end
end
{% endhighlight %}

`current_user` adalah object yang disediakan oleh Devise gem untuk user yang sudah loginmelakukan login.

Saya menggunakan helper `default_url_options` untuk membuat url form menjadi lebih mudah dibaca.

<pre class="url">
http://localhost:3000/en/users
</pre>

Kalau saya tidak menggunakan helper tersebut, maka url secara default akan seperti ini.

<pre class="url">
http://localhost:3000/users?locale=en
</pre>

Nah, pasti akan lebih memilih url form yang atas.


## Route

Kemudian pada bagian routing, tinggal mengikuti controller.

{% highlight_caption config/routes.rb %}
{% highlight ruby linenos %}
Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    # ...
    # ...

    namespace :users do
      # ...
      # ...
      resources :rates, only: %w[update]
      resources :locales, only: %w[update]
    end
  end

  namespace :admins do
    # ...
    # ...
  end
end
{% endhighlight %}

Blok `scope "(:locale)", locale: ...` dimaksudkan untuk membuat url form menjadi seperti yang saya sebutkan di atas.

Sehingga blok-blok routing yang lain, harus dimasukkan ke dalam blok ini agar memiliki url form yang sama.

Karena Admin tidak memerlukan url form yang bagus, maka saya keluarkan saja dari blok tersebut.

Selanjutnya, tinggal membuat view template.

## View

Seperti biasa, stylesheet pada catatan ini hanya sebagai contoh dan merupakan *dummy*. Jadi, akan tidak sesuai dengan yang ada pada ilustrasi gambar.

Hal ini dimaksudkan agar kode hanya terkonsentrasi pada blok **erb** yang berhubungan dengan topik yang sedang saya bahas.

Seperti yang tertulis pada judul, saya akan membuat menu ini pada navigation bar yang biasanya ada pada posisi atas dari halaman.

Struktur file dan direktorinya seperti ini.

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
│     ├─ admins/
│     ├─ layouts/
│     │  ├─ admins/
│     │  ├─ <mark>users/</mark>
│     │  │  ├─ <mark>navbar/</mark>
│     │  │  │  ├─ <mark>_locale.html.erb</mark>
│     │  │  │  └─ <mark>_rate.html.erb</mark>
│     │  │  ├─ <mark>_flash_message.html.erb</mark>
│     │  │  └─ <mark>_navbar.html.erb</mark>
│     │  ├─ admins.html.erb
│     │  ├─ admins_devise.html.erb
│     │  ├─ application.html.erb
│     │  ├─ mailer.html.erb
│     │  └─ mailer.text.erb
│     └─ users/
├─ ...
...
</pre>

Saya mulai dari membuat render partial dari navigation bar pada `application.html.erb`.

{% highlight_caption app/views/layouts/application.html.erb %}
{% highlight eruby linenos %}
<!DOCTYPE html>
<html>
  <head>
    <title>BANDITHIJO.COM</title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <%= render 'layouts/users/navbar' %>
    <%= render 'layouts/users/flash_message' %>
    <%= yield %>
  </body>
</html>
{% endhighlight %}

Berikut ini isi dari file `_navbar.html.erb`.

Saya membuat render partial untuk blok language dan currency.

{% highlight_caption app/views/layouts/users/_navbar.html.erb %}
{% highlight eruby linenos %}
<nav class="navbar navbar-expand-xl">
  <!-- Right Menu -->
  <div class="collapse navbar-collapse" id="navbar4">
    <ul class="navbar-nav ml-auto justify-content-end flex-grow-1 font-family-medium">
      <li class="nav-item d-flex">
        <!-- Community menu -->
      </li>
      <li class="nav-item d-flex">
        <!-- Promo menu -->
      </li>
      <li class="nav-item d-flex">
        <!-- Help menu -->
      </li>

      <!-- Dropdown Language Icon -->
      <li class="nav-item d-flex dropdown">

        <!-- For user -->
        <% if user_signed_in? %>
          <% unless current_user.locale == "ch" %>
            <a class="nav-link align-self-center" href="#" id="dropdown-language" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <%= image_tag("label/flag/us.svg", width: "20", height: "20") %>
              ENG
              <span class="icon-dropdown align-middle"></span>
            </a>
          <% else %>
            <a class="nav-link align-self-center" href="#" id="dropdown-language" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <%= image_tag("label/flag/ch.svg", width: "20", height: "20") %>
              CNY
              <span class="icon-dropdown"></span>
            </a>
          <% end %>
        <!-- For Guest -->
        <% else %>
          <% unless current_page?(locale: "ch") %>
            <a class="nav-link align-self-center" href="#" id="dropdown-language" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <%= image_tag("label/flag/us.svg", width: "20", height: "20") %>
              ENG
              <span class="icon-dropdown"></span>
            </a>
          <% else %>
            <a class="nav-link align-self-center" href="#" id="dropdown-language" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <%= image_tag("label/flag/ch.svg", width: "20", height: "20") %>
              CNY
              <span class="icon-dropdown"></span>
            </a>
          <% end %>
        <% end %>
        <!-- END Dropdown Language Icon -->

        <!-- Content of Dropdown List Language and Currency -->
        <div class="dropdown-menu border-0 rounded">
          <div class="row no-gutters">

            <!-- Language Preferences -->
            <%= render 'layouts/users/navbar/locale' %>
            <!-- END Language Preferences -->

            <!-- Currency Preferences -->
            <%= render 'layouts/users/navbar/rate' %>
            <!-- END Currency Preferences -->

          </div>
        </div>
      </li>
      <!-- END Dropdown Language Icon -->

      <!-- Dropdown User Menu -->
      ...
      ...

    </ul>
  </div>
  <!-- END Right Menu -->
</nav>
{% endhighlight %}

{% highlight_caption app/views/layouts/users/navbar/_locale.html.erb %}
{% highlight eruby linenos %}
<div class="col-md-auto border-bottom">
  <span>Language</span>
  <!-- Change language for user -->
  <% if user_signed_in? %>
    <%= button_to users_locale_path(current_user, locale: "en"), method: :put, class: "dropdown-item", style: "outline:none" do %>
      <% if current_user.locale == "en" %>
        <i class="icon-check-selected"></i>
      <% else %>
        <i class="icon-check-none"></i>
      <% end %>
      <span class="text-normal">
        <%= image_tag("label/flag/us.svg", class: "mr-1", width: "20", height: "20") %>
        English
      </span>
    <% end %>
    <%= button_to users_locale_path(current_user, locale: "ch"), method: :put, class: "dropdown-item", style: "outline:none" do %>
      <% if current_user.locale == "ch" %>
        <i class="icon-check-selected"></i>
      <% else %>
        <i class="icon-check-none"></i>
      <% end %>
      <span class="text-normal">
        <%= image_tag("label/flag/ch.svg", class: "mr-1", width: "20", height: "20") %>
        Chinese
      </span>
    <% end %>
  <!-- Change language for guest -->
  <% else %>
    <%= link_to({locale: "en"}, class: "dropdown-item #{"active" if current_page?(locale: "en") || current_page?(locale: "")}") do %>
      <%= image_tag("label/flag/us.svg", class: "mr-1", width: "20", height: "20") %>
      English
    <% end %>
    <%= link_to({locale: "ch"}, class: "dropdown-item #{"active" if current_page?(locale: "ch")}") do %>
      <%= image_tag("label/flag/ch.svg", class: "mr-1", width: "20", height: "20") %>
      Chinese
    <% end %>
  <% end %>
</div>
{% endhighlight %}

{% highlight_caption app/views/layouts/users/navbar/_rate.html.erb %}
{% highlight eruby linenos %}
<div class="col-md-auto px-2">
  <span><%= t("navbar_menu.currency_title") %></span>
  <!-- Change currency for user -->
  <% if user_signed_in? %>
    <%= button_to users_rate_path(current_user), params: {:rate => "MYR"}, method: :put, class: "dropdown-item", style: "outline:none" do %>
      <% if current_user.rate == "MYR" %>
        <i class="icon-check-selected"></i>
      <% else %>
        <i class="icon-check-none"></i>
      <% end %>
      MYR
      <span class="text-normal">
        Malaysian Ringgit
      </span>
    <% end %>
    <%= button_to users_rate_path(current_user), params: {:rate => "USD"}, method: :put, class: "dropdown-item", style: "outline:none" do %>
      <% if current_user.rate == "USD" %>
        <i class="icon-check-selected"></i>
      <% else %>
        <i class="icon-check-none"></i>
      <% end %>
      USD
      <span class="text-normal">
        US Dollar
      </span>
    <% end %>
    <%= button_to users_rate_path(current_user), params: {:rate => "CNY"}, method: :put, class: "dropdown-item", style: "outline:none" do %>
      <% if current_user.rate == "CNY" %>
        <i class="icon-check-selected"></i>
      <% else %>
        <i class="icon-check-none"></i>
      <% end %>
      RMB
      <span class="text-normal">
        Chinese Yuan
      </span>
    <% end %>
  <!-- Change currency for guest -->
  <% else %>
    <%= link_to({rate: "MYR"}, class: "dropdown-item #{(params[:rate] == 'USD' || params[:rate] == 'CNY')  ? '' : 'active'}") do %>
      MYR
      <span class="text-normal">
        Malaysian Ringgit
      </span>
    <% end %>
    <%= link_to({rate: "USD"}, class: "dropdown-item #{params[:rate] == 'USD' ? 'active' : ''}") do %>
      USD
      <span class="text-normal">
        US Dollar
      </span>
    <% end %>
    <%= link_to({rate: "CNY"}, class: "dropdown-item #{params[:rate] == 'CNY' ? 'active' : ''}") do %>
      RMB
      <span class="text-normal">
        Chinese Yuan
      </span>
    <% end %>
  <% end %>
</div>
{% endhighlight %}


Selanjutnya, isi dari file `_flash_message.html.erb`

{% highlight_caption app/views/layouts/users/_flash_message.html.erb %}
{% highlight eruby linenos %}
<% flash.each do |name, msg| %>
  <div class="alert bg-<%= name == 'error' ? 'secondary' : 'primary' %> text-center text-white">
    <i class="fa fa-exclamation-triangle mr-1"></i><%= msg %>
    <span class="close-button fa fa-times fa-2x" aria-hidden="true" data-dismiss="alert"></span>
  </div>
<% end %>
{% endhighlight %}

Selesai!

Mudah kan?

Kelihatannya saja banyak. Mungkin dikesempatan yang lain akan saya sederhanakan lagi.

Untuk kali ini, seperti ini dulu.

Mudah-mudahan dapat bermanfaat buat teman-teman.

Terima kasih.

(^_^)






# Referensi

1. [guides.rubyonrails.org/routing.html#controller-namespaces-and-routing](https://guides.rubyonrails.org/routing.html#controller-namespaces-and-routing){:target="_blank"}
<br>Diakses tanggal: 2019/12/21

2. [guides.rubyonrails.org/i18n.html](https://guides.rubyonrails.org/i18n.html){:target="_blank"}
<br>Diakses tanggal: 2019/12/21
