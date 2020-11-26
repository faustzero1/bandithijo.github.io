---
layout: 'post'
title: "Cara Aman Menyimpan Credentials di Rails"
date: 2020-11-26 11:59
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

# Latar Belakang

Biasanya Junior Programmer (seperti saya) belum mengetahui bagaimana cara mendefinisikan dan menyimpan credential dengan aman.

Credential di sini, biasanya API token dari service-service yang akan kita gunakan dalam web aplikasi yang kita bangun.

Contoh kasus:

Di awal project, kita membuat sebuah file bernama **local_env.yml.example**. File ini yang nantinya dicopy dan direname menjadi **local_env.yml**. Kemudian, kita masukkan file tersebut (local_env.yml) ke dalam **.gitignore**.

<pre>
PREOJECT_DIR/
├─ app/
├─ bin/
├─ config/
│  ├─ <mark>local_env.yml.example</mark>
│  └─ <mark>local_env.yml</mark>   <- di-include ke .gitignore
├─ db/
├─ lib/
├─ ...
└─ ...
</pre>

Nah, pada file **local_env.yml** ini, yang nantinya semua dev akan menempatkan credential. Biasanya credential didapatkan dari group chat internal (biasanya ada di catatan/note dari project). Jadi tidak diikutkan bersama project yang akan di push ke Git repo.

Biasanya, pada implementasi di code program, akan menggunakan cara seperti ini.

```yaml
# config/local_env.yml

# ...
# ...
SENDGRID_USERNAME: "engineering"
SENDGRID_PASSWORD: "d3v3l0p3r"
```

{% highlight ruby linenos %}
# config/environments/development.rb

Rails.application.configure do
# ...
# ...

config.action_mailer.smtp_settings = {
address:              "smtp.sendgrid.net",
port:                 587,
domain:               "localhost:3000",
authentication:       "plain",
user_name:            ENV["SENDGRID_USERNAME"],
password:             ENV["SENDGRID_PASSWORD"],
enable_starttls_auto: true
}
end
{% endhighlight %}

Perhatikan, pada baris ke 15 & 16. Seperti itu cara kita memanggilnya.

Menggunakan,

```ruby
ENV["..."]
```

# Pemecahan Masalah

Rails sudah menyediakan file **credentials.yml.enc** (.enc adalah abreviation dari encrypted) dan juga **master.key**.

<pre>
PREOJECT_DIR/
├─ app/
├─ bin/
├─ config/
│  ├─ <mark>credentials.yml.enc</mark>
│  └─ <mark>master.key</mark>
├─ db/
├─ lib/
├─ ...
└─ ...
</pre>

**credentials.yml.enc**, adalah file terenkripsi yang akan kita gunakan untuk menyimpan credential yang kita miliki. Untuk membukanya, kita memerlukan kunci, dan kunci tersebut adalah **master.key**.

Untuk membuka enkripsi tersebut, gunakan perintah di bawah ini di Terminal.

<pre>
$ <b>rails credentials:edit</b>
</pre>

<!-- INFORMATION -->
<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p markdown=1>Namun, sebelum menjalankanya, teman-teman perlu mengecek terlebih dahulu, apa hasil dari,</p>
<pre>
$ <b>echo $EDITOR</b>
</pre>
<p markdown=1>Karena, perintah `rails credentials:edit` akan membuka text editor yang didefinikan di `$EDITOR`.</p>
<p markdown=1>Misal seperti saya, isinya adalah `vim` (karena saya mendefinikan `export EDITOR=vim`).</p>
<div style="border-bottom: 1px dashed #0B4AB9;margin: 15px 0;"></div>
<p markdown=1>Tapi, teman-teman juga dapat menggunakan editor lain, misal VSCode.</p>
<pre>
$ <b>EDITOR="code --wait" rails credentials:edit</b>
</pre>
</div>

Kalau berhasil, file tersebut akan terbuka sebagai **credentials.yml**

```yaml
# aws:
#   access_key_id: 123
#   secret_access_key: 345

# Used as the base secret for all MessageVerifiers in Rails, including the one protecting cookies.
secret_key_base: 5877ac9c9c1ee0e...40e65a9c453...d2e1c70a9f12a6
```

Secara default, isinya hanya seperti di atas.

File ini berformat yaml, artinya kita menggunakan struktur yaml dalam mendifinikan variable di dalamnya.

Contohnya seperti pada bagian `#aws:`.

Nah, sekarang, kita dapat menambahkan credential dari API token yang kita miliki.

```yaml
# aws:
#   access_key_id: 123
#   secret_access_key: 345

# Used as the base secret for all MessageVerifiers in Rails, including the one protecting cookies.
secret_key_base: 5877ac9c9c1ee0e...40e65a9c453...d2e1c70a9f12a6

# iexcloud.io sandbox
iex_sandbox:
  publishable_token: Tpk_f854a7..................1de44260
  secret_token: Tsk_0a7246...................f8a3886
```

Kemudian, cara memanggilnya pada code program.

{% highlight ruby linenos %}
# app/models/stock.rb

class Stock < ApplicationRecord
  # you can find the API token here: https://iexcloud.io/console/tokens
  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_sandbox[:publishable_token],
      secret_token:      Rails.application.credentials.iex_sandbox[:secret_token],
      endpoint:          'https://sandbox.iexapis.com/v1'
    )
    client.price(ticker_symbol)
  end
end
{% endhighlight %}

Perhatikan, baris ke 7 & 8. Seperti itu cara kita memanggilnya.

Menggunakan,

```ruby
Rails.application.credentials
```








# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)



# Referensi

1. [https://edgeguides.rubyonrails.org/security.html#custom-credentials](https://edgeguides.rubyonrails.org/security.html#custom-credentials){:target="_blank"}
<br>Diakses tanggal: 2020/11/26
