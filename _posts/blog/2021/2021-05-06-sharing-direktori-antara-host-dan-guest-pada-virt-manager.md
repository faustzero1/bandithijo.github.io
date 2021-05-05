---
layout: 'post'
title: "Sharing Direktori Antara Host Linux dan Guest Windows pada Virt-Manager/KVM/Qemu"
date: 2021-05-06 00:40
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Virt-Manager', 'KVM', 'Qemu']
pin:
hot:
contributors: []
description: "Memiliki akses Home direktori yang dimiliki oleh Host dari dalam Guest, sangat memudahkan sekali untuk proses tukar menukar data. Tidak perlu repot-repot harus menggunakan aplikasi semacam Filezilla, scp, atau semacamnya. Semuanya cukup dilakukan dengan File Explorer di Linux dan Explorer Guest Windows."
---

# Latar Belakang Masalah

Saat membuat VM baru pada virt-manager, biasanya sharing Home direktori antara Host OS --dalam hal ini adalah GNU/Linux-- dan Guest OS --dalam hal ini adalah Windows-- tidak langsung tersedia. Kita perlu mengkonfigurasi secara manual.

**Bang, yang seperti apa sih "Sharing Home Direktori" itu?**

{% image https://i.postimg.cc/VkvRMH60/gambar-04.png | 04 %}

Bisa dilihat di **My Computer**, pada kategori **Network Location** seperti yang saya kotakin merah.

Kalau kita buka, isinya adalah Home direktori dari Host OS.

# Pemecahan Masalah

Untu memecahkan masalah di atas, teradapat beberapa prasyarat yang harus terpenuhi, diantaranya:

1. Mengaktifkan Samba service pada Host OS
2. Perlu membuat virtual network yang dapat diakses oleh Host OS (Bridge)
3. Menambahkan "Network Location" pada Guest OS yang dialamatkan pada IP address Host OS

Oke, saya akan jabarkan langkah-langkah di atas.

## Pasang Samba

Pasang Samba dulu apabila belum terinstal.

{% shell_term $ %}
sudo pacman -S samba
{% endshell_term %}

Kalau di Artix Linux, ikutkan dengan paket initnya, misal untuk OpenRC.

{% shell_term $ %}
sudo pacman -S samba samba-openrc
{% endshell_term %}

## Jalankan Samba Service

Sebelum dapat digunakan, tentunya Samba service harus dijalankan terlebih dahulu.

**systemd**

{% shell_term $ %}
sudo systemctl start smb
{% endshell_term %}

**OpenRC**

{% shell_term $ %}
sudo rc-service smb start
{% endshell_term %}

## Buat Samba User

Buat Samba user terlebih dahulu, saya merekomendasikan, agar mudah diingat, buat Samba user dengan credential yang sama dengan Guest OS yang digunakan.

Misal, di Guest OS (Windows), saya memiliki user:

{% pre_whiteboard %}
username: bandithijo
password: hijobandit
{% endpre_whiteboard %}

Sekarang, buat Samba user,

{% shell_term $ %}
smbpasswd -a bandithijo
{% endshell_term %}

<pre>
New SMB password:
Retype new SMB password:
</pre>

{% box_info %}
<p markdown=1>Sekedar catatan saja, agar tidak perlu repot-repot mencari-cari.</p>
<p markdown=1>**Mengganti Password**</p>
{% shell_term $ %}
smbpasswd bandithijo
{% endshell_term %}
<p markdown=1>**Menghapus Samba User**</p>
{% shell_term $ %}
smbpasswd -x bandithijo
{% endshell_term %}
{% endbox_info %}

## Membuat Virtual Network

{% box_perhatian %}
<p markdown=1>Saya tidak terlalu mahir dengan Networking.</p>
{% endbox_perhatian %}

**Virtual Network yang dibuat harus memiliki network yang sama dengan Host OS**.

Misal, Host OS memiliki IP address, 192.168.1.7/24, artinya Host OS berada pada network 192.168.1.0/24 dengan jumlah IP address yang tersedia adalah 254. Mulai dari rentar 192.168.1.2 - 192.168.1.254

Kita akan mengambil sebagian IP address yang tersedia tersebut.

Misal, dari ip 192.168.1.100 dengan netmask /28.

Untuk membuat Virtual Network, buka menu **Edit > Connection Details**.

Pergi ke tab **Virtual Networks**.

Tambahkan network baru dengan menu **+** di pojok kiri bawah.

Nanti akan terbuka window seperti di bawah ini.

{% image https://i.postimg.cc/pLrwTCMq/gambar-01.png | 01 %}

Isi bagian-bagian yang saya kotak merah.

{% pre_whiteboard %}
Name: network-bridge
Mode: NAT
IPv5:
  Network: 192.168.1.100/28
{% endpre_whiteboard %}

Lalu tekan **Finish**.

Nanti virt-manager secara pintar, akan mengalokasikan IP address yang tersedia untuk kita gunakan.

{% image https://i.postimg.cc/QxQQ7ZhM/gambar-02.png | 02 %}

Dapat dilihat pada gambar di atas, kita mendapatkan network 192.168.1.96/28, dengan alokasi IP address yang dapat kita gunakan pada rentang 192.168.1.104 - 192.168.1.110

Jadi, nanti ketika kita membuat Vitual Machine, IP address yang akan diambil dari rentang tersebut apabila kita gunakan Virtual Network **network-bridge**.

## Attach VM dengan Virtual Network

Anggaplah kita sudah memiliki Virtual Machine yang berisi Windows.

Pasang/attach Network Interface Controller (NIC) dengan Virtual Network yang kita buat di atas dengan nama **network-bridge**.

Seperti ini ilustrasinya,

{% image https://i.postimg.cc/qM1f4YSN/gambar-03.png | 03 %}

Dapat dilihat pada gambar di atas, Virtual Machine saya mendapatkan IP address 192.168.1.105, yang mana IP address ini masih dalam rentang yang kita bahas di atas (.104 - .110).

Karena Virtual Machinve (Guest OS) memiliki IP yang berada pada rentang Host OS, maka keduaya dapat saling berkomunikasi.

{% pre_whiteboard %}
Host  OS IP Address : 192.168.1.7
Guest OS IP Address : 192.168.1.105
{% endpre_whiteboard %}

Coba lakukan pengetesan dengan mengirimkan sinyal **ping**.

**Host OS (Linux) ping ke Guest OS (Windows)**

{% shell_term $ %}
ping -c 3 192.168.1.105
{% endshell_term %}

<pre>
PING 192.168.1.105 (192.168.1.105) 56(84) bytes of data.
64 bytes from 192.168.1.105: icmp_seq=1 ttl=128 time=0.312 ms
64 bytes from 192.168.1.105: icmp_seq=2 ttl=128 time=0.341 ms
64 bytes from 192.168.1.105: icmp_seq=3 ttl=128 time=0.353 ms

--- 192.168.1.105 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2016ms
rtt min/avg/max/mdev = 0.312/0.335/0.353/0.017 ms
</pre>

Di sisi lain,

**Guest OS (Windows) ping ke Host OS (Linux)**

{% shell_term $ %}
ping 192.168.1.7
{% endshell_term %}

<pre>
Microsoft Windows [Version 6.1.7601]
Copyright (c) 2009 Microsoft Corporation.  All rights reserved.

C:\Users\bandithijo>ping 192.168.1.7

Pinging 192.168.1.7 with 32 bytes of data:
Reply from 192.168.1.7: bytes=32 time=1ms TTL=64
Reply from 192.168.1.7: bytes=32 time<1ms TTL=64
Reply from 192.168.1.7: bytes=32 time<1ms TTL=64
Reply from 192.168.1.7: bytes=32 time<1ms TTL=64

Ping statistics for 192.168.1.7:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum = 1ms, Average = 0ms
</pre>

Oke, kita sudah punya network yang sesuai dengan prasyarat yang ditentukan.

## Buat Network Location di Guest OS

Buka Guest OS --dalam hal ini adalah Windows, kemudian buka **My Computer**.

Klik kanan dan pilih **Add a network location**.

{% image https://i.postimg.cc/63NkcGyZ/gambar-05.png | 05 %}

Next-next aja, sampai ketemu halaman seperti di bawah ini.

{% image https://i.postimg.cc/j2MBRgv6/gambar-06.png | 06 %}

Isi dengan format seperti yang saya kotakin merah.

{% pre_url %}
<b>\\192.168.1.7\bandithijo</b>
{% endpre_url %}

Dapat dilihat bahwa formulanya adalah,

{% pre_whiteboard %}
\\host_ip_address\host_username
{% endpre_whiteboard %}

Halaman selanjutnya adalah memberikan nama,

{% image https://i.postimg.cc/CLKWc0Lc/gambar-07.png | 07 %}

Finish!

Kalau berhasil, akan ada Home dari Host OS di my computer.

{% image https://i.postimg.cc/VkvRMH60/gambar-04.png | 04 %}

**Bang, saya tidak mau Home direktori yang dishare, tapi direktori tertentu. Bisa tidak?**

Tetu saja, Bisa!

Misal, direktori yang mau dishare ada di **/home/bandithijo/Documents/**.

Tinggal buat saja locationnya seperti ini.

{% pre_url %}
<b>\\192.168.1.7\bandithijo\Documents</b>
{% endpre_url %}

Hasilnya,

{% image https://i.postimg.cc/MHpr30xn/gambar-08.png | 08 %}




# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Selanjutnya, saya serahkan kepada imajinasi dan kreatifitas teman-teman. Hehe.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)




# Referensi

1. [wiki.archlinux.org/title/Samba](https://wiki.archlinux.org/title/Samba){:target="_blank"}
<br>Diakses tanggal: 2021/05/06
