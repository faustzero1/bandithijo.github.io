---
layout: 'post'
title: "Bagaimana Menulis Rake Task Buatan Sendiri"
date: 2020-06-26 16:38
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Ruby']
pin:
hot:
---

# Pendahuluan

Beberapa hari ini, saya sedang mengerjakan *side project* membuat *web scraper* menggunakan Ruby.

Project ini terus berkembang, hingga saya sampai pada kebutuhan untuk membuat Rake task sendiri.

# Tujuannya

Tujuan yang saya inginkan dalam membuat Rake tasks sendiri adalah untuk merangkum beberapa perintah sekaligus, agar tidak perlu menulis perintah yang panjang secara berulang-ulang. Bahasa kerennya, mungkin disebut "automatisasi".

# Instalasi

Rake benar-benar *tool* yang sangat *powerful* untuk melakukan proses automatisasi. Rake juga sangat praktis dan dapat dipasang pada project yang belum secara *default* memasang Rake. Bahkan juga dapat dipasang pada project yang bukan berbasis Ruby. Keren!

Pertama, pastikan teman-teman sudah memasang **Bundler** gem yaa.

<pre>
$ <b>bundler -v</b>
</pre>

```
Bundler version 2.1.4
```

Biasanya kalo Ruby project pasti sudah memiliki `Gemfile`, tinggal kita tambahkan Rake gem saja.

```ruby
# Gemfile

source 'https://rubygems.org'

...
...
gem 'rake'
```

Lalu jalankan instalasi gem baru dengan bantuan Bundler.

<pre>
$ <b>bundler install</b>
</pre>

# Konfgurasi

Pada catatan ini ada 2 konfigurasi yang akan saya tuliskan.

1. [Konfigurasi Rakefile untuk project apa saja](#konfigurasi-rakefile-untuk-project-apapun).
2. [Konfigurasi Rakefile untuk project yang menggunakan **Standalone Migrations** gem](#konfigurasi-rakefile-untuk-standalone-migrations-gem).

Namun sebelumnya, siapkan dahulu direktori untuk menyimpang file `.rake`.

Sebaiknya kita mengikuti *convention* (aturan) yang sudah disepakati bersama, agar struktur project kita dapat dibaca dan dipahami oleh orang lain.

Untuk itu, kita perlu membuat struktur direktori seperti ini, `lib/tasks`.

<pre>
root-project-dir/
│
...
...
├── Gemfile
├── Gemfile.lock
<mark>├── lib/</mark>
<mark>│   └── tasks/</mark>
│       └── *.rake
│
└── Rakefile
</pre>

Nantinya, kita akan meletakkan Rake tasks di dalam direktori tersebut.

Selanjutnya tinggal mengkonfigurasi Rakefile sesuai dengan preferensi project yang digunakan.

## Konfigurasi Rakefile untuk Project Apapun

Buat `Rakefile` pada project root direktori. Kemudian isikan seperti di bawah.

{% highlight ruby linenos %}
Dir.glob(File.join('lib/tasks/**/*.rake')).each { |file| load file }
{% endhighlight %}

Dapat dibaca, kalau baris di atas akan memerintahkan Rake untuk menjalankan file `.rake` yang ada di dalam direktori `lib/tasks/`.

## Konfigurasi Rakefile untuk Standalone Migrations Gem

Untuk yang membuat Ruby project menggunakan gem **Standalone Migrations**, biasanya karena ingin memanfaatkan migration dari gem **Active Record** --yang merupakan komponen dari Ruby on Rails-- agar dapat menggunakan migration di luar Ruby on Rails project.

Isi dari `Rakefile` pada konfigurasi Rake menggunakan gem Standalone Migrations, akan seperti ini.

{% highlight ruby linenos %}
require 'standalone_migrations'
StandaloneMigrations::Tasks.load_tasks
{% endhighlight %}

Perintah di atas juga akan menjalankan Rake task yang kita simpan di dalam direktori `lib/tasks/`.

# Menulis Rake Task

Dalam menulis Rake task, sebaiknya kita juga mengikuti *convention* yang sudah ada.

## Morfologi Rake Task

Morfologi dari Rake task, adalah seperti ini:

1. **Description** `desc`, akan memberikan deskripsi yang akan ditampilkan pada saat kita menjalankan perintah `$ rake --tasks` di Terminal.
2. **Task name** `:name`, nama dari task yang akan dipanggil pada saat menjalankan Rake.
3. **Code block**, adalah code atau perintah yang akan dijalankan ketika task dipanggil.

{% highlight ruby linenos %}
desc 'Description'
task :name do
  # task code ...
end
{% endhighlight %}

Meskipun sintaks dari Rake task ditulis dengan bahasa Ruby, namun ekstensi dalam meberikan nama file tetap menggunakan akhiran `.rake` bukan `.rb`.

## Tugas Sederhana

Misalnya hanya ada satu jenis tugas, kita dapat mendefiniskan seperti ini.

{% highlight ruby linenos %}
desc "Menjalankan main script"
tasks :run do
    system "ruby app/main.rb"
end
{% endhighlight %}

Saya punya Ruby script dengan nama `app/main.rb` yang ingin saya jalankan.

Kalau kita cek dengan perintah `$ rake --tasks`, akan menampilkan output:

<pre>
rake middleware                      # Prints out your Rack middleware stack
rake restart                         # Restart app by touching tmp/restart.txt
<mark>rake run                             # Menjalankan main script</mark>
rake secret                          # Generate a cryptographically secure secret key (this is typically used to generate a secret for cookie sessions)
rake stats                           # Report code statistics (KLOCs, etc) from the application or engine
</pre>

Dengan begini, saya tidak perlu lagi menjalankan command `$ ruby app/main.rb` yang cukup panjang, cukup menjalankan dengan `$ rake run`, maka hasilnya pun akan sama namun dengan command yang lebih pendek. =P

## Tugas Bercabang (Bertingkat) / Namespace

Tugas yang bercabang atau bertingkat ini, maksudnya seperti kita punya kategori tugas yang sama, namun detail pekerjaannya yang berbeda. Kalau yang pernah menggunakan Ruby on Rails, pasti pernah menggunakan perintah `$ rake db:create`, `$ rake db:migrate`, `$ rake db:rollback`, dll.

Nah, kira-kira begini cara buatnya (blok codenya hanya ilustrasi yaa, bro).

{% highlight ruby linenos %}
namespace :db do
  desc "Create database for current environment"
  task :create do
    ActiveRecord::Tasks::DatabaseTasks.create_all
  end

  desc "Drop database for current environment"
  task :drop do
    ActiveRecord::Tasks::DatabaseTasks.drop_all
  end
end
{% endhighlight %}

Perhatikan strukturnya, bahwa masing-masing tasks tetap memiliki morfologi yang sudah menjadi convention seperti yang sudah saya tulis di atas.

Kalau kita cek dengan perintah `$ rake --tasks`, akan menampilkan output:

<pre>
rake app:template                    # Applies the template supplied by LOCATION=(/path/to/template) or URL
rake app:update                      # Update configs and some other initially generated files (or use just update:configs or update:bin)
<mark>rake db:create                       # Create database for current environment</mark>
<mark>rake db:drop                         # Drop database for current environment</mark>
rake db:environment:set              # Set the environment value for the database
rake db:fixtures:load                # Loads fixtures into the current environment's database
</pre>

Secara sederhana *namesapce* akan mengkategorikan task yang sejenis, dalam hal ini, task yang memiliki tugas untuk berinteraksi dengan database `db` akan dimasukkan ke dalam *namespace* ini agar task list menjadi lebih rapi dan terorganisir.

# Melihat Daftar Rake Task

Untuk melihat daftar task apa saja, sekaligus task yang sudah kita buat, jalankan perintah berikut.

<pre>
$ <b>rake --tasks</b>
</pre>

atau,

<pre>
$ <b>rake -T</b>
</pre>













# Referensi

1. [cobwwweb.com/how-to-write-a-custom-rake-task](https://cobwwweb.com/how-to-write-a-custom-rake-task){:target="_blank"}
<br>Diakses tanggal: 2020/06/26

2. [www.rubyguides.com/2019/02/ruby-rake](https://www.rubyguides.com/2019/02/ruby-rake/){:target="_blank"}
<br>Diakses tanggal: 2020/06/26
