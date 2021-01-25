---
layout: 'post'
title: "Konfigurasi DNSCrypt-proxy di FreeBSD"
date: 2020-03-22 20:29
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'FreeBSD']
pin:
hot:
contributors: []
resume:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Pendahuluan

Kalau sebelumnya, saya sudah pernah menuliskan mengenai ["Konfigurasi DNSCrypt di Arch Linux"](/blog/konfigurasi-dnscrypt-proxy){:target="_blank"}, maka kali ini masih mengenai konfigurasi DNSCrypt juga namun pada sistem operasi FreeBSD. Woho!

Kira-kira awal Maret 2020, saya sudah resmi bermigrasi menggunakan FreeBSD. Sebenarnya beberapa hari setelahnya saya sudah mengkonfigurasi DNSCrypt-proxy agar dapat berjalan di FreeBSD. Namun, gagal. Ahaha.

Konfigurasi DNSCrypt-proxy pada FreeBSD pasti akan berbeda dengan Arch Linux, karena service dijalankan dengan cara yang berbeda. Arch Linux menggunakan systemd sedangkan FreeBSD menggunakan BSD init.

{% box_perhatian %}
<p>Sebenarnya saya tidak tahu, bagaimana cara yang benar dalam mengkonfigurasi DNSCypt-proxy di FreeBSD. Yang saya lakukan berikut ini adalah hasil buah pemikiran sendiri.</p>
<p>Maka dari itu, apabila cara yang saya lakukan ternyata tidak tepat, <b>mohon kesediannya untuk memberikan rekomendasi cara yang benar</b>.</p>
<p>Terima kasih. (^_^)</p>
{% endbox_perhatian %}

# Instalasi

Pasang dahulu paket `dnscrypt-proxy2`. Saat tulisan ini dibuat, paket ini sudah mencapai versi 2.0.39. Sedangkan pada repositori GitHubnya sudah mencapai versi 2.0.40

```
Name           : dnscrypt-proxy2
Version        : 2.0.39
Installed on   : Sun Mar 22 14:34:59 2020 WITA
Origin         : dns/dnscrypt-proxy2
Architecture   : FreeBSD:12:amd64
Prefix         : /usr/local
Categories     : security dns
Licenses       : ISCL
Maintainer     : egypcio@FreeBSD.org
WWW            : https://github.com/jedisct1/dnscrypt-proxy
Comment        : Flexible DNS proxy with support for encrypted protocols
Options        :
DOCS           : on
EXAMPLES       : on
Annotations    :
FreeBSD_version: 1201000
repo_type      : binary
repository     : FreeBSD
Flat size      : 8.00MiB
Description    :
A flexible DNS proxy with support for modern encrypted DNS protocols such as
DNSCrypt v2 and DNS-over-HTTP/2.

WWW: https://github.com/jedisct1/dnscrypt-proxy
```

Saya akan menggunakan pkg.

{% shell_user %}
doas pkg install dnscrypt-proxy2
{% endshell_user %}

# Konfigurasi

Biasanya, setelah proses instalasi selesai, akan keluar *message*. Saat tulisan ini dibuat, *message* yang dikeluarkan adalah seperti ini.

```
Message from dnscrypt-proxy2-2.0.39:

--
Version 2 of dnscrypt-proxy is written in Go and therefore isn't capable
of dropping privileges after binding to a low port on FreeBSD.

By default, this port's daemon will listen on port 5353 (TCP/UDP) as the
_dnscrypt-proxy user.

It's possible to bind it and listen on port 53 (TCP/UDP) with mac_portacl(4)
kernel module (network port access control policy). For this add
dnscrypt_proxy_mac_portacl_enable=YES in your rc.conf. The dnscrypt-proxy
startup script will load mac_portacl and add a rule where _dnscrypt-proxy user will
be able to bind on port 53 (TCP/UDP). This port can be changed by
dnscrypt_proxy_mac_portacl_port variable in your rc.conf. You also need to
change dnscrypt-proxy config file to use port 53.

Below are a few examples on how to redirect local connections from port
5353 to 53.

[ipfw]

  ipfw nat 1 config if lo0 reset same_ports \
    redirect_port tcp 127.0.0.1:5353 53 \
    redirect_port udp 127.0.0.1:5353 53
  ipfw add nat 1 ip from any to 127.0.0.1 via lo0

  /etc/rc.conf:
    firewall_enable="YES"
    firewall_nat_enable="YES"

  /etc/sysctl.conf:
    net.inet.ip.fw.one_pass=0

[pf]

  set skip on lo0
  rdr pass on lo0 proto { tcp udp } from any to port 53 -> 127.0.0.1 port 5353

  /etc/rc.conf:
    pf_enable="YES"

[unbound]

  /etc/rc.conf:
    local_unbound_enable="YES"

  /var/unbound/unbound.conf:
    server:
      interface: 127.0.0.1
      do-not-query-localhost: no

  /var/unbound/forward.conf:
    forward-zone:
      name: "."
      forward-addr: 127.0.0.1@5353

  If you are using local_unbound, DNSSEC is enabled by default. You should
  comment the "auto-trust-anchor-file" line or change dnscrypt-proxy to use
  servers with DNSSEC support only.
```

Nah, keren yaa, hehe. Ada rekomendasi konfigurasi yang diberikan oleh maintainer.

Biasanya, saya tinggal mengikuti pesan rekomendasi ini, dan konfigurasi sudah siap digunakan.

Namun, untuk kali ini, mungkin saya kurang bisa memahami pesan rekomendasi untuk pengaturan DNSCrypt-proxy.

Baik, langsung saja saya mulai dengan menambahkan satu baris konfigurasi pada `/etc/rc.conf`.

{% shell_user %}
doas vim /etc/rc.conf
{% endshell_user %}

{% highlight_caption /etc/rc.conf %}
{% highlight conf linenos %}
# ...
# ...

# dnscrypt-proxy2
dnscrypt_proxy_mac_portacl_enable="YES"
{% endhighlight %}

Tujuan dari penambahan ini adalah untuk merubah default port yang akan di-listen dari *default* port 5353 (TCP/UDP) ke port 53 (TCP/UDP) dengan bantuan `mac_portacl` (*network port access control policy*).

Selanjutnya cek file konfigurasi untuk DNSCrypt-proxy.

{% shell_user %}
doas vim /usr/local/etc/dnscrypt-proxy/dnscrypt-proxy.toml
{% endshell_user %}

Periksa apakah port yang digunakan sudah menggunakan port **53**, kira-kira pada baris 37.

{% highlight_caption /usr/local/etc/dnscrypt-proxy/dnscrypt-proxy.toml %}
{% highlight toml linenos %}
## List of local addresses and ports to listen to. Can be IPv4 and/or IPv6.
## Example with both IPv4 and IPv6:
## listen_addresses = ['127.0.0.1:5353']

listen_addresses = ['127.0.0.1:53']

{% endhighlight %}

Nah, sejauh yang saya pahami pada pesan rekomendasi pasca proses instalasi, kita diminta untuk menambahkan beberapa pengaturan seperti untuk `[ipfw]`, `[pf]`, dan `[unbound]`.

Selanjutnya, kita perlu membuat dns nameserver memiliki alamat `127.0.0.1`. Kalau saat ini, dns resolver saya masih memiliki nameserver yang digenerate otomatis oleh ISP.

Cek dengan perintah,

{% shell_user %}
cat /etc/resolv.conf
{% endshell_user %}

{% highlight_caption /etc/resolv.conf %}
{% highlight conf linenos %}
nameserver 118.98.44.10
nameserver 118.98.44.100
nameserver fe80::1%wlan0
{% endhighlight %}

Untuk membuat perubahan yang permanen, saya menggunakan `/etc/dhclient.conf`.

{% shell_user %}
doas vim /etc/dhclient.conf
{% endshell_user %}

Tambahkan baris ini,

{% highlight_caption /etc/dhclient.conf %}
{% highlight conf linenos %}
supersede domain-name-servers 127.0.0.1;
{% endhighlight %}

Selanjutnya, untuk dapat menerapkan konfigurasi ini, kita perlu merestart network.

{% shell_user %}
doas service netif restart
{% endshell_user %}

Nah, sekarang coba **restart** terlebih dahulu. Agar konfigurasi yang kita pasang pada file `/etc/rc.conf` dapat dijalankan.

Setelah itu, saat ini kita tidak dapat melakukan ping keluar. Tapi jangan khawatir, karena kita belum menjalankan DNSCrypt-proxy service.

Coba periksa status dari service DNSCrypt-proxy.

{% shell_user %}
doas service dnscrypt-proxy onestatus
{% endshell_user %}

Hasilnya akan,

```
dnscrypt_proxy is not running.
```

Kalau kita coba untuk menjalankannya.

{% shell_user %}
doas service dnscrypt-proxy onestart
{% endshell_user %}

Hasilnya akan tetap sama.

```
dnscrypt_proxy is not running.
```

**Kalau gagal seperti ini, bagaimana cara menjalankan DNSCrypt-proxy?**

Lantas saya mencoba menjalankan DNSCrypt-proxy via Terminal dengan mengkaitkan dengan file config.

{% shell_user %}
doas dnscrypt-proxy -config /usr/local/etc/dnscrypt-proxy/dnscrypt-proxy.toml
{% endshell_user %}

Nah, outputnya akan seperti ini.

```
[2020-03-22 22:43:48] [NOTICE] dnscrypt-proxy 2.0.39
[2020-03-22 22:43:48] [NOTICE] Network connectivity detected
[2020-03-22 22:43:48] [NOTICE] Source [public-resolvers] loaded
[2020-03-22 22:43:48] [NOTICE] Source [relays] loaded
[2020-03-22 22:43:48] [NOTICE] Firefox workaround initialized
[2020-03-22 22:43:48] [NOTICE] Now listening to 127.0.0.1:53 [UDP]
[2020-03-22 22:43:48] [NOTICE] Now listening to 127.0.0.1:53 [TCP]
[2020-03-22 22:43:49] [NOTICE] [ibksturm] OK (DNSCrypt) - rtt: 278ms
[2020-03-22 22:43:49] [NOTICE] [dnscrypt.one] OK (DNSCrypt) - rtt: 306ms
[2020-03-22 22:43:49] [NOTICE] [opennic-luggs] OK (DNSCrypt) - rtt: 306ms
[2020-03-22 22:43:49] [NOTICE] [skyfighter-dns] OK (DNSCrypt) - rtt: 252ms
[2020-03-22 22:43:50] [NOTICE] [quad9-doh-ip4-nofilter-pri] OK (DoH) - rtt: 36ms
[2020-03-22 22:43:51] [NOTICE] [cloudflare] OK (DoH) - rtt: 42ms
[2020-03-22 22:43:52] [NOTICE] [lelux.fi] OK (DoH) - rtt: 307ms
[2020-03-22 22:43:56] [NOTICE] [jp.tiarap.org] OK (DoH) - rtt: 1652ms
[2020-03-22 22:43:57] [NOTICE] [opennic-R4SAS] OK (DNSCrypt) - rtt: 408ms
[2020-03-22 22:44:00] [NOTICE] [powerdns-doh] OK (DoH) - rtt: 1095ms
[2020-03-22 22:44:02] [NOTICE] [doh.appliedprivacy.net] OK (DoH) - rtt: 250ms
[2020-03-22 22:44:02] [NOTICE] [quad9-dnscrypt-ip4-nofilter-alt] OK (DNSCrypt) - rtt: 41ms
[2020-03-22 22:44:02] [NOTICE] [quad9-dnscrypt-ip4-nofilter-alt] OK (DNSCrypt) - rtt: 41ms - additional certificate
[2020-03-22 22:44:02] [NOTICE] [ev-va] OK (DNSCrypt) - rtt: 366ms
[2020-03-22 22:44:03] [NOTICE] [arvind-io] OK (DNSCrypt) - rtt: 305ms
[2020-03-22 22:44:03] [NOTICE] [scaleway-fr] OK (DNSCrypt) - rtt: 306ms
[2020-03-22 22:44:05] [NOTICE] [dns.digitale-gesellschaft.ch] OK (DoH) - rtt: 309ms
[2020-03-22 22:44:05] [NOTICE] [opennic-rico4514] OK (DNSCrypt) - rtt: 303ms
[2020-03-22 22:44:05] [NOTICE] [v.dnscrypt.uk-ipv4] OK (DNSCrypt) - rtt: 245ms
[2020-03-22 22:44:06] [NOTICE] [dnscrypt.ca-1] OK (DNSCrypt) - rtt: 366ms
[2020-03-22 22:44:08] [NOTICE] [libredns] OK (DoH) - rtt: 205ms
[2020-03-22 22:44:09] [NOTICE] [sea-doh-us] OK (DoH) - rtt: 335ms
[2020-03-22 22:44:10] [NOTICE] [jp.tiar.app] OK (DNSCrypt) - rtt: 503ms
[2020-03-22 22:44:12] [NOTICE] [doh-crypto-sx] OK (DoH) - rtt: 369ms
[2020-03-22 22:44:15] [NOTICE] [ffmuc.net] OK (DNSCrypt) - rtt: 231ms
[2020-03-22 22:44:17] [NOTICE] [doh.ffmuc.net] OK (DoH) - rtt: 716ms
[2020-03-22 22:44:17] [NOTICE] [securedns] OK (DNSCrypt) - rtt: 308ms
[2020-03-22 22:44:18] [NOTICE] [opennic-luggs2] OK (DNSCrypt) - rtt: 304ms
[2020-03-22 22:44:19] [NOTICE] [publicarray-au2-doh] OK (DoH) - rtt: 175ms
[2020-03-22 22:44:20] [NOTICE] [a-and-a] OK (DoH) - rtt: 306ms
[2020-03-22 22:44:31] [NOTICE] [dnscrypt.eu-dk] OK (DNSCrypt) - rtt: 288ms
[2020-03-22 22:44:32] [NOTICE] [publicarray-au-doh] OK (DoH) - rtt: 699ms
[2020-03-22 22:44:33] [NOTICE] [d0wn-is-ns2] OK (DNSCrypt) - rtt: 409ms
[2020-03-22 22:44:34] [NOTICE] [gridns-jp] OK (DoH) - rtt: 334ms
[2020-03-22 22:44:36] [NOTICE] [sth-dnscrypt-se] OK (DNSCrypt) - rtt: 333ms
[2020-03-22 22:44:37] [NOTICE] [d0wn-tz-ns1] OK (DNSCrypt) - rtt: 468ms
[2020-03-22 22:44:37] [NOTICE] [ams-dnscrypt-nl] OK (DNSCrypt) - rtt: 248ms
[2020-03-22 22:44:49] [NOTICE] [jp.tiar.app-doh] OK (DoH) - rtt: 305ms
[2020-03-22 22:44:50] [NOTICE] [nextdns] OK (DoH) - rtt: 225ms
[2020-03-22 22:44:50] [NOTICE] [soltysiak] OK (DNSCrypt) - rtt: 294ms
[2020-03-22 22:44:54] [NOTICE] [faelix] OK (DoH) - rtt: 1432ms
[2020-03-22 22:44:59] [NOTICE] [dnscrypt.nl-ns0] TIMEOUT
[2020-03-22 22:44:59] [NOTICE] [qualityology.com] OK (DNSCrypt) - rtt: 224ms
[2020-03-22 22:45:00] [NOTICE] [dnscrypt.ca-2] OK (DNSCrypt) - rtt: 295ms
[2020-03-22 22:45:00] [NOTICE] [dnscrypt.uk-ipv4] OK (DNSCrypt) - rtt: 306ms
[2020-03-22 22:45:00] [NOTICE] [publicarray-au] OK (DNSCrypt) - rtt: 306ms
[2020-03-22 22:45:01] [NOTICE] [quad9-doh-ip4-nofilter-alt] OK (DoH) - rtt: 38ms
[2020-03-22 22:45:01] [NOTICE] [ev-to] OK (DNSCrypt) - rtt: 375ms
[2020-03-22 22:45:02] [NOTICE] [scaleway-ams] OK (DNSCrypt) - rtt: 301ms
[2020-03-22 22:45:03] [NOTICE] [doh-fi-snopyta] OK (DoH) - rtt: 308ms
[2020-03-22 22:45:03] [NOTICE] [publicarray-au2] OK (DNSCrypt) - rtt: 203ms
[2020-03-22 22:45:04] [NOTICE] [freetsa.org] OK (DNSCrypt) - rtt: 306ms
[2020-03-22 22:45:05] [NOTICE] [securedns-doh] OK (DoH) - rtt: 295ms
[2020-03-22 22:45:05] [NOTICE] [quad9-dnscrypt-ip4-nofilter-pri] OK (DNSCrypt) - rtt: 53ms
[2020-03-22 22:45:05] [NOTICE] [quad9-dnscrypt-ip4-nofilter-pri] OK (DNSCrypt) - rtt: 53ms - additional certificate
[2020-03-22 22:45:07] [NOTICE] [rumpelsepp.org] OK (DoH) - rtt: 260ms
[2020-03-22 22:45:08] [NOTICE] [ams-doh-nl] OK (DoH) - rtt: 307ms
[2020-03-22 22:45:10] [NOTICE] [dnscrypt.ca-1-doh] OK (DoH) - rtt: 324ms
[2020-03-22 22:45:11] [NOTICE] [opennic-bongobow] OK (DNSCrypt) - rtt: 280ms
[2020-03-22 22:45:13] [NOTICE] [sth-doh-se] OK (DoH) - rtt: 333ms
[2020-03-22 22:45:18] [NOTICE] [dnscrypt.eu-nl] OK (DNSCrypt) - rtt: 409ms
[2020-03-22 22:45:18] [NOTICE] Sorted latencies:
[2020-03-22 22:45:18] [NOTICE] -    36ms quad9-doh-ip4-nofilter-pri
[2020-03-22 22:45:18] [NOTICE] -    38ms quad9-doh-ip4-nofilter-alt
[2020-03-22 22:45:18] [NOTICE] -    41ms quad9-dnscrypt-ip4-nofilter-alt
[2020-03-22 22:45:18] [NOTICE] -    42ms cloudflare
[2020-03-22 22:45:18] [NOTICE] -    53ms quad9-dnscrypt-ip4-nofilter-pri
[2020-03-22 22:45:18] [NOTICE] -   175ms publicarray-au2-doh
[2020-03-22 22:45:18] [NOTICE] -   203ms publicarray-au2
[2020-03-22 22:45:18] [NOTICE] -   205ms libredns
[2020-03-22 22:45:18] [NOTICE] -   224ms qualityology.com
[2020-03-22 22:45:18] [NOTICE] -   225ms nextdns
[2020-03-22 22:45:18] [NOTICE] -   231ms ffmuc.net
[2020-03-22 22:45:18] [NOTICE] -   245ms v.dnscrypt.uk-ipv4
[2020-03-22 22:45:18] [NOTICE] -   248ms ams-dnscrypt-nl
[2020-03-22 22:45:18] [NOTICE] -   250ms doh.appliedprivacy.net
[2020-03-22 22:45:18] [NOTICE] -   252ms skyfighter-dns
[2020-03-22 22:45:18] [NOTICE] -   260ms rumpelsepp.org
[2020-03-22 22:45:18] [NOTICE] -   278ms ibksturm
[2020-03-22 22:45:18] [NOTICE] -   280ms opennic-bongobow
[2020-03-22 22:45:18] [NOTICE] -   288ms dnscrypt.eu-dk
[2020-03-22 22:45:18] [NOTICE] -   294ms soltysiak
[2020-03-22 22:45:18] [NOTICE] -   295ms dnscrypt.ca-2
[2020-03-22 22:45:18] [NOTICE] -   295ms securedns-doh
[2020-03-22 22:45:18] [NOTICE] -   301ms scaleway-ams
[2020-03-22 22:45:18] [NOTICE] -   303ms opennic-rico4514
[2020-03-22 22:45:18] [NOTICE] -   304ms opennic-luggs2
[2020-03-22 22:45:18] [NOTICE] -   305ms arvind-io
[2020-03-22 22:45:18] [NOTICE] -   305ms jp.tiar.app-doh
[2020-03-22 22:45:18] [NOTICE] -   306ms dnscrypt.one
[2020-03-22 22:45:18] [NOTICE] -   306ms opennic-luggs
[2020-03-22 22:45:18] [NOTICE] -   306ms scaleway-fr
[2020-03-22 22:45:18] [NOTICE] -   306ms a-and-a
[2020-03-22 22:45:18] [NOTICE] -   306ms dnscrypt.uk-ipv4
[2020-03-22 22:45:18] [NOTICE] -   306ms publicarray-au
[2020-03-22 22:45:18] [NOTICE] -   306ms freetsa.org
[2020-03-22 22:45:18] [NOTICE] -   307ms lelux.fi
[2020-03-22 22:45:18] [NOTICE] -   307ms ams-doh-nl
[2020-03-22 22:45:18] [NOTICE] -   308ms securedns
[2020-03-22 22:45:18] [NOTICE] -   308ms doh-fi-snopyta
[2020-03-22 22:45:18] [NOTICE] -   309ms dns.digitale-gesellschaft.ch
[2020-03-22 22:45:18] [NOTICE] -   324ms dnscrypt.ca-1-doh
[2020-03-22 22:45:18] [NOTICE] -   333ms sth-dnscrypt-se
[2020-03-22 22:45:18] [NOTICE] -   333ms sth-doh-se
[2020-03-22 22:45:18] [NOTICE] -   334ms gridns-jp
[2020-03-22 22:45:18] [NOTICE] -   335ms sea-doh-us
[2020-03-22 22:45:18] [NOTICE] -   366ms ev-va
[2020-03-22 22:45:18] [NOTICE] -   366ms dnscrypt.ca-1
[2020-03-22 22:45:18] [NOTICE] -   369ms doh-crypto-sx
[2020-03-22 22:45:18] [NOTICE] -   375ms ev-to
[2020-03-22 22:45:18] [NOTICE] -   408ms opennic-R4SAS
[2020-03-22 22:45:18] [NOTICE] -   409ms d0wn-is-ns2
[2020-03-22 22:45:18] [NOTICE] -   409ms dnscrypt.eu-nl
[2020-03-22 22:45:18] [NOTICE] -   468ms d0wn-tz-ns1
[2020-03-22 22:45:18] [NOTICE] -   503ms jp.tiar.app
[2020-03-22 22:45:18] [NOTICE] -   699ms publicarray-au-doh
[2020-03-22 22:45:18] [NOTICE] -   716ms doh.ffmuc.net
[2020-03-22 22:45:18] [NOTICE] -  1095ms powerdns-doh
[2020-03-22 22:45:18] [NOTICE] -  1432ms faelix
[2020-03-22 22:45:18] [NOTICE] -  1652ms jp.tiarap.org
[2020-03-22 22:45:18] [NOTICE] Server with the lowest initial latency: quad9-doh-ip4-nofilter-pri (rtt: 36ms)
[2020-03-22 22:45:18] [NOTICE] dnscrypt-proxy is ready - live servers: 58
```
Lihat, akan ada penilaian besar latency.

Dapat dilihat bahwa server bernama `quad9-doh-ip4-nofilter-pri` memiliki rtt (*round-trip delay time*) paling kecil diantara server lainnya, sebesar 36ms.

Dan pada akhirnya akan ada output,

```
[2020-03-22 22:45:18] [NOTICE] dnscrypt-proxy is ready - live servers: 58
```

Kalau sudah begini, langsung bisa kita gunakan.

Coba lakukan pengetesan dengan [**dnsleaktest.com**](https://www.dnsleaktest.com/){:target="_blank"}.

{% image https://i.postimg.cc/zvPYSxkr/gambar-01.png | 1 | Hasil pengetesan dengan dnsleaktest.com<br>(<i>gambar menyusul server postimages sedang maintenance</i>) %}

Selanjutnya, saya perlu untuk membuat proses pemanggilan DNSCrypt-proxy ini menjadi otomatis saat sistem pertama kali di jalankan. Agar tidak perlu repot-repot.

Karena saya menggunakan BSPWM, saya hanya perlu menambahkan perintah pemanggilan DNSCrypt-proxy pada BSPWM config.

Contohnya begini kira-kira untuk punya saya.

{% shell_user %}
vim ~/.config/bspwm/bspwmrc
{% endshell_user %}

Dan tambahkan command untuk menjalankan DNSCrypt-proxy seperti saat kita menjalankan di atas Terminal.

{% highlight_caption $HOME/.config/bspwm/bspwmrc %}
{% highlight conf linenos %}
# ...
# ...
sudo dnscrypt-proxy -config /usr/local/etc/dnscrypt-proxy/dnscrypt-proxy.toml &
{% endhighlight %}

Untuk teman-teman yang menggunakan Desktop Environment atau Window Manager yang lain, silahkan menyesuaikan sendiri yaa. (^_^)

<br>
Nah, permasalahannya, adalah saya memerlukan **sudo**.

Sementara, saya akan izinkan user saya, agar menjalankan DNSCrypt-proxy tanpa perlu memasukkan password.

Caranya, tambahkan pada `visudo`.

{% shell_user %}
doas visudo
{% endshell_user %}

{% highlight_caption visudo %}
{% highlight conf linenos %}
# ...
# ...

bandithijo ALL=(ALL) NOPASSWD: /usr/bin/killall,/usr/local/sbin/dnscrypt-proxy
{% endhighlight %}

Nah, saya juga sekalian menambahkan untuk `killall` agar dapat dijalankan tanpa perlu memasukkan password.

{% box_info %}
<p><b>visudo</b> hanya akan terdapat pada teman-teman yang menggunakan paket <b>sudo</b> pada FreeBSD.</p>
<p>Untuk yang menggunakan <b>doas</b>, silahkan menyesuaikan sendiri untuk pengaturannya yaa. (^_^)</p>
{% endbox_info %}

# Pesan Penulis

Oke sementara segini dulu.

Mungkin beberapa hari lagi akan saya update hasil ekperimen menjalankan DNSCrypt-proxy tanpa menggunakan **sudo**.




# Referensi

1. [dnscrypt.info/](https://dnscrypt.info/){:target="_blank"}
<br>Diakses tanggal: 2020/03/22

2. [dnscrypt.org/](https://www.dnscrypt.org/){:target="_blank"}
<br>Diakses tanggal: 2020/03/22

3. [en.wikipedia.org/wiki/DNSCrypt](https://en.wikipedia.org/wiki/DNSCrypt){:target="_blank"}
<br>Diakses tanggal: 2020/03/22

4. [github.com/DNSCrypt/dnscrypt-proxy](https://github.com/DNSCrypt/dnscrypt-proxy){:target="_blank"}
<br>Diakses tanggal: 2020/03/22
