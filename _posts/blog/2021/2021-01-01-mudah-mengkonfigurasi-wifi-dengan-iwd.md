---
layout: 'post'
title: "Mudah Mengkonfigurasi Wi-Fi dengan iwd (iwctl)"
date: 2021-01-01 00:00
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips']
pin:
hot:
contributors: []
resume:
---

# Latar Belakang

Setelah pada catatan sebelumnya, saya menulis tentang [**Mudah Mengkonfigurasi Wi-Fi dengan wpa_supplicant**](/blog/mudah-mengkonfigurasi-wifi-dengan-wpa_supplicant){:target="_blank"}.

Catatan kali ini, saya akan menulis calon penerus dari **wpa_supplicant**, yaitu **iwd**.

# Sekilas Tentang iwd

**iwd** adalah kependekan dari **iNet wireless daemon**, adalah wireless daemon tool untuk Linux yang dikembangkan oleh Intel.

Tujuan inti dari proyek ini adalah untuk mengoptimalkan pemanfaatan sumber daya agar tidak tergantung dengan banyak external library dan **hanya memanfaatkan fitur yang disediakan oleh Kernel Linux semaksimal mungkin**.

Seperti halnya **wpa_supplicant**, **iwd** pun dapat digunakan secara standalone maupun dikombinasikan dengan comprehensive network manager seperti **ConnMan**, **NetworkManager**, dan **systemd-networkd**.

# Instalasi

Pasang **iwd** sangat mudah di Arch Linux.

{% shell_user %}
sudo pacman -S iwd
{% endshell_user %}

Untuk Artix Linux,

{% shell_user %}
sudo pacman -S iwd iwd-openrc
{% endshell_user %}

Pada iwd package ini kita juga akan mendapatkan:

1. `iwctl`, shell interface
2. `iwd`, daemon
3. `iwmon`, Wi-Fi monitoring tool

# Cara Penggunaan

Cara penggunaan yang akan saya catat adalah cara yang saya pergunakan. Pasti akan banyak sekali cara dalam menggunakan iwd. Jadi jangan kaku. Kita harus fleksibel agar tidak patah. 😄

## iwctl Shell

{% box_info %}
<p markdown=1>2020 ini, Arch merubah tools untuk terhubung ke jaringan Wi-Fi yang sebelumnya menggunakan **wifi-menu**, sekarang sudah diganti dengan menggunakan **iwd** -- **iwd** adalah replacement untuk **wpa_supplicant**.</p>
<p markdown=1>Pada menu startup archiso pertama kali, teman-teman akan disuguhkan tampilan sepertin ini.</p>

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

<p markdown=1>Teman-teman dapat melihat, terdapat informasi yang memberikan kita petunjuk untuk authenticate Wi-Fi, kita diminta untuk menggunakan `iwctl` -- **iwctl** adalah interface dari **iwd**.</p>
{% endbox_info %}

{% shell_user %}
iwctl
{% endshell_user %}

Kita akan dibawa masuk ke dalam iwd shell yang berpenampilan seperti di bawah ini.

<pre>
<span class="cmd">[iwd]# </span><b>_</b>
</pre>

Artinya kita sudah berada di dalam iwd shell.

## iwctl Help

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

## iwctl Device List

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

## iwctl Station Scan

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


## iwctl Station Get Networks

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

## iwctl Station Connect

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

{% shell_user %}
ip a s wlan0
{% endshell_user %}

<pre>
3: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 08:11:96:00:00:00 brd ff:ff:ff:ff:ff:ff
    inet <mark>192.168.1.7/24</mark> brd 192.168.1.255 scope global dynamic noprefixroute wlan0
       valid_lft 86050sec preferred_lft 75250sec
    inet6 fe80::9373:975b:0000:0000/64 scope link
       valid_lft forever preferred_lft forever
</pre>

Nah, dapat dilihat, saya sudah mendapatkan IP address.

{% box_info %}
<p markdown=1>Saya menggunakan **dhcpcd** service.</p>
{% endbox_info %}

Sekarang coba tes koneksi internet dengan ping.

{% shell_user %}
ping archlinux.org
{% endshell_user %}

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

## iwctl Station Disconnect

<pre>
<span class="cmd">[iwd]# </span><b>station wlan0 disconnect</b>
</pre>


# Lokasi File Config

## General (Main) File Config

Berlokasi di **/etc/iwd/main.conf**.

Kalau tidak ada teman-teman bisa buat sendiri --saya juga buat sendiri.

Apabila kita mendefinisikan option di dalam file config ini, terntu akan berdampak general.

Misal,

### Enable Built-in DHCP

Saya ingin semua file konfigurasi network SSID yang tersimpan, menggunakan *buil-it* DHCP client bawaan dari iwd.

Saya tidak perlu, mengeset satu-persatu di setiap file config network yang tersimpan di `/var/lib/iwd/<nama_network>.psk`. Tapi cukup pada file main.conf saja.

{% highlight_caption /etc/iwd/main.conf %}
{% highlight sh linenos %}
[General]
EnableNetworkConfiguration=true
{% endhighlight %}

## File Config Network Spesifik

Berbeda dengan **wpa_supplicant** yang menyimpan file configurasi pada direktori **/etc/wpa_supplicant/**, sehingga dapat diakses oleh semua user. **iwd** menyimpan file configurasi atau *stored data file* pada direktori **/var/lib/iwd/**. Sehingga hanya root yang dapat mengakses direktori ini.

<pre>
<mark>/var/lib/iwd/</mark>
├── bandithijo.psk
├── OF-LT2.psk
└── hotspot

1 directory, 1 file
</pre>

Isi dari file `.psk` (presharedkey) tersebut adalah credential dari SSID yang merupakan nama file.

{% highlight_caption /var/lib/iwd/bandithijo.psk %}
{% highlight sh %}
[Security]
PreSharedKey=de91478f405cc6685267c972844591e1adfde34e5e74c525c44b0b5e3e16a968
Passphrase=iniadalahpassword
{% endhighlight %}

## Konfigurasi Auto Connect ke Network Tertentu

Tambahkan saja option `AutoConnect=true` pada group `[Settings]`, di dalam file config dari network yang kita inginkan.

Misal,

{% highlight_caption /var/lib/iwd/bandithijo.psk %}
{% highlight sh linenos %}
[Security]
PreSharedKey=de91478f405cc6685267c972844591e1adfde34e5e74c525c44b0b5e3e16a968
Passphrase=iniadalahpassword

[Settings]
AutoConnect=true
{% endhighlight %}

Atau, kalau ingin lebih general, tambahkan pada file **/etc/iwd/main.conf**.


# Konfigurasi Lanjut

Untuk konfigurasi lebih lanjut, atau cara-cara lain dalam mengkonfigurasi iwd, teman-teman dapat melihat pada Arch Wiki.

[**Arch Wiki: iwd**](https://wiki.archlinux.org/index.php/Iwd){:target="_blank"}.



# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)

# Terima Kasih

1. Herman Thaw
2. Suka Isnaini


# Referensi

1. [wiki.archlinux.org/index.php/Iwd](https://wiki.archlinux.org/index.php/Iwd){:target="_blank"}
<br>Diakses tanggal: 2021/01/01

2. [iwd.wiki.kernel.org/gettingstarted](https://iwd.wiki.kernel.org/gettingstarted){:target="_blank"}
<br>Diakses tanggal: 2021/01/01

3. [jlk.fjfi.cvut.cz/arch/manpages/man/iwd.config.5](https://jlk.fjfi.cvut.cz/arch/manpages/man/iwd.config.5){:target="_blank"}
<br>Diakses tanggal: 2021/01/01
