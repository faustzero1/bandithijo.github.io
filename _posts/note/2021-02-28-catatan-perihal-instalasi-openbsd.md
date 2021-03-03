---
layout: 'post'
title: "Catatan Instalasi OpenBSD"
date: 2021-02-28 05:54
permalink: '/note/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'note'
tags: ['Tips']
wip: true
pin:
contributors: []
---

# Prakata

Migrasi ke OpenBSD mungkin akan menjadi perjalanan yang panjang dan penuh persiapan.

Karena prosesnya yang tidak sekali waktu langsung selesai, namun saya cicil di waktu luang, maka saya merasa perlu untuk mendokumentasikan catatan, agar tidak hilang begitu saja.

Saya mempublikasikan catatan untuk teman-teman pembaca Blog BaditHijo, agar dapat sama-sama kita manfaatkan.

Terima kasih telah menjadi pembaca setia dan menemani saya sampai saat ini.


# Troubleshooting

## Mengakses Root

Untuk berpindah ke root shell, dapat menggunakan.

{% shell_cmd $ %}
su
{% endshell_cmd %}

Masukkan password root yang dibuat pada saat proses instalasi.

<br>
## Root permission from user

**doas** is preinstalled by default, kita hanya perlu melakukan konfigurasi,

{% highlight_caption /etc/doas.conf %}
{% highlight sh linenos %}
permit :wheel
{% endhighlight %}

Kalau kita mau user hanya memasukkan password sekali, dan sementara waktu tidak perlu memasukkan password,

{% highlight_caption /etc/doas.conf %}
{% highlight sh linenos %}
permit persist :wheel
{% endhighlight %}

<br>
## Text editor

**vi** is preinstalled by default, jadi kita dapat menggunakan text editor ini.

{% shell_cmd $ %}
vi
{% endshell_cmd %}

<br>
## Firmware update

Dapat dilakukan dengan:

{% shell_cmd $ %}
fw_update
{% endshell_cmd %}

<br>
## USB tethering

Lihat interface dari usb tethering,

{% shell_cmd $ %}
ifconfig
{% endshell_cmd %}

<pre>
...


urndis0: flags=8802<BROADCAST,SIMPLEX,MULTICAST> mtu 1500
        lladdr 0a:12:52:cf:95:21
        index 5 priority 0 llprio 3
</pre>

Biasanya akan bernama **urndis0**.

Tinggal kita jalankan,

{% shell_cmd # %}
dhclient urndis0
{% endshell_cmd %}

Kalau berhasil, kita akan mendapatkan IP address.

<pre>
urndis0: 192.168.42.224 lease accepted from 192.168.42.129 (6e:45:af:fc:be:9f)
</pre>

Kalau kita cek dengan **ifconfig**.

<pre>
urndis0: flags=808843<UP,BROADCAST,RUNNING,SIMPLEX,MULTICAST,AUTOCONF4> mtu 1500
        lladdr d2:58:ec:ab:0c:62
        index 5 priority 0 llprio 3
        inet 192.168.42.224 netmask 0xffffff00 broadcast 192.168.42.255
</pre>

<br>
## Connect Wifi

Untuk melakukan scaning, misal wifi interface kita **iwn0**.

\* dapat ditebak kalau wireless card saya adalah intel.

{% shell_cmd # %}
ipconfig iwn0 scan
{% endshell_cmd %}

Kemudia, setelah mendapatkan SSID yang kita inginkan, tinggal connect.

{% shell_cmd # %}
ifconfig iw0 nwid &lt;network-name> wpakey &lt;passphrase>
{% endshell_cmd %}

Kemudian, untuk mendapatkan IP address, dapat menggunakan dhcp.

{% shell_cmd # %}
dhcp
{% endshell_cmd %}

<br>
## DHCP Server

Jika ingin mengaktifkan DHCP server service saat startup, dapat menggunakan,

{% shell_cmd # %}
rcctl enable dhcpd
{% endshell_cmd %}

Atau untuk mengeset perinterface saja, dapat menggunkan,

Misal, untuk etheret interface **em0** dan **iwn0**.

{% shell_cmd # %}
rcctl set dhcpd flags em0 iwn0
{% endshell_cmd %}

<br>
## Tmux

Sejak OpeBSD 4.6, tmux telah menjadi bagian dari base system, sehingga kita tidak perlu repot-repot memasangnya.

Tinggal jalankan tmux di terminal.

{% shell_cmd $ %}
tmux
{% endshell_cmd %}

<br>
## Starting X (Xenodm)

The recommended way to run X is with the xenodm(1) display manager. It offers some important security benefits over the traditional startx(1) command.
If xenodm(1) wasn't enabled during installation, it can be done so later like any other system daemon:

{% shell_cmd # %}
rcctl enable xenodm
rcctl start xenodm
{% endshell_cmd %}

On some platforms, you will need to disable the console getty(8) to use it. **This is not needed on amd64, i386 or macppc**.

Cara di atas akan meng-enable-kan Display Manager yang --mungkin bernama-- **xenodm**.

Dan ketika kita login, default sessionnya adalah **fvwm** yang merupakan turunan dari **twm**.


{% comment %}
# Referensi

1. [openbsdhandbook.com/openbsd_for_linux_users/](https://www.openbsdhandbook.com/openbsd_for_linux_users/){:target="_blank"}
{% endcomment %}
