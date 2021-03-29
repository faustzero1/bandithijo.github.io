---
layout: 'post'
title: "Rails Seeding dengan Spesifik Single atau Multiple Seed File"
date: 2021-03-29 19:00
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
description: "Catatan kali ini, saya akan mencatatat tentang bagaimana mendiferensiasi seeds sesuai kategori tertentu dan juga menjalankan rails db:seed untuk single spesifik file."
---

# Prerequisite

`Ruby 3.0.0` `Rails 6.1.3.1`

# Latar Belakang Masalah

Pada Rails project yang sederhana, mungkin tidak akan terlalu mengalami kendala apabila menjalankan seeds dari file **db/seeds.rb**.

Umumnya, Junior Rails Developer akan meletakkan semua seeds pada file tersebut. Mulai dari seed untuk membuat berbagai tipe user (misal; admin, guest, customer, dll.), membuat dan mengisi table product, dan lain sebagainya, akan campur aduk menjadi satu di dalam file **db/seeds.rb** tersebut.

Hal ini wajar, karena secara default, saat membuat project baru, Rails menyediakan skeleton seperti itu.

{% pre_whiteboard %}
 app
 bin
 config
 db
│  migrate
│  schema.rb
└  <mark>seeds.rb</mark>
 lib
 log
 public
...
{% endpre_whiteboard %}

Lantas, **bagaimana apabila kita hanya ingin menjalankan satu buah seed saja?**

Misalkan, hanya ingin menjalankan seed untuk mengenerate user dengan tipe "subscriber", tanpa harus menjalankan semua seeds.

# Pemecahan Masalah

Secara sederhana, saya akan mengistilahkan "**Modularisasi**-kan, saja!".

Modularisasi, merujuk pada proses yang biasa digunakan untuk memecah-mecah sebuah single file yang berisi banyak komponen, menjadi beberapa komponen-komponen yang dikategorikan berdasarkan fungsi dan tujuan tertentu.

Kira-kira seperti ini project skeleton untuk seeds apabila telah dipecah-pecah.

{% pre_whiteboard %}
 app
 bin
 config
 db
│  migrate
│  <mark>seeds</mark>
│ │  <mark>01_admins.seeds.rb</mark>
│ │  <mark>02_customers.seeds.rb</mark>
│ │  <mark>03_subscribers.seeds.rb</mark>
│ │  <mark>04_products.seeds.rb</mark>
│ └  <mark>05_orders.seeds.rb</mark>
│  schema.rb
└  <mark>seeds.rb</mark>
 lib
 log
 public
...
{% endpre_whiteboard %}

Pemecahan file **db/seeds.rb**, saya letakkan pada direktori **db/seeds/** dan saya berikan nama dengan sufix **\*.seeds.rb**.

Tidak ada aturan (convention) baku untuk hal ini.

## File Induk seeds.rb

Untuk membaca semua file-file yang berakhiran **\*.seeds.rb** yang ada di dalam direktori **db/seeds/**, saya menggunakan cara seperti ini di dalam file **db/seeds.rb**.

{% highlight_caption db/seeds.rb %}
{% highlight ruby linenos %}
Dir[File.join(Rails.root, "db", "seeds", "*.seeds.rb")].sort.each { |seed| load seed }
{% endhighlight %}

<br>
Untuk isi dari file-file **db/seeds/\*.seeds.rb** tidak perlu saya tuliskan lah yaa. Sama saja isinya seperti tipikal seeds pada umumnya, hanya saja dipisah/dikategorikan berdasarkan tujuan atau fungsi tertentu.

## Seeding

Rails menyediakan rake task untuk melakukan seeding,

{% shell_cmd $ %}
rails db:seed
{% endshell_cmd %}

Meskipun kita sudah me-modularisasi-kan seeds, kalau kita melakukan seeding dengan perintah di atas, maka rails akan menjalankan semua file seeding tersebut.

### Seeding hanya pada single seed file

Seperti yang sudah saya singgung sebelumnya, catatan ini adalah mengenai cara melakukan seeding hanya pada single seed file yang kita tentukan.

Kita perlu membuat file tasks untuk mengcover hal tersebut.

{% pre_whiteboard %}
 app
 bin
 config
 db
 lib
│  assets
└  tasks
  └  <mark>db_seed_single.rake</mark>
 log
 public
...
{% endpre_whiteboard %}

{% highlight_caption lib/tasks/db_seed_single.rake %}
{% highlight ruby linenos %}
namespace :db do
  namespace :seed do
    task :single => :environment do
      filename = Dir[File.join(Rails.root, 'db', 'seeds', "#{ENV['SEED']}.seeds.rb")][0]
      puts "Seeding #{filename}..."
      load(filename) if File.exist?(filename)
    end
  end
end
{% endhighlight %}

Nah, dengan begini, kita sudah membuat 1 buah rake task baru dengan perintah,

Misal, untuk file **db/seeds/01_admins.seeds.rb**.

{% shell_cmd $ %}
rails db:seed:single SEED=01_admins
{% endshell_cmd %}

Kalau berhasil,

<pre>
Seeding /home/bandithijo/rails_project/db/seeds/01_admins.seeds.rb...
Admin has created: bandithijo@gmail.com
</pre>

Kita hanya perlu menuliskan nama file, tanpa sufix **\*.seeds.rb**.

### Seeding pada multiple seed file

Kali ini, kebutuhannya adalah melakukan seeding pada 1 atau lebih file seeds.

{% pre_whiteboard %}
 app
 bin
 config
 db
 lib
│  assets
└  tasks
  │  <mark>db_seed_multiple.rake</mark>
  └  db_seed_single.rake
 log
 public
...
{% endpre_whiteboard %}

{% highlight_caption lib/tasks/db_seed_multiple.rake %}
{% highlight ruby linenos %}
namespace :db do
  namespace :seed do
    task :multiple => :environment do
      seeds = ENV['SEEDS'].split(',')
      seeds.each do |seed|
        filename = Dir[File.join(Rails.root, 'db', 'seeds', "#{seed}.seeds.rb")][0]
        puts "Seeding #{filename}..."
        load(filename) if File.exist?(filename)
      end
    end
  end
end
{% endhighlight %}

Cara menjalankanya,

{% shell_cmd $ %}
rails db:seed:multiple SEEDS=01_admins,02_developers
{% endshell_cmd %}

Kalau berhasil,

<pre>
Seeding /home/bandithijo/rails_project/db/seeds/01_admins.seeds.rb...
Admin has created: bandithijo@gmail.com
Seeding /home/bandithijo/rails_project/db/seeds/02_customers.seeds.rb...
Customer has created: budidibu@gmail.com
Customer has created: bayuyuba@gmail.com
</pre>


<br>
Nah, mantap!






<br>
# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Selanjutnya, saya serahkan kepada imajinasi dan kreatifitas teman-teman. Hehe.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)




# Referensi

1. [https://stackoverflow.com/a/31815032/4862516](https://stackoverflow.com/a/31815032/4862516){:target="_blank"}
<br>Diakses tanggal: 2021/03/29
