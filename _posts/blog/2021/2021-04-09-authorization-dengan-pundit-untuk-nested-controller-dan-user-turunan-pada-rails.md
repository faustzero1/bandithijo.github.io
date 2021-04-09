---
layout: 'post'
title: "Auhtorization dengan Pundit untuk Nested Controller dan User Turunan pada Rails"
date: 2021-04-09 05:40
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
description: "Catatan ini mengenai bagaimana cara membuat authorization dengan bantuan gem Pundit pada controller bertingkat, misal Authors::Articles. Author merupakan turunan dari User, karena User memiliki lebih dari satu user type. Tujuannya adalah untuk membatasi Author hanya dapat mengedit & menghapus Article miliknya saja."
---

# Prerequisite

`Ruby 3.0.1` `Rails 6.1.3.1`

# Target

Membatasi antar Author untuk mengedit dan menghapus Article yang bukan miliknya.

Untuk feature authorization tersebut, kita akan gunakan **Pundit** gem.

# Sekenario

Author merupakan turunan dari User dengan type "Author".

Kita ingin membuat feature administrasi untuk Author yang menampilkan semua daftar Article dan Semua Author.

Hanya Author pemilik Article yang dapat mengedit/menghapus Article yang ia miliki.

# Eksekusi

## Pasang Pundit Gem

Pasang **Pundit** pada Gemfile.

{% highlight_caption Gemfile %}
{% highlight ruby linenos %}
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# ...

gem 'pundit', '~> 2.1'

# ...
{% endhighlight %}

Install.

{% shell_term $ %}
bundle install
{% endshell_term %}

## Generate pundit:install

Jalankan generator untuk membuat konfigurasi awal.

{% shell_term $ %}
rails g pundit:install
{% endshell_term %}

Generator ini akan membuatkan direktori **app/policies** dan juga file bernama **application_policy.rb**.

{% pre_whiteboard %}
 app
│  assets
│  channels
│  controllers
│  helpers
│  javascript
│  jobs
│  mailers
│  models
│  <mark>policies</mark>
│ └  <mark>application_policy.rb</mark>
└  views
 bin
 config
 db
 lib
...
{% endpre_whiteboard %}

## Include Pundit

Saya akan mengincludekan Pundit pada **application_controller** agar setiap controller turunan dapat menggunakan Pundit.

{% highlight_caption app/controllers/application_controller.rb %}
{% highlight ruby linenos %}
class ApplicationController < ActionController::Base
  include Pundit
end
{% endhighlight %}

## Define pundit_user

Pundit menyediakan objek **current_user** sebagai instansiasi terhadap user yang sudah melakukan authentication.

Namun, karena kita menggunakan user type berupa Authro yang merupakan turunan dari User, kita perlu memodifikasi method **pundit_user**.

Kita letakkan pada controller.

Saya memiliki **authors_controller** yang merupakan induk dari semua controller yang ada di bawahnya.

{% pre_whiteboard %}
 app
│  assets
│  channels
│  controllers
│ │  admins
│ │  authors
│ │ │  articles_controller.rb
│ │ │  confirmations_controller.rb
│ │ │  dashboard_controller.rb
│ │ │  omniauth_callbacks_controller.rb
│ │ │  passwords_controller.rb
│ │ │  registrations_controller.rb
│ │ │  sessions_controller.rb
│ │ └  unlocks_controller.rb
│ │  concerns
│ │  public
│ │  admins_controller.rb
│ │  application_controller.rb
│ │  articles_controller.rb
│ └  <mark>authors_controller.rb</mark>
│  helpers
│  javascript
│  jobs
│  mailers
│  models
│  policies
│ └  application_policy.rb
└  views
 bin
 config
 db
 lib
...
{% endpre_whiteboard %}

{% highlight_caption /app/controller/authors_controller.rb %}
{% highlight ruby linenos %}
class AuthorsController < ApplicationController
  protect_from_forgery prepend: true, with: :exception
  before_action :authenticate_author!
  layout "application_author"

  def pundit_user
    current_author
  end

  protected

  def after_sign_in_path_for(_resource)
    authors_root_path
  end
end
{% endhighlight %}

Baris ke 6-8, saya mendefinisikan **pundit_user** sebagai **current_author**.

## Buat policy untuk Article

Karena yang ingin kita batasi adalah Article agar hanya Author si pemilik Article saja yang dapat memodifikasinya.

Struktur direktori dan file dari policy ini mengikuti dari controller namun menggunakan singular.

{% pre_whiteboard %}
 app
│  assets
│  channels
│  controllers
│  helpers
│  javascript
│  jobs
│  mailers
│  models
│  policies
│ │  <mark>author_policy</mark>
│ │ └  <mark>article_policy.rb</mark>
│ │  application_policy.rb
│ └  <mark>author_policy.rb</mark>
└  views
 bin
 config
 db
 lib
...
{% endpre_whiteboard %}

{% highlight_caption app/policies/author_policy.rb %}
{% highlight ruby linenos %}
class AuthorPolicy < ApplicationPolicy
end
{% endhighlight %}

{% highlight_caption app/policies/author/article_policy.rb %}
{% highlight ruby linenos %}
class Author::ArticlePolicy < AuthorPolicy
  def edit?
    record.user_id == user.id
  end
end
{% endhighlight %}

Misalkan, kita akan membatasi action **edit**, maka kita definisikan method **edit?** dengan isinya, apabila user_id dari record sama dengan id dari user yang sedang mengakses, maka diberikan ijin untuk mengedit.

## Authroize controller

Nah, kita telah mengatur policy untuk action edit, maka kita perlu memberikan authorization pada action edit di **articles_controller**.

{% highlight_caption app/controllers/authors/articles_controller.rb %}
{% highlight ruby linenos %}
class Authors::ArticlesController < AuthorsController
  # ...

  def edit
    @article = Article.find(params[:id])
    authorize @article, policy_class: Author::ArticlePolicy
  end

  # ...
end
{% endhighlight %}

Baris ke-6 adalah pemberian authorization pada action edit.

Parameter **policy_class** ini sebenarnya adalah cara manual untuk mengarahkan file policy.

Saya menggunakannya hanya sebagai contoh siapa tahu kita mendapatkan kasus-kasus khusus, seperti nama Object dengan nama Controller atau Policy tidak sama.

Selesai.










# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Selanjutnya, saya serahkan kepada imajinasi dan kreatifitas teman-teman. Hehe.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)




# Referensi

1. [github.com/varvet/pundit](https://github.com/varvet/pundit){:target="_blank"}
<br>Diakses tanggal: 2021/04/09
