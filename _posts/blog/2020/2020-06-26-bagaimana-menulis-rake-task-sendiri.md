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

Buat dulu Rake file pada direktori `lib/tasks/`, kasih nama bebas.

Misalkan saya kasih nama sesuai dengan tugas yang akan dikerjakan, yaitu `run.rake`.

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

### Tingkat Satu

Tugas yang bercabang atau bertingkat ini, maksudnya seperti kita punya kategori tugas yang sama, namun detail pekerjaannya yang berbeda. Kalau yang pernah menggunakan Ruby on Rails, pasti pernah menggunakan perintah `$ rake db:create`, `$ rake db:migrate`, `$ rake db:rollback`, dll.

Nah, kira-kira begini cara buatnya (blok codenya hanya ilustrasi yaa, bro).

Karena ada banyak tugas yang merupakan tugas yang mirip, yaitu untuk mengintervensi database, maka saya beri nama `database.rake`.

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

### Tingkat Lebih dari Satu
Nah, mungkin teman-teman yang menggunakan Ruby on Rails juga pernah melihat perintah `$ rake db:migrate:status`, pasti sudah bisa ketebak dong yaa, gimana cara membuatnya.

{% highlight ruby linenos %}
namespace :db do
  desc "Migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)."
  task :migrate do
    ActiveRecord::Tasks::DatabaseTasks.migrate
  end

  namespace :migrate do
    desc "Display status of migrations"
    task :status do
        ActiveRecord::Tasks::DatabaseTasks.migrate_status
    end
  end
end
{% endhighlight %}

Kalau kita cek dengan perintah `$ rake --tasks`, akan menampilkan output:

<pre>
rake db:environment:set              # Set the environment value for the database
rake db:fixtures:load                # Loads fixtures into the current environment's database
<mark>rake db:migrate                      # Migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)</mark>
<mark>rake db:migrate:status               # Display status of migrations</mark>
rake db:new_migration[name,options]  # Creates a new migration file with the specified name
rake db:prepare                      # Runs setup if database does not exist, or runs migrations if it does
</pre>

## Memasukkan Argument

Terkadang kita membutuhkan argument yang akan diolah di dalam task.

Misalkan kita punya Rake task seperti ini.

{% highlight ruby linenos %}
desc "Menjalankan operasi penjumlahan"
task :penjumlahan do
  puts 1 + 2
end
{% endhighlight %}

<pre>
$ <b>rake penjumlahan</b>
# => 3
</pre>

Nah, kita ingin membuat dua angka yang dijumlahkan tersebut menjadi dinamis, diambil dari argumen yang diberikan.

Berikut ini adalah 4 cara dalam memasukkan argument ke dalam Rake task.

### 1. The Rake Way

Rake memiliki built-in function yang dapat menerima argument, caranya seperti ini.

{% highlight ruby linenos %}
desc "Menjalankan operasi penjumlahan"
task :penjumlahan, [:num1, :num] do |t, args|
  puts args[:num1].to_i + args[:num].to_i
end
{% endhighlight %}

<pre>
$ <b>rake penjumlahan[1,2]</b>
# => 3
</pre>

<!-- INFORMATION -->
<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>Namun, cara ini memiliki kelemahan apabila kita menggunakan ZSH Shell. Biasanya kita akan mendapatkan error berupa,</p>
<pre>zsh: no matches found ...</pre>
<p>Untuk mengatasi hal ini, kita perlu <b>menambahkan escape charater</b> pada perintahnya. Menjadi seperti ini:</p>
<pre>
$ <b>rake penjumlahan\[1,2\]</b>
# => 3
</pre>
<p>Terlihat tidak cantik yaa.</p>
<p>Selain itu, kita <b>tidak boleh menggunakan spasi setelah tanda koma "," diantara argument</b>, hal ini akan menyebabkan error yang lain.</p>
</div>

### 2. Environment Variables

Kita akan menggunakan cara *environment variables* seperti yang biasa dijalankan di terminal, misal `RAILS_ENV=`.

Nah, kita dapat menggunakan metode yang sama.

{% highlight ruby linenos %}
desc "Menjalankan operasi penjumlahan"
task :penjumlahan do
  puts ENV['NUM1'].to_i + ENV['NUM2'].to_i
end
{% endhighlight %}

Cara menjalankannya akan seperti ini:

<pre>
$ <b>rake penjumlahan NUM1=1 NUM2=2</b>
# => 3
</pre>

Cara ini dapat dilakukan, namun agak sia-sia kalau menjalankan task dengan melakukan pengesetan/pendefinisian *environment variables*.

### 3. Menggunakan ARGV

ARGV adalah *command line argument*. Untuk teman-teman yang pernah membuat Ruby script dan ingin mengambil inputan dari user bersamaan dengan menjalankan command, pasti pernah menggunakannya.

<pre>
$ <b>ruby script.rb <mark>nama</mark></b>
</pre>

Nah, `nama` itu adalah *command line argument* yang akan digunakan di dalam `script.rb` tersebut. Inilah yang disebut Ruby ARGV.

Berikut ini adalah contoh task yang memanfaatkan Ruby ARGV.

{% highlight ruby linenos %}
desc "Menjalankan operasi penjumlahan"
task :penjumlahan do
  ARGV.each { |a| task a.to_sym do ; end }
  puts ARGV[1].to_i + ARGV[2].to_i
end
{% endhighlight %}

Cara menjalankannya akan seperti ini:

<pre>
$ <b>rake penjumlahan 1 2</b>
# => 3
</pre>

### 4. Menggunakan Ruby OptionParser

Cara memberikan argument dengan **OptionParser** ini mirip seperti yang kita lakukan untuk menjalankan commmand dengan penambahan **flag**, misal yang umum kita gunakan untuk mengetahui command help, yaitu dengan menambahkan flag `-h`.

Nah, yang akan kita buat, mirip seperti itu.

{% highlight ruby linenos %}
require 'optparse'

desc "Menjalankan operasi penjumlahan"
task :penjumlahan do
  options = {}

  OptionParser.new do |opts|
    opts.banner = "Gunakan: rake penjumlahan [options]"
    opts.on("-o", "--one ARG", Integer) { |num1| options[:num1] = num1 }
    opts.on("-t", "--two ARG", Integer) { |num2| options[:num2] = num2 }
  end.parse!

  puts options[:num1].to_i + options[:num2].to_i
  exit
end
{% endhighlight %}

Cara menjalankannya seperti ini:

<pre>
$ <b>rake penjumlahan -- -o 1 -t 2</b>
</pre>

atau,

<pre>
$ <b>rake penjumlahan -- --one 1 --two 2</b>
</pre>

# Melihat Daftar Rake Task

Untuk melihat daftar task apa saja, sekaligus task yang sudah kita buat, jalankan perintah berikut.

<pre>
$ <b>rake --tasks</b>
</pre>

atau,

<pre>
$ <b>rake -T</b>
</pre>

# Pesan Penulis

Yang saya tuliskan pada catatan ini adalah hal sederhana dalam membuat Rake tasks. Apabila teman-teman mendapatkan kasus yang lebih kompleks, dapat menelusuri Google sendiri yaa.

Silahkan mendalami daftar referensi yang saya berikan di bawah.

Mudah-mudahan dapat bermanfaat buat teman-teman.

Terima kasih.

(^_^)







# Referensi

1. [cobwwweb.com/how-to-write-a-custom-rake-task](https://cobwwweb.com/how-to-write-a-custom-rake-task){:target="_blank"}
<br>Diakses tanggal: 2020/06/26

2. [cobwwweb.com/4-ways-to-pass-arguments-to-a-rake-task](https://cobwwweb.com/4-ways-to-pass-arguments-to-a-rake-task){:target="_blank"}
<br>Diakses tanggal: 2020/06/26

3. [www.rubyguides.com/2019/02/ruby-rake](https://www.rubyguides.com/2019/02/ruby-rake/){:target="_blank"}
<br>Diakses tanggal: 2020/06/26

4. [ruby-doc.org/stdlib-2.7.1/libdoc/optparse/rdoc/OptionParser.html](https://ruby-doc.org/stdlib-2.7.1/libdoc/optparse/rdoc/OptionParser.html){:target="_blank"}
<br>Diakses tanggal: 2020/06/26
