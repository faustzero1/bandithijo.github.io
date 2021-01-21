---
layout: 'post'
title: 'Step 1: Connecting to the Internet'
date: 2018-02-09 02:00
permalink: '/arch/:title'
author: 'BanditHijo'
license: true
comments: false
toc: true
category: 'arch'
tags:
pin:
---


# STEP 1 : Connecting to the Internet

## 1.1 Pilih Network Adapter

Untuk terhubung ke internet, terlebih dahulu kita perlu memilih mau menggunakan jalur kabel Ethernet, atau jalur Wi-Fi.

Lihat daftar network interface yang ada di sistem kita dengan menggunakan,

{% shell_root %}
ip address show
{% endshell_root %}

Atau, dapat kita singkat,

{% shell_root %}
ip a s
{% endshell_root %}

<pre>
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 brd 127.255.255.255 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp1s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN group default qlen 1000
    link/ether 00:16:d3:00:00:00 brd ff:ff:ff:ff:ff:ff
3: <mark>wlp3s0</mark>: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state DOWN group default
qlen 1000
    link/ether 08:11:96:00:00:00 brd ff:ff:ff:ff:ff:ff
</pre>

Saya memiliki ethernet dengan nama interface `enp1s0` dan wireless interface dengan nama `wlp3s0`.

Berarti saya punya dua pilihan untuk terhubung ke internet.

Namun, pada catatan kali ini, saya baru sempat menuliskan untuk Wireless interface saja.

### 1.1.1 Menggunakan Built-in Wi-Fi Adapter

Meskipun instalasi Arch Linux ini berupa _command line_, namun kita tetap dapat menggunakan _wifi adapter_ untuk terhubung dengan jaringan. \(apabila _wifi adapter_ kalian terdeteksi\). Lakukan pengecekan dengan perintah di bawah.

<br>
<s>
{% shell_root %}
<del>wifi-menu</del>
{% endshell_root %}
</s>

~~Apabila keluar menu interaktif berupa daftar SSID yang tersedia, maka pilih SSID milik kalian dan masukkan _password_ dari SSID. Apabila hanya keluar pesan berupa `--help`, menandakan _wifi adapter_ kalian belum terdeteksi oleh _kernel driver_ Arch _Installer_.~~

#### iwctl shell

2020 ini, Arch merubah tools untuk terhubung ke jaringan Wi-Fi yang sebelumnya menggunakan **wifi-menu**, sekarang sudah diganti dengan menggunakan **iwd** -- **iwd** adalah replacement untuk **wpa_supplicant**.

Pada menu startup archiso pertama kali, teman-teman akan disuguhkan tampilan sepertin ini.

<pre>
Arch Linux 5.9.11-arch2-1 (tty1)

archiso login: root (automatic lgin)

To install Arch Linux follow the installation guide:
https://wiki.archlinux.org/index.php/Installation_guide

For Wi-Fi, authenticate to the wireless network using the iwctl utility.
Ethernet and Wi-Fi connections using DHCP should work automatically.

After connecting to the internet, the installation guide can be accessed
via the convenience script Installation_guide.

root@archiso ~ # _
</pre>

Teman-teman dapat melihat, terdapat informasi yang memberikan kita petunjuk untuk authenticate Wi-Fi, kita diminta untuk menggunakan `iwctl` -- **iwctl** adalah interface dari **iwd**.

{% shell_root %}
iwctl
{% endshell_root %}

Kita akan dibawa masuk ke dalam iwd shell yang berpenampilan seperti di bawah ini.

<pre>
<span class="cmd">[iwd]# </span><b>_</b>
</pre>

Artinya kita sudah berada di dalam iwd shell.

#### iwctl help

Jangan panik dan mundur, karena tidak ada petunjuk apa-apa, kamu dapat memasukkan perintah `help` untk mendapatkan petuah yang berguna.

<pre>
<span class="cmd">[iwd]# </span><b>help</b>
</pre>

<pre>
                               iwctl version 1.10
--------------------------------------------------------------------------------
  Usage
--------------------------------------------------------------------------------
  iwctl [--options] [commands]

                               Available options
--------------------------------------------------------------------------------
  Options                                           Description
--------------------------------------------------------------------------------
  --username                                        Provide username
  --password                                        Provide password
  --passphrase                                      Provide passphrase
  --dont-ask                                        Don't ask for missing
                                                    credentials
  --help                                            Display help

                               Available commands
--------------------------------------------------------------------------------
  Commands                                          Description
--------------------------------------------------------------------------------

Adapters:
  adapter list                                      List adapters
  adapter &lt;phy> show                                Show adapter info
  adapter &lt;phy> set-property &lt;name> &lt;value>         Set property

Ad-Hoc:
  ad-hoc list                                       List devices in Ad-hoc mode
  ad-hoc &lt;wlan> start &lt;"network name"> &lt;passphrase> Start or join an existing
                                                    Ad-Hoc network called
                                                    "network name" with a
                                                    passphrase
  ad-hoc &lt;wlan> start_open &lt;"network name">         Start or join an existing
                                                    open Ad-Hoc network called
                                                    "network name"
  ad-hoc &lt;wlan> stop                                Leave an Ad-Hoc network

Access Point:
  ap list                                           List devices in AP mode
  ap &lt;wlan> start &lt;"network name"> &lt;passphrase>     Start an access point
                                                    called "network name" with
                                                    a passphrase
  ap &lt;wlan> stop                                    Stop a started access
                                                    point

Devices:
  device list                                       List devices
  device &lt;wlan> show                                Show device info
  device &lt;wlan> set-property &lt;name> &lt;value>         Set property

Known Networks:
  known-networks list                               List known networks
  known-networks &lt;"network name"> forget            Forget known network
  known-networks &lt;"network name"> show              Show known network
  known-networks &lt;"network name"> set-property &lt;name> &lt;value>Set property

WiFi Simple Configuration:
  wsc list                                          List WSC-capable devices
  wsc &lt;wlan> push-button                            PushButton mode
  wsc &lt;wlan> start-user-pin &lt;8 digit PIN>           PIN mode
  wsc &lt;wlan> start-pin                              PIN mode with generated
                                                    8 digit PIN
  wsc &lt;wlan> cancel                                 Aborts WSC operations

Station:
  station list                                      List devices in Station mode
  station &lt;wlan> connect &lt;"network name"> [security]Connect to network
  station &lt;wlan> connect-hidden &lt;"network name">    Connect to hidden network
  station &lt;wlan> disconnect                         Disconnect
  station &lt;wlan> get-networks [rssi-dbms/rssi-bars] Get networks
  station &lt;wlan> get-hidden-access-points [rssi-dbms]Get hidden APs
  station &lt;wlan> scan                               Scan for networks
  station &lt;wlan> show                               Show station info


Miscellaneous:
  version                                           Display version
  quit                                              Quit program
</pre>

#### iwctl device list

Kita perlu mengetahui nama interface yang tersedia di sistem kita. Dengan kata lain adalah wireless interface yang tersedia.

<pre>
<span class="cmd">[iwd]# </span><b>device list</b>
</pre>

<pre>
                                    Devices
--------------------------------------------------------------------------------
  Name                Address             Powered   Adapter   Mode
--------------------------------------------------------------------------------
  wlan0               08:11:96:00:00:00   on        phy0      station
</pre>

**wlan0**, adalah name wireless interface yang tersedia di sistem saya. Kita juga dapat informasi berupa address, powered status, adapter name, dan mode.

Namun, yang akan kita ingat menjadi perhatian adalah nama dari interface, yaitu **wlan0**. Karena akan banyak kita gunakan di dalam command-command selanjutnya.

Teman-teman juga dapat melihat keterangan tentang wireless interface tersebut lebih detail dengan menggunakan perintah,

<pre>
<span class="cmd">[iwd]# </span><b>device wlan0 show</b>
</pre>

<pre>
                                 Device: wlan0                                *
--------------------------------------------------------------------------------
  Settable  Property            Value
--------------------------------------------------------------------------------
            Name                wlan0
         *  Mode                station
         *  Powered             on
            Address             08:11:96:00:00:00
            Adapter             phy0
</pre>

#### iwctl station scan

Sekarang, kita masuk ke blok **Station**.

Kita perlu terlebih dahulu melakukan scanning untuk mencari SSID yang tersedia.

<pre>
<span class="cmd">[iwd]# </span><b>station wlan0 scan</b>
</pre>

Jangan bingung, karena memang tidak akan keluar apa-apa.

Namun, kalau teman-teman menjalankan option `show`, terlebih dahulu sebelum `scan`.

<pre>
<span class="cmd">[iwd]# </span><b>station wlan0 show</b>
</pre>

<pre>
                                 Station: wlan0
--------------------------------------------------------------------------------
  Settable  Property            Value
--------------------------------------------------------------------------------
            Scanning            no
            State               disconnected
</pre>

Saat, menjalankan `scan`, value dari Scanning yang berisi **no** akan teganti menjadi **yes**.

Lalu setelah proses scanning selesai, akan berubah kembali menjadi **no**.

Untuk melihat hasil scan, kita gunakan option **get-networks**.


#### iwctl station get-networks

Setelah kita melakukan scanning, saatnya melihat hasilnya dengan menggunakan perintah,

<pre>
<span class="cmd">[iwd]# </span><b>station wlan0 get-networks</b>
</pre>

<pre>
                               Available networks                             *
--------------------------------------------------------------------------------
    Network name                    Security  Signal
--------------------------------------------------------------------------------
    bandithijo                      psk       ***
    KIKEL                           psk       ****
    Yumi2268                        psk       *
    SIHOMBING                       psk       *
    MDR001                          psk       *
    Hertop                          psk       *
    SURYA                           psk       *
    SALSHA                          psk       *

</pre>

Temukan **Network name** atau SSID yang teman-teman miliki.

Kalau sudah, kita akan gunakan option **connect** untuk terhubung.

#### iwctl station connect

<pre>
<span class="cmd">[iwd]# </span><b>station wlan0 connect bandithijo</b>
</pre>

Kemudian, kalian akan diminta untuk memasukkan passphrase.

<pre>
station wlan0 connect bandithijo
Type the network passphrase for bandithijo psk.
Passphrase: **************
</pre>

Masukkan password dari SSID. Password akan disensor dengan tanda bintang *.

Untuk melihat apakah kita sudah terkoneksi atau belum, gunakna option **show**.

<pre>
<span class="cmd">[iwd]# </span><b>station wlan0 show</b>
</pre>

<pre>
                                 Station: wlan0
--------------------------------------------------------------------------------
  Settable  Property            Value
--------------------------------------------------------------------------------
            Scanning            no
            State               connected
            Connected network   bandithijo

</pre>

Kalau **State** nya sudah bernilai **connected**, artinya kita sudah berhasil terhubung dengan network.

Untuk keluar dari iwctl, bisa ketik `exit`.

<pre>
<span class="cmd">[iwd]# </span><b>exit</b>
</pre>

Lakukan pengujian.

Lihat network interface list, apakah wireless interface yang kita gunakan sudah mendapatkan IP address atau belum.

{% shell_root %}
ip a s wlan0
{% endshell_root %}

<pre>
3: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 08:11:96:00:00:00 brd ff:ff:ff:ff:ff:ff
    inet <mark>192.168.1.7/24</mark> brd 192.168.1.255 scope global dynamic noprefixroute wlan0
       valid_lft 86050sec preferred_lft 75250sec
    inet6 fe80::9373:975b:0000:0000/64 scope link
       valid_lft forever preferred_lft forever
</pre>

Nah, dapat dilihat, saya sudah mendapatkan IP address.

Sekarang coba tes koneksi internet dengan ping.

{% shell_root %}
ping -c 3 archlinux.org
{% endshell_root %}

<pre>
PING archlinux.org (95.217.163.246) 56(84) bytes of data.
64 bytes from archlinux.org (95.217.163.246): icmp_seq=1 ttl=52 time=226 ms
64 bytes from archlinux.org (95.217.163.246): icmp_seq=2 ttl=52 time=215 ms
64 bytes from archlinux.org (95.217.163.246): icmp_seq=3 ttl=52 time=246 ms

--- archlinux.org ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2000ms
rtt min/avg/max/mdev = 215.292/228.954/245.752/12.631 ms
</pre>

Mantap! Kita telah berhasil terhubung ke internet.












<br>
### 1.1.2 Menggunakan USB Tethering

Cara lainnya, kita masih dapat menggunakan koneksi dari kabel LAN ataupun dengan menggunakan _USB tethering smarpthone_.

Untuk penggunaan _USB tethering smartphone_, hubungkan _smartphone_ dengan laptop menggunakan kabel _USB_, lakukan pengecekan apakah sudah terhubung atau belum.

{% shell_root %}
lsusb
{% endshell_root %}

Apabila sudah terlihat nama dari *device smartphone* kita, lakukan perintah di bawah untuk mengaktifkan DHCP *daemon service*.

{% shell_root %}
dhcpcd
{% endshell_root %}

Setelah itu akan muncul pemberitahuan seperti di bawah.

```
dev: loaded udev
no interfaces have a carrier
forked to background, child pid 342
```

Lakukan pengetesan apakah kita telah terhubung ke Internet,

{% shell_root %}
ping -c 3 google.com
{% endshell_root %}

Dalam langkah ini, kalian mungkin perlu menunggu beberapa saat hingga `ping` dapat berhasil, mungkin sekitar 1 - 2 menit.
Apabila telah berhasil, kalian dapat bergerak ke _step_ selanjutnya.

Apabila masih belum dapat terhubung dengan Internet, maka proses instalasi akan terkendala pada saat akan men-*download* paket-paket dari _mirror server_.

## 1.2 Memilih Mirrorlist

Karena _base package_ yang diperlukan untuk menjadikan sistem operasi seutuhnya harus kita unduh dari _server_ repositori, maka kita perlu memilih daftar _mirror server_. Tujuannya untuk mempercepat proses pengunduhan paket-paket aplikasi dari _server_ repositori.

{% box_pertanyaan %}
<p><b>Mengapa tidak menggunakan <i>mirror-mirror</i> lokal Indonesia?</b></p>
<p>Karena belum tentu apabila kita memilih server repositori di Indonesia sudah pasti akan mendapatkan kecepatan yang maksimal. Maka biarkan program yang memilihkan untuk kita.</p>
{% endbox_pertanyaan %}

Buat _backup_ `mirrorlist` terlebih dahulu.

{% shell_root %}
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
{% endshell_root %}

~~Kemudian kita akan menggunakan `rankmirrors` untuk memilih alamat _mirror_ mana yang paling cepat.~~

<pre>
<s># rankmirrors -n 5 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist</s>
</pre>

~~Proses ini akan memakan waktu sebentar. Karena `rankmirrors` akan melakukan filter pada ratusan alamat _mirror server_ yang ada pada daftar _file_ `mirrorlist`.~~

{% box_perhatian %}
<p>Penggunaan <code>rankmirrors</code> sudah <b>tidak direkomendasikan</b> lagi oleh Arch Wiki.</p>
<p>Saat ini, sudah menggunakan <code>reflector</code>.</p>
{% shell_root %}
pacman -Syy
pacman -S reflector
{% endshell_root %}
<p>*reflector sudah tersedia di ArchISO, kita tidak perlu repot memasangnya lagi.</p>
{% shell_root %}
reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
{% endshell_root %}
{% endbox_perhatian %}

Setelah selesai, maka daftar _server_ repositori yang tadinya ada banyak sekali, hanya akan terseleksi dan tersisa menjadi 5 _server_ paling cepat saja. Kalian dapat melihatnya dengan mengetikkan `$ cat /etc/pacman.d/mirrorlist`.

Setelah itu, kita perlu memperbaharui metadata repository kita untuk dapat sinkron dengan repositori yang baru saja kita rubah.
{% shell_root %}
pacman -Syy
{% endshell_root %}
Tunggu proses sinkorinasi metadata hingga selesai. Setelah itu kita bisa bergerak ke-*step* selanjutnya.



<!-- NEXT PREV BUTTON -->
{% assign btn-next = "/arch/step-0-introduction" %}
{% assign btn-menu = "/arch/" %}
{% assign btn-prev = "/arch/step-2-disk-partitioning" %}
<div class="post-nav">
<a class="btn-blue-l" href="{{ btn-next }}"><img class="btn-img" src="/assets/img/logo/logo_ap.png"></a>
<a class="btn-blue-c" href="{{ btn-menu }}"><img class="btn-img" src="/assets/img/logo/logo_menu.svg"></a>
<a class="btn-blue-r" href="{{ btn-prev }}"><img class="btn-img" src="/assets/img/logo/logo_an.png"></a>
</div>
