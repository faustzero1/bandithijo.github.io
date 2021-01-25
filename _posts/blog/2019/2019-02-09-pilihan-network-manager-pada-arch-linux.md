---
layout: 'post'
title: 'Comprehensive Network Manager yang Saya Pergunakan pada Arch Linux'
date: 2019-02-09 05:52
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Arch Linux', 'Tips', 'Tools', 'Terminal']
pin:
hot:
contributors: []
resume: "Terdapat banyak sekali tools yang dapat kita gunakan untuk mengatur jaringan di GNU/Linux. Perkakas-perkakas ini sering diistilahkan dengan Comprehensive Network Manager, atau Network Manager saja. Tapi jangan salah paham yaa, karena salah satu Network Manager tersebut ada yang bernama NetworkManager."
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Sebagai pengguna Arch Linux, kita dibebaskan untuk memilih **Network Manager** yang akan kita gunakan untuk menghandle jaringan (*networking*).

Kegunaan dari Network Manager ini adalah untuk memfasilitasi kita mengelola pengaturan koneksi jaringan melalui profil jaringan agar kita dapat dengan mudah melakukan perpindahan antar jaringan.

| Network manager | GUI | Archiso | <center>CLI tools</center> | PPP support (3G modem) | DHCP client | <center>Systemd units</center> |
| :--: | :--: | :--: | :-- | :--: | :--: | :-- |
| ConnMan | unofficial | No | connmanctl | Yes | internal | `connman.service` |
| netctl | unofficial | Yes (base) | netctl, wifi-menu | Yes | dhcpcd, dhclient | `netctl-ifplug@interface.service`, `netctl-auto@interface.service` |
| NetworkManager | Yes | No | nmcli, nmtui | Yes | internal, dhcpcd, dhclient | `NetworkManager.service` |
| systemd-networkd | No | Yes | networkctl | No | internal | `systemd-networkd.service`, `systemd-resolved.service` |
| Wicd | Yes | No | wicd-cli, wicd-curses | No | dhcpcd | `wicd.service` |

<p class="img-caption" style="text-align:left;">Sumber: <a href="https://wiki.archlinux.org/index.php/Network_configuration#Network_managers" target="_blank">Arch Wiki/Network Configuration</a></p>

Apabila kita melakukan instalasi Arch Linux dengan Archiso, biasanya yang paling populer untuk terkoneksi dengan jaringan wireless adalah `wifi-menu`, paket ini merupakah paket yang dibawa secara *default* oleh `netctl` yang merupakan salah satu Network Manger yang sudah ada di dalam Archiso, selain `systemd-network`.

Namun, apabila wireless card kita ternyata belum terdeteksi, kita masih dapat menggunakan `netctl` juga yang sudah membawa `dhcpcd` untuk menghandle konektifitas via *usb-tethering smartphone*.

Untuk catatan kali ini, saya hanya akan mendokumentasikan mengenai **NetworkManager**, karena ini yang saya pergunakan.

Saya juga merekomendasikan untuk teman-teman yang baru menggunakan Arch Linux atau yang ingin praktis dan simpel seperti saya, NetworkManager adalah pilihan yang mudah.

# Instalasi

Proses pemasangan paket `networkmanager` juga sangat mudah.

{% shell_user %}
sudo pacman -S networkmanager
{% endshell_user %}

Secara *default* paket ini sudah membawa daemon untuk services, aplikasi CLI yaitu `nmcli` dan aplikasi TUI `nmtui`.

Atau dapat pula menambahkan paket untuk GUI.

{% shell_user %}
sudo pacman -S nm-connection-editor
{% endshell_user %}

Namun, apabila paket ini sudah terdapat dalam proses pemasangan paket `networkmanager`, tidak perlu lagi kita instal kembali.

Untuk yang ingin menggunakan trayicon dapat menambahkan paket `network-manager-applet`.

{% shell_user %}
sudo pacman -S Network-manager-applet
{% endshell_user %}

Setelah memasang paket `networkmanager` jangan lupa untuk mengaktifkan daemon services dari Network Manager.

{% shell_user %}
sudo systemctl enable NetworkManager.service
sudo systemctl start NetworkManager.service
{% endshell_user %}

Perhatikan huruf besar dan kecilnya!

# Konfigurasi

Sejujurnya saya bingung apa yang harus dikonfigurasi, karena semua sudah dihandle oleh NetworkManager.

Kita hanya perlu memasukkan profil jaringan seperti SSID, dll.

# Paket Tambahan

Ada beberapa paket tambahan yang saya pergunakan, Seperti

1. Modem Support:
   - [`modemmanager`](https://www.archlinux.org/packages/?name=modemmanager){:target="_blank"}
   - [`mobile-broadband-provider-info`](https://www.archlinux.org/packages/?name=mobile-broadband-provider-info){:target="_blank"}
   - [`usb_modeswitch`](https://www.archlinux.org/packages/?name=usb_modeswitch){:target="_blank"}.

2. VPN Support:
   - [`networkmanager-openvpn`](https://www.archlinux.org/packages/?name=networkmanager-openvpn){:target="_blank"}
   - [`networkmanager-pptp`](https://www.archlinux.org/packages/?name=networkmanager-pptp){:target="_blank"}
   - dan masih banyak lagi, silahkan lihat di [Arch Wiki](https://wiki.archlinux.org/index.php/NetworkManager#VPN_support){:target="_blank"}

# Tampilan

## GUI

Berikut ini adalah beberapa tampilan NetworkManager menggunakan GUI.

{% image https://i.postimg.cc/0NDyGKzB/gambar-01.png | 1 | nm-applet %}

{% image https://i.postimg.cc/C14MXyHC/gambar-02.png | 2 | nm-connection-editor %}

## TUI

Untuk saat ini, saya lebih sering menggunakan TUI, dan tidak menggunakan kedua paket di atas untuk memilih network profile.

Fungsinya sama saja, hanya berbeda tampilan.

{% image https://i.postimg.cc/W1HPDNSf/gambar-03.png | 3 | nmtui, bagian depan %}

{% image https://i.postimg.cc/vBWRSWyp/gambar-04.png | 4 | nmtui, bagian Edit connection %}

{% image https://i.postimg.cc/j5V0XMpH/gambar-05.png | 5 | nmtui, bagian Activate a connection %}

{% image https://i.postimg.cc/QMKZ12yN/gambar-06.png | 6 | nmtui, bagian Set system hostname %}

Sejak menggunakan `nmtui`, saya tidak memerlukan lagi `nm-applet`. Sehingga membuat saya terbebas dari menggunakan trayicon.

## Memanfaatkan Rofi untuk Interface NetworkManager

Saya tidak menggunakan trayicon untuk memilih network dan memanggil Network Manager Settings. Saya lebih senang tidak menggunakan trayicon agar tampilan desktop tetap clean dan tidak terlalu banyak icon yang tidak konvergen dengan theme.

Sebelumnya, saya menggunakan aplikasi `nmtui` untuk melakukan konfigurasi jaringan, seperti: memilih-milih SSID. Namun, baru-baru saja saya menggunakan `networkmanager_dmenu`.

Untuk memanggilnya, saya menggunakan <kbd>SUPER</kbd>+<kbd>F8</kbd>.

{% highlight_caption $HOME/.config/sxhkd/sxhkdrc %}
{% highlight sh linenos %}
# ...
# ...

# Network Manager Dmenu
bindsym $mod+F8 exec --no-startup-id networkmanager_dmenu
{% endhighlight %}

Aplikasi ini dapat kita gunakan untuk memilih-mili jaringan dan beberapa menu jaringan. Dapat menggunakan `dmenu` atau `rofi` sebagai frontend nya. Tentu saja saya memilih menggunakan `rofi` agar seragam dengan theme. Hehehe.

{% image https://i.postimg.cc/LsHPsDVN/gambar-17.gif | 17 | Tampilan NetworkManager_dmenu dengan Rofi %}


# Pesan Penulis

Sekali waktu, apabila ada waktu luang, coba sempatkan untuk mencoba network manager yang lain juga.

Menggunakan Arch Linux memberikan kita kemudahan untuk membongkar-pasang berbagai macam aplikasi pendukung yang kita perlukan.

Beberapa waktu yang lalu, saya pun sempat mencoba **connman** dan **wicd**.

{% image https://i.postimg.cc/mZ9spG8J/gambar-07.png | 7 | Tampilan GUI dari <code>connman-gtk</code> %}

{% image https://i.postimg.cc/3JHHPbqR/gambar-08.png | 8 | Tampilan GUI dari <code>wicd-gtk</code> %}

Sebaik-baik dokumentasi adalah yang ditulis dan dikelola secara aktif oleh developer dari aplikasi yang bersangkutan.

Silahkan menggali informasi lebih jauh dan lebih luas pada daftar referensi yang saya sertakan.

Karena tulisan ini bukan ditujukan untuk membuat tandingan dari dokumentasi resmi yang sudah ada. Melainkan sebagai catatan dan ulasan berkaitan dengan aplikasi ini yang saya pergunakan sehari-hari.

Sepertinya ini saja yang dapat saya tulisakan. Mudah-mudahan dapat bermanfaat bagi teman-teman yang memerlukan.


# Referensi

1. [wiki.archlinux.org/index.php/Network_configuration#Network_managers](https://wiki.archlinux.org/index.php/Network_configuration#Network_managers){:target="_blank"}
<br>Diakses tanggal: 2019/02/09

2. [wiki.archlinux.org/index.php/NetworkManager](https://wiki.archlinux.org/index.php/NetworkManager){:target="_blank"}
<br>Diakses tanggal: 2019/02/09
