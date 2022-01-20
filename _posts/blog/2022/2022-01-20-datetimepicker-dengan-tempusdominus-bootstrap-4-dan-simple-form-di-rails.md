---
layout: 'post'
title: "Date Time Picker dengan Tempus Dominus Bootstrap 4 dan simple_form di Ruby on Rails 6"
date: 2022-01-20 05:54
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Rails', 'Javascript']
pin:
hot:
contributors: []
description: "Konsistensi UI di setiap browser yang digunakan oleh user untuk membuka web aplikasi yang kita bangun, merupakan hal yang penting. Date time picker sudah disediakan oleh browser modern, namun baik Google Chrome maupun Firefox memiliki tampilan yang berbeda. Kita perlu menyeragamkannya dengan menggunakan date time picker pihak ketiga. Kita akan gunakan Javascript library yang bernama Tempus Dominus Bootstrap 4 pada web aplikasi yang dibangun dengan Ruby on Rails 6. Dan juga mengunakan simple_form gem untuk mempermudah membuat form."
---

# Prerequisite

`Ruby 3.0.3` `Rails 6.1.4` `simple_form 5.1` `Bootstrap 4` `Tempusdominus-Bootstrap-4 5.39` `jQuery 3.6` `Moment.js 2.29`

# Problem

Ketidakseragaman style dari date time picker pada browser.

> *Unsupporting browsers gracefully degrade to a text input, but this creates problems in **consistency of user interface** (the presented controls are different) and data handling.* [1]

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/XqVyw4DD/gambar-01.gif" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 1 - Default Date picker pada Google Chrome (Kiri) dan Firefox (Kanan) yang memiliki style yang berbeda</p>

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/L821WhrX/gambar-03.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 2 - Default Date Picker dari Google Chrome (Kiri) & Firefox (Kanan)</p>

Gambar 1 & 2 di atas menggunakan `date_field`.

Apabila menggunakan `datetime_field`, Chrome juga dapat memberikan time selection UI di sebelah calendar, sedangkan Firefox tidak memberikan time selection UI, hanya calendar dan input text saja (dicoba: Januari 2022).


# Target

Menyeragamkan date time picker pada input `date_field`.

{% highlight_caption app/views/tasks/_form.html.erb %}
{% highlight eruby linenos %}
<%= form_with(model: task) do |form| %>
  <!-- ... -->

  <div class="field">
    <%= form.label :created_at %>
    <%= form.date_field :created_at %>
  </div>

  <!-- ... -->
<% end %>
{% endhighlight %}

Kalau ingin mengikutkan time, dapat menggunakan `datetime_field`.

{% highlight_caption app/views/tasks/_form.html.erb %}
{% highlight eruby linenos %}
<%= form_with(model: task) do |form| %>
  <!-- ... -->

  <div class="field">
    <%= form.label :created_at %>
    <%= form.datetime_field :created_at %>
  </div>

  <!-- ... -->
<% end %>
{% endhighlight %}


# Instalasi

## 1. Tempus Dominus Bootstrap 4

Pada web dokumentasi dari Tempus Dominus - Bootstrap 4, terdapat beberapa cara untuk memasang library ini ke dalam web aplikasi kita. Namun, pada catatan kali ini saya akan menggunakan `yarn` package manager untuk memasang Javascript library ke dalam Rails project.

Namun, terlebih dahulu Rails project yang digunakan sebaiknya perlu dipasang Bootstrap 4.

Kalau belum, dapat melihat caranya di sini, [**Memasang Bootstrap 4 pada Rails 6 dengan Yarn**](/blog/memasang-bootstrap-pada-rails-menggunakan-yarn){:target="_blank"}.

Setelah Bootstrap 4 selesai dipasang & disetting pada project dengan Rails 6, kemudian baru pasang **tempusdominus-bootstrap4** & **moment.js** library.

{% shell_term $ %}
yarn add tempusdominus-bootstrap-4 moment
{% endshell_term %}

Tunggu proses instalasi selesai.

```
success Saved lockfile.
success Saved 3 new dependencies.
info Direct dependencies
├─ moment@2.29.1
└─ tempusdominus-bootstrap-4@5.39.0
info All dependencies
├─ moment-timezone@0.5.34
├─ moment@2.29.1
└─ tempusdominus-bootstrap-4@5.39.0
Done in 5.79s.
```

Kalau sudah selesai, kedua package tersebut akan ditambahkan ke dalam file `package.json` yang ada di root project direktori.

{% highlight_caption package.json %}
{% highlight json linenos %}
{
  "name": "datetimepicker-with-tempusdominus-bootstrap-4",
  "private": true,
  "dependencies": {
    "@rails/actioncable": "^6.0.0",
    "@rails/activestorage": "^6.0.0",
    "@rails/ujs": "^6.0.0",
    "@rails/webpacker": "5.4.3",
    "bootstrap": "4",
    "jquery": "^3.6.0",
    "moment": "^2.29.1",
    "popper.js": "^1.16.1",
    "tempusdominus-bootstrap-4": "^5.39.0",
    "turbolinks": "^5.2.0",
    "webpack": "^4.46.0",
    "webpack-cli": "^3.3.12"
  },
  "version": "0.1.0",
  "devDependencies": {
    "webpack-dev-server": "^3"
  }
}
{% endhighlight %}


## 2. simple_form gem

Pasang simple_form, lihat versi terbaru dari halaman [rubygems:simple_form](https://rubygems.org/gems/simple_form){:target="_blank"}.

{% highlight_caption Gemfile %}
{% highlight ruby linenos %}
gem 'simple_form', '~> 5.1'
{% endhighlight %}

Install dengan,

{% shell_term $ %}
bundle install
{% endshell_term %}

Jalankan generator untuk memasang beberapa file pendukung.

{% shell_term $ %}
rails generate simple_form:install --bootstrap
{% endshell_term %}

`--bootstrap`, karena saya menggunakan Bootstrap.

Outputnya akan seperti di bawah ini.

```
   create  config/initializers/simple_form.rb
   create  config/initializers/simple_form_bootstrap.rb
    exist  config/locales
   create  config/locales/simple_form.en.yml
   create  lib/templates/erb/scaffold/_form.html.erb
===============================================================================

Be sure to have a copy of the Bootstrap stylesheet available on your
application, you can get it on http://getbootstrap.com/.

For usage examples and documentation, see:

 http://simple-form-bootstrap.plataformatec.com.br/

===============================================================================
```


# Konfigurasi

## 1. Konfigurasi Webpack untuk Moment.js

Definisikan `moment` pada webpacker environment agar dapat dikenali oleh aplikasi.

{% highlight_caption config/webpack/environment.js %}
{% highlight javascript linenos %}
const { environment } = require('@rails/webpacker')

const webpack = require("webpack")

environment.plugins.append("Provide", new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default'],
  moment: 'moment'
}))

module.exports = environment
{% endhighlight %}

Baris **9**, adalah pendefinisian `moment` yang perlu dilakukan.


## 2. Konfigurasi Javascript

Kita perlu melakukan **import** terhadapat **tempusdominus-bootstrap-4** dan **moment** ke dalam aplikasi.

{% highlight_caption app/javascript/packs/application.js %}
{% highlight javascript linenos %}
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery"
import "bootstrap"

import "moment"
import "tempusdominus-bootstrap-4"

document.addEventListener('turbolinks:load', () => {
  $('#datetimepicker').datetimepicker({
    format: 'YYYY-MM-DD',
    autoHide: true
  });
});

Rails.start()
Turbolinks.start()
ActiveStorage.start()
{% endhighlight %}

Baris **14**-**15** dan **17**-**22**, adalah bagian yang perlu ditambahkan.

`$('#datetimepicker')`, adalah ID dari input field yang akan kita gunakan pada view template.

`format: 'YYYY-MM-DD'`, yang akan membuat format date pada input field bernilai **YYYY-MM-DD**.

`autoHide: true`, yang akan membuat popup window datepicker keluar setelah user melakukan pilihan.


## 3. Konfigurasi Stylesheet

Kalau menggunakan cara pemasangan Bootstrap 4 seperti yang saya gunakan, [Memasang Bootstrap 4 pada Rails 6 dengan Yarn](http://localhost:4000/blog/memasang-bootstrap-pada-rails-menggunakan-yarn#3-konfigurasi-stylesheet){:target="_blank"}, maka kita perlu mengimport stylesheet untuk tempusdominus-bootstrap-4 ke dalam file **custom.scss**.

{% highlight_caption app/assets/stylesheets/custom.scss %}
{% highlight css linenos %}
@import 'bootstrap/scss/bootstrap';
@import 'tempusdominus-bootstrap-4/src/sass/tempusdominus-bootstrap-4';
{% endhighlight %}

Baris **2**, adalah bagian yang perlu ditambahkan.

{% box_pertanyaan %}
<p markdown=1><b>Darimana saya mengetahui lokasi stylesheet dari Javascript library yang dipasang?</b></p>
<p markdown=1>Telusuri file stylesheet dari Javascript library yang digunakan, di dalam direktori **node_modules** (dalam root project direktori).</p>
{% endbox_pertanyaan %}


# Implementasi

Kalau menggunakan **simple_form**,

Langsung saja ke bagian view template, dalam kasus ini, saya memodifikasi inputan date pada file `_form.html.erb`.

{% highlight_caption app/views/tasks/_form.html.erb %}
{% highlight eruby linenos %}
<div class="row">
  <div class="col px-3">

    <%= simple_form_for @task do |form| %>

      <!-- input date_field default -->
      <div class="field">
        <%= form.label :created_at %>
        <%= form.date_field :created_at %>
      </div>

      <!-- input date_field tempusdominus-bootstrap-4 -->
      <div class="form-group">
        <%= form.label :created_at, class: "form-label" %>
        <%= form.input :created_at,
          input_html: {
            class: "form-control datetimepicker-input",
            id: "datetimepicker",
            placeholder: "yyyy-mm-dd",
            autocomplete: "off",
            data: {
              toggle: "datetimepicker",
              target: "#datetimepicker"
            }
          },
          as: :string,
          label: false,
          wrapper: false %>
      </div>

      <!-- [...] -->
    <% end %>

  </div>
</div>
{% endhighlight %}

Baris **12**-**29**, adalah input tanggal yang dibuat dari **tempusdominus-bootstrap-4**.

Baris **6**-**10**, adalah input tanggal yang tampilannya akan mengikuti browser.

`input_html: { ... }`, digunakan untuk membungkus semua tag html, seperti: `class`, `id`, `data`, `placeholder`, dll.

`as: :string`, digunakan untuk mendefinisikan bahwa value dari `.input` yang digunakan akan disimpan sebagai **string**.

`label: false`, secara default `.input` sudah termasuk dengan label yang diambil dari nama field. Set *false* untuk mendisablenya.

`wrapper: false`, secara default, `.input` sudah dibungkus dengan `<div>`. Set *false* untuk mendisablenya. Apabila tidak, terkadang dapat menyebabkan permasalahan pada tampilan input field yang berubah dari bentuk aslinya.

{% box_perhatian %}
<p markdown=1>**Perhatikan!** Gunakan `text_field` dan bukan `date_field`.</p>
{% endbox_perhatian %}

Selesai!


# Hasil

![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/85R7P4SS/gambar-02.gif" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 3 - Date picker yang sudah menggunakan tempusdominus-bootstrap-4</p>

![gambar_4]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/VkgCPm8F/gambar-04.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 4 - Date picker yang sudah menggunakan tempusdominus-bootstrap-4 </p>

Dapat dilihat, baik pada Google Chrome (Kiri) dan Firefox (Kanan), date input field diantara keduanya memiliki tampilan yang serupa.

Selain itu, date format yang ditampilkan juga memiliki format **YYYY-MM-DD**.


# Demo Project

[github:demo_datetimepicker_with_tempusdominus-bootstrap-4_simple_form](https://github.com/bandithijo/demo_datetimepicker_with_tempusdominus-bootstrap-4_simple_form){:target="_blank"}


# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)


# Referensi

1. [https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/date](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/date){:target="_blank"}
<br>Diakses tanggal: 2022/01/20

1. [https://blog.nightly.mozilla.org/2017/06/12/datetime-inputs-enabled-on-nightly/](https://blog.nightly.mozilla.org/2017/06/12/datetime-inputs-enabled-on-nightly/){:target="_blank"}
<br>Diakses tanggal: 2022/01/20

1. [https://getdatepicker.com/5-4/Usage/](https://getdatepicker.com/5-4/Usage/){:target="_blank"}
<br>Diakses tanggal: 2022/01/20

1. [https://github.com/heartcombo/simple_form](https://github.com/heartcombo/simple_form){:target="_blank"}
<br>Diakses tanggal: 2022/01/20
