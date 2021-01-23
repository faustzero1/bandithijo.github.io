---
layout: 'post'
title: "Konfigurasi Ruby on Rails ActionMailer dengan Gmail"
date: 2020-12-22 08:13
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
resume: "Pada umumnya, tutorial ActionMailer pasti mendemonstrasikan penggunaan SendGrid dengan Heroku. Sudah terlalu mainstream, dan juga sejak SendGrid diakuisisi, jadi lebih sering gagal. Catatan kali ini mungkin dapat membantu teman-teman agar dapat menggunakan layanan Gmail saja. Hari gini, siapa yang gak pakai Gmail?"
---

# Latar Belakang Masalah

Catatan kali ini terinspirasi saat saya mencoba menggunakan SendGrid dengan Heroku sebagai Add-ons, namun tidak berjalan dengan baik.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/wT7rfFFX/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Virtual User untuk SendGrid yang dibuatkan oleh Heroku, dibanned oleh SendGrid.</p>

Ternyata, masalah tersebut bukan saya saja yang mengalami.

Dari beberapa diskusi di berbagai tempat yang saya baca, satu yang paling menarik adalah diskusi yang dilakukan di GitHub Issues dari SendGrid/doc, [issue #2908](https://github.com/sendgrid/docs/issues/2908){:target="_blank"}.

Dan, pada komentar [yang ini](https://github.com/sendgrid/docs/issues/2908#issuecomment-732194727){:target="_blank"}, saya menemukan solusinya.

Pada komenetar tersebut, ia memberikan resource ini, ["Ruby on Rails Action Mailer configuration"](https://hixonrails.com/ruby-on-rails-tutorials/ruby-on-rails-action-mailer-configuration/){:target="_blank"}.

Pada halaman tersebut ditunjukkan bagaimana cara mengkonfigurasi ActionMailer dengan beberapa layanan, diantaranya:

1. Amazon SES
2. Mailgun
3. SendGrid
4. Mandrill
5. Gmail


# Pemecahan Masalah

Saya memutuskan untuk mencoba konfigurasi dengan Gmail, dengan alasan saya sudah memiliki akun Gmail, jadi tidak perlu daftar lagi.

Karena Gmail menyediakan layanan SMTP sebagai protokol untk berkirim email, maka kita dapat mengkonfigurasi ActionMailer untuk menggunakan protokol SMTP juga.

Gmail memberikan kita jatah 500 email per hari yang dapat dikirim dengan protokol SMTP ini pada paket "free plan", untuk GSuit Standard memiliki jatah 2000 email per hari.

500 email per hari sudah lebih dari cukup, karena saya hanya ingin coba-coba fitur ActionMailer saja.

Ayo kita konfigurasi Gmail terlebih dahulu.

# Konfigurasi Google Account

Cara terbaik untuk menggunakan Google Account tanpa mengendorkan keamanan yang berlapis (2-Step Verification) adalah dengan memanfaatkan fitur **App passwords**.

Dengan fitur App passwords ini, kita dapat mengenerate password untuk masing-masing aplikasi yang ingin kita berikan akses ke akun Gmail kita. Jadi, tidak menggunakan password utama, dan juga masing-masing app akan mendapatkan hasil generate password yang berbeda-beda.

Caranya, teman-teman dapat mengikuti langkah-langkahnya di bawah ini.

1. Buka [**Google Account Security Settings**](https://myaccount.google.com/security){:target="_blank"}.

2. Pastikan **2-Step Verification** sudah di-**enable**-kan (1).

  ![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/90pJzwWY/gambar-02.png" onerror="imgError(this);"}{:class="myImg"}

{:start="3"}
3. Pilih **App passwords** (2), untuk men-generate App passwords.

4. Berikan nama aplikasi dengan cara seperti gambar di bawah ini (3).

![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/L6jZkFfG/gambar-03.png" onerror="imgError(this);"}{:class="myImg"}

{:start="5"}
5. Isikan saja dengan nama bebas sesuai nama Rails project yang sedang dikerjakan, agar tidak bingung (4).

![gambar_4]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/QtDzt3Qs/gambar-04.png" onerror="imgError(this);"}{:class="myImg"}

{:start="6"}
6. Catat password yang berada di kotak kuning (5).

![gambar_5]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/Y0nDbLJq/gambar-05.png" onerror="imgError(this);"}{:class="myImg"}

{:start="7"}
7. Nah, kalau sudah seperti ini. Kita telah berhasil men-generate App password yang nantinya akan kita gunakan untuk ActionMailer.

![gambar_6]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/gk1Njpp5/gambar-06.png" onerror="imgError(this);"}{:class="myImg"}

{% box_info %}
<p>Cara di atas dilakukan dengan mengaktifkan 2-Step Verification, agar kita dapat mengontrol app apa yang akan kita berikan akses dan yang tidak.</p>
<p>Namun, kalau teman-teman tidak ingin menggunakan 2-Step Verification, tidak perlu melakukan langkah di atas.</p>
{% endbox_info %}

# Konfigurasi Rails ActionMailer

## 1. Konfigurasi Gmail SMTP

Untuk mendefinisikan Gmail SMTP, saya memilih mendefinisikan di **config/environment.rb**.

Alasannya, agar konfigurasi Gmail SMTP ini dapat diakses oleh ketiga environment (Developer, Test, dan Production).

{% highlight_caption config/environment.rb %}
{% highlight ruby linenos %}
# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  port:                 587,
  address:              'smtp.gmail.com',
  user_name:            Rails.application.credentials.gmail[:SMTP_USER_NAME],
  password:             Rails.application.credentials.gmail[:SMTP_PASSWORD],
  authentication:       :plain,
  enable_starttls_auto: true
}
{% endhighlight %}

Baris ke 7-4, adalah baris yang kita tambahkan.

Dapat dilihat, pada `user_name` & `password`, saya menyimpan credential dengan cara Rails, yaitu memanfaatkan file **config/credentials.yml.enc**. Yang belum pernah tahu, boleh baca di artikel ini, ["Cara Aman Menyimpan Credentials di Rails"](/blog/cara-aman-menyimpan-credentials-di-rails){:target="_blank"}.

Selanjutnya, daftarkan dulu credential tersebut.

{% shell_user %}
rails credentials:edit
{% endshell_user %}

{% highlight_caption config/credentials.yml.enc %}
{% highlight yml linenos %}
# aws:
#   access_key_id: 123
#   secret_access_key: 345

# Used as the base secret for all MessageVerifiers in Rails, including the one protecting cookies.
secret_key_base: f9c45a057d6a...dipotong & diperpendek...ba3d28ecc618f5473746ce

gmail:
  SMTP_USER_NAME: rizqiassyaufi@gmail.com
  SMTP_PASSWORD: aakuruhhfwxlaupa
{% endhighlight %}

Nah, password yang sebelumnya sudah kita generate pada langkah 6 di atas, kita masukkan sebagai password akun Gmail kita.

Kalau yang tidak menggunakan cara **App passwords**, tinggal masukkan password Gmail.

Simpan dan exit.

Selanjutnya, jangan lupa definisikan **RAILS_MASTER_KEY** yang berisi **config/master.key**, ke server tempat kita mendeploy aplikasi.

Misal, untuk Heroku.

{% shell_user %}
heroku config:set RAILS_MASTER_KEY=`cat config/master.key`
{% endshell_user %}

# Konfigurasi Environment

## 1. Development

{% highlight_caption config/environments/development.rb %}
{% highlight ruby linenos %}
Rails.application.configure do
  #...
  #...

  config.action_mailer.delivery_method = :test
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  #...
  #...
end
{% endhighlight %}

**delivery_method** `:test` diganti menjadi `:smtp` apabila teman-teman ingin mencoba mengirimkan link konfirmasi dari via email dari Gmail SMTP.

Jika, link konfirmasi hanya ingin di Rails server log saja, biarkan tetap `:test`.

## 2. Production

{% highlight_caption config/environments/production.rb %}
{% highlight ruby linenos %}
Rails.application.configure do
  #...
  #...

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_url_options = { host: 'bandithijo-saas-app.herokuapp.com', protocol: 'https' }

  #...
  #...
end
{%endhighlight %}

Ganti **host:** sesuai dengan alamat dari project teman-teman.

Selesai!

Dengan begini tinggal diuji coba.

Saya akan coba dengan ActionMailer untuk Email Confirmation dengan Devise gem.

{% youtube Vio7yGUJEgw %}





# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)


# Referensi

1. [hixonrails.com/ruby-on-rails-tutorials/ruby-on-rails-action-mailer-configuration](https://hixonrails.com/ruby-on-rails-tutorials/ruby-on-rails-action-mailer-configuration/){:target="_blank"}
<br>Diakses tanggal: 2020/12/22
