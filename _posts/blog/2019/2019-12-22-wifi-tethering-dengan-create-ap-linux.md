---
layout: 'post'
title: "Berbagi WiFi Tethering dengan create_ap pada GNU/Linux"
date: 2019-12-22 09:51
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Ulasan']
pin:
hot:
contributors: []
resume: "Fitur tethering Wi-Fi mungkin mudah didapatkan apabila menggunakan Desktop Environment tertentu. Karena biasanya sudah menyediakan menu untuk berbagi network dengan Wi-Fi. Namun, bagaimana apabila kita menggunakan Window Manager? comprehensive network manager seperti NetworkManager sejauh yang saya tahu, belum memiliki fitur ini, namun ConnMan sudah memiliki fitur Wi-F- tethering. Namun, jangan khawatir, sudah ada tools yang standalone yang dapat menyediakan layanan Wi-Fi tethering, yaitu create_ap."
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Catatan ini juga sebagai ulasan dari script **create_ap**.

Seperti definisi singkat yang ditulis pada GitHub repo, create_ap adalah script yang dapat membuat NAT atau Bridge WiFi Access Point.

Bahasa awamnya WiFi Tethering, atau berbagi koneksi internet lewat WiFi. Nah.

Kira-kira seperti itu.

# Ulasan

Bagi pengguna GNU/Linux seperti saya yang hanya menggunakan Window Manager, script seperti ini sangat membantu dan nyaman digunakan. Karena tidak harus membuka aplikasi GUI.

## Fitur yang diberikan

Beberapa fitur yang diberikan oleh **create_ap** adalah:

1. Membuat Access Point (AP) pada channel mana saja
2. Dapat menggunakan salah satu dari enkripsi yang disediakan (WPA, WPA2, WPA/WPA2, Open (no encryption)
3. Menyembunyikan SSID
4. Menonaktifkan komunikasi antara client (client isolation)
5. Mendukung IEEE 802.11n dan 802.11ac
6. Internet sharing dengan metode: NATed, Bridged atau None (tidak ada internet sharing)
7. Memilih IP Gateway untuk AP (hanya dapat dilakukan pada NATed dan None)
8. Membuat Access Point (AP) dengan interface yang sama dengan koneksi internet yang kita gunakan.
9. Dapat membuat SSID dengan pipe atau dengan argument

## Dependensi

Paket-paket berikut ini perlu dipasang, agar dapat menggunakan **create_ap**.

### General

1. `bash`/`zsh`/dst.
2. `util-linux` (untuk getopt)
3. `procps` atau `procps-ng`
4. `hostapd`
5. `iproute2`
6. `iw`
7. `iwconfig` (kamu hanya memerlukan paket ini apabila `iw` tidak dapat mengenali adapter yang kita gunakan)
8. `haveged` (optional)

### Untuk NATed atau None

1. `dnsmasq`
2. `iptables`

## Instalasi

### Arch Linux

Beruntungnya saya menggunakan Arch Linux. Paket **create_ap** sudah terdapat pada official repo.

{% shell_user %}
sudo pacman -S create_ap
{% endshell_user %}

### Distribusi lain

Untuk yang menggunakan distribusi lain, dapat membuild sendiri dari source.

{% shell_user %}
git clone https://github.com/oblique/create_ap
cd create_ap
make install
{% endshell_user %}

## Penggunaan

Sekarang, coba saya jalankan dulu **create_ap**.

{% shell_user %}
create_ap
{% endshell_user %}

```
Usage: create_ap [options] <wifi-interface> [<interface-with-internet>] [<access-point-name> [<passphrase>]]

Options:
  -h, --help              Show this help
  --version               Print version number
  -c <channel>            Channel number (default: 1)
  -w <WPA version>        Use 1 for WPA, use 2 for WPA2, use 1+2 for both (default: 1+2)
  -n                      Disable Internet sharing (if you use this, don't pass
                          the <interface-with-internet> argument)
  -m <method>             Method for Internet sharing.
                          Use: 'nat' for NAT (default)
                               'bridge' for bridging
                               'none' for no Internet sharing (equivalent to -n)
  --psk                   Use 64 hex digits pre-shared-key instead of passphrase
  --hidden                Make the Access Point hidden (do not broadcast the SSID)
  --mac-filter            Enable MAC address filtering
  --mac-filter-accept     Location of MAC address filter list (defaults to /etc/hostapd/hostapd.accept)
  --redirect-to-localhost If -n is set, redirect every web request to localhost (useful for public information networks)
  --hostapd-debug <level> With level between 1 and 2, passes arguments -d or -dd to hostapd for debugging.
  --isolate-clients       Disable communication between clients
  --ieee80211n            Enable IEEE 802.11n (HT)
  --ieee80211ac           Enable IEEE 802.11ac (VHT)
  --ht_capab <HT>         HT capabilities (default: [HT40+])
  --vht_capab <VHT>       VHT capabilities
  --country <code>        Set two-letter country code for regularity (example: US)
  --freq-band <GHz>       Set frequency band. Valid inputs: 2.4, 5 (default: 2.4)
  --driver                Choose your WiFi adapter driver (default: nl80211)
  --no-virt               Do not create virtual interface
  --no-haveged            Do not run 'haveged' automatically when needed
  --fix-unmanaged         If NetworkManager shows your interface as unmanaged after you
                          close create_ap, then use this option to switch your interface
                          back to managed
  --mac <MAC>             Set MAC address
  --dhcp-dns <IP1[,IP2]>  Set DNS returned by DHCP
  --daemon                Run create_ap in the background
  --stop <id>             Send stop command to an already running create_ap. For an <id>
                          you can put the PID of create_ap or the WiFi interface. You can
                          get them with --list-running
  --list-running          Show the create_ap processes that are already running
  --list-clients <id>     List the clients connected to create_ap instance associated with <id>.
                          For an <id> you can put the PID of create_ap or the WiFi interface.
                          If virtual WiFi interface was created, then use that one.
                          You can get them with --list-running
  --mkconfig <conf_file>  Store configs in conf_file
  --config <conf_file>    Load configs from conf_file

Non-Bridging Options:
  --no-dns                Disable dnsmasq DNS server
  -g <gateway>            IPv4 Gateway for the Access Point (default: 192.168.12.1)
  -d                      DNS server will take into account /etc/hosts

Useful informations:
  * If you're not using the --no-virt option, then you can create an AP with the same
    interface you are getting your Internet connection.
  * You can pass your SSID and password through pipe or through arguments (see examples).
  * On bridge method if the <interface-with-internet> is not a bridge interface, then
    a bridge interface is created automatically.

Examples:
  create_ap wlan0 eth0 MyAccessPoint MyPassPhrase
  echo -e 'MyAccessPoint\nMyPassPhrase' | create_ap wlan0 eth0
  create_ap wlan0 eth0 MyAccessPoint
  echo 'MyAccessPoint' | create_ap wlan0 eth0
  create_ap wlan0 wlan0 MyAccessPoint MyPassPhrase
  create_ap -n wlan0 MyAccessPoint MyPassPhrase
  create_ap -m bridge wlan0 eth0 MyAccessPoint MyPassPhrase
  create_ap -m bridge wlan0 br0 MyAccessPoint MyPassPhrase
  create_ap --driver rtl871xdrv wlan0 eth0 MyAccessPoint MyPassPhrase
  create_ap --daemon wlan0 eth0 MyAccessPoint MyPassPhrase
  create_ap --stop wlan0
```

Nah, kita dapat melihat, beberapa contoh yang disertakan.

Sangat mudah sekali penggunaannya.

Bentuk dari perintahnya akan seperti ini.

{% shell_user %}
create_ap [options] &lt;wifi-interface> [&lt;interface-with-internet>] [&lt;access-point-name> [&lt;passphrase>]]
{% endshell_user %}

### Tanpa passphrase (open network)

{% shell_user %}
create_ap wlan0 eth0 MyAccessPoint
{% endshell_user %}

Berarti, kita mendapatkan internet dari interface `eth0` dan akan kita sharing menggunakan interface `wlan0` dengan nama Access Point `MyAccessPoint`.

Mudha dimengerti kan?

### WPA + WPA2 passphrase

{% shell_user %}
create_ap wlan0 eth0 MyAccessPoint MyPassPhrase
{% endshell_user %}

### Access Point tanpa internet

{% shell_user %}
create_ap -n wlan0 MyAccessPoint MyPassPhrase
{% endshell_user %}

### Bridged internet sharing

{% shell_user %}
create_ap -m bridge wlan0 eth0 MyAccessPoint MyPassPhrase
{% endshell_user %}

### Bridged Internet sharing (pre-configured bridge interface)

{% shell_user %}
create_ap -m bridge wlan0 br0 MyAccessPoint MyPassPhrase
{% endshell_user %}

### Internet sharing sharing dari WiFi interface yang sama

Ini yang paling sering saya pergunakan.

{% shell_user %}
create_ap wlan0 wlan0 MyAccessPoint MyPassPhrase
{% endshell_user %}

### Menggunakan WiFi adapter driver yang berbeda

{% shell_user %}
create_ap --driver rtl871xdrv wlan0 eth0 MyAccessPoint MyPassPhrase
{% endshell_user %}

### Tanpa passphrase (open network) menggunakan pipe

Nah, ini adalah fitur yang dimention pada poin nomor 9 di atas.

{% shell_user %}
echo -e "MyAccessPoint" | create_ap wlan0 eth0
{% endshell_user %}

### WPA + WPA2 passphrase menggunakan pipe

{% shell_user %}
echo -e "MyAccessPoint\nMyPassPhrase" | create_ap wlan0 eth0
{% endshell_user %}

### Enable IEEE 802.11n

{% shell_user %}
create_ap --ieee80211n --ht_capab '[HT40+]' wlan0 eth0 MyAccessPoint MyPassPhrase
{% endshell_user %}

### Client Isolation

Ini adalah contoh penggunaan fitur nomor 4 di atas.

{% shell_user %}
create_ap --isolate-clients wlan0 eth0 MyAccessPoint MyPassPhrase
{% endshell_user %}

## Systemd Service

Kita juga dapat memanfaatkan systemd service untuk membuat konfigurasi yang persisten.

### Menjalankan service

{% shell_user %}
sudo systemctl start create_ap
{% endshell_user %}

### Menjalankan service saat proses booting

{% shell_user %}
sudo systemctl enable create_ap
{% endshell_user %}

# Troubleshooting

## ERROR: Failed to initialize lock

Apabila saat menjalankan `create_ap` muncul pesan seperti di atas, maka cukup hapus file `.lock` yang tersimpan pada direktori `/tmp`.

{% shell_user %}
rm /tmp/create_ap.all.lock
{% endshell_user %}

# Pesan Penulis

Gimana?

Penggunaan script ini sangat mudah bukan?

Fitur yang disediakan juga cukup dapat meng-*cover* kebutuhan kita sehari-hari.

Apalagi saya yang hanya user biasa ini.

Untuk dokumentasi lebih lengkap dapat mengunjungi halaman GitHb repo dari **create_ap**.








# Referensi

1. [github.com/oblique/create_ap](https://github.com/oblique/create_ap){:target="_blank"}
<br>Diakses tanggal: 2019/12/22
