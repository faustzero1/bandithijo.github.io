---
layout: 'post'
title: 'Konfigurasi DNSCrypt di Arch Linux'
date: 2018-08-22 12:52
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Security', 'Tips', 'Arch Linux']
pin:
hot: true
---

<!-- BANNER OF THE POST -->
<img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="https://s20.postimg.cc/hvtdtlfa5/banner_post_20.png" alt="banner">

# Pendahuluan
DNSCrypt ? Apa itu ?

Dokumentasi ini tidak ditulis untuk menjelaskan pertanyaan-pertanyaan tersebut. Mungkin teman-teman bisa mencari-cari literatur sendiri untuk jawaban dari pertanyaan di atas, yaa. Seperti [di sini](https://dnscrypt.info/){:target="_blank"}.

# Permasalahan
Kesulitan dalam mengakses beberapa portal informasi membuat saya gerah. Pasalnya saya kehilangan beberapa bahan bacaan dan sumber informasi yang bagus sekali dari internet berskala global. Di sisi lain, saya pun setuju dengan adanya pemblokiran-pemblokiran ini. Agar informasi yang tidak semestinya dilihat oleh kelompok umur yang belum dewasa secara psikologis tidak melihat konten tersebut dengan mudah dan gamblang. Terlebih lagi untuk teman-teman yang sudah memiliki anak. Akan sangat diuntungkan oleh kebijakan ini. Toh, kita yang orang dewasa sudah pada pintar-pintar mencari jalan menuju roma.

Baiklah, saya tidak ingin menuliskan panjang lebar tentang *issue* ini. Apabila kalian membaca post ini, mungkin masalah yang kita hadapi sama, mas bro !

# Instalasi
Kita perlu memasang paket yang bernama [**dnscrypt-proxy**](https://www.archlinux.org/packages/?name=dnscrypt-proxy){:target="_blank"}.
```
$ sudo pacman -S dnscrypt-proxy
```

# Konfigurasi
Setelah kita berhasil memasang paket `dnscrypt-proxy`, tahap selanjutnya tentu saja mengkonfigurasi. Jujur saja, untuk saya, bagian ini agak susah-susah gampang. Bukan susah dalam artian sulit, namun lebih ke *tricky*. Karena dalam beberapa kasus, cara A terbukti berhasil di saya, namun belum tentu dengan di sistem kalian.

Pada dokumentasi ini saya langsung saja akan menggunakan cara yang berhasil saya terapkan pada sistem saya.

Sekenario pada dokumentasi ini adalah, kita akan mengkonfigurasi `dnscrypt-proxy` terlebih dahulu, selanjutnya kita akan mengkonfigurasi `/etc/resolv.conf` agar tidak ter-*generate* oleh NetworkManager.

## Konfigurasi DNSCrypt
Setelah kita memasang paket `dnscrypt-proxy`, akan terdapat dua service yang disediakan, yang kita <span class="stabilo">hanya bisa memilih salah satu dari keduanya</span> untuk kita *enable*-kan<sup>[1](https://bandithijo.com/blog/konfigurasi-dnscrypt-proxy#referensi)</sup>.

Kedua service tersebut adalah :
1. `dnscrypt-proxy.service`
2. `dnscrypt-proxy.socket`

Pada dokumentasi ini saya akan menggunakan `.socket` karena sudah terbukti terkonfigurasi dengan baik pada sistem saya.
Karena saat saya menggunakan `.service`, saya sudah meng-*enable* kan service agar dapat dijalankan saat proses sistem dimulai, namun ternyata tidak dijalankan. Karena keterbatasan ilmu, saya memutuskan untuk mencoba menggunakan `.socket` dan berjalan sesuai harapan.

Lahkah-lahkahnya sebagai berikut :

1. Edit file `/etc/dnscrypt-proxy/dnscrypt-proxy.toml`.<sup>[1](https://bandithijo.com/blog/konfigurasi-dnscrypt-proxy#referensi)</sup>
```
$ sudo vim /etc/dnscrypt-proxy/dnscrypt-proxy.toml
```
Cari pada baris yang bertuliskan `listen_addresses`, *value* yang ada pada kurung kotak, berupa ip address dan port, kita kosongkan. Sehingga akan berbentuk seperti ini.<sup>[1](https://bandithijo.com/blog/konfigurasi-dnscrypt-proxy#referensi)</sup>
```
...
listen_addresses = [ ]
...
```
Simpan dan exit.


2. Konfigurasi socket agar aktif saat proses booting.
```
$ sudo systemctl enable dnscrypt-proxy.socket
```
```
Created symlink /etc/systemd/system/sockets.target.wants/dnscrypt-proxy.socket → /usr/lib/systemd/system/dnscrypt-proxy.socket
```
Jalankan socket.
```
$ sudo systemctl start dnscrypt-proxy.socket
```
Cek status socket, apakah sudah *active (running)* atau *inactive*.
```
$ sudo systemctl status dnscrypt-proxy.socket
```
    <pre>
    ● dnscrypt-proxy.socket - DNSCrypt-proxy socket
      Loaded: loaded (/usr/lib/systemd/system/dnscrypt-proxy.socket; enabled; vendor preset: disabled)
      Active: <mark>active (running)</mark> since Wed 2018-08-22 09:12:01 WITA; 4h 33min ago
        Docs: https://github.com/jedisct1/dnscrypt-proxy/wiki
      Listen: 127.0.0.1:53 (Stream)
              127.0.0.1:53 (Datagram)
              [::1]:53 (Stream)
              [::1]:53 (Datagram)
       Tasks: 0 (limit: 4915)
      Memory: 40.0K
      CGroup: /system.slice/dnscrypt-proxy.socket

      Aug 22 09:12:01 BanditHijo-X260 systemd[1]: dnscrypt-proxy.socket: TCP_DEFER_ACCEPT failed: Protocol not available
      Aug 22 09:12:01 BanditHijo-X260 systemd[1]: dnscrypt-proxy.socket: TCP_NODELAY failed: Protocol not available
      Aug 22 09:12:01 BanditHijo-X260 systemd[1]: Listening on DNSCrypt-proxy socket.</pre>
Apabila terlihat status `dnscrypt-proxy.socket` sudah **active (running)**, artinya service sudah berjalan dengan baik.

    Kalau kita menggunakan *socket* secara otomatis akan mengaktifkan juga *service*-nya.

    Coba saja lakukan pengecekan status.

    ```
    $ sudo systemctl status dnscrypt-proxy.service
    ```
    <pre>
    ● dnscrypt-proxy.service - DNSCrypt-proxy client
      Loaded: loaded (/usr/lib/systemd/system/dnscrypt-proxy.service; disabled; vendor preset: disabled)
      Active: <mark>active (running)</mark> since Wed 2018-08-22 09:12:01 WITA; 4h 33min ago
        Docs: https://github.com/jedisct1/dnscrypt-proxy/wiki
    Main PID: 634 (dnscrypt-proxy)
       Tasks: 11 (limit: 4624)
      Memory: 17.2M
      CGroup: /system.slice/dnscrypt-proxy.service
              └─634 /usr/bin/dnscrypt-proxy --config /etc/dnscrypt-proxy/dnscrypt-proxy.toml </pre>

Kalau sudah seperti di atas, artinya service yang kita perlukan sudah berjalan dengan baik.

Sekarang lanjut ke konfigurasi nameserver pada `/etc/resolv.conf`.

## Konfigurasi resolv.conf

Mengapa kita perlu mengkonfigurasi file `/etc/resolv.conf` ?

Untuk teman-teman yang menggunakan ISP (*Internet Service Provider*) seperti IndiH0ME, biasanya konfigurai router yang dilakukan oleh ISP akan memaksa kita untuk menggunakan `nameserver 192.168.0.1` atau IP address tertentu seperti:
```
nameserver 118.98.44.100
nameserver 118.98.44.10
nameserver fe80::1%wls3
```
Hal ini menyebabkan setiap kita mengganti `nameserver` tersebut, misal mengganti manjadi DNS Google (`nameserver 8.8.8.8`) maka akan tetap terganti ke `nameserver 192.168.0.1` setelah sistem sleep/restart. Sehingga sifatnya tidak dapat permanen.

Yang jadi permasalahan adalah, untuk dapat menggunakan `dnscrypt-proxy` service, kita harus menggunakan `nameserver 127.0.0.1`. Kita memang dapat mengganti `nameserver` ini secara *manual*, namun tentu saja saya malas untuk mengganti setiap kali akan mengguanakan `dnscrypt-proxy` service.

Saya mendapati banyak cara untuk membuat *value* dari `nameserver` yang terdapat di dalam file `/etc/resolv.conf` tidak dapat berubah / ter-*regenerate* secara otomatis. Namun, saya hanya akan menuliskan cara yang saya gunakan. Saya juga belum tahu ini cara yang mudah atau tidak. Apabila teman-teman punya cara yang lebih baik, mungkin bisa menambahkan di kolom komentar.

Langkah-langkahnya :

1. Edit file `/etc/dhcpcd.conf`.<sup>[2,3](https://bandithijo.com/blog/konfigurasi-dnscrypt-proxy#referensi)</sup>
```
$ sudo vim /etc/dhcpcd.conf
```
Tambahkan pada baris paling bawah.
```
static domain_name_servers=127.0.0.1
```
Save dan exit.

Untuk memastikan `nameserver` berubah menjadi static, coba **restart** terlebih dahulu.

Berikut adalah tampilan file `/etc/resolv.conf`.

Sebelum restart.
```
# Generated by NetworkManager
nameserver 192.168.1.1
```
Sesudah restart.
```
# Generated by resolvconf
nameserver 127.0.0.1
```

# Hasilnya
Apabila kedua langkah di atas sudah kita lakukan, sekarang tinggal melakukan pengujian.
```
$ ping -c 5 reddit.com
```
Apabila berhasil.
```
PING reddit.com (151.101.1.140) 56(84) bytes of data.
64 bytes from 151.101.1.140 (151.101.1.140): icmp_seq=1 ttl=55 time=32.3 ms
64 bytes from 151.101.1.140 (151.101.1.140): icmp_seq=2 ttl=55 time=32.6 ms
64 bytes from 151.101.1.140 (151.101.1.140): icmp_seq=3 ttl=55 time=32.7 ms
64 bytes from 151.101.1.140 (151.101.1.140): icmp_seq=4 ttl=55 time=32.10 ms
64 bytes from 151.101.1.140 (151.101.1.140): icmp_seq=5 ttl=55 time=32.4 ms

--- reddit.com ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 10ms
rtt min/avg/max/mdev = 32.330/32.623/32.977/0.278 ms
```
Apabila gagal.
```
PING internetpositif.uzone.id (36.86.63.185) 56(84) bytes of data.
64 bytes from 36.86.63.185: icmp_seq=1 ttl=245 time=30.2 ms
64 bytes from 36.86.63.185: icmp_seq=2 ttl=245 time=30.8 ms
64 bytes from 36.86.63.185: icmp_seq=3 ttl=245 time=31.6 ms
64 bytes from 36.86.63.185: icmp_seq=4 ttl=245 time=29.6 ms
64 bytes from 36.86.63.185: icmp_seq=5 ttl=245 time=29.7 ms

--- internetpositif.uzone.id ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 9ms
rtt min/avg/max/mdev = 29.596/30.352/31.551/0.755 ms
```
Sekarang buka browser *favorite* kalian, dan buka halaman [www.reddit.com](https://www.reddit.com){:target="_blank"}.

# Kesimpulan
Yang dibutuhkan untuk dapat mennggunakan `dnscrypt-proxy` adalah :
1. Service `dnscrypt-proxy` yang sudah *running*
2. `nameserver 127.0.0.1` pada `/etc/resolv.conf`

# Referensi

1. [wiki.archlinux.org/index.php/DNSCrypt](https://wiki.archlinux.org/index.php/DNSCrypt){:target="_blank"}
<br>Diakses tanggal: 2018/09/22

2. [wiki.archlinux.org/index.php/Domain_name_resolution#Use_resolv.conf.head](https://wiki.archlinux.org/index.php/Domain_name_resolution#Use_resolv.conf.head){:target="_blank"}
<br>Diakses tanggal: 2018/09/22

3. [superuser.com/questions/442096/change-default-dns-server-in-arch-linux](https://superuser.com/questions/442096/change-default-dns-server-in-arch-linux){:target="_blank"}
<br>Diakses tanggal: 2018/09/22

4. [github.com/jedisct1/dnscrypt-proxy](https://github.com/jedisct1/dnscrypt-proxy){:target="_blank"}
<br>Diakses tanggal: 2018/09/22

