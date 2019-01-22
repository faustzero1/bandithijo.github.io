---
layout: 'post'
title: 'Reflector, Python Script untuk Memfilter Pacman Mirrorlist Arch Linux'
date: 2018-12-11 01:59
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Arch Linux', 'Tips', 'Tools', 'Terminal']
pin:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="/assets/img/logo/logo_blank_banner.png" data-echo="" alt="banner"> -->

# Prakata

Jika sebelum posting ini saya tulis, saya hanya mengetahui *tools* bernama `rankmirrors` untuk memfilter mirrors tercepat. Dan sepertinya *scripts* ini sudah *deprecated* dari *official repository* Arch Linux.

Selama ini saya hanya menggunakan mirror dari Indonesia.
```
Server = http://mirror.poliwangi.ac.id/archlinux/$repo/os/$arch
Server = http://suro.ubaya.ac.id/archlinux/$repo/os/$arch
```
Namun, beberapa hari belakangan ini, terasa ada yang aneh dengan mirror-mirror ini. Tidak terdapat *update*. Ahahaha. Terdengar konyol.

Singkat cerita, bertemulah saya dengan tools [`reflector`](https://www.archlinux.org/packages/community/any/reflector/){:target="_blank"}.

Kemalasan saya menggunakan `rankmirrors` dikarenakan kita harus menunggu lama sekali untuk mendapatkan hasilnya, meskipun hanya 5 mirror. Mungkin karena keterbatasan ilmu dan pemahaman saya pada saat itu. Namun, `reflector` memberikan hasil yang sangat timpang dalam hal kecepatan memberikan hasil. Lantas saya pun langsung mencoba mengkonfigurasikan `reflector` ke dala msistem saya.

Berikut ini adalah catatan-catatan yang tentu saja saya kutip dari Arch Wiki.

# Penerapan

<!-- PERHATIAN -->
<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
<p>Perintah-perintah di bawah ini akan menimpa file <code>/etc/pacman.d/mirrorlist</code>. Sangat dianjurkan untuk membuat <i>backup</i> terlebih dahulu.</p>
<p><pre>$ sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup</pre></p>
</div>

## Instalasi

Install paket `reflector`.
```
$ sudo pacman -S reflector
```

## Contoh Penggunaan

Untuk melihat bagaimana cara menggunakan `reflector` selalu biasakan untuk membaca `--help` dari sebuah *tools*.
```
$ reflector --help
```
```
usage: Reflector.py [-h] [--connection-timeout n] [--list-countries]
                    [--cache-timeout n] [--save <filepath>]
                    [--sort {age,rate,country,score,delay}] [--threads n]
                    [--verbose] [--info] [-a n] [-c <country>] [-f n]
                    [-i <regex>] [-x <regex>] [-l n] [--score n] [-n n]
                    [-p <protocol>] [--completion-percent [0-100]]
```
Detail lebih lengkap dapat dilihat sendiri yaa.

<br>
**Contoh 1**

Contoh di bawah ini akan menampilkan output yang dikerjakan *script* (`--verbose`) dan menyortir lima mirror yang paling ter-*update* (`--latest 5`) yang diurutkan berdasarkan hasil kecepatan *download* (`--sort rate`) kemudian hasilnya akan langsung menimpa  (`--save`) isi dari file `/etc/pacman.d/mirrorlist`.

```
$ sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
```
<br>
**Contoh 2**

Contoh di bawah ini akan menyeleksi 100 mirror yang berprotokol HTTP & HTTPS yang sudah tersinkronisasi dan diurutkan berdasarkan kecepatan *download*.

```
$ sudo reflector --latest 100 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist
```

<br>
**Contoh 3**

Contoh di bawah ini akan menyeleksi mirror berdasarkan protokol HTTPS yang terupadate 12 jam terakhir, berlokasi di Indonesia, serta diurutkan berdasarkan kecepatan *download*.

```
$ sudo reflector --country Indonesia --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
```

<br>
Nah, gimana? mantep yaa?

Biar lebih mantep lagi yuk kita bikin automatis aja proses di atas.

## Automatisasi

Automatisasi ini tergantung kalian ingin menggunakan yang mana.

<br>
**Systemd Service**

Contoh ini akan menjalankan `reflector.service` setelah network service up and online.

```
$ sudo vim /etc/systemd/system/reflector.service
```
<pre>
[Unit]
Description=Pacman mirrorlist update
Wants=network-online.target
After=network-online.target

[Service]
Type=oneshot
ExecStart=<mark>/usr/bin/reflector --protocol https --latest 30 --number 20 --sort rate --save /etc/pacman.d/mirrorlist</mark>

[Install]
RequiredBy=multi-user.target
</pre>

Parameter dari `ExecStart=` dapat teman-teman rubah sesuai preferensi masing-masing.

Kemudian, apabila ingin di jalankan sekali waktu, tinggal panggil dan jalankan saja servicenya.

```
$ sudo systemctl start reflector.service
```

Service ini hanya berjalan sekali dan langsung berhenti (*inactive*). Sehingga kita hanya perlu memanggil/menjalankannya apabila kita membutuhkan servie ini saja.

Saya tidak menyarankan untuk meng-*enable*-kan service ini setiap komputer di-*reboot*.

<br>
**Cron Task**

Untuk mengupdate mirrorlist daily, kira-kira seperti ini.

```
$ sudo vim /etc/cron.daily/mirrorlist
```
```
#!/bin/bash

# Get the country thing
/usr/bin/reflector -c "Indonesia" -p http -p https --sort rate > /etc/pacman.d/mirrorlist

# Work through the alternatives
/usr/bin/reflector -p http -p https --latest 20 --sort rate >> /etc/pacman.d/mirrorlist
```

# Pesan Penulis

Sekian catatan pribadi saya, mudah-mudahan bermanfaat bagi yang tersasar dan menemukannya.

Apabila menemukan kesalahan dan kegagalan sekali lagi saya berpesan, tulisan ini bukan tulisan yang baik. Dokumentasi paling baik adalah yang ditulis langsung oleh tim pengembangnya. Silahkan merujuk pada referensi yang saya sertakan, yaa.


# Referensi

1. [wiki.archlinux.org/index.php/Reflector](https://wiki.archlinux.org/index.php/Reflector){:target="_blank"}
<br>Diakses tanggal: 2018/12/11

2. [xyne.archlinux.ca/projects/reflector/](https://xyne.archlinux.ca/projects/reflector/){:target="_blank"}
<br>Diakses tanggal: 2018/12/11

3. [archlinux.org/packages/community/any/reflector/](https://www.archlinux.org/packages/community/any/reflector/){:target="_blank"}
<br>Diakses tanggal: 2018/12/11
