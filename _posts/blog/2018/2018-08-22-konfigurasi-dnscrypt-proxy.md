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
contributors: []
resume:
---

<!-- BANNER OF THE POST -->
<img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="https://s20.postimg.cc/hvtdtlfa5/banner_post_20.png" onerror="imgError(this);" alt="banner">

# Pendahuluan
DNSCrypt ? Apa itu ?

Dokumentasi ini tidak ditulis untuk menjelaskan pertanyaan-pertanyaan tersebut. Mungkin teman-teman bisa mencari-cari literatur sendiri untuk jawaban dari pertanyaan di atas, yaa. Seperti [di sini](https://dnscrypt.info/){:target="_blank"}.

# Permasalahan
Kesulitan dalam mengakses beberapa portal informasi membuat saya gerah. Pasalnya saya kehilangan beberapa bahan bacaan dan sumber informasi yang bagus sekali dari internet berskala global. Di sisi lain, saya pun setuju dengan adanya pemblokiran-pemblokiran ini. Agar informasi yang tidak semestinya dilihat oleh kelompok umur yang belum dewasa secara psikologis tidak melihat konten tersebut dengan mudah dan gamblang. Terlebih lagi untuk teman-teman yang sudah memiliki anak. Akan sangat diuntungkan oleh kebijakan ini. Toh, kita yang orang dewasa sudah pada pintar-pintar mencari jalan menuju roma.

Baiklah, saya tidak ingin menuliskan panjang lebar tentang *issue* ini. Apabila kalian membaca post ini, mungkin masalah yang kita hadapi sama, mas bro !

# Instalasi
Kita perlu memasang paket yang bernama [**dnscrypt-proxy**](https://www.archlinux.org/packages/?name=dnscrypt-proxy){:target="_blank"}.

{% shell_user %}
sudo pacman -S dnscrypt-proxy
{% endshell_user %}

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

   {% shell_user %}
sudo vim /etc/dnscrypt-proxy/dnscrypt-proxy.toml
{% endshell_user %}

   Cari pada baris yang bertuliskan `listen_addresses`, *value* yang ada pada kurung kotak, berupa ip address dan port, kita kosongkan. Sehingga akan berbentuk seperti ini.<sup>[1](https://bandithijo.com/blog/konfigurasi-dnscrypt-proxy#referensi)</sup>

   {% highlight_caption /etc/dnscrypt-proxy/dnscrypt-proxy.toml %}
   {% pre_caption %}
listen_addresses = [ ]
{% endpre_caption %}

   Simpan dan exit.

2. Konfigurasi socket agar aktif saat proses booting.

   {% shell_user %}
sudo systemctl enable dnscrypt-proxy.socket
{% endshell_user %}

   ```
   Created symlink /etc/systemd/system/sockets.target.wants/dnscrypt-proxy.socket → /usr/lib/systemd/system/dnscrypt-proxy.socket
   ```

   Jalankan socket.

   {% shell_user %}
sudo systemctl start dnscrypt-proxy.socket
{% endshell_user %}

   Cek status socket, apakah sudah *active (running)* atau *inactive*.

   {% shell_user %}
sudo systemctl status dnscrypt-proxy.socket
{% endshell_user %}

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

   Tapi, `dnscrypt-proxy.serivce` ini akan berjalan setelah kita merestart network atau sistem operasi.

   Kalau sudah seperti di atas, artinya service yang kita perlukan sudah berjalan dengan baik.

<br>
Sekarang lanjut ke konfigurasi nameserver pada `/etc/resolv.conf`.

## Konfigurasi resolv.conf

<!-- PERHATIAN -->
<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
<p>Bagian ini telah diperbaharui sejak tanggal 2020-06-26.</p>
</div>

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/d1F4dHzX/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}

Sebelumnya, terima kasih kepada mas [DØNIX (@dsnvhlm)](https://t.me/dsnvhlm){:target="_blank"} yang telah memberikan informasi dan masukan untuk bagian ini.

Saya sependapat, karena menggunakan service **dhcpcd** hanya untuk membuat static dns pada file `/etc/resolv.conf` terlalu *overkill* (berlebihan).

Saya memang menanti-nantikan ada cara yang lebih praktis. Dan cara yang diberikan oleh mas **DØNIX** ini sangat mudah untuk kita aplikasikan.

Saran tersebut juga didukung dari [sini](https://wiki.archlinux.org/index.php/Domain_name_resolution#Conditional_forwarding){:target="_blank"}, yang menginformasikan seperti ini.

> *In a dynamic environment (laptops and to some extents desktops), you need to configure your resolver based on the network(s) you are connected to. The best way to do that is to use **openresolv** because it supports multiple subscribers.*

Nah, sudah cukup banyak pendapat yang mengarah pada **openresolv**.

Yuk, langsung kita sikat!

Pertama, kita perlu mengintervensi NetworkManager, karena isi dari file `/etc/resolv.conf` merupakan *symlink* dari salah satu dari 3 file ini:

1. `/run/systemd/resolve/stub-resolv.conf`
2. `/run/systemd/resolve/resolv.conf`
3. `/usr/lib/systemd/resolv.conf`

Kalau saya, ada di no. 2. Saya tebak, teman-teman juga biasanya no. 2.

Untuk memerintahkan NetworkManager agar mengguanakn **openresolv**, kita perlu membuat sebuah file config di dalam direktori NetworkManager config.

{% shell_user %}
sudo vim /etc/NetworkManager/conf.d/rc-manager.conf
{% endshell_user %}

Lalu isikan seperti ini.

{% highlight_caption /etc/NetworkManager/conf.d/rc-manager.conf %}
{% pre_caption %}
[main]
rc-manager=resolvconf
{% endpre_caption %}

Oke, urusan kita dengan NetworkManager selesai.

Selanjutnya, kita perlu mengkonfigurasi **openresolv**.

Openresolv sudah merupakan paket dari **core/openresolv**, yang artinya sudah berada pada core package dari Arch Linux. Jadi kita tidak perlu memasangnya.

Nah, openresolv menyediakan file binary perintah bernama `resolvconf` dan file konfigurasi di `/etc/resolvconf.conf`.

Buka file konfig tersebut, dan **uncomment** baris yang mengandung `name_servers=`.

{% highlight_caption /etc/resolvconf.conf %}
{% pre_caption %}
# Configuration for resolvconf(8)
# See resolvconf.conf(5) for details

resolv_conf=/etc/resolv.conf
# If you run a local name server, you should uncomment the below line and
# configure your subscribers configuration files below.
<mark>name_servers=127.0.0.1</mark>
{% endpre_caption %}

\*Uncomment baris yang saya marking.

Untuk konfigurasi dnscrypt-proxy yang kita lakukan, kita menggunakan nameserver 127.0.0.1.

{% box_info %}
<p>Sekedar info saja, kalau kita perhatikan nama dari option tersebut <code>name_servers=</code> yang berbentuk plural, artinya kita dapat mendefinisikan lebih dari satu name server. Caranya dengan mengapit dengan petik dua (") dan setiap name server dipisahkan oleh spasi.</p>
<pre>
name_servers="127.0.0.1 8.8.8.8 4.4.4.4 1.1.1.1"
</pre>
{% endbox_info %}

Nah, dengan begini tahap konfigurasi static DNS dengan file resolv.conf telah selesai.

Untuk memastikan `nameserver` berubah menjadi static, coba restart serivice dari `NetworkManager.service` terlebih dahulu.

{% shell_user %}
sudo systemctl restart NetworkManager.service`
{% endshell_user %}

Kemudian coba lakukan pengecekan isi dari file `/etc/resolv.conf`.

{% shell_user %}
cat /etc/resolv.conf
{% endshell_user %}

Apakah nameserver sudah berubah menjadi `nameserver 127.0.0.1` ?

Kalau belum, tunggu sekitar 2-3 menit. Sambil melakukan restart terhadap kedua service di atas.

Kalau gak sabar, bisa jalankan perintah di bawah, untuk mengenerate isi dari file `/etc/resolv.conf` sesuai dengan yang kita konfig.

{% shell_user %}
sudo resolvconf -u
{% endshell_user %}

Selesai!

<br>
Berikut adalah tampilan file `/etc/resolv.conf` sebelum dan sesudah kita konfig.

**Sebelum**.
{% highlight_caption /etc/resolv.conf %}
{% pre_caption %}
# Generated by NetworkManager
nameserver 118.98.44.100
nameserver 118.98.44.10
nameserver fe80::1%wls3
{% endpre_caption %}

**Sesudah**.
{% highlight_caption /etc/resolv.conf %}
{% pre_caption %}
# Generated by resolvconf
nameserver 127.0.0.1
{% endpre_caption %}

<br>
**Video demonstrasinya**

{% youtube 1zf1Dpyzq84 %}


# Hasilnya

Apabila kedua langkah di atas sudah kita lakukan, sekarang tinggal melakukan pengujian.

**Apabila berhasil**.

{% shell_user %}
dig +short txt qnamemintest.internet.nl
{% endshell_user %}

```
a.b.qnamemin-test.internet.nl.
"HOORAY - QNAME minimisation is enabled on your resolver :)!"
```

{% shell_user %}
ping -c 3 reddit.com
{% endshell_user %}

```
PING reddit.com (151.101.1.140) 56(84) bytes of data.
64 bytes from 151.101.1.140 (151.101.1.140): icmp_seq=1 ttl=55 time=32.3 ms
64 bytes from 151.101.1.140 (151.101.1.140): icmp_seq=2 ttl=55 time=32.6 ms
64 bytes from 151.101.1.140 (151.101.1.140): icmp_seq=3 ttl=55 time=32.7 ms

--- reddit.com ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 10ms
rtt min/avg/max/mdev = 32.330/32.623/32.977/0.278 ms
```

**Apabila gagal**.

{% shell_user %}
dig +short txt qnamemintest.internet.nl
{% endshell_user %}

```
a.b.qnamemin-test.internet.nl.
"NO - QNAME minimisation is NOT enabled on your resolver :("
```

{% shell_user %}
ping -c 3 reddit.com
{% endshell_user %}

```
PING internetpositif.uzone.id (36.86.63.185) 56(84) bytes of data.
64 bytes from 36.86.63.185: icmp_seq=1 ttl=245 time=30.2 ms
64 bytes from 36.86.63.185: icmp_seq=2 ttl=245 time=30.8 ms
64 bytes from 36.86.63.185: icmp_seq=3 ttl=245 time=31.6 ms

--- internetpositif.uzone.id ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 9ms
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

2. [wiki.archlinux.org/index.php/Domain_name_resolution#Conditional_forwarding](https://wiki.archlinux.org/index.php/Domain_name_resolution#Conditional_forwarding){:target="_blank"}
<br>Diakses tanggal: 2020/06/26

3. [wiki.archlinux.org/index.php/NetworkManager#Use_openresolv](https://wiki.archlinux.org/index.php/NetworkManager#Use_openresolv){:target="_blank"}
<br>Diakses tanggal: 2020/06/26

4. [wiki.archlinux.org/index.php/Openresolv](https://wiki.archlinux.org/index.php/Openresolv){:target="_blank"}
<br>Diakses tanggal: 2020/06/26

5. [superuser.com/questions/442096/change-default-dns-server-in-arch-linux](https://superuser.com/questions/442096/change-default-dns-server-in-arch-linux){:target="_blank"}
<br>Diakses tanggal: 2018/09/22

6. [github.com/jedisct1/dnscrypt-proxy](https://github.com/jedisct1/dnscrypt-proxy){:target="_blank"}
<br>Diakses tanggal: 2018/09/22

7. [www.privacytools.io/providers/dns/](https://www.privacytools.io/providers/dns/){:target="_blank"}
<br>Diakses tanggal: 2020/07/26

