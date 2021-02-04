---
layout: 'post'
title: "Bootstrap 4 Custom File Input dengan bs-custom-file-input Javascript pada Rails 6"
date: 2021-02-05 01:19
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Rails', 'Bootstrap']
pin:
hot:
contributors: []
resume: "Bootstrap 4 menyediakan component untuk custom file input, namun component ini memiliki dependensi Javascript library yang bernama bs-custom-file-input. Catatan kali ini, saya akan membahas bagaimana cara memasang bs-custom-file-input pada Rails 6 yang menggunakan Webpacker."
---

# Requirements

`ruby 2.7.2` `rails 6.1.1` `bootstrap 4.6` `bs-custom-file-input 1.3.4`

# Latar Belakang Masalah

Catatan kali ini, saya akan membicarakan developing dari sisi front-dend. Yaitu memasang component **Custom File Input** Bootstrap 4 pada Rails 6.

{% image https://i.postimg.cc/6Qs5cMW9/gambar-01.png | 1 %}

Component ini, dapat teman-teman lihat di sini, [**Components > Custom file input**](https://getbootstrap.com/docs/4.6/components/input-group/#custom-file-input){:target="_blank"}.

Seperti yang kita tahu, Rails 6 secara default menggunakan Webpacker untuk mem-packaging dan mem-bundling aset-aset Javascript. Sehingga cara mengkonfigurasi Javascript library tentu akan sedikit berbeda dengan saat kita menggunakan Rails 5 yang menggunakan Sprockets.

# Permasalahan

Component custom file input milik Bootstrap tersebut memerlukan Javascript library yang berama [**bs-custom-file-input**](https://www.npmjs.com/package/bs-custom-file-input){:target="_blank"}.

Kalau kita belum memasang library tersebut, maka akan seperti di bawah ini.

{% image https://i.postimg.cc/85NkQsf9/gambar-02.gif | 2 %}

Dapat dilihat, **nama file** yang kita pilih, tidak tampil di input field.

Nah, ini karena bs-custom-file-input belum dipasang.

# Instalasi

## Pasang bs-custom-file-input library

Saya memilih menggunakan **yarn** untuk memasang library ini.

{% shell_cmd $ %}
yarn add bs-custom-file-input
{% endshell_cmd %}


## Definisikan pada pack

Kita perlu memanggil library bs-custom-file-input ke dalam pack yang terletak pada **app/javascript/packs/application.js**.

{% highlight_caption app/javascript/packs/application.js %}
{% highlight javascript linenos %}
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import 'bootstrap'
import bsCustomFileInput from 'bs-custom-file-input'

$(document).on('turbolinks:load', function() {

  // for bs-custom-file-input
  bsCustomFileInput.init()

})
{% endhighlight %}

Baris ke-7, adalah proses import dari bs-custom-file-input library.

baris ke-12, adalah proses inisialisasi, untuk menjalankan library.

<br>
Kelar!

Hanya seperti ini saja.

Sekarang, seharusnya sudah berhasil memunculkan nama file pada input field.

{% image https://i.postimg.cc/YS12sQ0Q/gambar-03.gif | 3 %}

Mantap!










# Pesan Penulis

Ngomong-ngomong, kalau masih kesulitan mengintegrasikan Bootstrap 4 dengan Rails 6, dapat membaca catatan saya di sini, [**Memasang Bootstrap 4 pada Rails 6 dengan Yarn**](/blog/memasang-bootstrap-pada-rails-menggunakan-yarn){:target="_blank"}.

Sepertinya, segini dulu yang dapat saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)




# Referensi

1. [getbootstrap.com/docs/4.6/components/input-group/](https://getbootstrap.com/docs/4.6/components/input-group/){:target="_blank"}
<br>Diakses tanggal: 2021/02/05

2. [www.npmjs.com/package/bs-custom-file-input](https://www.npmjs.com/package/bs-custom-file-input){:target="_blank"}
<br>Diakses tanggal: 2021/02/05
