---
layout: 'post'
title: "Mudah Mengkonfigurasi Wi-Fi dengan wpa_supplicant"
date: 2020-12-31 07:31
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
---

# Latar Belakang Masalah

Saya baru menyadari kalau saya ternyata lebih sering menggunakan koneksi wireless ketimbang menggunakan kabel.

Artinya, NetworkManager yang saya pergunakan sebagai network manager yang memiliki banyak sekali fitur yang dapat memudahkan kita untuk mengkonfigurasi segala sesuatu tentang jaringan, hanya saya pergunakan salah satu sari sekian banyak fiturnya.

Hal ini mulai terasa kurang efisien buat saya.

Terlebih lagi, NetworkManager ini mungkin sebenarnya hanya layer tambahan yang digunakan untuk memudahkan dalam mengkonfigurasi wireless networking yang menggunakan **wpa_supplicant**.

Lantas, karena saya lebih banyak menggunakan wireless network ketimbang ethernet, maka saya memutuskan untuk hanya menggunkan **wpa_supplicant** dalam menghandle konektifitas dengan Wi-Fi.

Saya terinspirasi ketika berpindah dari Arch Linux ke Artix Linux.

Dan membaca Arch Wiki, pada bagian yang ini [**Network configuration/Wireless > Options**](https://wiki.archlinux.org/index.php/Network_configuration/Wireless#Utilities){:target="_blank"}.

Pada Arch Wiki disebutkan,

> Just like other network interfaces, the wireless ones are controlled with ip from the [iproute2](https://archlinux.org/packages/?name=iproute2){:target="_blank"} package.
>
> Managing a wireless connection requires a basic set of tools.
>
> **Either use a [network manager](https://wiki.archlinux.org/index.php/Network_configuration#Network_managers){:target="_blank"} or use one of the following directly**.

| Software | Package | WEXT | nl80211 | WEP | WPA/WPA2 | ArchISO |
| :--: | :--: | :--: | :--: | :--: | :--: | :--: |
| wireless_tools | wireless_tools | Yes | No | Yes | No | Yes |
| iw | iw | No | Yes | Yes | No | Yes |
| Wpa Supplicant | wpa_supplicant | Yes | Yes | Yes | Yes | Yes |
| iwd | iwd | No | Yes | No | Yes | Yes |

\***wireless_tools** sudah deprecated.



# Apa itu wap_supplicant

Secara sederhana wpa_supplicant adalah tools yang dapat kita pergunakan untuk meminta/me-request otentikasi ke jaringan. Awalan **wpa_** menandakan bahwa tools ini mendukung WPA. Tidak hanya WPA, tapi juga WEP dan WPA2.

**WPA2 itu apa, bang?**

Adalah kependekan dari **Wi-Fi Protected Access II**, adalah standar yang digunakan untuk menetapkan keamanan untuk jaringan wireless. WPA2 ini hadir untuk menggantikan WEP yang sudah deprecated (usang).

wpa_supplicant sangat cocok digunakan untuk desktop, laptop, maupun embedded system.

Yok, tanpa berlama-lama, langsung saja kita pasang.



# Instalasi

Pasang dulu paket **wpa_supplicant**.

<pre>
$ <b>sudo pacman -S wpa_supplicant</b>
</pre>

Kalau kita memasang paket ini, kita akan mendapatkan:

1. `wpa_supplicant` (main program)
2. `wpa_passphrase` (passphrase tool)
3. `wpa_cli` (front-end cli)

Kita juga dapat memasang package [**wpa_supplicant_gui**](https://aur.archlinux.org/packages/wpa_supplicant_gui/){:target="_blank"} `wpa_gui`, untuk yang lebih senang berinteraksi dengan aplikasi GUI.

# Konfigurasi

## Kenali Wireless Interface yang Digunakan
Pertama-tama, periksa dulu nama wireless interface yang teman-teman gunakan.

<pre>
$ <b>ip a s</b>
</pre>

<pre>
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN group default qlen 1000
    link/ether 00:16:d3:c4:fb:d2 brd ff:ff:ff:ff:ff:ff
3: <mark>wlan0</mark>: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default
qlen 1000
    link/ether 08:11:96:00:00:00 brd ff:ff:ff:ff:ff:ff
</pre>

Punya saya bernama `wlan0`.

<!-- INFORMATION -->
<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p markdown=1>Kalau teman-teman ingin menggunakan **Traditional Network Interface Name** seperti `wlan0`, kalian dapat mengunjungi catatan saya [**Mengembalikan Nama Interface Menjadi Traditional Interface Name (eth0, wlan0, etc.)**](/blog/mengembalikan-nama-interface-ke-raditional-interface-name){:target="_blank"}.</p>
<p markdown=1>Tapi, **saya tidak merekomendasikan** yaa.</p>
</div>

Selanjutnya, untuk terhubung dengan network yang ada, kita dapat menggunakan 2 cara.

1. Menggunakan `wpa_cli`
2. Menggunakan `wpa_passphrase`

## 1. Menggunakan wpa_cli

Terlebih dahulu kita harus menambahkan sedikit konfigurasi agar dapat menyimpan config dari wpa_cli.

<pre>
$ <b>sudoedit /etc/wpa_supplicant/wpa_supplicant.conf</b>
</pre>

{% highlight conf linenos %}
ctrl_interface=/run/wpa_supplicant
update_config=1
{% endhighlight %}

Kalau sudah ada, tidak perlu diubah-ubah.

Nah, sebelum menjalankan wpa_supplicant service dengan systemd, kita bisa coba menjalankan tanpa membuat service.

<pre>
$ <b>sudo wpa_supplicant -B -i <i>nama_interface</i> -c /etc/wpa_supplicant/wpa_supplicant.conf</b>
</pre>

`-B`, untuk *run daemon in the background*.

`-i`, untuk mendefinisikan nama interface.

`-c`, untuk mendefinisikan lokasi dari wpa_supplicant.conf.

Ganti *nama_interface* dengan yang teman-teman pergunakan.

Selanjutnya, kita akan gunakan **wpa_cli**.

<pre>
$ <b>sudo wpa_cli</b>
</pre>

<pre>
wpa_cli v2.9
Copyright (c) 2004-2019, Jouni Malinen <j@w1.fi> and contributors

This software may be distributed under the terms of the BSD license.
See README for more details.

Selected interface 'wlan0'

Interactive mode

> _
</pre>

Di dalam shell ini, kita dapat memanfaatkan auto completion untuk perintah-perintah yang tersedia menggunakan tombol <kbd>Tab</kbd>.

### Bantuan

Seperti biasa, untuk melihat ketersediaan command yang ada, kita dapat menggunakan.

<pre>
> <b>help</b>
</pre>

### Scanning

Untuk melakukan pencarian nama network yang ada di sekitar kita.

<pre>
> <b>scan</b>
OK
<3>CTRL-EVENT-SCAN-STARTED
<3>CTRL-EVENT-SCAN-RESULTS
<3>WPS-AP-AVAILABLE
</pre>

### Melihat Hasil Scan

Untuk melihat hasil yang telah di-scan.

<pre>
> <b>scan_results</b>
bssid / frequency / signal level / flags / ssid
00:67:62:78:91:40       2462    -49     [WPA-PSK-CCMP][WPA2-PSK-CCMP][ESS]                      KIKEL
60:18:88:00:00:00       2432    -61     [WPA-PSK-CCMP][WPA2-PSK-CCMP][WPS][ESS]                 bandithijo
fc:a6:cd:be:d8:b0       2462    -88     [WPA-PSK-CCMP][WPA2-PSK-CCMP][ESS]                      SALSHA
e8:01:8d:ae:fb:00       2437    -86     [WPA-PSK-CCMP][WPA2-PSK-CCMP][ESS]                      SIHOMBING
88:c3:97:6d:44:37       2462    -89     [WPA-PSK-CCMP+TKIP][WPA2-PSK-CCMP+TKIP][WPS][ESS]       SURYA
</pre>

### Mendaftarkan Network

Saya ingin mendaftarkan network baru degan SSID bernama **bandithijo**.

Namun, kita perlu mengambil nomor index --ibarat nomor antrian.

<pre>
> <b>add_network</b>
0
</pre>

Nah, berarti saya akan menggunakan index ke-**0** untuk mendaftarkan network ini.

Selanjutnya, kita akan mengeset credential untuk network tersebut.

<pre>
> <b>set_network 0 ssid "bandithijo"</b>
OK
> <b>set_network 0 psk "passwordinirahasiasekali"</b>
OK
</pre>

<!-- INFORMATION -->
<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>Kalau SSID nya tanpa password, kalian dapat menggantinya dengan:</p>

<pre>
> <b>set_network 0 ssid "bandithijo"</b>
> <b>set_network 0 key_mgmt NONE</b>
</pre>

</div>


<!-- INFORMATION -->
<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>Kalau terjadi kesalahan input, tinggal jalankan perintah yang sama dengan nilai yang benar.</p>
</div>


### Melihat Daftar Network yang Tersimpan

Untuk melihat daftar network yang pernah didaftarkan, gunakan perintah:

<pre>
> <b>list_networks</b>
network id / ssid / bssid / flags
0       bandithijo      any     [TEMP-DISABLED]
</pre>


### Untuk Terhubung dengan Network

Dapat dilihat, pada network index ke-0, saya telah berhasil menyimpan konfigurasi untuk network **bandithijo**.

Untuk terkoneksi dengan network tersebut, kita gunakan perintah:

<pre>
> <b>select_network 0</b>
OK
</pre>

atau

<pre>
> <b>enable_network 0</b>
OK
</pre>

Kalau berhasil, outputnya akan seperti ini.

<pre>
<3>CTRL-EVENT-SSID-REENABLED id=0 ssid="bandithijo"
<3>CTRL-EVENT-SCAN-STARTED
<3>CTRL-EVENT-SCAN-RESULTS
<3>WPS-AP-AVAILABLE
<3>SME: Trying to authenticate with 60:18:88:00:00:00 (SSID='bandithijo' freq=2432 MHz)
<3>Trying to associate with 60:18:88:00:00:00 (SSID='bandithijo' freq=2432 MHz)
<3>Associated with 60:18:88:00:00:00
<3>CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
<3>WPA: Key negotiation completed with 60:18:88:00:00:00 [PTK=CCMP GTK=CCMP]
<3>CTRL-EVENT-CONNECTED - Connection to 60:18:88:00:00:00 completed [id=0 id_str=]
<3>CTRL-EVENT-REGDOM-CHANGE init=CORE type=WORLD
</pre>

Mantap, coba test <code>$ <b>ip a s</b></code>, untuk melihat apakah wireless interface yang kita gunakan telah mendapatkan IP address atau belum. Seharusnya pada tahap ini, sudah mendapatkan IP address.

Kalau sudah, laukan test koneksi dengan `ping`.


### Simpan Hasil Konfigurasi

Sebelum keluar, jangan lupa untuk menyimpan hasil konfigurasi.

<pre>
> <b>save_config</b>
OK
</pre>


### Keluar dari wpa_cli

Untuk keluar, kita dapat menggunakan perintah.

<pre>
> <b>quit</b>
</pre>


### Disconnect

Untuk disconnect dari jaringan, masuk lagi ke **wpa_cli**, dan jalankan printah:

<pre>
> <b>disconnect</b>
OK
<3>CTRL-EVENT-DISCONNECTED bssid=60:18:88:00:00:00 reason=3 locally_generated=1
<3>CTRL-EVENT-REGDOM-CHANGE init=CORE type=WORLD
</pre>


## 2. Menggunakan wpa_passphrase

Metode ini dapat kita gunakan untuk terkoneksi secara cepat ke SSID apabila kita sudah tahu nama SSID dan passwordnya.

Sebenarnya `wpa_passphrase` ini digunakan untuk mengenerate konfigurasi minimal yang dapat kita gunakan ke konfigurasi wpa_supplicant.

<pre>
$ <b>wpa_passphrase bandithijo iniadalahpassword</b>
</pre>

<pre>
network={
        ssid="bandithijo"
        #psk="iniadalahpassword"
        psk=de91478f405cc6685267c972844591e1adfde34e5e74c525c44b0b5e3e16a968
}
</pre>

Kita bisa copy dan masukkan ke dalam **/etc/wpa_supplicant/wpa_supplicant.conf** untuk konfigurasi yang lebih persistent.

Atau dengan cara mengkombinasikan dengan perintah wpa_supplicant.

<!-- PERHATIAN -->
<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
<p markdown=1>Namun, pastikan **wpa_supplicant belum berjalan** di process maupun di service.</p>
</div>

<pre class="url">
$ <b>sudo wpa_supplicant -B -i <mark>interface</mark> -c <(wpa_passphrase <mark>MYSSID</mark> <mark>passphrase</mark>)</b>
</pre>

<pre>
$ <b>sudo wpa_supplicant -B -i wlan0 -c <(wpa_passphrase bandithijo iniadalahpassword)</b>
</pre>

<!-- PERHATIAN -->
<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
<p markdown=1>Namun, karena proses substitusi, kita tidak dapat menjalankan proses ini dengan **sudo**.</p>

<pre>
Successfully initialized wpa_supplicant
Failed to open config file '/dev/fd/63', error: No such file or directory
Failed to read or parse configuration '/dev/fd/63'
</pre>

<p markdown=1>Kita perlu menggunakan **root shell**</p>

<pre>
$ <b>sudo su</b>
</pre>

<pre>
# <b>wpa_supplicant -B -i wlan0 -c <(wpa_passphrase bandithijo iniadalahpassword)</b>
</pre>

<pre>
Successfully initialized wpa_supplicant
</pre>
</div>

Nah, mantap!

Sekarang seharusnya wireless interface sudah mendapatkan IP address.

<pre>
$ <b>ip a s wlan0</b>
</pre>

<pre>
3: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 08:11:96:00:00:00 brd ff:ff:ff:ff:ff:ff
    inet <mark>192.168.1.7</mark>/24 brd 192.168.1.255 scope global dynamic noprefixroute wlan0
       valid_lft 86006sec preferred_lft 75206sec
    inet6 fe80::9373:975b:0000:0000/64 scope link
       valid_lft forever preferred_lft forever
</pre>

Nah, dapat dilihat, saya sudah mendapatkan IP address.

Sekarang coba tes koneksi internet dengan ping.

<pre>
$ <b>ping archlinux.org</b>
</pre>

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


# Penggunaan yang Lebih Advanced

Untuk konfigurasi dan penggunaan yang lebih advanced, teman-teman dapat membaca sendiri di Arch Wiki.

[**wpa_supplicant: Advanced usage**](https://wiki.archlinux.org/index.php/Wpa_supplicant#Advanced_usage){:target="_blank"}.


# Bagaimana Saya Menggunakan wpa_supplicant?

Kalau saya, karena tidak banyak berpindah2 tempat, saya memilih menggunakan service untuk menjalankan **wpa_supplicant**.

Saat ini saya sudah menggunakan **OpenRC**. Secara default, service akan membaca file `/etc/wpa_supplicant/wpa_supplicant.conf`.

Namun, saya ingin lebih fleksible, saya buat file **wpa_supplicant.conf** ini menjadi symbolic link dari beberapa file configurasi yang tergantung dari tempat.

1. Rumah
2. Kantor

Misal seperti ini

<pre>
$ tree /etc/wpa_supplicant
.
├── wpa_cli.sh
├── <span style="color:red;">wpa_supplicant.conf</span> -> wpa_supplicant-home.conf
├── <mark>wpa_supplicant-home.conf</mark>
└── <mark>wpa_supplicant-office.conf</mark>
</pre>

Dapat dilihat, saat ini saya sedang menggunakan Wi-Fi di rumah, maka saya menghubungkan symbolic link konfigurasi `-home.conf` dengan `wpa_supplicant.conf`.

Isi dari file **wpa_supplicant-home.conf** maupun **wpa_supplicant-office.conf**, kira-kira seperti ini:

{% highlight_caption /etc/wpa_supplicant/wpa_supplicant-home.conf %}
{% highlight conf linenos %}
ctrl_interface=/run/wpa_supplicant
update_config=1

network={
  ssid="bandithijo"
  #psk="iniadalahpassword"
  psk=de91478f405cc6685267c972844591e1adfde34e5e74c525c44b0b5e3e16a968
}
{% endhighlight %}

Hanya berbeda di SSD dan passphrase.

<br>
Untuk berganti-ganti symbolic link, saya mengunakan cara seperti ini:

**Home**

<pre>
$ <b>sudo ln -sf /etc/wpa_supplicant/wpa_supplicant-home.conf /etc/wpa_supplicant/wpa_supplicant.conf</b>
</pre>

**Office**

<pre>
$ <b>sudo ln -sf /etc/wpa_supplicant/wpa_supplicant-office.conf /etc/wpa_supplicant/wpa_supplicant.conf</b>
</pre>

<br>
Setelah file konfigurasi siap, tinggal jalankan service dari **wpa_supplicant**.

Misal, pada **OpenRC**.

Tambahkan ke dalam service default yang akan dijalankan ketika sistem startup.

\*Tidak perlu menggunakan **default** juga bisa, karena sudah default.

<pre>
$ <b>sudo rc-update add wpa_supplicant default</b>
</pre>

<pre>
* service wpa_supplicant added to runlevel default
</pre>

Lihat, apakah sudah masuk daftar status list.

<pre>
$ <b>rc-status --all</b>
</pre>

<pre>
Runlevel: default
 cronie                                                                [  started  ]
 <mark>wpa_supplicant                                                        [  stopped  ]</mark>
 dhcpcd                                                                [  started  ]
 alsasound                                                             [  started  ]
 dbus                                                                  [  started  ]
</pre>

Tinggal di-start saja.

<pre>
$ <b>sudo rc-service wpa_supplicant start</b>
</pre>

<pre>
wpa_supplicant    | * Starting WPA Supplicant Daemon ...
wpa_supplicant    |Successfully initialized wpa_supplicant                    [ ok ]
</pre>

Mantap, sekarang seharusnya kita sudah dapat terhubung dengan jaringan.

Untuk systemd, mohon maaf saya belum sempat mencoba menggunakan systemd. Kemungkin hanya perlu menjalankan service dari wpa_supplicant.service seperti biasa. Silahkan merujuk ke Arch Wiki.





# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)


# Referensi

1. [wiki.archlinux.org/index.php/Wpa_supplicant](https://wiki.archlinux.org/index.php/Wpa_supplicant){:target="_blank"}
<br>Diakses tanggal: 2020/12/31

2. [wiki.archlinux.org/index.php/Network_configuration/Wireless#Utilities](https://wiki.archlinux.org/index.php/Network_configuration/Wireless#Utilities){:target="_blank"}
<br>Diakses tanggal: 2020/12/31
