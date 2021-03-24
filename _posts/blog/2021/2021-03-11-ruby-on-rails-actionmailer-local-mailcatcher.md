---
layout: 'post'
title: "Konfigurasi Ruby on Rails ActionMailer pada Local Environment dengan MailCatcher"
date: 2021-03-11 17:01
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
description: "Sebelumnya, saya sudah pernah mencatat tentang konfigurasi ActionMailer dengan memanfaatkan Gmail SMTP protokol untuk mengirimkan email confirmation. Untuk testing di lokal, kita dapat memanfaatkan tools MailCatcher."
---

# Latar Belakang Masalah

Mungkin teman-teman pernah dalam situasi harus mendevelop fitur email di web aplikasi yang teman-teman bangun, tapi tidak ada internet.

Hahaha jarang sekali yaa. Tapi, misalkan kita sedang apes dan terjebak dalam situasi seperti itu.

# Pemecahan Masalah

Kita akan menggunakan MailCatcher.

> MailCatcher runs a super simple SMTP server which catches any message sent to it to display in a web interface.
>
> Run mailcatcher, set your favourite app to deliver to smtp://127.0.0.1:1025 instead of your default SMTP server, then check out http://127.0.0.1:1080 to see the mail that's arrived so far.

Dengan MailCatcher, kita dapat manangkap email yang dikirimkan dengan prokotol SMTP ke localhost.

{% image https://i.postimg.cc/DwbNRGvF/gambar-01.png | 01 %}

Sebenarnya, kita dapat membaca email dari log yang ditampilkan pada Rails server log. Namun, tentu saja kita tidak dapat melihat view template dari email.

# Instalasi

Proses instalasi sangat mudah, selayaknya memasan gem.

{% shell_cmd $ %}
gem install mailcatcher
{% endshell_cmd %}

# Jalankan MailCatcher Daemon

Setelah proses instalasi selesai, jalankan MailCatcher daemon.

{% shell_cmd $ %}
mailcatcher
{% endshell_cmd %}

<pre>
Starting MailCatcher
==> smtp://127.0.0.1:1025
==> http://127.0.0.1:1080/
*** MailCatcher runs as a daemon by default. Go to the web interface to quit.
</pre>

Port **1025** denga protokol SMTP, akan kita pasangkan pada Rails.

Untuk mengakses MailCatcher Web Interface, dapat diakses dengan alamat,

{% pre_url %}
http://127.0.0.1:1080
{% endpre_url %}

# Rails Config

{% highlight_caption config/environments/development.rb %}
{% highlight ruby linenos %}
config.action_mailer.raise_delivery_errors = false
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = { address: "127.0.0.1", port: 1025 }
{% endhighlight %}

Kalau menggunakan Devise, biasanya diminta untuk menambahkan,

```ruby
config.action_mailer.default_url_options = { host: "localhost", port: 3000 }
```

Jadinya akan seperti ini

{% highlight_caption config/environments/development.rb %}
{% highlight ruby linenos %}
config.action_mailer.raise_delivery_errors = false
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = { address: "127.0.0.1", port: 1025 }
config.action_mailer.default_url_options = { host: "localhost", port: 3000 }
{% endhighlight %}

Sesuaikan saja dengan yang sudah ada. Jangan ada baris konfig yang berulang.

**Perhatian!**

Karena **action_mailer.delivery_method** di atas menggunakan protokol `:smtp`, kita perlu memisahkan antara ActionMailer development dengan production.

Apabila terdapat configurasi untuk ActionMailer pada file **config/environment.rb**, tinggal tambahkan kondisi untuk environment production.

{% highlight_caption config/environment.rb %}
{% highlight ruby linenos %}
# ...

# ActionMailer with Gmail
if Rails.env.production?
  ActionMailer::Base.smtp_settings = {
    port:                 587,
    address:              'smtp.gmail.com',
    user_name:            Rails.application.credentials.gmail[:SMTP_USER_NAME],
    password:             Rails.application.credentials.gmail[:SMTP_PASSWORD],
    authentication:       :plain,
    enable_starttls_auto: true
  }
end
{% endhighlight %}

Selesai!


# Demonstrasi

{% image https://i.postimg.cc/W3cmXqyt/gambar-02.gif | 02 %}

Dengan begini, kita dapat menguji fitur email dengan berbagai macam alamat email yang akan langsung ditangkap oleh MailCatcher.


<br>
# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Selanjutnya, saya serahkan kepada imajinasi dan kreatifitas teman-teman. Hehe.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)




# Referensi

1. [mailcatcher.me](https://mailcatcher.me/){:target="_blank"}
<br>Diakses tanggal: 2021/03/11
