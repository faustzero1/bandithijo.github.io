---
layout: 'post'
title: "Memasang Pagination dengan Pagy pada Rails"
date: 2020-02-20 07:27
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

`Ruby 2.6.3` `Rails 5.2.3` `PostgreSQL 11.5`

# Prakata

Bos ditempat saya bekerja, pernah membagikan sebuah tulisan mengenai perbandingan dari 3 gems yang digunakan untuk membantu developer dalam membuat fitur pagination pada web aplikasi yang mereka bangun. 2 diantara gems tersebut adalah gems yang sudah terkenal (setidaknya yang saya tahu seperti itu) dan sudah sering menjadi pilihan.

3 gems tersebut adalah:

1. Kaminari
2. Will Paginate
3. Pagy

# Kenapa Pagy?

Coba teman-teman melihat sebentar pada artikel mengenai perbandingan diantara 3 pagination gems tersebut.

Cek [di sini](https://ddnexus.github.io/pagination-comparison/gems.html){:target="_blank"}.

Pada artikel tersebut, Pagy benar-benar tidak terkalahkan.

Wajar saja, karena dari konsep dasar yang digunakan oleh Pagy itu sendiri,

1. Pagination is simple task
2. Keep it simple
3. Stay away from busines logic
4. No Rails engine needed
5. dst.

Dari artikel tersebut, hasil yang diberika Pagy sangat mengintimidasi pembaca yang menggunakan 2 gems yang lain untuk menangani pagination. Terutama saya, sebagai Rails developer yang masih baru.

Setelah membaca-baca dan mencoba-coba sedikit, saya pun memutuskan untuk memigrasikan pagination pada proyek yang sedang saya kerjakan yang sebelumnya menggunakan Kaminari.

# Migrasi Kaminari to Pagy

Langkah-langkah migrasi yang saya lakukan adalah, saya tidak langsung menghapus Kaminari gem dari Gemfile. Namun, menambahkan Pagy gem.

{% highlight_caption Gemfile %}
{% highlight ruby linenos %}

# ...
# ...
gem 'kaminari',      '~> 1.1', '>= 1.1.1'
gem 'pagy',          '~> 3.7', '>= 3.7.2'
# ...
# ...
{% endhighlight %}

Jalankan bundle install

{% shell_user %}
bundle install
{% endshell_user %}

Setelah selesai, tambahkan module **Pagy::Backend** dan **Pagy::Frontend**.

{% highlight_caption app/controllers/application_controller.rb %}
{% highlight ruby linenos %}
class ApplicationController < ActionController::Base
  include Pagy::Backend

  ...
  ...
end
{% endhighlight %}

{% highlight_caption app/helpers/application_helper.rb %}
{% highlight ruby linenos %}
module ApplicationHelper
  include Pagy::Frontend
  ...
  ...
end
{% endhighlight %}

Kemudian, tambahkan pagy initializer apabila diperlukan.

{% highlight_caption config/initializers/pagy.rb %}
{% highlight ruby linenos %}
# encoding: utf-8
# frozen_string_literal: true

# Pagy initializer file (3.7.2)
# Customize only what you really need and notice that Pagy works also without any of the following lines.
# Should you just cherry pick part of this file, please maintain the require-order of the extras


# Extras
# See https://ddnexus.github.io/pagy/extras


# Backend Extras

# Array extra: Paginate arrays efficiently, avoiding expensive array-wrapping and without overriding
# See https://ddnexus.github.io/pagy/extras/array
# require 'pagy/extras/array'

# Countless extra: Paginate without any count, saving one query per rendering
# See https://ddnexus.github.io/pagy/extras/countless
# require 'pagy/extras/countless'
# Pagy::VARS[:cycle] = false    # default

# Elasticsearch Rails extra: Paginate `ElasticsearchRails::Results` objects
# See https://ddnexus.github.io/pagy/extras/elasticsearch_rails
# require 'pagy/extras/elasticsearch_rails'

# Searchkick extra: Paginate `Searchkick::Results` objects
# See https://ddnexus.github.io/pagy/extras/searchkick
# require 'pagy/extras/searchkick'


# Frontend Extras

# Bootstrap extra: Add nav, nav_js and combo_nav_js helpers and templates for Bootstrap pagination
# See https://ddnexus.github.io/pagy/extras/bootstrap
# require 'pagy/extras/bootstrap'

# Bulma extra: Add nav, nav_js and combo_nav_js helpers and templates for Bulma pagination
# See https://ddnexus.github.io/pagy/extras/bulma
# require 'pagy/extras/bulma'

# Foundation extra: Add nav, nav_js and combo_nav_js helpers and templates for Foundation pagination
# See https://ddnexus.github.io/pagy/extras/foundation
# require 'pagy/extras/foundation'

# Materialize extra: Add nav, nav_js and combo_nav_js helpers for Materialize pagination
# See https://ddnexus.github.io/pagy/extras/materialize
# require 'pagy/extras/materialize'

# Navs extra: Add nav_js and combo_nav_js javascript helpers
# Notice: the other frontend extras add their own framework-styled versions,
# so require this extra only if you need the unstyled version
# See https://ddnexus.github.io/pagy/extras/navs
# require 'pagy/extras/navs'

# Semantic extra: Add nav, nav_js and combo_nav_js helpers for Semantic UI pagination
# See https://ddnexus.github.io/pagy/extras/semantic
# require 'pagy/extras/semantic'

# UIkit extra: Add nav helper and templates for UIkit pagination
# See https://ddnexus.github.io/pagy/extras/uikit
# require 'pagy/extras/uikit'

# Multi size var used by the *_nav_js helpers
# See https://ddnexus.github.io/pagy/extras/navs#steps
# Pagy::VARS[:steps] = { 0 => [2,3,3,2], 540 => [3,5,5,3], 720 => [5,7,7,5] }   # example


# Feature Extras

# Headers extra: http response headers (and other helpers) useful for API pagination
# See http://ddnexus.github.io/pagy/extras/headers
# require 'pagy/extras/headers'
# Pagy::VARS[:headers] = { page: 'Current-Page', items: 'Page-Items', count: 'Total-Count', pages: 'Total-Pages' }     # default

# Support extra: Extra support for features like: incremental, infinite, auto-scroll pagination
# See https://ddnexus.github.io/pagy/extras/support
# require 'pagy/extras/support'

# Items extra: Allow the client to request a custom number of items per page with an optional selector UI
# See https://ddnexus.github.io/pagy/extras/items
# require 'pagy/extras/items'
# Pagy::VARS[:items_param] = :items    # default
# Pagy::VARS[:max_items]   = 100       # default

# Overflow extra: Allow for easy handling of overflowing pages
# See https://ddnexus.github.io/pagy/extras/overflow
# require 'pagy/extras/overflow'
# Pagy::VARS[:overflow] = :empty_page    # default  (other options: :last_page and :exception)

# Metadata extra: Provides the pagination metadata to Javascript frameworks like Vue.js, react.js, etc.
# See https://ddnexus.github.io/pagy/extras/metadata
# you must require the shared internal extra (BEFORE the metadata extra) ONLY if you need also the :sequels
# require 'pagy/extras/shared'
# require 'pagy/extras/metadata'
# For performance reason, you should explicitly set ONLY the metadata you use in the frontend
# Pagy::VARS[:metadata] = [:scaffold_url, :count, :page, :prev, :next, :last]    # example

# Trim extra: Remove the page=1 param from links
# See https://ddnexus.github.io/pagy/extras/trim
# require 'pagy/extras/trim'



# Pagy Variables
# See https://ddnexus.github.io/pagy/api/pagy#variables
# All the Pagy::VARS are set for all the Pagy instances but can be overridden
# per instance by just passing them to Pagy.new or the #pagy controller method


# Instance variables
# See https://ddnexus.github.io/pagy/api/pagy#instance-variables
# Pagy::VARS[:items] = 20                                   # default


# Other Variables
# See https://ddnexus.github.io/pagy/api/pagy#other-variables
# Pagy::VARS[:size]       = [1,4,4,1]                       # default
# Pagy::VARS[:page_param] = :page                           # default
# Pagy::VARS[:params]     = {}                              # default
# Pagy::VARS[:anchor]     = '#anchor'                       # example
# Pagy::VARS[:link_extra] = 'data-remote="true"'            # example


# Rails

# Rails: extras assets path required by the helpers that use javascript
# (pagy*_nav_js, pagy*_combo_nav_js, and pagy_items_selector_js)
# See https://ddnexus.github.io/pagy/extras#javascript
# Rails.application.config.assets.paths << Pagy.root.join('javascripts')


# I18n

# Pagy internal I18n: ~18x faster using ~10x less memory than the i18n gem
# See https://ddnexus.github.io/pagy/api/frontend#i18n
# Notice: No need to configure anything in this section if your app uses only "en"
# or if you use the i18n extra below
#
# Examples:
# load the "de" built-in locale:
# Pagy::I18n.load(locale: 'de')
#
# load the "de" locale defined in the custom file at :filepath:
# Pagy::I18n.load(locale: 'de', filepath: 'path/to/pagy-de.yml')
#
# load the "de", "en" and "es" built-in locales:
# (the first passed :locale will be used also as the default_locale)
# Pagy::I18n.load({locale: 'de'},
#                 {locale: 'en'},
#                 {locale: 'es'})
#
# load the "en" built-in locale, a custom "es" locale,
# and a totally custom locale complete with a custom :pluralize proc:
# (the first passed :locale will be used also as the default_locale)
# Pagy::I18n.load({locale: 'en'},
#                 {locale: 'es', filepath: 'path/to/pagy-es.yml'},
#                 {locale: 'xyz',  # not built-in
#                  filepath: 'path/to/pagy-xyz.yml',
#                  pluralize: lambda{|count| ... } )


# I18n extra: uses the standard i18n gem which is ~18x slower using ~10x more memory
# than the default pagy internal i18n (see above)
# See https://ddnexus.github.io/pagy/extras/i18n
# require 'pagy/extras/i18n'

# Default i18n key
# Pagy::VARS[:i18n_key] = 'pagy.item_name'   # default
{% endhighlight %}

Secara default, semua konfigurasinya dalam keadaan terdisable.

Teman-teman dapat memilih mana-mana saja yang teman-teman perlukan.

Misalkan seperti default items per satu halaman, secara default berjumlah 20.

Atau contoh lain, untuk frontend.

{% highlight_caption config/initializers/pagy.rb %}
{% highlight ruby linenos %}
# ...
# ...

# Frontend Extras

# Bootstrap extra: Add nav, nav_js and combo_nav_js helpers and templates for Bootstrap pagination
# See https://ddnexus.github.io/pagy/extras/bootstrap
require 'pagy/extras/bootstrap'

# Bulma extra: Add nav, nav_js and combo_nav_js helpers and templates for Bulma pagination
# See https://ddnexus.github.io/pagy/extras/bulma
# require 'pagy/extras/bulma'

# Foundation extra: Add nav, nav_js and combo_nav_js helpers and templates for Foundation pagination
# See https://ddnexus.github.io/pagy/extras/foundation
# require 'pagy/extras/foundation'

# Materialize extra: Add nav, nav_js and combo_nav_js helpers for Materialize pagination
# See https://ddnexus.github.io/pagy/extras/materialize
# require 'pagy/extras/materialize'

# ...
# ...
{% endhighlight %}

Saya menggunakan bootstrap, maka saya memilih frontend extra untuk Bootstrap theme, agar tampilan pagination pada view template saya mengunakan Bootstrap theme.

# Controller

Selanjutnya pada controller, bisa memigrasikan object query yang menggunakan Kaminary menjadi Pagy, seperti contoh di bawah.

**Kaminary**

{% highlight_caption app/controllers/admin/users_controller.rb %}
{% highlight ruby linenos %}
class Admin::UsersController < AdminsController
  def index
    @users = User.order(id: :desc).page(params[:page])
  end

  # ...
end
{% endhighlight %}

**Pagy**

{% highlight_caption app/controllers/admin/users_controller.rb %}
{% highlight ruby linenos %}
class Admin::UsersController < AdminsController
  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 25)
  end

  # ...
end
{% endhighlight %}

# View

Kemudian pada view template, saya akan menambahkan direktori `app/views/pagy/` dan menambahkan Bootstrap theme `_bootstrap_nav.html.erb`.

Tujuannya agar mudah untuk melakukan kostumisasi.

{% highlight_caption app/views/pagy/_bootstrap_nav.html.erb %}
{% highlight eruby linenos %}
<%#
  This template is i18n-ready: if you don't use i18n, then you can replace the pagy_t
  calls with the actual strings ("&lsaquo; Prev", "Next &rsaquo;", "&hellip;").

  The link variable is set to a proc that returns the link tag.
  Usage: link.call( page_number [, text [, extra_attributes_string ]])
-%>
<% link = pagy_link_proc(pagy, 'class="page-link"') -%>
<%#                            -%><nav aria-label="pager"  class="pagy-bootstrap-nav pagination" role="navigation">
<%#                            -%>  <ul class="pagination">
<% if pagy.prev                -%>    <li class="page-item prev"><%== link.call(pagy.prev, pagy_t('pagy.nav.prev'), 'aria-label="previous"') %></li>
<% else                        -%>    <li class="page-item prev disabled"><a href="#" class="page-link"><%== pagy_t('pagy.nav.prev') %></a></li>
<% end                         -%>
<% pagy.series.each do |item| # series example: [1, :gap, 7, 8, "9", 10, 11, :gap, 36] -%>
<%   if    item.is_a?(Integer) -%>    <li class="page-item"><%== link.call(item) %></li>
<%   elsif item.is_a?(String)  -%>    <li class="page-item active"><%== link.call(item) %></li>
<%   elsif item == :gap        -%>    <li class="page-item disabled gap"><a href="#" class="page-link"><%== pagy_t('pagy.nav.gap') %></a></li>
<%   end                       -%>
<% end                         -%>
<% if pagy.next                -%>    <li class="page-item next"><%== link.call(pagy.next, pagy_t('pagy.nav.next'), 'aria-label="next"') %></li>
<% else                        -%>    <li class="page-item next disabled"><a href="#" class="page-link"><%== pagy_t('pagy.nav.next') %></a></li>
<% end                         -%>
<%#                            -%>  </ul>
<%#                            -%></nav>
{% endhighlight %}

Nah, mantap, kalo sudah tinggal merubah helper method yang dimiliki kaminari pada view template.

Pertama-tama, `.total_count`. Ini adalah helper method yang disediakan oleh kaminari untuk mentotal jumlah dari collection.

**Kamniari**
{% highlight_caption app/views/admin/users/index.html.erb %}
{% highlight eruby linenos %}
...
...
  <%= @users.total_count %>
...
...
{% endhighlight %}

**Pagy**
{% highlight_caption app/views/admin/users/index.html.erb %}
{% highlight eruby linenos %}
...
...
  <%= @pagy.count %>
...
...
{% endhighlight %}

Kedua, pada bagian paginationnya akan seperti ini.

**Kaminari**

{% highlight_caption app/views/admin/users/index.html.erb %}
{% highlight eruby linenos %}
...
...
  <!-- Kaminari Pagination -->
  <div class="d-flex justify-content-center">
    <%= paginate @users %>
  </div>
  <!-- END Kaminari Pagination -->
...
...
{% endhighlight %}

**Pagy**

{% highlight_caption app/views/admin/users/index.html.erb %}
{% highlight eruby linenos %}
...
...
  <!-- Pagy Pagination -->
  <div class="d-flex justify-content-center">
    <%== render partial: 'pagy/bootstrap_nav', locals: {pagy: @pagy} %>
  </div>
  <!-- END Pagy Pagination -->
...
...
{% endhighlight %}

Atau seperti ini apabila jumlah halaman hanya satu.

{% highlight_caption app/views/admin/users/index.html.erb %}
{% highlight eruby linenos %}
...
...
  <!-- Pagy Pagination -->
  <div class="d-flex justify-content-center">
    <%== render partial: 'pagy/bootstrap_nav', locals: {pagy: @pagy} if @pagy.pages > 1 %></div>
  <!-- END Pagy Pagination -->
...
...
{% endhighlight %}

Selanjutnya saya hanya perlu merubah semua collection pada controller dan view helper dari Kaminari ke Pagy.

Setelah dipastikan semuanya sudah dirubah, bisa dicoba untuk menghapus Kamniari dari Gemfile kemudian juga menghapus elemen-elemen lain yang digunakan oleh Kaminari dalam struktur direktori web aplikasi kita, misalnya Kaminari view template termasuk Kamniari initializer config.

Sekian.

Sepertinya segini saja yang dapat saya catat dan bagikan.

Mudah-mudahan dapat bermanfaat bagi teman-teman yang memerlukan.

Terima kasih.

(^_^)


# Referensi

1. [ddnexus.github.io/pagination-comparison/gems.html](https://ddnexus.github.io/pagination-comparison/gems.html){:target="_blank"}
<br>Diakses tanggal: 2020/02/20

2. [ddnexus.github.io/pagy/migration-guide](https://ddnexus.github.io/pagy/migration-guide){:target="_blank"}
<br>Diakses tanggal: 2020/02/20

3. [ddnexus.github.io/pagy/](https://ddnexus.github.io/pagy/){:target="_blank"}
<br>Diakses tanggal: 2020/02/20

4. [github.com/ddnexus/pagy](https://github.com/ddnexus/pagy){:target="_blank"}
<br>Diakses tanggal: 2020/02/20

