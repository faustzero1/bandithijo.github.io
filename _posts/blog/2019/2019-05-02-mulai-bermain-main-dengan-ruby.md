---
layout: 'post'
title: 'Mulai Bermain-main dengan Ruby'
date: 2019-05-02 00:29
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Ruby', 'Ulasan']
pin:
hot:
contributors: []
description: "Catatan ini adalah awal pertama kali saya mulai menekuni bahasa pemrograman Ruby."
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Awal saya bertemu dengan bahasa Ruby adalah saat mengikuti "[*Online Course Ruby on Rails*](https://www.idrails.com/training-ruby-on-rails){:target="_blank"}" yang dibawakan oleh mas [Agung Setiawan](http://agung-setiawan.com/){:target="_blank"} pada Agustus 2017.

{% image https://i.postimg.cc/854nxFQN/50041702-10217428365690776-8442941827375431680-n.jpg | 1 | Sumber: <a href="https://www.facebook.com/photo.php?fbid=10217428365610774&set=pb.1524018222.-2207520000.1556728701.&type=3&theater" target="_blank">Facebook Agung Setiawan</a> Batch 9 (Posted: 18 Januari 2019) %}

Saat itu saya termasuk dalam **Batch 2**, saat tulisan ini saya buat, course ini sudah memasuki **Batch 10**.

{% box_info %}
<p>Berdasarkan email dari mas Agung Setiawan yang saya terima pada 3 May 2019, pada pukul 09:28.</p>
<p><b>"Batch 10 ini adalah batch terakhir sebelum course-nya saya hentikan sampai waktu yang tidak ditentukan."</b></p>
{% endbox_info %}

Bagi teman-teman yang tertarik bisa langsung menghubungi mas Agung Setiawan pada nomor Handphone yang tertera pada poster di atas.

---

Saat itu saya hanya sekedar menonton dan mengikuti saja alur dari mater-materi yang diberikan. Belum benar-benar mengerti apa yang sebenarnya terjadi, apa yang dapat dilakukan dengan Ruby? dan apa yang Ruby dapat berikan untuk saya?

Singkat cerita, setelah menyelesaikan semua materi Ruby on Rails, saya melanjutkan lagi belajar Python dengan Django Web Framework.

Namun di tengah jalan, saya tertarik untuk memindahkan platform blog saya, yang semula menggunakan Blogger (Blogspot), menjadi menggunakan Static Site Generator (SSG), yaitu Jekyll yang juga dibangun dengan bahasa Ruby.

Beberapa kali saya bersinggungan dengan Jekyll Plugins yang ditulis dengan bahasa Ruby.

Ada "*something*" yang membuat saya betah. Satu hal yang paling saya sadari adalah, Ruby, terkhusus Jekyll, sangat memudahkan dan membantu saya dalam menyelesaikan pemecahan permasalahan kebutuhan yang saya temui selama membangun blog ini.

Di tengah keputusasaan belajar Django Web Framework yang tak kunjung "lulus-lulus", tak kunjung membuahkan hasil nyata. Saya kembali berpikir, mengapa tidak mencoba lagi Ruby on Rails (RoR) yang juga menggunakan Ruby sama seperti halnya blog Jekyll yang sudah setahun saya bangun.

Lantas saya pun mulai membuka kembali video-video materi belajar tahun 2017 yang lalu.

Dan ...

Saya mulai nyambung dengan apa yang mas Agung berikan dalam video itu. Seperti ada sekumpulan *engineer* di dalam otak saya sedang ngobrolin Ruby. Wkwkwk.

Sensasi seperti ini bukan yang pertama kali saya dapat. Saya pernah mengalami sebelumnya saat belajar Python, kemudian SQL Query, Javascript dan kemudian Liquid template language yang saya gunakan untuk membangun theme blog ini.

Saya menafsirkan, maksud dari sensasi ini adalah, saya sudah mulai "klik" dan tidak ada lagi rasa takut.

# Pembahasan

Maksud dari blog post kali ini adalah, saya ingin menampilkan kebiasaan saya saat mempelajari bahasa pemrograman yang baru.

Buat saya, cara paling efektif adalah dengan selalu bermain bersama bahasa tersebut.

Berpikir, bernafas, berlari, tidur, mandi, dan sebagainya harus bersama bahasa tersebut.

Sebentar, agak berlebihan. Kayaknya belum sampai tahap seperti itu. Wkwkwk.

Biasanya saya awali dengan mengkonfersikan script-script yang saya buat dengan bahasa sebelumnya.

Kebetulan Ruby adalah bahasa pemrograman yang menggunakan interpreter, sehingga mirip dengan Python yang dapat kita gunakan sebagai *scripting language*.

Saat mempelajari bahasa Python, saya membuat beberapa Python script untuk menyelsaikan beberapa pekerjaan rumah tangga kecil-kecilan.

Nah, karena saat ini sedang belajar Ruby, saya akan mulai mengkonfersikan Python script yang saya buat menjadi Ruby script, wkwkwkwk.

## Contoh 1

Di bawah ini adalah contoh Python script sederhana yang saya gunakan untuk membuat multiple user pada sistem operasi GNU/Linux.

{% highlight python linenos %}
#!/usr/bin/env python3

import os

userDibuat = int(input('Masukkan jumlah user yang ingin dibuat: '))

print(userDibuat, 'users akan dibuat.')

for user in range(1, userDibuat+1):
    username = input(f'Masukkan USERNAME untuk user ke-{user} : ')
    os.system(
        f'''
        sudo useradd -m -g users -G sudo,storage,power,input,network {username}
        ''')
    print('Username:', username, 'berhasil ditambahkan !')

print('>> SELESAI MAS BROH !')
{% endhighlight %}

Nah, sekarang versi Ruby nya.

{% highlight ruby linenos %}
#!/usr/bin/env ruby

puts 'Masukkan jumlah user yang ingin dibuat: '
userDibuat = gets.to_i

puts "#{userDibuat} users akan dibuat."

userDibuat.times do |user|
    puts "Masukkan USERNAME untuk user ke-#{user+1} : "
    username = gets.chomp
    system("sudo useradd -m -g users -G sudo,storage,power,input,network \
           #{username}")
    puts "Username: #{username} berhasil ditambahkan !"
end

puts '>> SELESAI MAS BROH !'
{% endhighlight %}

Gimana? Mirip bukan?

Secara struktur sintaks, sama-sama mudah untuk dibaca dan ndak bikin ngebong.


## Contoh 2

{% youtube jr43cIer1Fw %}

<br>
Nah! Dari kedua contoh di atas. Masih banyak lagi yang akan saya coba konfersikan. Karena setiap Python script memiliki fungsi yang berbeda-beda.

Saya jadi penasaran dan sangat bersemangat untuk melanjutkan proses belajar Ruby ini.

Sepertinya segini dulu ceritanya.

Terima kasih yang sudah mampir yaa.


# Referensi

1. [ruby-doc.org/core-2.4.0/Kernel.html#method-i-system](https://ruby-doc.org/core-2.4.0/Kernel.html#method-i-system){:target="_blank"}
<br>Diakses tanggal: 2019/05/02

2. [ruby-doc.org/core-2.4.0/ARGF.html](https://ruby-doc.org/core-2.4.0/ARGF.html){:target="_blank"}
<br>Diakses tanggal: 2019/05/02

