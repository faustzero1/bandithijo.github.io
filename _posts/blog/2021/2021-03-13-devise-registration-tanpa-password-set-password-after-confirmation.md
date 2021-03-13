---
layout: 'post'
title: "Devise Registration Tanpa Password, Set Password Setelah Confirmation"
date: 2021-03-13 14:00
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
description: "Catatan kali ini tentang pemanfaatan Devise gem untuk registration tanpa menginputkan password, password akan diminta setelah user membuka link konfirmasi yang dikirimkan via email."
---

# Latar Belakang Masalah

Catatan kali ini tentang pemanfaatan Devise gem untuk registration tanpa menginputkan password, password akan diminta setelah user membuka link konfirmasi yang dikirimkan via email.

# Pemecahan Masalah

## Gemfile

1. [**Devise**](https://github.com/heartcombo/devise){:target="_blank"}, untuk authentication
2. [**Simple Form**](https://github.com/heartcombo/simple_form){:target="_blank"}, untuk menghandle form agar lebih praktis*

\* Optional

{% highlight_caption Gemfile %}
{% highlight ruby linenos %}
gem 'devise',      '~> 4.7', '>= 4.7.3'
gem 'simple_form', '~> 5.1'
{% endhighlight %}

Jalankan bundle install,

{% shell_cmd $ %}
bundle install
{% endshell_cmd %}

Kemudian install kedua gem tersebut ke dalam web aplikasi.

Dahulukan **simple_form**, dengan begitu form-form yang akan digenerate oleh **Devise** akan otomatis menggunakan form dari simple_form.

{% shell_cmd $ %}
rails g simple_form:install
{% endshell_cmd %}

Setelah itu, **devise**.

{% shell_cmd $ %}
rails g devise:install
{% endshell_cmd %}

## ActionMailer

Selanjutnya konfigurasi ActionMailer untuk environment development.

{% highlight_caption config/environments/development.rb %}
{% highlight ruby linenos %}
Rails.application.configure do
  # ...

  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = { address: '127.0.0.1', port: 1025 }

  # ...
end
{% endhighlight %}

Baris 10 dan 12, adalah configurasi untuk MailCatcher.

Untuk yang belum tahu MailCatcher, dapat dibaca di sini, [**Konfigurasi Ruby on Rails ActionMailer pada Local Environment dengan MailCatcher**](/blog/ruby-on-rails-actionmailer-local-mailcatcher){:target="_blank"}.

## Devise Initializer

Kita perlu merubah beberapa konfigurasi pada Devise initializer.

{% highlight_caption config/initializer/devise.rb %}
{% highlight ruby linenos %}
Devise.setup do |config|
  # ...

  # ==> Mailer Configuration
  # Configure the e-mail address which will be shown in Devise::Mailer,
  # note that it will be overwritten if you use your own mailer class
  # with default "from" parameter.
  config.mailer_sender = 'no-reply@example.com'

  # If true, requires any email changes to be confirmed (exactly the same way as
  # initial account confirmation) to be applied. Requires additional unconfirmed_email
  # db field (see migrations). Until confirmed, new email is stored in
  # unconfirmed_email column, and copied to email column on successful confirmation.
  config.reconfirmable = false

  # ...
end
{% endhighlight %}

Ganti `config.mailer_sender =` sesuai alamat yang teman-teman inginkan.

Ganti `config.reconfirmable =` menjadi **false**.

## Devise User Model

Kita akan membuat User model dengan devise.

{% shell_cmd $ %}
rails g devise User
{% endshell_cmd %}

Buka migrationsnya, dan enablekan `:confirmation_token`, `:confirmed_at`, `:confirmation_sent_at` pada bagian **Confirmable**.

{% highlight_caption db/migrate/20210312144943_devise_create_users.rb %}
{% highlight ruby linenos %}
# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      # ...

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      # ...
    end

      # ...
  end
end
{% endhighlight %}

Saya akan menambahkan filed **name**.

{% shell_cmd $ %}
rails g migration add_name_to_users name:string
{% endshell_cmd %}

{% highlight_caption db/migration/20210312145059_add_name_to_users.rb %}
{% highlight ruby linenos %}
class AddNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
  end
end
{% endhighlight %}

Sip, jalankan migration.

{% shell_cmd $ %}
rails db:migrate
{% endshell_cmd %}

Aktifkan module `:confirmable` pada **user.rb** model.

{% highlight_caption app/models/user.rb %}
{% highlight ruby linenos %}
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
end
{% endhighlight %}

Sekalian, tambahkan logic untuk menghandle registration tanpa password di bawah module-module Devise tersebut.

{% highlight_caption app/modles/user.rb %}
{% highlight ruby linenos %}
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  # new function to set the password without knowing the current
  # password used in our confirmation controller.
  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end

  def password_match?
     self.errors[:password] << "can't be blank" if password.blank?
     self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
     self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
     password == password_confirmation && !password.blank?
  end

  # new function to return whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

  # Devise::Models:unless_confirmed` method doesn't exist in Devise 2.0.0 anymore.
  # Instead you should use `pending_any_confirmation`.
  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end

  def password_required?
    # Password is required if it is being set, but not for new records
    if !persisted?
      false
    else
      !password.nil? || !password_confirmation.nil?
    end
  end
end
{% endhighlight %}

## Controller

Kita akan membuat 2 custom controller yang merupakan turunan dari Devise controller.

1. RegistrationsController < Devise::RegistrationsController
2. ConfirmationsController < Devise::ConfirmationsController

{% highlight_caption app/controllers/registrations_controller.rb %}
{% highlight ruby linenos %}
class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end

{% endhighlight %}

{% highlight_caption app/controllers/confirmations_controller.rb %}
{% highlight ruby linenos %}
class ConfirmationsController < Devise::ConfirmationsController
  # Remove the first skip_before_filter (:require_no_authentication) if you
  # don't want to enable logged users to access the confirmation page.
  # If you are using rails 5.1+ use: skip_before_action
  # skip_before_filter :require_no_authentication
  # skip_before_filter :authenticate_user!

  # PUT /resource/confirmation
  def update
    with_unconfirmed_confirmable do
      if @confirmable.has_no_password?
        @confirmable.attempt_set_password(params[:user])
        if @confirmable.valid? and @confirmable.password_match?
          do_confirm
        else
          do_show
          @confirmable.errors.clear # so that we wont render :new
        end
      else
        @confirmable.errors.add(:email, :password_already_set)
      end
    end

    if !@confirmable.errors.empty?
      self.resource = @confirmable
      render 'devise/confirmations/new' # Change this if you don't have the views on default path
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    with_unconfirmed_confirmable do
      if @confirmable.has_no_password?
        do_show
      else
        do_confirm
      end
    end
    unless @confirmable.errors.empty?
      self.resource = @confirmable
      render 'devise/confirmations/new' # Change this if you don't have the views on default path
    end
  end

  protected

  def with_unconfirmed_confirmable
    @confirmable = User.find_or_initialize_with_error_by(:confirmation_token, params[:confirmation_token])
    if !@confirmable.new_record?
      @confirmable.only_if_unconfirmed {yield}
    end
  end

  def do_show
    @confirmation_token = params[:confirmation_token]
    @requires_password = true
    self.resource = @confirmable
    render 'devise/confirmations/show' # Change this if you don't have the views on default path
  end

  def do_confirm
    @confirmable.confirm
    set_flash_message :notice, :confirmed
    sign_in_and_redirect(resource_name, @confirmable)
  end
end
{% endhighlight %}

Baris baris ke 58, kita akan membuat sendiri custom view template tersebut.

<br>
Pada catatan ini, saya membuat homepage, untuk tempat bernaung setelah melakukan registrasi dan juga sebagai **root_path**.

{% shell_cmd $ %}
rails g controller Home index
{% endshell_cmd %}


## Routes

{% highlight_caption config/routes.rb %}
{% highlight ruby linenos %}
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  devise_for :users, controllers: {
    registrations: 'registrations',
    confirmations: 'confirmations'
  }

  as :user do
    put '/users/confirmation' => 'confirmations#update', via: :patch, as: :update_user_confirmation
  end
end
{% endhighlight %}


## Devise Views

Kita akan mengenerate Devise views.

{% shell_cmd $ %}
rails g devise:views
{% endshell_cmd %}

Yang perlu dimodifikasi adalah:

1. mengedit registrations/new, menambahkan field name, menghilangkan field password & password_confirmation
2. membuat confirmations/show, meletakkan field password & password_confirmation

<br>
Modifikasi view template **registrations/new**.

{% highlight_caption app/views/devise/registrations/new.html.erb %}
{% highlight eruby linenos %}
<h2>Sign up</h2>

<%= simple_form_for(resource, as: resource_name, url: registration_path(resource_name)) do |f| %>
  <%= f.error_notification %>

  <div class="form-inputs">
    <%= f.input :name,
                required: true,
                autofocus: true,
                input_html: { autocomplete: "name" }%>
    <%= f.input :email,
                required: true,
                input_html: { autocomplete: "email" }%>

    <%# :password & :password_confirmation, dipindahkan ke views/devise/confirmations/show.html.erb %>
  </div>

  <div class="form-actions">
    <%= f.button :submit, "Sign up" %>
  </div>
<% end %>

<%= render "devise/shared/links" %>
{% endhighlight %}

{% image https://i.postimg.cc/DzyQ71qR/gambar-02.png | 02 %}

Dapat dilihat, pada form registrasi ini, hanya menampilkan input field berupa **name** dan **email**.

Saya memindahkan field password dan password_confirmation ke halaman yang lain,

yaitu halaman **views/devise/confirmations/show.html.erb**.

{% highlight_caption app/views/devise/confirmations/show.html.erb %}
{% highlight eruby linenos %}
<h2>Account Activation<% if resource.try(:user_name) %> for <%= resource.user_name %><% end %></h2>

<%= simple_form_for(resource, as: resource_name, url: update_user_confirmation_path, html: { method: :put }) do |f| %>
  <%= devise_error_messages! %>

  <div class="form-inputs">
    <% if @requires_password %>
      <%= f.input :password,
                  required: true,
                  autofocus: true,
                  hint: ("#{@minimum_password_length} characters minimum" if @minimum_password_length),
                  input_html: { autocomplete: "new-password" } %>
      <%= f.input :password_confirmation,
                  required: true,
                  input_html: { autocomplete: "new-password" } %>
    <% end %>

    <%= hidden_field_tag :confirmation_token,@confirmation_token %>
  </div>

  <div class="form-actions">
    <%= f.button :submit, "Activate" %>
  </div>
<% end %>
{% endhighlight %}

{% image https://i.postimg.cc/5t7Byjgy/gambar-03.png | 03 %}

<br>
{% highlight_caption app/views/devise/confirmations/new.html.erb %}
{% highlight ruby linenos %}
<h2>Resend confirmation instructions</h2>

<%= simple_form_for(resource, as: resource_name, url: confirmation_path(resource_name), html: { method: :post }) do |f| %>
  <%= f.error_notification %>
  <%= f.full_error :confirmation_token %>

  <div class="form-inputs">
    <%= f.input :email,
                required: true,
                autofocus: true,
                value: (resource.pending_reconfirmation? ? resource.unconfirmed_email : resource.email),
                input_html: { autocomplete: "email" } %>
  </div>

  <div class="form-actions">
    <% if resource.pending_reconfirmation? %>
      <%= f.button :submit, "Resend confirmation instructions" %>
    <% end %>
  </div>
<% end %>

<% unless user_signed_in? %>
  <%= render "devise/shared/links" %>
<% end %>
{% endhighlight %}

<br>

Pasang nav untuk menempatkan link indikator apabila user telah login atau belum.

{% highlight_caption app/layouts/application.html.erb %}
{% highlight eruby linenos %}
<!DOCTYPE html>
<html>
  <head>
    <!-- ... -->
  </head>

  <body>
    <nav style="margin-bottom: 20px;">
      <% if user_signed_in? %>
        <%= link_to current_user.name, edit_user_registration_path, class:"navbar-item" %>
        <%= link_to "Log Out", destroy_user_session_path, method: :delete, class:"navbar-item" %>
      <% else %>
        <% unless [
            new_user_session_path,
            new_user_registration_path,
            new_user_confirmation_path,
            user_confirmation_path,
            new_user_password_path
        ].include? request.path %>
          <%= link_to "Sign In", new_user_session_path, class:"navbar-item" %>
          <%= link_to "Sign up", new_user_registration_path, class:"navbar-item"%>
        <% end %>
      <% end %>
    </nav>

    <%= yield %>
  </body>
</html>
{% endhighlight %}


<br>
# Demonstrasi

{% image https://i.postimg.cc/ZqNC6RFV/gambar-01.gif | 01 %}


<br>
# Repositori

[**github.com/bandithijo/demo_devise_confirmable**](https://github.com/bandithijo/demo_devise_confirmable){:target="_blank"}




<br>
# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Selanjutnya, saya serahkan kepada imajinasi dan kreatifitas teman-teman. Hehe.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)




# Referensi

1. [mailcatcher.me](https://mailcatcher.me/){:target="_blank"}
<br>Diakses tanggal: 2021/03/13

2. [Let's Build: With Ruby on Rails - Project Management App - Part 2](https://youtu.be/RpyzUdxZolY){:target="_blank"}
<br>Diakses tanggal: 2021/03/13
