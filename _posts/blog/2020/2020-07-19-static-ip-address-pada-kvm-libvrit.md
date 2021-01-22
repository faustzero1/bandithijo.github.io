---
layout: 'post'
title: "Membuat IP Address Static pada KVM libvirt (virt-manager)"
date: 2020-07-19 13:04
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Network']
pin:
hot:
contributors: []
resume:
---

# Sekenario Masalah

Saya mencoba membangun Virtual Private Server untuk belajar men-deploy Ruby on Rails ke production.

Saya tidak menggunakan VirtualBox, melainkan Virtual Machine Manager (virt-manager).

Beberapa kali saya dapati, kalau IP address yang diset melalui DHCP selalu berubah-ubah pada guest instance yang saya pasang.

Hal ini mempengaruhi konfigurasi yang ada pada web aplikasi, karena saya harus mengubah IP server yang ada pada konfigurasi deploy `config/deploy/production.rb`.

# Pemecahan Masalah

Agar IP address dari guest instance tidak berubah-ubah, kita perlu mendefinisikannya pada virtual router yang mengatur DHCP.

Saya akan tulis langkah-langkahnya di bawah ini.

<!-- PERHATIAN -->
<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
<p>Sebelumnya, guest instance <b>harus dalam keadaan mati</b>.</p>
<p>Pastikan <b>libvirtd.service</b> berstatus <b>active (running)</b>.</p>
<pre>
● libvirtd.service - Virtualization daemon
     Loaded: loaded (/usr/lib/systemd/system/libvirtd.service; disabled; vendor preset: disabled)
     Active: <b>active (running)</b> since Sun 2020-07-19 16:14:49 WITA; 2s ago
TriggeredBy: ● libvirtd-admin.socket
             ● libvirtd-ro.socket
             ● libvirtd.socket
       Docs: man:libvirtd(8)
             https://libvirt.org
   Main PID: 345535 (libvirtd)
      Tasks: 19 (limit: 32768)
     Memory: 22.8M
     CGroup: /system.slice/libvirtd.service
             ├─107869 /usr/bin/dnsmasq --conf-file=/var/lib/libvirt/dnsmasq/default.conf --leasefile-ro --dhcp-script=/usr/lib/libvirt/libvirt_leaseshelper
             ├─107870 /usr/bin/dnsmasq --conf-file=/var/lib/libvirt/dnsmasq/default.conf --leasefile-ro --dhcp-script=/usr/lib/libvirt/libvirt_leaseshelper
             └─345535 /usr/bin/libvirtd --timeout 120
</pre>
</div>

## 1. Mengecek Daftar Virtual Network

Kita perlu mengetahui nama dari virtual network yang ada dan yang kita gunakakan.

<pre>
$ <b>sudo virsh net-list</b>
</pre>

```
 Name      State    Autostart   Persistent
--------------------------------------------
 default   active   yes         yes

```

Biasanya, secara *default* hanya akan ada satu dengan nama **default**.

Sudah dapat dipastikan, kalau network yang digunakan oleh guest instance yang kita gunakan, menggunakan network **default** ini.

Untuk memastikan lagi kita perlu melihat range Ip address yang ada ada virtual network **default**.

<pre>
$ <b>sudo virsh net-dumpxml default | grep -i '<range'</b>
</pre>

<pre>
      &lt;range start='<b>192.168.122.2</b>' end='<b>192.168.122.254</b>'/&gt;
</pre>

Nah, kalau IP yang ada pada guest instance kita berada pada range IP tersebut di atas, berarti benar, guest instance yang kita gunakan menggunakan network **default** tersebut.

## 2. Mengetahui MAC Address yang Digunakan Guest Instance

Karena kita ingin mengeset IP address static pada guest instance yang kita perlukan, kita memerlukan MAC address dari guest instance yang kita gunakan.

Kita memerlukan nama dari guest instance.

<pre>
$ <b>sudo virsh list --all</b>
</pre>

```
 Id   Name                State
------------------------------------
 -    ubuntu18.04         shut off
 -    ubuntu18.04-clone   shut off

```

Nah, dari hasil di atas, saya memiliki dua buah guest instance.

Misal, saya ingin mengkonfigurasi IP address static pada keduanya.

Maka, kita perlu mengambil dan mencata kedua MAC address dari kedua guest instance tersebut.

Cara untuk mendapatkan MAC address dari guest instance,

<pre>
$ <b>sudo virsh dumpxml <mark>ubuntu18.04</mark> | grep -i '<mac'</b>
</pre>

<pre>
      &lt;mac address='<b>52:54:00:c0:95:43</b>'/&gt;
</pre>

<pre>
$ <b>sudo virsh dumpxml <mark>ubuntu18.04-clone</mark> | grep -i '<mac'</b>
</pre>

<pre>
      &lt;mac address='<b>52:54:00:ef:b7:15</b>'/&gt;
</pre>

Catat dan simpan kedua MAC address dari kedua guest instance tersebut.

## 3. Edit Virtual Network XML

Nah, pada tahap ini, kita akan melakukan pendefinisian IP address static kepada kedua guest instance yang kita punya di dalam file konfigurasi XML dari virtual network **default**.

Kalau ingin melihat konfigurasi dari network **default** ini, kita dapat menggunakan perintah berikut.

<pre>
$ <b>sudo virsh net-edit default</b>
</pre>

{% highlight_caption %}
{% highlight xml linenos %}
<network>
  <name>default</name>
  <uuid>6115b620-438d-44ad-9215-ce3ca396a890</uuid>
  <forward mode='nat'>
    <nat>
      <port start='1024' end='65535'/>
    </nat>
  </forward>
  <bridge name='virbr0' stp='on' delay='0'/>
  <mac address='52:54:00:f6:8e:3d'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
      <host mac='52:54:00:c0:95:43' name='ubuntu18.04' ip='192.168.122.101'/>
      <host mac='52:54:00:ef:b7:15' name='ubuntu18.04-clone' ip='192.168.122.102'/>
    </dhcp>
  </ip>
</network>
{% endhighlight %}

Pada baris ke 14 & 15, saya menambahkan konfigurasi IP address static untuk kedua guest instance di dalam tag `<dhcp>...</dhcp>`. tepat di bawah tag `<range>`.

```xml
<host mac='52:54:00:c0:95:43' name='ubuntu18.04' ip='192.168.122.101'/>
<host mac='52:54:00:ef:b7:15' name='ubuntu18.04-clone' ip='192.168.122.102'/>
```

<!-- INFORMATION -->
<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>Perintah <code>net-edit</code> akan secara otomatis menggunakan <b>vi</b> text editor.</p>
<p>Apabila teman-teman tidak memiliki <b>vi</b>, teman-teman dapat menggunakan <b>nano</b> atau <b>vim</b>.</p>
<pre>
$ <b>sudo EDITOR=nano virsh net-edit default</b>
</pre>
<pre>
$ <b>sudo EDITOR=vim virsh net-edit default</b>
</pre>
</div>

Kemudian simpan.

Untuk melihat hasilnya, kita dapat menggunakan perintah di bawah.

<pre>
$ <b>sudo virsh net-dumpxml default</b>
</pre>

{% highlight_caption %}
{% highlight xml linenos %}
<network>
  <name>default</name>
  <uuid>6115b620-438d-44ad-9215-ce3ca396a890</uuid>
  <forward mode='nat'>
    <nat>
      <port start='1024' end='65535'/>
    </nat>
  </forward>
  <bridge name='virbr0' stp='on' delay='0'/>
  <mac address='52:54:00:f6:8e:3d'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
      <host mac='52:54:00:c0:95:43' name='ubuntu18.04' ip='192.168.122.101'/>
      <host mac='52:54:00:ef:b7:15' name='ubuntu18.04-clone' ip='192.168.122.102'/>
    </dhcp>
  </ip>
</network>
{% endhighlight %}

Apabila sudah terdapat konfigurasi yang kita tambahkan tadi, artinya kita sudah berhasil.

## 4. Restart DHCP Service

Karena konfigurasi IP address di virtual network ini dihandle oleh DHCP server, kita perlu me-reset ulang untuk mengaktifkan konfigurasi yang baru saja kita tambahkan.

<pre>
$ <b>sudo virsh net-destroy default</b>
</pre>

```
Network default destroyed

```

Kemudian, jalankan kembali virtual network nya.

<pre>
$ <b>sudo virsh net-start default</b>
</pre>

```
Network default started

```

## 5. Restart libvirtd.service

Restart <b>libvirtd.service</b>.

<pre>
$ <b>sudo systemctl restart libvirtd.service</b>
</pre>

## 6. ReOpen The Stage

Kalau teman-teman menggunakan Virtual Machine Manager, harus exit dan buka kembali.

Kalau teman-teman yang tidak menggunakan Virtual Machine Manager, tinggal langsung jalakan saja.

<pre>
$ <b>sudo virsh start ubuntu18.04-clone</b>
</pre>

```
Domain ubuntu18.04-clone started

```

Kemudian check statusnya.

<pre>
$ <b>sudo virsh list --all</b>
</pre>

<pre>
 Id   Name                State
------------------------------------
<b> 1    ubuntu18.04-clone   running</b>
 -    ubuntu18.04         shut off

</pre>

Nah, sudah running.

Coba ping dulu IP address dari guest instance,

<pre>
$ <b>ping -c 3 192.168.122.102</b>
</pre>

```
PING 192.168.122.102 (192.168.122.102) 56(84) bytes of data.
64 bytes from 192.168.122.102: icmp_seq=1 ttl=64 time=0.332 ms
64 bytes from 192.168.122.102: icmp_seq=2 ttl=64 time=0.290 ms
64 bytes from 192.168.122.102: icmp_seq=3 ttl=64 time=0.258 ms

--- 192.168.122.102 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2023ms
rtt min/avg/max/mdev = 0.258/0.293/0.332/0.030 ms
```

Selanjutnya, tinggal ssh session ke guest instance tersebut.

<pre>
$ <b>ssh deploy@192.168.122.102</b>
</pre>

<pre>
Welcome to Ubuntu 18.04.4 LTS (GNU/Linux 4.15.0-111-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

 System information disabled due to load higher than 1.0


2 packages can be updated.
0 updates are security updates.


Last login: Sun Jul 19 02:46:17 2020 from 192.168.122.1
<b>deploy@ubuntu:~$</b> _
</pre>

Kalau mau matikan tinggal jalanin.

<pre>
$ <b>sudo virsh shutdown ubuntu18.04-clone</b>
</pre>

```
Domain ubuntu18.04-clone is being shutdown

```





Selesai!!!

Saya rasa hanya ini yang dapat saya tuliskan saat ini.

Mudah-mudahan dapat bermanfaat untuk teman-teman.

Terima kasih.

(^_^)








# Referensi


1. [KVM libvirt assign static guest IP addresses using DHCP on the virtual machine](https://www.cyberciti.biz/faq/linux-kvm-libvirt-dnsmasq-dhcp-static-ip-address-configuration-for-guest-os/){:target="_blank"}
<br>Diakses tanggal: 2020/07/19

2. [20.36. Displaying Per-guest Virtual Machine Information](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/sect-managing_guest_virtual_machines_with_virsh-displaying_per_guest_virtual_machine_information){:target="_blank"}
<br>Diakses tanggal: 2020/07/19

3. [14.22.6. Editing a Virtual Network's XML Configuration File](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/virtualization_administration_guide/sub-sect-virtual_networking_commands-eding_a_virtual_networks_xml_configuration_file){:target="_blank"}
<br>Diakses tanggal: 2020/07/19

4. [libvirt - 2.61. net-edit](https://libvirt.org/sources/virshcmdref/html/sect-net-edit.html){:target="_blank"}
<br>Diakses tanggal: 2020/07/19
