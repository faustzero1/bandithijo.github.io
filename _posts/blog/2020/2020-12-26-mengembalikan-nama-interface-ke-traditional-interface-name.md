---
layout: 'post'
title: "Mengembalikan Nama Interface Menjadi Traditional Interface Name (eth0, wlan0, etc.)"
date: 2020-12-26 08:48
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

Mungkin yang baru menggunakan GNU/Linux tidak mengerti apa maksudnya "Traditional Interface Name".

Penamaan interface saat ini sudah menggunakan aturan penamaan yang baru.

Kita dapat melihat daftar network interface yang ada di sistem dengan menggunakan perintah-perintah yang disediakan oleh [**iproute2**](https://en.wikipedia.org/wiki/iproute2){:target="_blank"}.

{% shell_user %}
ip address show
{% endshell_user %}

Atau dapat dipersingkat,

{% shell_user %}
ip a s
{% endshell_user %}

<pre>
1: <mark>lo</mark>: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: <mark>eth0</mark>: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN group default qlen 1000
    link/ether 00:16:d3:c4:fb:d2 brd ff:ff:ff:ff:ff:ff
3: <mark>wlan0</mark>: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default
qlen 1000
    link/ether 08:11:96:00:00:00 brd ff:ff:ff:ff:ff:ff
</pre>

Bagian yang saya marking kuning, adalah nama interface.

**lo**, adalah interface loopback.

**eth0**, adalah interface untuk ethernet.

**wlan0**, adalah interface untuk wireless.

Angka **0** dibagian belakang dapat bertambah seiring bertambahnya jumlah interface, misal wlan1, wlan2, wlan3.

Namun, saat ini, sudah tidak lagi menggunakan namespace seperti ini sejak systemd v197, dikarenakan beberapa alasan terkait keamanan.

Mungkin yang teman-teman miliki akan seprti ini namanya, `wlp3s0`, `enp1s0`. Ya, ini adalah interface namespace yang baru.

Keuntungan apabila kita menggunakan namespace yang baru.

1. Stable interface names across reboots
2. Stable interface names even when hardware is added or removed, i.e. no re-enumeration takes place (to the level the firmware permits this)
3. Stable interface names when kernels or drivers are updated/changed
4. Stable interface names even if you have to replace broken ethernet cards by new ones
5. The names are automatically determined without user configuration, they just work
6. The interface names are fully predictable, i.e. just by looking at lspci you can figure out what the interface is going to be called
7. dan seterusnya, masih banyak.

Teman-teman dapat membaca penjelasan lebih lengkapnya pada artikel ini, [**Predictable Network Interface Names**](https://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/){:target="_blank"}.

Dari keuntungan-keuntungan tersebut, tidak ada yang cocok dengan saya. Terutama poin-poin pertama.

Karena saya hanya menggunakan laptop dan tidak memiliki banyak interface.

Maka, saya putuskan untuk tidak menggunakan interface namespace yang baru. Alasan yang kurang greget. 😄

{% box_perhatian %}
<p>Saya tidak merekomendasikan untuk mengikuti apa yang saya lakukan.</p>
{% endbox_perhatian %}

Okeh, langsung saja bah, males nulis teori-teori. Temen-temen bisa cari tahu sendiri yaa.

# Pemecahan Masalah

Sebenarnya di Arch Wiki sudah ada yang mencatatkan.

Teman-teman bisa pilih antara:

1. [Change interface name](https://wiki.archlinux.org/index.php/Network_configuration#Change_interface_name){:target="_blank"}.
2. [Revert to traditional interface names](https://wiki.archlinux.org/index.php/Network_configuration#Revert_to_traditional_interface_names){:target="_blank"}

Untuk catatan kali ini, sesuai judulnya, saya akan mencatat cara kedua, yaitu "Mengembalikan ke Traditional Interface Names".

Cara kedua ini juga terdapat 2 cara:

## 1. Masking Udev Rule

Dengan melakukan masking terhadap udev rule yang memberikan aturan interface namespace yang baru.

{% shell_user %}
ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules
{% endshell_user %}

## 2. Kernel Parameter

Cara alternatif adalah dengan menambahkan `net.ifnames=0` di kernel parameter.

Saya menggunakan cara alternatif ini, karena praktis. 😁

Karena saya menggunakan GRUB, maka saya akan menambahkan parameter tersebut melalui konfigurasi GRUB saja, agar lebih mudah.

{% highlight_caption /etc/default/grub %}
{% highlight sh linenos %}
# GRUB boot loader configuration

# ...
# ...
GRUB_CMDLINE_LINUX_DEFAULT="... ... ..."
GRUB_CMDLINE_LINUX="net.ifnames=0"
# ...
# ...
{% endhighlight %}

Selesai.

Tinggal reboot dan coba lakukan <code>$ <b>ip a s</b></code> lagi untuk melihat nama interface, apakah sudah kembali ke traditional interface namespace atau belum.




# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)


# Referensi

1. [Arch Wiki - Network configuration: Revert to traditional interface names](https://wiki.archlinux.org/index.php/Network_configuration#Revert_to_traditional_interface_names){:target="_blank"}
<br>Diakses tanggal: 2020/12/26

2. [Artix Wiki - Migrtaion: Configure Networking](https://wiki.artixlinux.org/Main/Migration#Configure_networking){:target="_blank"}
<br>Diakses tanggal: 2020/12/27
