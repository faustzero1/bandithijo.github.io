---
layout: 'post'
title: "Penjadwalan Tasks dengan Cron Menggunakan Whenever Gem pada Ruby/Rails"
date: 2020-07-07 14:47
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Ruby', 'Rails']
pin:
hot:
contributors: []
resume:
---

# Sekenario Masalah

Saya memiliki sebuah Rake tasks atau Ruby script, baik pada aplikasi Ruby maupun dengan Ruby on Rails, yang bertugas melakukan sebuah pekerjaan (*task*).

Namun, saya ingin membuat pekerjaan tersebut berjalan secara otomatis tanpa perlu saya panggil terlebih dahulu.

Nah, karena saya menggunakan GNU/Linux, saya sudah cukup familiar dengan Cron. Karena ada aplikasi penunjang saya yang juga menggunakan Cron yaitu Neomutt yang bertugas mengambil email setiap 5 menit.

Pertama-tama, periksa dulu Cron service udah aktif atau belum.

{% shell_user %}
sudo systemctl status cronie.service
{% endshell_user %}

<pre>
● cronie.service - Periodic Command Scheduler
     Loaded: loaded (/usr/lib/systemd/system/cronie.service; enabled; vendor preset: disabled)
     Active: <b>active (running)</b> since Sun 2020-07-05 07:46:19 WITA; 2 days ago
   Main PID: 298 (crond)
      Tasks: 1 (limit: 4610)
     Memory: 19.8M
     CGroup: /system.slice/cronie.service
             └─298 /usr/bin/crond -n
</pre>

Pastikan statusnya sudah aktif.

Kemudian periksa apakah ada cronjob yang sudah aktif.

{% shell_user %}
crontab -l
{% endshell_user %}

Nanti, kita akan menggunakan perintah di atas untuk melihat apakah cronjob yang kita inisiasi dengan whenever sudah berhasil didaftarkan atau tidak.

# Instalasi Whenever Gem

Pasang pada `Gemfile`.

{% highlight_caption Gemfile %}
{% highlight ruby linenos %}
# Gemfile

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# ...
# ...

gem 'whenever', '~> 1.0', require: false

{% endhighlight %}

Kemudian install dengan menjalankan perintah,

{% shell_user %}
bundle install
{% endshell_user %}

# Inisialisasi Config File

Setelah memasang Whenever gem, kita perlu menjalankan perintah untuk mengenerate file konfigurasi yang bernama `config/schedule.rb`.

{% shell_user %}
wheneverize .
{% endshell_user %}

<pre>
project_dir/
├── app/
├── bin/
├── config/
... ...
│   └── <mark>schedule.rb</mark>
...
...
</pre>

Perintah di atas akan membuat file `config/schedule.rb`.

Sekarang coba buka file tersebut. Di dalamnya sudah terdapat beberapa contoh sintaks untuk membuat jadwal.

{% highlight_caption config/schedule.rb %}
{% highlight ruby linenos %}
# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
{% endhighlight %}

Perhatikan baris kode 11, 12, 13. Masing-masing baris tersebut adalah contoh bagaimana kita dapat menjalankan atau memanggil perintah (*command*) yang kita jalankan di dalam penjadwalan.

**Masing-masing baris tersebut dijalankan secara paralel, bukan dalam urutan (*sequence*)**. Artinya, apabila terdapat 3 perintah tasks, maka ke-3 nya akan dijalankan secara bersama-sama, bukan satu-persatu secara bergantian.

Misal,

{% highlight_caption config/schedule.rb %}
{% highlight ruby linenos %}
every 2.hours do
  rake "db:create"   # untuk membuat database
  rake "db:migrate"  # untuk menjalankan migrasi, seperti membuat tabel
  rake "db:seed"     # untuk mengisi tabel dengan data buatan
end
{% endhighlight %}

Ketiga perintah `rake` tersebut, akan dijalankan secara bersamaan. **Hal ini dapat menyebabkan terjadinya error** dikarenakan seharusnya perintah tersebut dijalankan secara berurutan.

Lantas, bagaimana cara membuat ketiga tasks tersebut berjalan secara berurutan? Mudah, tinggal gunakan perintah `command`.

Dengan menggunakan `command`, kita selayaknya menjalankan perintah di atas Terminal, dengan memisahkan masing-masing perintah dengan tanda titik koma (;).

{% highlight_caption config/schedule.rb %}
{% highlight ruby linenos %}
project_dir = `echo $PWD`.strip
every 2.hours do
  command "cd #{project_dir}; \
           rake db:create; \
           rake db:migrate; \
           rake db:seed"
end
{% endhighlight %}

Perintah di atas, sudah dapat dibaca dengan mudah kan yaa?

Saya masuk ke dalam direktori project yang sudah lebih dahulu saya definisikan variabel `project_dir=` secara dinamis menggunakan <code>`echo $PWD`.strip</code> untuk mendapatkan lokasi project direktori, kemudian baru menjalankan ketiga tasks secara berurutan.

# Mengeset Waktu

Kelebihan dari Whenever gem adalah kita dapat mendifinisikan waktu seperti kita menulis bahasa Inggris.

{% highlight_caption config/schedule.rb %}
{% highlight ruby linenos %}
every 3.hours do # 1.minute 1.day 1.week 1.month 1.year is also supported
  # task
end

every 1.day, at: '4:30 am' do
  # task
end

every 1.day, at: ['4:30 am', '6:00 pm'] do
  # task
end

every :hour do # Many shortcuts available: :hour, :day, :month, :year, :reboot
  # task
end

every :sunday, at: '12pm' do # Use any day of the week or :weekend, :weekday
  # task
end

every '0 0 27-31 * *' do
  # task
end
{% endhighlight %}

# Mengeset Output Log

Kita dapat menyimpan output tasks yang dijalankan ke dalam file log.

{% highlight_caption config/schedule.rb %}
{% highlight ruby linenos %}
set :output, 'log/rake.log'
every 2.hours do
  # task
end
{% endhighlight %}

Apabila, cronjob kita berhasil dijalankan, maka outputnya akan tersimpan di file `log/rake.log`

<pre>
project_dir/
├── app/
├── bin/
├── config/
├── db/
├── lib/
├── log/
│   ├── development.log
│   ├── production.log
│   └── <mark>rake.log</mark>
...
...
</pre>

# Tentukan Environment Path

Tidak kalah penting adalah, kita perlu mendefinisikan environment path.

## Ruby on Rails Project

{% highlight_caption config/schedule.rb %}
{% highlight ruby linenos %}
env :PATH, ENV['PATH']
every 2.hours do
  # task
end
{% endhighlight %}

## Ruby Project

{% highlight_caption config/schedule.rb %}
{% highlight ruby linenos %}
ENV.each { |k, v| env(k, v) }
every 2.hours do
  # task
end
{% endhighlight %}

# Mendaftarkan Schedule ke Cronjob

Apabila kita sudah selesai menulis schedule. Langkah selanjutnya adalah mendaftarkan pada Cronjob.

**Penting:** secara *default*, environment akan bernilai `production`. Apabila kita ingin melakukan ujicoba pada sistem lokal, kita dapat menjalankan dengan perintah.

{% shell_user %}
whenever --update-crontab --set environment=development
{% endshell_user %}

Apabila kita berada di production server, maka cukup menjalankan perintah.

{% shell_user %}
whenever --update-crontab
{% endshell_user %}

Setelah itu periksa, apakah jadwal yang kita daftarkan sudah berada pada daftar Cronjob atau tidak.

{% shell_user %}
crontab -l
{% endshell_user %}

Tampilannya akan seperti ini untuk Ruby on Rails.

<pre>
# Begin Whenever generated tasks for: /home/bandithijo/doc/Belajar/belajar-rails/covid19-indo-harian/config/schedule.rb at: 2020-07-07 17:10:11 +0800
PATH=/home/bandithijo/.rbenv/versions/2.6.6/bin:/home/bandithijo/.rbenv/libexec:/home/bandithijo/.rbenv/plugins/ruby-build/bin:/home/bandithijo/.rbenv/shims:/home/bandithijo/bin:/usr/local/bin:/home/bandithijo/.rbenv/shims:/home/bandithijo/bin:/usr/local/bin:/home/bandithijo/.local/bin:/home/bandithijo/.rbenv/plugins/ruby-build/bin:/home/bandithijo/.rbenv/shims:/home/bandithijo/.rbenv/bin

<mark>0 */2 * * * /bin/bash -l -c 'cd /home/bandithijo/dex/belajar-rails/covid19-indo-harian; rake db:create; rake db:migrate; rake db:seed >> log/rake.log 2>&1'</mark>

# End Whenever generated tasks for: /home/bandithijo/doc/Belajar/belajar-rails/covid19-indo-harian/config/schedule.rb at: 2020-07-07 17:10:11 +0800
</pre>

Perintah `rake db:create`, `rake db:migrate`, `rake db:seed` di atas, hanya perumpamaan, dan bukan perintah yang sebenarnya untuk kita jalankan di dalam Whenever schedule.

Selesai!

# Pesan Penulis

Apabila teman-teman memiliki kebutuhan yang lebih kompleks dan belum tersedia pada catatan ini, silahkan merujuk pada README pada GitHub dari Whenever gem yang cukup mengcover semua kebutuhan dan sangat deskriptif. Saya sudah sertakan pada bagian referensi di bawah.

Sepertinya segini saja.

Terima kasih.

(^_^)




# Referensi

1. [Scheduling tasks in Rails with Cron and using the Whenever Gem](https://medium.com/@pawlkris/scheduling-tasks-in-rails-with-cron-and-using-the-whenever-gem-34aa68b992e3){:target="_blank"}
<br>Diakses tanggal: 2020/07/07

2. [How to Schedule Cron Jobs in Ruby With the Whenever Gem](https://www.rubyguides.com/2019/04/ruby-whenever-gem/){:target="_blank"}
<br>Diakses tanggal: 2020/07/07

3. [github.com/javan/whenever](https://github.com/javan/whenever){:target="_blank"}
<br>Diakses tanggal: 2020/07/07

