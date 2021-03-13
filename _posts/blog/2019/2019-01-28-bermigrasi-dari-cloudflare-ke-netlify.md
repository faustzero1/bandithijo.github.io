---
layout: 'post'
title: 'BanditHijo.com, Bermigrasi dari Cloudflare ke Netlify'
date: 2019-01-28 01:18
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Jekyll', 'Tips', 'Ulasan']
pin:
hot:
contributors: []
description: "Awalmula bandithijo berpindah domain ke .com menggunakan CLoudflare sebagai DNS resolver. Kali ini, kita akan coba menggunakan Netlify yang bertugas dsebagai CI dan juga DNS resolver."
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Bermigrasi? Sepertinya untuk kasus saya, lebih pas kalau saya sebut "mencoba". Ya, belajar mencoba menggunakan platform lain.

Awalnya hanya ingin coba-coba, namun setelah berhasil dan merasakan ada "*something*" yang saya rasakan lebih baik dari Netlify ketimbang menggunakan Cloudflare, saya pun memutuskan untuk tetap menggunakan Netlify.

Kedua platform ini tidak dapat dibandingkan karena memiliki definisi dan fungsi yang berbeda.

[Apa itu Cloudflare?](https://www.cloudflare.com/){:target="_blank"}
<span style="font-size:14px;"><i>Cloudflare, Inc. is a U.S. company that provides content delivery network services, DDoS mitigation, Internet security and distributed domain name server services. Cloudflare's services sit between the visitor and the Cloudflare user's hosting provider, acting as a reverse proxy for websites. - Wikipedia</i></span>

[Apa itu Netlify?](https://www.netlify.com/){:target="_blank"}
<span style="font-size:14px;"><i>Netlify is a San Francisco-based cloud computing company that offers hosting and serverless backend services for static websites. It features continuous deployment from Git across a global application delivery network, serverless form handling,support for AWS Lambda functions, and full integration with Let's Encrypt. - Wikipedia</i></span>

Pokoknya, saat ini, saya hanya butuh konfigurasi DNS dan Nameservers-nya saja untuk dapat menghubungkan GitHub/GitLab dengan domain name yang saya beli dari Dewaweb.

# Proses Migrasi

Proses-proses di bawah ini ~~tidak~~ harus berurutan. Saya mencoba menyusun dan mengurutkan berdasarkan sekenario yang saya alami.

## GitHub

### Menghapus GitHub Page

Sebenarnya langkah ini tidak diperlukan. Ini hanya preferensi saya saja.

1. Buka tab **Settings** pada repository GitHub.

   {% image https://i.postimg.cc/kgV8Y97C/gambar-01.png | 1 %}

2. Scrolling ke bawah, pada bagian "GitHub Pages". Ganti **Source** dari **master branch** menjadi **None**.

   {% image https://i.postimg.cc/6QnZw071/gambar-02.png | 2 %}
Kemudian, **Save**.

   Karena saya memiliki **custom domain** maka saya hapus dahulu isian dari **Custom domain**. Setelah itu, baru merubah **Source** menjadi **None**.

   Dengan begini, repository **bandithijo.github.io** sudah tidak lagi menjadi GitHub page.

3. Selanjutnya, rename repository dari **bandithijo.github.io** menjadi **bandithijo.com**.

   {% image https://i.postimg.cc/0QCJKy0Y/gambar-03.png | 3 %}
Kemudian **Rename**.

   Setelah berhasil, nama dari repositori saya akan berubah.

   {% image https://i.postimg.cc/wvzmBmLx/gambar-04.png | 4 %}

   Tujuannya hanya untuk menyamakan presepsi saja, bahwa sudah tidak ada lagi repositori yang bernama **bandithijo.github.io**.

   Agar dikemudian hari tidak menimbulkan ambigu.

### Mengganti Nama Direktori Root

1. Saya juga perlu mengganti nama direktori root yang ada di laptop.

   {% shell_user %}
mv bandithijo.github.io bandithijo.com
{% endshell_user %}

   Tujuannya masih sama, agar tidak menimbulkan ambigu di kemudian hari.

### Mengganti Alamat Git Remote

1. Ganti alamat GitHub **remote** yang lama dengan yang baru.

   {% shell_user %}
vim .git/config
{% endshell_user %}

   Ganti pada section `[remote "origin"]`, `/bandithijo.github.io.git` menjadi `/bandithijo.com.git`.

   ```sh
   # ...
   # ...

   [remote "origin"]
    url = git@github.com:bandithijo/<mark>bandithijo.com</mark>.git
    fetch = +refs/heads/*:refs/remotes/origin/*

   # ...
   # ...
   ```

   Perubahan alamat remote ini adalah hal yang direkomendasikan oleh perintah `git` saat saya melakukan `git push -u origin master`.

   {% image https://i.postimg.cc/jS5Cdr51/gambar-05.png | 5 %}

### Menghapus CNAME

1. Hapus **CNAME** yang ada pada root direktori.

   <pre>
   bandithijo.com
   ├── _drafts/
   ├── _includes/
   ├── _layouts/
   ├── _posts/
   ├── _site/
   ├── assets/
   ├── pages/
   ├── _config.yml
   ├── 404.html
   ├── <mark>CNAME</mark>  <-- Hapus aku
   ├── Gemfile
   ├── Gemfile.lock
   └── index.html</pre>

   {% shell_user %}
rm CNAME
{% endshell_user %}

## Netlify

### Tambah Site Baru

1. Setelah login dan otomatis di arahkan ke alamat [app.netlify.com/](https://app.netlify.com/){:target="_blank"}. Saya menambahkan site baru.

   {% image https://i.postimg.cc/8PS526Mt/gambar-06.png | 6 %}

2. Karena saya menggunakan GitHub repo, maka pada langkah 1, ini saya memilih GitHub.

   {% image https://i.postimg.cc/RFhfnnXc/gambar-07.png | 7 %}
Asiknya dengan Netlify, saya dapat berganti-ganti **resource**.

   Jadi meskipun saya memilih GitHub saat ini, nanti saya masih dapat berubah ke resource yang lain, GitLab misalnya.

3. Saya akan diminta untuk memberikan hak autorisasi Netlify dengan akun GitHub. (Saya tidak memiliki gambarnya)

4. Pada tahap ini, saya diminta untuk memilih repository GitHub.

   {% image https://i.postimg.cc/6QvVHZdt/gambar-08.png | 8 %}

5. Padah tahap ini saya diminta untuk melakukan setting untuk mendeploy repository.

   {% image https://i.postimg.cc/26KQM9bb/gambar-09.png | 9 %}
Saya menambahkan `;rm _site/feed.xml` karena saya tidak menggunakan `feed.xml`.

   Pada langkah ini, sebenarnya di laptop (*local*/*development*), saya membuild Jekyll dengan menggunakan *custom command*.

   {% shell_user %}
JEKYLL_ENV=production jekyll build; rm _site/feed.xml
{% endshell_user %}

   Terdapat `JEKYLL_ENV=production` yang mendefiniskan bahwa build ini untuk **production environment**.

   Kegunaan dari *variabels* ini adalah saya membagi *environment* menjadi dua, *development* dan *production*. Yang mana terdapat beberapa elemen yang tidak akan ditampilkan pada *development environment* seperti: Disqus, Google Analytics, dan SEO support.

   Netlify menyediakan [Build Environment Variables](https://www.netlify.com/docs/build-settings/){:target="_blank"}, namun tidak support untuk Jekyll, hanya mensupport: Node, NPM, dan Yarn.

   Untuk mengatasi hal ini pada Netlify, saya perlu menambahkan gem bernama `jekyll-netlify`.

   Tambahkan pada jajaran plugins di `gemfile`.

   ```ruby
   gem 'jekyll-netlify', '~> 0.2.0'
   ```
   Kemudian, tambahkan pada jajaran plugins di `_config.yaml`.

   ```ruby
   plugins:
     - jekyll-netlify
   ```

   Dengan begini, saya tetap dapat menggunakan dua *environment*. Saat dibuild di Netlify, akan menjadi *production environment*.

   Namun, apabila repositori GitHub/GitLab kita sudah berupa hasil build (_site), maka kosongkan saja dua input box di atas.

   Kalau sudah yakin, klik **Deploy site**.

6. Akan keluar tampilan seperti ini.

   {% image https://i.postimg.cc/JntfdM1b/gambar-10.png | 10 %}
Saat ini statusnya project kita sedang di build dan di deploy oleh Netlify.

### Konfigurasi Custom Domain

1. Sembari menunggu proses deploy selesai, saya melakukan **Domain settings**.

   {% image https://i.postimg.cc/7PFFXFj2/gambar-11.png | 11 %}

2. Karena saya memiliki domain sendiri, yaitu **bandithijo.com**, maka saya melakukan konfigurasi custom domain, pilih **Add custom domain**.

   {% image https://i.postimg.cc/vB3WDw9S/gambar-12.png | 12 %}

3. Saya mengisikan "bandithijo.com", lebih direkomendasikan untuk menggunakan "www". Namun pada tulisan kali ini saya akan menunjukkan mudahnya konfigurasi custom domain pada Netlify.

   {% image https://i.postimg.cc/NFnm78d6/gambar-13.png | 13 %}
Tekan **Verify**.

4. Netlify akan mengkonfirmasi bahwa "bandithijo.com" sudah ada yang punya, apakah pemiliknya adalah saya?

   {% image https://i.postimg.cc/Y00QWDz2/gambar-14.png | 14 %}
Tentu saja, **Yes, add domain**.

5. Akan tampil domain "bandithijo.com" dan "www.bandithijo.com" yang memiliki status **Check DNS configuration**.

   {% image https://i.postimg.cc/76zY5gpG/gambar-15.png | 15 %}
Pilih salah satu dari kedua warning tersebut.

6. Akan terbuka popup window yang berisi tentang rekomendasi konfigurasi DNS. Untuk melakukan *pointing root domain* ke Netlify.

   {% image https://i.postimg.cc/T1qd9T2T/gambar-16.png | 16 %}
Namun, saya hiraukan saja, karena saya hanya ingin praktis dengan menggunakan DNS dari Netlify.

7. Scrolling ke bawah, untuk menemukan bantuan dalam menggunakan DNS dari Netlify.

   {% image https://i.postimg.cc/8cVkM7Sy/gambar-17.png | 17 %}
Saat ini, saya memilih menggunakan Netlify DNS agar lebih praktis.

8. Sekali lagi saya diminta untuk memastikan apakah domain **bandithijo.com** benar saya miliki atau tidak.

   {% image https://i.postimg.cc/vZ1R8QRD/gambar-18.png | 18 %}

   {% image https://i.postimg.cc/NFnm78d6/gambar-13.png | 13 %}

9. Bagian menambahkan DNS record yang lain, saya **continue** saja.

   {% image https://i.postimg.cc/j5bBhPDJ/gambar-19.png | 19 %}

10. Copy paste domain Nameserver milik Netlify yang nanti akan saya letakkan pada konfigurasi Nameserver di Dewaweb.

    {% image https://i.postimg.cc/fbX6XBRN/gambar-20.png | 20 %}

    ```
    dns1.p06.nsone.net
    dns2.p06.nsone.net
    dns3.p06.nsone.net
    dns4.p06.nsone.net
    ```

### Mengganti Default Domain Netlify

1. Saya perlu mengganti Default subdomain yang diberikan secara random oleh Netlify.

   {% image https://i.postimg.cc/LX5Lw0gd/gambar-21.png | 21 %}
Pilih **Edit site name**. Untuk merubahnya.

2. Saya isikan sesuai nama domain yang saya miliki. **bandithijo**.

   {% image https://i.postimg.cc/W179PCzt/gambar-22.png | 22 %}
Pilih **Save**.

3. Lakukan pengecekan. **Go to DNS panel**.

   {% image https://i.postimg.cc/YqHfqRJF/gambar-23.png | 23 %}

   {% image https://i.postimg.cc/m2y3cMs5/gambar-24.png | 24 %}

   Maka target dari DNS record sudah di arahkan ke alamat Default domain yang baru.

### Redirect Default Subdomain Netlify ke Primary Domain

1. Untuk melakukan redirect secara otomatis saat pengunjung mengakses **bandithijo.netlify.com** akan langsung diarahkan ke **bandithijo.com**, saya perlu melakukan konfigurasi tambahan untuk ini.

2. Netlify sudah menyarankan untuk membuat file `_redirects` pada direktori root dari direktori site saya.

   {% image https://i.postimg.cc/sDgxcZW8/gambar-25.png | 25 %}

   Namun, saya lebih memilih cara lain.

3. Saya memilih menambahkan file `netlify.toml` pada direktori root Jekyll saya. Yang isinya mirip seperti file `_redirects` yang disarankan oleh Netlify.

   {% shell_user %}
vim netlify.toml
{% endshell_user %}

   <pre>
   [[redirects]]
     from = "https://bandithijo.netlify.com/*"
     to = "https://bandithijo.com/:splat"
     status = 301
     force = true</pre>

   Saya menggunakan cara ini karena, saat menggunakan file `_redirects`, pada bagian **Settings** > **GitHub page**, dikatakan bahwa isi dari file `_redirects` tidak sesuai dengan semestinya.

   Maka dari itu saya menggunakan cara file `netlify.toml` yang sudah saya coba dan ternyata berhasil dijalankan pada kedua repository GitHub dan GitLab.

   Sekarang, apabila ada pengunjung yang dengan atau tanpa sengaja mengakses alamat **bandithijo.netlify.com** akan otomatis didirect ke **bandithijo.com**.

## Dewaweb

### Menambahkan Netlify Nameservers

1. Buka Client Area pada Dewaweb.

2. Saya hanya perlu mengganti default Dewaweb Nameserver dengan 4 buah Nameserver yang sudah diberikan oleh Netlify.

   {% image https://i.postimg.cc/4dMGQmTC/gambar-26.png | 26 %}

   {% image https://i.postimg.cc/brthCpzZ/gambar-27.png | 27 %}

3. Pastikan berhasil memasukkan Nameserver Netlify.

   {% image https://i.postimg.cc/GhRL7Tyr/gambar-28.png | 28 %}

   Apabila gagal, ulangi sampai Nameserver benar-benar tersimpan.

3. Pada Dewaweb, saya tidak perlu melakukan konfigurasi **DNS Management**.

   {% image https://i.postimg.cc/qM2tgd8B/gambar-29.png | 29 %}

   Karena saya sudah menggunakan DNS management milik Netlify.

# Konfigurasi HTTPS

Sebenarnya tahap ini tidak perlu saya lakukan.

Karena apabila langkah di atas (konfigurasi Nameservers) sudah benar, secara otomatis saya akan mendapatkan SSL/TLS certificate.

Namun untuk mencatat prosedur manualnya, saya akan tetap menuliskan langkah-langkahnya di bawah ini.

1. Kembali lagi ke Netlify

2. Scrolling ke bagian paling bawah dari halaman Settings Domain.
{% image https://i.postimg.cc/7L6jtw9q/gambar-30.png | 30 %}
Pilih **Verify DNS configuration**.

3. Apabila berhasil.
{% image https://i.postimg.cc/J05LVKk8/gambar-31.png | 31 %}
Tinggal menunggu (paling lama 24 jam) hingga Netlify memberikan sertifikat Let's Encrypt (TLS/SSL certificate) untuk mendapatkan HTTPS.

4. Yak! Tidak sampai 5 menit, SSL/TLS certificate dari Let's Encrypt saya sudah jadi.
{% image https://i.postimg.cc/VsW5XP7K/gambar-32.png | 32 %}

5. Saya coba cek di browser.
{% image https://i.postimg.cc/63N5GMCs/gambar-33.png | 33 %}

# Tips

## WWW or not WWW?

Untuk masalah ini, Belum akan saya bahas di sini.

Namun apabila ingin berpindah dari "tanpa WWW (apex domain)" dan ingin menggunakan "WWW (subdomain)" caranya sangat mudah.

Cukup klik menu pada domain **www.bandithijo.com**.
{% image https://i.postimg.cc/T3QG7R8P/gambar-34.png | 34 %}
Lalu klik **Set as primary domain**.


# Pesan Penulis

Masih banyak yang saya dapat eksplorasi dari Netlify. Namun untuk saat ini, saya hanya menggunakan Netlify sebagai DNS management saja sebagai ganti dari Cloudflare yang saya pergunakan sebelumnya.

Sangat terasa sekali perbedaan dalam hal kecepatan akses. Meskipun saya tidak melakukan pencatatan secara angka, namun secara rasa, mengunjungi bandithijo.com pasca menggunakan Netlify, sama cepatnya seperti yang saya rasakan saat mengakses bandithijo.com pada *development environment*.

Migrasi ke Netlify ini juga membawa semangat baru untuk saya, karena melihat (meskipun belum memahami) dari sepintas membaca menu dan fitur-fitur yang terdapat di dalam Netlify, seperti dapat menjadi hal yang baik bagi bandithijo.com ke depannya.

Oke, rasanya sudah cukup seperti ini dulu.

Ini adalah catatan yang sangat panjang. Mudah-mudahan pengalaman saya dapat bermanfaat bagi teman-teman yang memerlukan.


# Terima Kasih

1. [Aflasio](https://blog.aflasio.com/){:target="_blank"}

2. [Nanda Okitavera](https://okitavera.me/){:target="_blank"}

3. Beserta teman-teman di group [JAMstack Indonesia](https://t.me/JAMstackID){:target="_blank"} yang telah banyak menginspirasi saya (memberikan observation value) bagi saya untuk bermigrasi menggunakan Netlify.



# Referensi

1. [www.netlify.com/docs/continuous-deployment/](https://www.netlify.com/docs/continuous-deployment/){:target="_blank"}
<br>Diakses tanggal: 2019/01/28

2. [www.netlify.com/docs/custom-domains/](https://www.netlify.com/docs/custom-domains/){:target="_blank"}
<br>Diakses tanggal: 2019/01/28

3. [www.netlify.com/docs/dns/](https://www.netlify.com/docs/dns/){:target="_blank"}
<br>Diakses tanggal: 2019/01/28

4. [www.netlify.com/docs/redirects/](https://www.netlify.com/docs/redirects/){:target="_blank"}
<br>Diakses tanggal: 2019/01/28

5. [www.netlify.com/docs/netlify-toml-reference/](https://www.netlify.com/docs/netlify-toml-reference/){:target="_blank"}
<br>Diakses tanggal: 2019/01/28

6. [github.com/jayvdb/jekyll-netlify](https://github.com/jayvdb/jekyll-netlify){:target="_blank"}
<br>Diakses tanggal: 2019/01/28
