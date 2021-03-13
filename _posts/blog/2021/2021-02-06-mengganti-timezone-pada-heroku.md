---
layout: 'post'
title: "Mengganti Zona Waktu pada Heroku"
date: 2021-02-06 00:15
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Heroku']
pin:
hot:
contributors: []
description: "Kamu punya web aplikasi yang dideploy di Heroku? Dan tarnyata zona waktu Heroku berbeda dengan zona waktu konsumen dari web aplikasi kamu. Pada catatan kali ini, saya akan menunjukkan bagaimana cara mengganti zona waktu pada Heroku."
---


# Latar Belakang Masalah

Saya memiliki web aplikasi yang saya bangun dengan Rails menggunakan referensi waktu dengan cara seperti ini,

{% highlight_caption app/helpers/application_helper.rb %}
{% highlight ruby linenos %}
current_time = DateTime.now.strftime('%Y-%m-%d')
{% endhighlight %}

Variable `current_time` tersebut yang akan saya jadikan referensi.

# Permasalahan

**DateTime.now** tersebut akan sangat tergantung dari waktu mesin --waktu server.

Misal, dalam level development, yang menjadi server adalah laptop saya sendiri, maka variable **current_time** akan berisi waktu dari laptop saya sebagai referensi.

**Lantas, bagaimana pada level production? Yang servernya berada di luar dari Indonesia, misal seperti Heroku?**

Tentu saja, current_time akan berisi waktu yang dimiliki oleh Heroku.

**Apakah kita perlu cara lain untuk mendapatka referensi waktu saat ini?**

Tidak. Syukurlah, Heroku menyediakan fitur agar kita dapat menentukan current_time berdasarka TimeZone.

Jadi kita cukup mendefinisikan zona waktu yang akan kita pakai. Maka web aplikasi yang kita deploy ke Heroku yang entah menggunakan zona waktu bagian mana, akan mengikuti zona waktu yang kita tentukan.

Semudah itu.

# Caranya

Pada catatan ini, saya menggunakan zona waktu **Asia/Makassar**.



{% box_info %}
<p markdown=1>Saya berasumsi bahwa teman-tema sudah memasang paket **heroku-cli**.</p>
<p>Tools ini akan kita gunakan untuk berinteraksi dengan Heroku melalui Terminal. Benar-benar sangat memudahkan sekali.</p>
{% endbox_info %}

## Set TimeZone

Buka Terminal emulator kalian dan jalankan,

{% shell_cmd $ %}
heroku config:set TZ="Asia/Makassar"
{% endshell_cmd %}

Tunggu prosesnya hingga selesai.

<pre>
Setting TZ and restarting ⬢ siaga-covid19... done, v13
TZ: Asia/Makassar
</pre>

Nah, berhasil.


## Cek TimeZone

{% shell_cmd $ %}
heroku config:get TZ
{% endshell_cmd %}

Hasilnya,

<pre>
Asia/Makassar
</pre>

Nah, kalau sudah sesuai dengan yang kita definisikan, artinya kita telah berhasil.

Kalau mau dipastikan lagi kalian dapat membuka Heroku Dashboard, pergi ke web applikasi project directori, pilih tab **Settings**, lalu klik **Reveal Config Vars**.

Seharusnya sudah ada variable **TZ** dengan value TimeZone yang kita definisikan.

{% image https://i.postimg.cc/wBRt8NC0/gambar-01.png | 01 %}

Mantap!

Seharusnya, saat ini web aplikasi kita sudah menggunakan TimeZone yang kita definisikan.











# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)




# Referensi

1. [dev.to/paulasantamaria/change-the-timezone-on-a-heroku-app-2b4](https://dev.to/paulasantamaria/change-the-timezone-on-a-heroku-app-2b4){:target="_blank"}
<br>Diakses tanggal: 2021/02/06
