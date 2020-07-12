---
layout: 'post'
title: "Membuat Fitur Pertemanan dengan Referral Link pada Rails"
date: 2020-02-10 15:10
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
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prerequisite

`Ruby 2.6.3` `Rails 5.2.3` `PostgreSQL 11.5`

# Prakata

Catatan kali ini, saya akan menuliskan tentang fitur yang bertujuan untuk menambahkan teman dengan menggunakan "*referral link*" pada Ruby on Rails.

# Permasalahan

Saya memiliki tabel **users** menampung data user dan tabel **friendships**, yang menampung data relasi antar user.

Sebagai ilustrasi user dengan ID 1 berelasi dengan user dengan ID 2 pada tebal yang sama, yaitu tabel users.

# Pemecahan masalah

## Migration

Pertama, buat dulu Active Record Migration untuk membuat users model.

```
$ rails generate model user full_name email password invitation_token
```

Selanjutnya, modifikasi pada file migration tersebut, seperti di bawah ini.

```ruby
# db/migrate/20200128080714_create_users.rb

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email, default: "", null: false
      t.string :password, default: "", null: false
      t.string :invitation_token

      t.timestamps
    end
  end
end
```

Saya juga menambahkan field `:invitation_token` untuk menampung data token yang akan disematkan (dipasang) sebagai kode unik pada akhiran *referral link*.

<br>
Selanjutnya, buat Active Record Migration untuk membuat friendships model.

Migration ini adalah migration yang menentukan relasi antar user pada tabel friendships.

```
$ rails generate model friendship
```

Selanjutnya, modifikasi file migration tersebut, seperti di bawah ini.

```ruby
# db/migrate/20200128121401_create_users.rb

class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :friend
      t.string :status, default: 'pending', null: 'false'

      t.timestamps
    end
  end
end
```

Perhatikan tipe data dari `:user` dan `:friend` yang merupakan `belongs_to`.

Kedua field ini mengarah pada tabel users. Yang nantinya akan menyimpan data berupa ID (`:user_id` dan `:friend_id`) dengan tipe data integer. Dengan foreign_key yang akan dipegang oleh field `:user_id` yang akan berfungsi sebagai **user yang menginvite**. Sedangkan, `:friend_id` sebagai **user yang diinvite**.

Pada tabel friendships ini, saya juga menambahkan field `:status`. Yang nantinya akan menampung 3 nilai.

```ruby
['pending', 'approved', 'rejected']
```

Field `:status` ini mungkin nantinya dapat dimanfaatkan untuk fitur *commission amount*. Namun, pada catatan kali ini, saya tidak membahas hal ini.

Selanjutnya, tinggal menjalankan kedua migration tersebut.

```
$ rails db:migrate
```

## Model

Saya akan menggunakan `belongs_to` pada friendship model. Sedangkan pada user model saya akan menggunakan `has_many` dan `has_many :through` association.

Saya sempat membaca, dapat pula menggunakan `has_and_belongs_to_many` (HABTM) association. Namun, belum saya coba.

Saya akan mulai dari user model.

```ruby
# app/models/user.rb

class User < ApplicationRecord
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
end

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  full_name              :string
#  email                  :string           default(""), not null
#  password               :string           default(""), not null
#  invitation_token       :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
```

`has_many :friendships` yang akan menampung nilai ID dari user yang menginvite. Pada tabel friendships, nilai ini akan disimpan pada field `:user_id`.

Sedangkan, `has_many :friends, through: :friendships` yang akan menampung nilai ID dari user yang diinvite. Pada tabel friendships, nilai akan disimpan pada field `:friend_id`.

<br>
Selanjutnya untuk friendship model.

```ruby
# app/models/friendship.rb

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
end

# == Schema Information
#
# Table name: friendships
#
#  id         :bigint           not null, primary key
#  status     :string           default("pending")
#  friend_id  :bigint
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_friendships_on_friend_id  (friend_id)
#  index_friendships_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
```

Nah, sudah jelas sekali, kalau data yang ada di tabel friendships ini akan berasosiasi dengan tabel users.
Namun, memiliki asosiasi antar user pada tabel user.

1. Yang mengundang `:user`
2. Yang diundang `:friend`

Karena `:friend` juga merupakan association dari user model, maka saya perlu mendefinisikan `class_name: 'User'`.

Selanjutnya, saya akan membuat sebuah method yang akan digunakan untuk mengenerate invitation_token.

Saya akan buat dengan menggunakan concern.

```ruby
# app/models/concerns/generate_invitation_token.rb

module GenerateInvitationToken
  extend ActiveSupport::Concern

  included do
    before_create :generate_invitation_token
  end

  protected

  def generate_invitation_token
    begin
      self.invitation_token = self.full_name.downcase.strip.gsub(' ', '')
      generate_another_token(self.invitation_token)
    end while User.exists?(invitation_token: self.invitation_token)
  end

  def generate_another_token(token)
    self.invitation_token = token + (User.where("invitation_token ilike ?", "%#{token}%").count + 1).to_s
  end
end
```

module GenerateInvitationToken di atas, akan membuatkan invitation_token dari `:full_name` dan akan menambahkan nila 1 di belakangnya. Sehingga, apabila terdapat dua buah user dengan `:full_name` yang sama, maka akan dibedakan berdasarkan angka terakhir pada invitation_token (kode unik).

Nah, tinggal diincludekan pada user model.

```ruby
# app/models/user.rb

class User < ApplicationRecord
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  include GenerateInvitationToken
end
```

Setelah merelasikan antar model dan , selanjutnya saya akan mencoba relasi antar user pada Rails Console.

Buat dua buah user baru.

```
irb(main):001:0> budi = User.create(email: 'budibudiman@gmail.com', full_name: 'Budi Budiman', password: 'budiman')
irb(main):002:0> nina = User.create(email: 'ninaremina@gmail.com', full_name: 'Nina Remina', password: 'ninaremina')
```

Sekarang saya akan menggunakan method `.friendships.create`, untuk membuat pertemanan antar Budi dan Nina.

Budi sebagai yang mengundang, Nina sebagai yang diundang.

```
irb(main):003:0> budi.friendships.create(friend: nina)
```
```
(0.2ms)  BEGIN
Friendship Create (9.5ms)  INSERT INTO "friendships" ("user_id", "friend_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4) RETURNING "id"  [["user_id", 21], ["friend_id", 22], ["created_at", "2020-02-10 23:06:36.308621"], ["updated_at", "2020-02-10 23:06:36.308621"]]
(2.2ms)  COMMIT

=> #<Friendship id: 1, user_id: 1, friend_id: 2, status: "pending", created_at: "2020-02-10 23:06:36", updated_at: "2020-02-10 23:06:36">
```

Nah, pada Active Record sudah berhasil.

Selanjutnya tinggal memasangnya ke dalam controller.

## Controller

Karena proses penambahan pertemanan ini terjadi pada saat user yang diundang melakukan registration (*). Maka saya akan menambahkan fungsi penambahan pertemanan ini di user registration controller pada action create (`Users::RegistrationsController#create`).

<!-- INFORMATION -->
<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>Contoh controller di bawah ini adalah registrations_controller yang dimiliki oleh Devise.</p>
<p>Karena saya membuat model user, menggunakan Devise generator.</p>
</div>


```ruby
# app/controllers/users/registrations_controller.rb

class Users::RegistrationsController < Devise::RegistrationsController
  ...
  ...

  def new
    if params.has_key?(:invitation_token)
      # Untuk digunakan pada hidden_field di halaman registrasi
      @invitation_token = params[:invitation_token]
    end
    super
  end

  def create
    super
    unless params[:user][:invitation_token].blank?
      if resource.save
        # Untuk menambahkan teman yang diundang ke teman yang mengundang
        inviter = User.find_by_invitation_token(params[:user][:invitation_token])
        inviter.friendships.create(friend: resource)
        resource.save
      end
    end
  end

  ...
  ...

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [
        # permit :invitation_token pada user_params
        :full_name, :date_of_birth, :locale, :rate, :invitation_token
      ]
    )
  end
end
```

Siapkan juga controller untuk `Users::FriendshipsController`.

```ruby
# app/controllers/users/friendships_controller.rb

class Users::FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @invited_friends = InviteFriend.where(user_id: current_user.id)
    @invitation_token_url = request.base_url + '/invite/' + current_user.invitation_token
  end
end
```

Karena saya menggunakan Devise, maka saya memiliki `current_user`.

Instance variable `@invitation_token_url` nanti akan diguanakan pada view template.

## Routes

Selanjutnya, saya akan menambahkan routing untuk *referral link* agar langsung diarahkan ke halaman registrasi (*).

```ruby
# config/routes.rb

Rails.application.routes.draw do
  ...
  ...
  ...
  get 'referral=:invitation_token' => 'users/registrations#new'
end
```

Bentuk dari url dapat teman-teman sesuaikan sendiri.

## View Template

Yang perlu dikerjakan pada view template ada dua bagian.

Pertama, bagian halaman registrasi.

Kedua, bagian halaman user profile yang akan menampilkan tabel yang berisi daftar teman.

Saya akan mulai dari bagian pertama.

**Halaman Registrasi**

Pada view template, saya perlu untuk menampung nilai instance variable `@invitation_token` yang pada `users_controller#new` berisi `params[:user][:invitation_token]`.

```erb
<!-- app/views/users/registrations/new.html.erb -->

<%= form_for(resource, as: resource_name, url: registration_path(resource_name)) do |f| %>
  ...
  ...
  ...

  <div class="input-group">
    <%= f.hidden_field :invitation_token, value: @invitation_token %>
  </div>

  <%= f.submit "Sign Up", class: "btn btn-primary btn-block" %>

  ...
  ...
<% end %>
```

<!-- INFORMATION -->
<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>Path yang saya gunakan di atas juga merupakan path milik Devise.</p>
</div>

<br>
**User Profile Menu**

Bagian kedua, tampilan frontend untuk user yang mengundang.

Paga bagian ini akan terdapat *referral link* yang berisi invitation_token yang akan digunakan oleh user untuk mengundang teman.

Selain itu, juga akan terdapat tabel yang menunjukkan siapa-siapa saja teman yang sudah diundang.

Sebelumnya, saya sudah menyimpakan controller dengan action index untuk user friendships_controller ini di atas (pada bagian controller).

```erb
<!-- app/views/users/friendships/index.html.erb -->

...
...
...

<!-- Invitation Token -->
<div class="mb-2 mb-sm-0">
  <text id="invitation-token">
    <%= @invitation_token_url %>
  </text>
</div>
<div class="d-flex align-items-center">
  <span id="copied"></span>
  <span id="copy-link" onclick="copyToClipboard('invitation-token')">
    Copy Link
  </span>
</div>
<!-- END Invitation Token -->

<!-- Friendship list -->
<div class="row">
  <table class="table">
    <thead>
      <tr>
        <td>Name</td>
        <td>Joined Date</td>
        <td>Commission</td>
      </tr>
    </thead>
    <tbody>
      <% @invited_friends.each do |friend| %>
        <tr>
          <td width="60%">
            <%= image_tag(friend.friend.image_url || "avatar/profile.png", class: "rounded-circle") %>
            <%= friend.friend.full_name %>
          </td>
          <td>
            <%= friend.friend.created_at.strftime("%d %b %Y") %>
          </td>
          <% if friend&.status == 'pending' %>
            <td class="text-warning">Pending</td>
          <% elsif friend&.status == 'approved' %>
            <td class="text-primary">RM20</td>
          <% elsif friend&.status == 'rejected' %>
            <td class="text-danger">Rejected</td>
          <% end %>
        </tr>
      <% end %>
    </tbody>
  </table>
</div>
<!-- END Friendship list -->

```

Saya menambahkan fungsi "Copy URL" agar lebih praktis, tinggal tekan tombol dan *referral link* akan tercopy ke dalam clipboard.

```erb
<!-- app/views/users/friendships/index.html.erb -->

...
...
<!-- END Friendship list -->

<script>
  // For Copy Link
  function copyToClipboard(id) {
    var from = document.getElementById(id);
    var range = document.createRange();
    window.getSelection().removeAllRanges();
    range.selectNode(from);
    window.getSelection().addRange(range);
    document.execCommand('copy');
    window.getSelection().removeAllRanges();
  };

  // For Notification Text "Copied!" After copy link button clicked
  $('body').on("click", "#copy-link", function() {
    notification("<%= t('user.copied') %>!", 5000)
  });
  function notification(s, time) {
    $("<span class='text-primary font-family-medium'>"+s+"</span>").appendTo('#copied').fadeTo(time, 1, function() {
      $(this).fadeTo(1000, 0, function() {
        $(this).remove()
      });
    });
  };
</script>
```

# Kekurangan(*)

**Kekurangan** dari fitur yang saya buat ini adalah dalam hal *user experience* (UX).

Karena ketika user menerima *referral link*, user langsung disuguhkan dengan halaman registrasi. Hal ini menjadi kekurangan, karena user tidak dapat melakukan eksplorasi pada halaman-halaman di web terlebih dahulu.

# Pesan Penulis

Oke, saya akhiri catatan ini.

Mudah-mudahan sedikit banyak dapat bermanfaat buat teman-teman yang memerlukan.

Terima kasih

(^_^)



# Referensi

1. [guides.rubyonrails.org/association_basics.html](https://guides.rubyonrails.org/association_basics.html){:target="_blank"}
<br>Diakses tanggal: 2020/02/10

2. [medium.com/@carlescliment/about-rails-concerns-a6b2f1776d7d](https://medium.com/@carlescliment/about-rails-concerns-a6b2f1776d7d){:target="_blank"}
<br>Diakses tanggal: 2020/02/10
