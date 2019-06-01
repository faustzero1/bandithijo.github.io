---
layout: 'post'
title: 'Konfigurasi Custom Domain GitHub Pages dengan Amazon Route 53'
date: 2019-06-01 10:10
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Ulasan']
pin:
hot:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Kira-kira sudah dua minggu ini saya mengikuti kelas "[Belajar Menjadi AWS Solutions Architect Associate](https://www.dicoding.com/academies/104){:target="_blank"}" yang diadakan oleh Dicoding.

Yang menarik, pada *final submission*, saya akan mencoba mengumpulkan *submission* dengan memanfaatkan layanan Amazon Route 53 untuk mengelola DNS dari domain ini, yang sebelumnya saya kelola menggunakan Netlify.

Bukan pertama kali ini saya berpindah-pindah DNS management. Pertama kali saya menggunakan CloudFlare, kemudian Netlify.

Dan sekarang, mumpung sedang ada fasilitas gratis dari Dicoding yang bekerja sama dengan AWS Educate, tidak ada salahnya untuk mencoba, yee kan? Hohoho.

Btw, **kenapa aplikasi DNS management milik AWS ini dinamakan Route 53?**

Nomor 53 ini merepresentasikan port yang biasa digunakan untuk service DNS pada umumnya, yaitu **port 53 TCP/UDP**.

Oke, kita langsung ke konfigurasi yaa.


# Konfigurasi

Pada tahap ini, saya akan membagi menjadi 3 tahapan.

1. [Konfigurasi *Custom Domain* di GitHub]({{ site.url }}/blog/konfigurasi-custom-domain-github-pages-dengan-amazon-route53#1-konfigurasi-custom-domain-di-github)
2. [Konfigurasi *Hosted Zone* di Route 53]({{ site.url }}/blog/konfigurasi-custom-domain-github-pages-dengan-amazon-route53#2-konfigurasi-hosted-zone-di-route-53)
3. [Konfigurasi *Nameservers* di Dewaweb (Platform penyedia layanan Domain yang saya gunakan)]({{ site.url }}/blog/konfigurasi-custom-domain-github-pages-dengan-amazon-route53#3-konfigurasi-nameservers-di-penyedia-layanan-domain)


## 1. Konfigurasi Custom Domain di GitHub

Di sini, saya mengasumsikan teman-teman sudah memiliki GitHub Pages.

Secara *default* GitHub Pages memiliki nama domain seperti ini **username.github.io**.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/NfDMr5Gt/gambar-01.png"}

Untuk mengatur konfirgurasi dari *custom domain* pada GitHub Pages, caranya sangat mudah.

1. Pergi ke repository tempat teman-teman menyimpan GitHub Pages.

2. Pergi ke tab **Settings**.

3. Scrolling ke bawah, sampai menemukan secion "GitHub Pages", seperti di bawah.

    ![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/J4przvK4/gambar-02.png"}

4. Pada bagian **Custom domain**, isikan dengan domain yang teman-teman miliki.

5. Kemudian, **Save** untuk menyimpannya.

Perhatikan pada bagian atas, akan terdapat keterangan,

"&#10004;**Your site is published at http://bandithijo.com**".

Artinya, kita sudah berhasil mengeset *custom domain* untuk GitHub Pages.

Sebagai catatan, **Enforce HTTPS** akan terdisable (*untick*). Namun jangan khawatir, karena konfigurasi HTTPS akan ditangani oleh DNS Management.

**Jangan lupa!**

Teman-teman perlu menambahkan file bernama `CNAME` yang berisi nama domain teman-teman, tanpa `www.`.

Contohnya seperti `CNAME` milik saya.

```
bandithijo.com
```

Hanya seperti itu saja isi di dalam `CNAME`.


<br>
## 2. Konfigurasi Hosted Zone di Route 53

Di sini saya mengasumsikan teman-teman sudah mempunyai akun Amazon.

Selanjutnya akan saya bagi dalam 3 tahapan.

### Mendaftarkan Domain ke Hosted Zone

1. Masuk ke Amazon Console dan pilih layanan [Route 53](https://console.aws.amazon.com/route53){:target="_blank"}.

2. Selanjutnya, pilih tab "**Hosted Zones**".

3. Buat Hosted Zone baru dengan memilih tombol biru pada bagian atas bertuliskan "**Create Hosted Zone**".

    ![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/wjdjPLWD/gambar-03.png"}

4. Isikan **Domain Name:** dengan domain yang teman-teman miliki.

5. Isikan **Comment:** dengan deskripsi bebas dari domain teman-teman.

6. **Type:** biarkan dengan pilihan **Public Hosted Zone**.

7. Kemudian pilih tombol **Create** di bawah.

8. Setelah Hosted Zone jadi, klik namanya untuk masuk ke dalam daftar record set yang dimiliki oleh Hosted Zone kita.

9. Tampilannya akan seperti di bawah ini.

    ![gambar_4]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/BvmZXyJC/gambar-04.png"}

10. Saat pertama kali dibuat, hanya akan terdapat dua buah record set, **Nameservers** dan **SOA (*Start of authority*)**, seperti yang saya kotak merah pada gambar di atas.

11. Catat keempat **Nameservers** yang diberikan secara default oleh Amazon Route 53.

    Seperti milik saya,

    ```
    ns-826.awsdns-39.net
    ns-1058.awsdns-04.org
    ns-1923.awsdns-48.co.uk
    ns-84.awsdns-10.com
    ```

    Karena akan kita inputkan ke dalam konfigurasi Nameserver yang ada pada penyedia domain.

12. Selanjutnya Kita perlu menambahkan 2 record set, A dan CNAME.

### Menambahkan Record Set A

1. Buat record set A dengan memilih tombol biru **Create Record Set** di bagian atas.

    ![gambar_5]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/52q2MyGT/gambar-05.png"}

2. Lalu isikan seperti gambar di atas.

3. **Name:** adalah domain yang kita miliki.

4. **Type:**, isikan dengan `A - IPv4 address`.

5. **Value:**, isikan dengan 4 IP address yang diberikan oleh GitHub Pages.

    ```
    185.199.108.153
    185.199.109.153
    185.199.110.153
    185.199.111.153
    ```

6. Kemudian **Save Record Set** untuk menyimpan konfigurasi ini.

### Menambahkan Record Set CNAME

1. Buat record set CNAME dengan memilih tombol biru **Create Record Set** di bagian atas.

    ![gambar_6]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/ZqbKYZzR/gambar-06.png"}

2. Lalu isikan seperti gambar di atas.

3. **Name:**, isikan dengan `www`.

4. **Type:**, isikan dengan `CNAME - Canonical name`.

5. **Value:**, isikan dengan domain GitHub Pages milik teman-teman.

    ```
    username.github.io
    ```

6. Kemudian **Save Record Set** untuk menyimpan konfigurasi ini.


<br>
Kita perlu melakukan pengujian apakah konfigurasi Name Record A dan CNAME yang kita masukkan di atas berhasil atau belum.

Tapi, nanti akan kita lakukan di akhir. Setelah kita memasukkan konfigurasi Nameservers pada penyedia layanan domain.



<br>
## 3. Konfigurasi Nameservers di Penyedia Layanan Domain

Saya membeli domain pada Dewaweb.com.

Bagi teman-teman yang tidak membeli domain di Dewaweb, jangan khawatir, karena maksud dan tujuan dari tahap ketiga ini adalah memasukkan Nameservers yang sudah diberikan oleh Mazon Route 53 ke dalam pengaturan Nameservers yang disediakan oleh layanan penyedia domain seperti Dewaweb.

Secara garis besar, tampilannya akan mirip seperti di bawah ini.

![gambar_7]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/MZL7c65v/gambar-07.png"}

Masukkan 4 alamat Nameservers yang sudah kita catat sebelumnya.


Dengan begini, tahap konfigurasi Custom Domain GitHub Pages dengan Route 53 sebagai DNS Management telah selesai.


<br>
# Pengujian

Lakukan pengujian `ping` terlebih dahulu, apakah domain kita sudah *up* atau belum.

```
$ ping -c 3 bandithijo.com
```
```
PING bandithijo.com (185.199.109.153) 56(84) bytes of data.
64 bytes from 185.199.109.153 (185.199.109.153): icmp_seq=1 ttl=56 time=43.2 ms
64 bytes from 185.199.109.153 (185.199.109.153): icmp_seq=2 ttl=56 time=42.7 ms
64 bytes from 185.199.109.153 (185.199.109.153): icmp_seq=3 ttl=56 time=43.5 ms

--- bandithijo.com ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 5ms
rtt min/avg/max/mdev = 42.743/43.145/43.532/0.364 ms
```

<br>
Selanjutnya tahap menggali informasi DNS nameserver dengan DNS lookup utility bernama `dig`.

```
$ dig bandithijo.com
```
```
; <<>> DiG 9.14.2 <<>> bandithijo.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 16638
;; flags: qr rd ra; QUERY: 1, ANSWER: 4, AUTHORITY: 4, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;bandithijo.com.                        IN      A

;; ANSWER SECTION:
bandithijo.com.         300     IN      A       185.199.110.153
bandithijo.com.         300     IN      A       185.199.108.153
bandithijo.com.         300     IN      A       185.199.111.153
bandithijo.com.         300     IN      A       185.199.109.153

;; AUTHORITY SECTION:
bandithijo.com.         172800  IN      NS      ns-1058.awsdns-04.org.
bandithijo.com.         172800  IN      NS      ns-1923.awsdns-48.co.uk.
bandithijo.com.         172800  IN      NS      ns-826.awsdns-39.net.
bandithijo.com.         172800  IN      NS      ns-84.awsdns-10.com.

;; Query time: 469 msec
;; SERVER: 118.98.44.100#53(118.98.44.100)
;; WHEN: Sat Jun 01 17:46:12 WITA 2019
;; MSG SIZE  rcvd: 243
```

Output di atas dapat berbeda-beda.

Kalau sedang beruntung, dapat menampilkan informasi yang banyak seperti di atas. Terdapat `ANSWER` dan `AUTHORITY` section.

Terkadang hanya menampilkan `ANSWER` section saja.

Perhatikan hasilnya.

Apabila telah sesuai dengan yang kita inputkan pada Amazon Console Route 53, berarti konfigurasi kita telah berhasil.

<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>Perlu diperhatikan bahwa proses perubahan Nameservers di atas sampai menjadi Nameservers yang baru, <mark><b>memerlukan waktu yang tidak sebentar</b></mark>.</p>
<p>Jadi jangan khawatir apabila setelah teman-teman selesai mengkonfigurasi, tidak langsung dapat dilihat hasilnya.</p>
</div>

<br>
# Pesan Penulis

Apabila mengalami kegagalan, silahkan merujuk juga ke tautan referensi yang saya sertakan di bawah.

Sepertinya cukup segini dulu, ya geys!

Terima kasih.


<br>
# Referensi

1. [help.github.com/en/articles/using-a-custom-domain-with-github-pages](https://help.github.com/en/articles/using-a-custom-domain-with-github-pages){:target="_blank"}
<br>Diakses tanggal: 2019/06/01

2. [help.github.com/en/articles/securing-your-github-pages-site-with-https](https://help.github.com/en/articles/securing-your-github-pages-site-with-https){:target="_blank"}
<br>Diakses tanggal: 2019/06/01

3. [help.github.com/en/articles/troubleshooting-custom-domains](https://help.github.com/en/articles/troubleshooting-custom-domains){:target="_blank"}
<br>Diakses tanggal: 2019/06/01

4. [sophiafeng.com/technical/2015/02/12/setting-up-custom-domain-name-with-github-pages-and-amazon-route-53/](http://sophiafeng.com/technical/2015/02/12/setting-up-custom-domain-name-with-github-pages-and-amazon-route-53/){:target="_blank"}
<br>Diakses tanggal: 2019/06/01

