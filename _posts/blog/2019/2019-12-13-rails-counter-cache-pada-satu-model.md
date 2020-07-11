---
layout: 'post'
title: "Rails Counter Cache pada Satu Model"
date: 2019-12-13 20:49
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Rails']
pin:
hot:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prerequisite

`Ruby 2.6.3` `Rails 5.2.3` `PostgreSQL 11.5`

# Prakata

**Counter Cache**, apa itu?

Merupakan field/kolom yang akan menyimpan hasil perhitungan dari tabel yang berasosiasi dengan dirinya (tabel yang memiliki field/kolom counter cache).

Dengan menggunakan counter cache, kita akan memperoleh keuntungan dimana object yang kita buat tidak perlu memanggil database untuk mendapatkan suatu nilai total, misal `COUNT(*)` query, jadi cukup dengan mengakses counter cache field saja.

Contohnya kalau dalam Rails project seperti ini.

```ruby
@user.posts.size
```

Atau

```ruby
@user.posts.count
```

Kedua Active Record di atas akan menghasilkan SQL query serperti ini kira-kira.

```sql
SELECT COUNT(*) FROM "articles" WHERE "articles"."author_id" = $1
```

Nah, penggunaan `size()` dan `count()` ini akan menambah query `COUNT(*)` yang artinya akan menambahkan query baru untuk memanggil database.

Namun, pada catatan ini, saya tidak membahas secara mendalam mengenai Counter Cache, teman-teman dapat membacanya pada blog dari teman-teman yang lain.

Saya akan membahas kasus yang mungkin cukup unik, yang saya alami.

# Permasalahan

Seperti definisi yang sudah saya jelaskan di atas. Counter Cache adalah salah satu options dari banyak options yang dapat kita gunakan apabila kita menggunakan Active Record Association yaitu `belongs_to`.[<sup>1</sup>](#referensi).

Active Record Association, sesuai namanya, Association, adalah hubungan/koneksi antara 2 Active Record model.

Yang artinya options counter cache dapat kita gunakan pada model yang saling berasosiasi.

Nah, sedangkan, saya ingin menggunakannya hanya pada 1 model.

Apakah bisa? Tentu saja bisa. Saya cukup lama mencari solusi ini.

# Sekenario

Saya ingin membuat fitur "Invite Friend" yang nantinya akan terdapat 2 buah field.

1. Field `inviting_user_id`, akan menampung data berupa id user yang menginvite user tersebut.
2. Field `inviting_users_count`, akan menampung berapa banyak user yang berhasil diinvite.

Di sini, saya tidak menggunakan model lain selain model user.

Yang mana, seharusnya, untuk dapat menggunakan counter_cache, kita harus memiliki dua model yang saling berasosiasi menggunakan `belongs_to`.

# Pemecahan Masalah

Pertama-tama seperti halnya convetion pada counter cache, saya perlu manambahkan kolom baru pada tabel yang ingin saya buatkan counter cachenya.

Buat migration untuk menambahkan kolom counter cache.

```
$ rails g migration add_inviting_user_to_users
```
<pre>
    <span style="color:#859900;">create</span> 20191122174434_add_inviting_user_count_to_users.rb
</pre>

Setelah file migrasi jadi, saya akan menambahkan dua buah kolom.

```ruby
# db/migrate/20191122174434_add_inviting_user_count_to_users.rb

class AddInvitingUsersCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :inviting_user_id, :integer
    add_column :users, :inviting_users_count, :integer, default: 0, null: false
  end
end
```

Untuk field `inviting_users_count` adalah field yang saya siapkan untuk counter cache, yang harus mengikuti aturan penamaan kolom untuk counter cache. yaitu, penamaannya harus plural (jamak).

Kemudian, jalankan migrationnya.

```
$ rails db:migrate
```

Apabila berhasil, berikut ini adalah bentuk dari skema database setelah migrasi berhasil kita jalankan.

<pre>
<span style="color:#586e75;font-style:italic;"># db/schema.rb</span>

create_table "users", force: :cascade do |t|
  ...
  ...
  ...
  <mark>t.integer "inviting_user_id"</mark>
  <mark>t.integer "inviting_users_count", default: 0, null: false</mark>
end


<span style="color:#586e75;font-style:italic;"># Users table</span>
+------------------------+-----------------------------+-----------------------------------------------------+
| Column                 | Type                        | Modifiers                                           |
|------------------------+-----------------------------+-----------------------------------------------------|
| id                     | bigint                      |  not null default nextval('users_id_seq'::regclass) |
| email                  | character varying           |  not null default ''::character varying             |
| encrypted_password     | character varying           |  not null default ''::character varying             |
| created_at             | timestamp without time zone |  not null                                           |
| updated_at             | timestamp without time zone |  not null                                           |
| full_name              | character varying           |                                                     |
| <mark>inviting_user_id       | integer</mark>                     |                                                     |
| <mark>inviting_users_count   | integer                     |  not null default 0</mark>                                 |
+------------------------+-----------------------------+-----------------------------------------------------+
</pre>

Selanjutnya tinggal membuat asosiasi pada user model.

```ruby
# app/models/user.rb

class User < ApplicationRecord
  ...
  ...

  has_many   :inviting_users,
             class_name: 'User',
             foreign_key: :inviting_user_id
  belongs_to :inviting_user,
             class_name: 'User',
             counter_cache: :inviting_users_count,
             optional: true

  ...
  ...
end
```

Saya rasa, sudah jelas dari kode di atas. Bagaimana relasi antar kedua field dalam satu model dapat terjadi.

Kira-kira begini cerita asosiasi yang terjadi.

User memiliki banyak `:inviting_user`, yang berasal dari `User` class, yang akan ditempatkan pada field `:inviting_user_id`.

Data pada `:inviting_user` merupakan data milik User, yang berasal dari `User` class, yang akan ditempatkan pada field `:inviting_users_count`, asosiasi ini bersifat `optional: true`, sehingga, apabila tidak terdapat asosiasi dengan object `:inviting_user`, data user tetap akan dibuat.

Tujuan dari `optional: true` adalah untuk melewati validasi *presence* apabila data baru akan dibuat. Karena secara default pada Rails 5, `belongs_to` akan bernilai `optional: false`.

Apabila tidak, maka user baru yang tidak memiliki relasi dengan user lain, tidak akan dapat dibuat.

Begini kira-kira hasilnya.

<pre>
<span style="color:#586e75;font-style:italic;"># Users table</span>
+------+-----------------------+--------------------+------------------------+
| id   | full_name             | inviting_user_id   | inviting_users_count   |
|------+-----------------------+--------------------+------------------------|
| 1    | Rizqi Assyaufi        | &lt;null&gt;             | 1                      |
| 2    | Baik Budiman          | 1                  | 0                      |
</pre>

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/P5NkZJFn/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 1 - Baik Budiman melakukan registrasi dengan menggunakan kode referral yang diberikan oleh Rizqi Assyaufi.</p>

Selesai!

Mudah-mudahan catatan kali ini dapat bermanfaat bagi teman-teman yang memerlukan.

Dokumentasi lebih lengkap dapat dibaca pada daftar referensi yang saya sertakan di bawah.

Terima kasih

(^_^)



# Referensi

1. [guides.rubyonrails.org/association_basics.html#options-for-belongs-to](https://guides.rubyonrails.org/association_basics.html#options-for-belongs-to){:target="_blank"}
<br>Diakses tanggal: 2019/12/13

2. [guides.rubyonrails.org/association_basics.html#options-for-has-many-counter-cache](https://guides.rubyonrails.org/association_basics.html#options-for-has-many-counter-cache){:target="_blank"}
<br>Diakses tanggal: 2019/12/13

3. [stackoverflow.com/questions/35265225/rails-counter-cache-on-the-same-model](https://stackoverflow.com/questions/35265225/rails-counter-cache-on-the-same-model){:target="_blank"}
<br>Diakses tanggal: 2019/12/13
