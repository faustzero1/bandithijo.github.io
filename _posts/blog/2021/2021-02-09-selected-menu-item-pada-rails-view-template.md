---
layout: 'post'
title: "Selected Menu Item pada Rails View Template"
date: 2021-02-09 18:13
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
description: "Membuat menu item untuk menampilkan menu yang aktif dan yang tidak mungkin akan menjadi hal yang sedikit menyulitkan. Catatan kali ini, saya akan sedikit mencatat berbagai macam cara yang pernah saya lakukan untuk membuat fitur menu item yang dapat menampilkan indikator aktif (selected)."
---

# Prerequisite

`ruby 2.7.2` `rails 6.1.1` `bootstrap 4.6.x`

# Latar Belakang

Kali ini saya kembali mencatat perihal front-end pada Ruby on Rails untuk membuat menu yang dapat menampilkan indikator aktif (selected) saat berada pada halaman yang dipilih.

{% image https://i.postimg.cc/DyNSMHLs/gambar-01.gif | 01 %}

Pada demonstrasi gambar di atas, saya menggunakan [**Accordion/Collapsibles**](https://www.w3schools.com/howto/howto_js_accordion.asp){:target="_blank"} dengan Bootstrap card yang sudah dimodifikasi.

Cukup banyak cara yang dapat kita gunakan untuk membuat selected menu item.

Saya akan coba meng-cover sebanyak yang saya pernah gunakan.

{% box_info %}
<p>Style class dan filename, hanya ilustrasi.</p>
<p>Saya perlu mempersingkat class agar code tidak terlalu panjang.</p>
<p>Jadi, jangan bingung apabila kode terapan tidak akan mirip dengan contoh di gambar ilustrasi di atas apabila digunakan.</p>
{% endbox_info %}

# Penerapan

## Menggunakan Controller atau Action Name

Setiap params hash selalu berisi controller dan action, untuk mengetahui valuenya di view template dengan cara seperti ini.

```eruby
<%= controller.controller_name %>
```

```eruby
<%= controller.action_name %>
```

Atau yang lebih sederhana,

```eruby
<%= controller_name %>
```

```eruby
<%= action_name %>
```

Nah, kalau sudah begini, tinggal kita jadikan perbandingan saja.

Misal seperti ini:

```eruby
<div class="collapse <%= 'show' if controller_name == 'home' %>"></div>
```

```eruby
<div class="collapse <%= 'show' if action_name == 'index' %>"></div>
```

Penerapan ke view templatenya akan seperti ini:

{% highlight_caption app/views/shared/_navbar.html.erb %}
{% highlight eruby linenos %}
<ul class="nav nav-tabs mb-3">
  <li class="nav-item">
    <%= link_to "Beranda", root_path,
        class: "nav-link #{'active' if controller_name == 'home'}" %>
  </li>
  <li class="nav-item">
    <%= link_to "Blog", blog_path,
        class: "nav-link #{'active' if controller_name == 'blog'}" %>
  </li>
</ul>
{% endhighlight %}

<br>
**Bagaimana kalau satu menu yang sama, tetapi digunakan untuk menampilkan dua atau lebih halaman yang berbeda?**

Mudah, kita dapat menggunakan bentuk array dengan method **include?**.

```eruby
<div class="collapse <%= 'show' if  ['home', 'blog'].include? controller_name %>"></div>
```

```eruby
<div class="collapse <%= 'show' if  ['index', 'new', 'edit'].include? action_name %>"></div>
```

<br>
## Menggunakan Routing Prefix dengan Request Path

```eruby
<div class="collapse <%= 'show' if [admins_root_path, admins_dashboard_path].include? request.path %>"></div>
```

Dapat dilihat, saya memiliki array dengan dua buah routing prefix:

```ruby
[admins_root_path, admins_dashboard_path]
```

Kemudian saya buat single if condition:

Tampilkan `'show'` jika `path` yang di `request` termasuk di dalam isi dari array `[admins_root_path, admins_dashboard_path]`.

Nah, penerapan ke view templatenya akan seperti ini:

Dapat dilihat pada bari 4, 11, 14.

{% highlight_caption app/views/shared/_sidebar.html.erb %}
{% highlight eruby linenos %}
<div class="card">
  <div class="card-header" id="headingOne">
    <h2 class="mb-0">
      <button class="btn btn-block <%= 'collapsed' unless [admins_root_path, admins_dashboard_path].include? request.path %>" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
        <%= bootstrap_icon 'house-fill' %>
        <%= 'Beranda' %>
      </button>
    </h2>
  </div>

  <div id="collapseOne" class="collapse <%= 'show' if [admins_root_path, admins_dashboard_path].include? request.path %>" aria-labelledby="headingOne">
    <div class="card-body">
      <ul class="list-group list-group-flush">
        <li class="list-group-item <%= 'active' if [admins_dashboard_path, admins_root_path].include? request.path %>" aria-current="true">
          <%= link_to admins_dashboard_path, class: 'child-menu-sidebar d-flex align-items-center' do %>
            <%= bootstrap_icon 'pie-chart' %>
            <%= 'Dashboard' %>
          <% end %>
        </li>
        <li class="list-group-item d-flex align-items-center" aria-current="true">
          <%= link_to nil, class: 'child-menu-sidebar d-flex align-items-center' do %>
            <%= bootstrap_icon 'rss' %>
            <%= 'Feed' %>
          <% end %>
        </li>
        <li class="list-group-item d-flex align-items-center" aria-current="true">
          <%= link_to nil, class: 'child-menu-sidebar d-flex align-items-center' do %>
            <%= bootstrap_icon 'back' %>
            <%= 'Landing' %>
          <% end %>
        </li>
      </ul>
    </div>
  </div>
</div>
{% endhighlight %}

<br>
## Menggunakan ActionView Helper

Kita dapat membuat method sendiri yang dapat kita gunakan di view template.

Saya akan meletakkan di **app/helpers/application_helper.rb**.

{% highlight_caption app/helpers/application_helper.rb %}
{% highlight ruby linenos %}
module ApplicationHelper
  ACTIVE_CLASS = 'is-active'.freeze

  def active_for(options)
    name_of_controller = options.fetch(:controller) { nil }
    name_of_action     = options.fetch(:action) { nil }
    request_path       = options.fetch(:path) { nil }

    return ACTIVE_CLASS if request_path && request_path == request.path

    if name_of_controller == controller_name
      ACTIVE_CLASS if name_of_action.nil? || (name_of_action == action_name)
    end
  end
end
{% endhighlight %}

Dan, penerapan pada view templatenya akan seperti ini:

Terdapat 2 cara yang dapat digunakan:

1. Menggunakan routing path
2. Menggunakan controller atau action name

{% highlight_caption app/views/shared/_navbat.html.erb %}
{% highlight eruby linenos %}
<div id="navbar" class="navbar-collapse collapse">
  <ul class="nav navbar-nav navbar-right">
    <li class='<%= active_for(path: "/users/#{current_user.id}") %>'>
      <%= link_to current_user %>
    </li>
    <li class='<%= active_for(controller: "events") %>'>
      <%= link_to events_path %>
    </li>
    <li class='<%= active_for(controller: "users", action: "edit") %>'>
      <%= link_to edit_user_path(current_user) %>
    </li>
  </ul>
</div>
{% endhighlight %}

Sumber: [**pelted/application_helper.rb**](https://gist.github.com/pelted/5dac756f690a61f698145dc9495a9633){:target="_blank"}.







<br>
# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Selanjutnya, saya serahkan kepada imajinasi dan kreatifitas teman-teman. Hehe.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)




# Referensi

1. [How TO - Collapsibles/Accordion](https://www.w3schools.com/howto/howto_js_accordion.asp){:target="_blank"}
<br>Diakses tanggal: 2021/02/09

2. [gist.github.com/pelted/5dac756f690a61f698145dc9495a9633](https://gist.github.com/pelted/5dac756f690a61f698145dc9495a9633){:target="_blank"}
<br>Diakses tanggal: 2021/02/09
