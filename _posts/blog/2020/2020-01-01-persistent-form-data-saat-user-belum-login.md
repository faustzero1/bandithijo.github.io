---
layout: 'post'
title: "Mempertahankan Data pada Form ketika User Belum Melakukan Authentication"
date: 2020-01-01 11:36
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
description: "Catatan ini mengenai cara memperhankan data (persistent) pada sebuah form ketika user belum melakukan authentication atau registration pada Ruby on Rails."
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prerequisite

`Ruby 2.6.3` `Rails 5.2.3` `PostgreSQL 11.5`

# Prakata

Mengawali tahun 2020 ini, saya mencatat mengenai Ruby on Rails.

Kali ini mengenai bagaimana cara memberikan *user experience flow* yang baik dengan web aplikasi yang menggunakan form saat pengguna belum melakukan *authentication*.

# Permasalahan

Dalam mengisi form, misalkan form pemesanan (*order*), yang memiliki banyak inputan data, tentunya pengguna akan merasa kesal, apabila sudah memasukkan banyak data, namun saat menekan tombol *submit*, dan harus melakukan *sign in* atau *sign up* terlebih dahulu, setelah itu, data yang pengguna masukkan pada *order form* tadi sudah menghilang. Artinya, pengguna harus memasukkan kembali data-data yang sudah ia masukkan sebelumnya.

*User experience flow* di atas, tentunya akan membuat user merasa kesal.

# Penyelesaian Masalah

Kebetulan, web aplikasi kali ini menggunakan Devise gem untuk menghandle proses *authentication*.[<sup>1</sup>](#referensi)

Saya dapat memanfaatkan helper-helper module yang sudah disediakan oleh Devise.

Seperti, untuk membawa user kembali ke halaman sebelumnya, dengan `stored_location_for` dari `Devise::Controllers::StoreLocation`.

Untuk menyelesaikan permasalahan di atas, saya akan memodifikasi controller-controller yang menghandle proses-proses di atas.

Proses di atas terdiri dari:

1. **Order**, yang dihandle oleh `Users::OrderExperiencesController#create`
2. **Sign In**, yang dihandle oleh `Users::SessionsController`
3. **Sign Out**, yang dihandle oleh `Users::RegistrationsController`

<br>
**Bagaimana memertahankan data yang sudah dimasukkan sebelumnya pada Order form?**

Untuk membuat data yang ada pada form menjadi *persistent*, saya akan memanfaatkan **session**.[<sup>2</sup>](#referensi) Kemudian, setelah user melakukan *authentication*, session akan di-*passing* ke dalam variable dan akan dikosongkan.

## Order Experiences Controller

Karena proses order experience ini di-*handle* oleh action `:create`, maka saya perlu memodifikasi isi dari action ini.

{% highlight_caption app/controllers/users/order_experiences_controller.rb %}
{% highlight ruby linenos %}
# frozen_string_literal: true

class Users::OrderExperiencesController < ApplicationController
  # pastikan untuk tidak memfilter action :create, karena akan dihandling oleh
  # redirect rule yang akan dibuat
  before_action :authenticate_user!, except: [:create]

  def create
    # mengecek apakah pengunjung sudah sign in/sign up
    if current_user.nil?
      # menyimpan data dari form ke dalam session, yang akan digunakan setelah login/register
      session[:order] = params
      # redirect ke user login/register page
      redirect_to new_user_session_path
    else
      # jika user sudah login, diproses seperti biasa
      order = current_traveler.orders.create(order_params)
      redirect_to users_order_experience_path(order.id)
    end
  end

  # ...
  # ...

  private

  def order_params
    params.require(:order).permit(
      :trip_date, :time_slot, :total_traveler, :experience_id,
      traveler_attributes: [:id, :full_name, :email, :phone]
    )
  end
end
{% endhighlight %}

Pastikan pada callback `before_action :authenticate_user!`, buat pengecualian untuk action `:create`.

Selanjutnya, tinggal memodifikasi controller yang menghandle proses login/register.

## Sessions & Registrations Controller

Kedua controller ini adalah controller yang digenerate oleh Devise.

{% highlight_caption app/controllers/users/sessions_controller.rb %}
{% highlight ruby linenos %}
# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # ...

  # ...
  # ...

  protected

  # ...
  # ...

  # path yang akan dituju setelah sign in
  def after_sign_in_path_for(resource_or_scope)
    # memeriksa apakah ada data order yang tersimpan pada session
    if session[:order].present?
      # membuat order dengan data yang tersimpan pada session
      order = current_traveler.orders.create(session[:order]["order"])
      # mengosongkan session
      session[:order] = nil
      # redirect ke halaman order
      users_order_experience_path(order.id)
    else
      # jika tidak ada data order yang tersimpan pada session
      stored_location_for(resource_or_scope) || super
    end
  end
end
{% endhighlight %}


{% highlight_caption app/controllers/users/registrations_controller.rb %}
{% highlight ruby linenos %}
# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # ...

  # ...
  # ...

  protected

  # ...
  # ...

  # path yang akan dituju setelah sign up
  def after_sign_up_path_for(resource_or_scope)
    # memeriksa apakah ada data order yang tersimpan pada session
    if session[:order].present?
      # membuat order dengan data yang tersimpan pada session
      @order = current_traveler.orders.create(session[:order]["order"])
      # mengosongkan session
      session[:order] = nil
      # redirect ke halaman order
      users_order_experience_path(@order.id)
    else
      # jika tidak ada data order yang tersimpan pada session
      stored_location_for(resource_or_scope) || super
    end
  end

  # ...
  # ...
end
{% endhighlight %}

Selesai!

Mungkin pada kesempatan yang lain, akan saya buatkan reponya.

Mudah-mudahan bermanfaat.

Terima kasih.

(^_^)









# Referensi

1. [How To: Redirect back to current page after sign in, sign out, sign up, update](https://github.com/plataformatec/devise/wiki/How-To:-Redirect-back-to-current-page-after-sign-in,-sign-out,-sign-up,-update){:target="_blank"}
<br>Diakses tanggal: 2020/01/01

2. [Action Controller Overview > Session](https://guides.rubyonrails.org/action_controller_overview.html#session){:target="_blank"}
<br>Diakses tanggal: 2020/01/01

3. [blog.justinthiele.com/retaining-form-data-through-a-login-process-a](https://blog.justinthiele.com/retaining-form-data-through-a-login-process-a){:target="_blank"}
<br>Diakses tanggal: 2020/01/01
