---
layout: 'post'
title: "Mudah Menggunakan Bluetoothctl"
date: 2021-01-13 15:28
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

Selama ini saya masih menggunakan Blueman Manager untuk mengurusi hal-hal terkait bluetooth.

Satu-satunya bluetooth device yang saya gunakan adalah headset bluetooth yang jarang sekali saya pergunakan.

Karena jarang digunakan, maka ketika harus berurusan dengannya, saya memilih untuk gak ribet-ribet untuk mencoba workflow baru. Maka, saya gunakan Blueman Manager saja yang praktis.

# Apa itu bluetoothctl?

Bluetoothctl adalah tools yang dapat kita pergunakan untuk melakukan pairing a device from the shell.

# Cara Penggunaan

## Nyalakan bluetoothd service

**systemd**

{% shell_user %}
sudo systemctl start bluetoothd.service
{% endshell_user %}

**OpenRC**

{% shell_user %}
sudo rc-service bluetoothd start
{% endshell_user %}

<br>
Pastikan **bluetoothd** service sudah salam status aktif.


## Masuk bluetoothctl shell

Untuk mengakses bluetoothctl shell, cukup jalankan perintah di Termial:

{% shell_user %}
bluetoothctl
{% endshell_user %}

Kita akan dibawa ke dalam bluetoothctl shell, ditandai dengan prompt seperti ini:

<pre>
[bluetooth]# _
</pre>

<br>
Gunakan perintah **help** untuk melihat perintah apa saja yang tersedia.

<pre>
<span class="cmd">[bluetooth]# </span><b>help</b>
</pre>

<pre>
Menu main:
Available commands:
-------------------
advertise                                         Advertise Options Submenu
scan                                              Scan Options Submenu
gatt                                              Generic Attribute Submenu
list                                              List available controllers
show [ctrl]                                       Controller information
select &lt;ctrl>                                     Select default controller
devices                                           List available devices
paired-devices                                    List paired devices
system-alias &lt;name>                               Set controller alias
reset-alias                                       Reset controller alias
power &lt;on/off>                                    Set controller power
pairable &lt;on/off>                                 Set controller pairable mode
discoverable &lt;on/off>                             Set controller discoverable mode
discoverable-timeout [value]                      Set discoverable timeout
agent &lt;on/off/capability>                         Enable/disable agent with given capability
default-agent                                     Set agent as the default one
advertise &lt;on/off/type>                           Enable/disable advertising with given type
set-alias &lt;alias>                                 Set device alias
scan &lt;on/off>                                     Scan for devices
info [dev]                                        Device information
pair [dev]                                        Pair with device
cancel-pairing [dev]                              Cancel pairing with device
trust [dev]                                       Trust device
untrust [dev]                                     Untrust device
block [dev]                                       Block device
unblock [dev]                                     Unblock device
remove &lt;dev>                                      Remove device
connect &lt;dev>                                     Connect device
disconnect [dev]                                  Disconnect device
menu &lt;name>                                       Select submenu
version                                           Display version
quit                                              Quit program
exit                                              Quit program
help                                              Display help about this program
export                                            Print environment variables
</pre>

## Pilih Controller

Untuk melihat daftar bluetooth controller yang tersedia:

<pre>
<span class="cmd">[bluetooth]# </span><b>list</b>
</pre>

Hasilnya, kira-kira seperti ini.

<pre>
Controller 00:1C:26:D8:E0:18 BlueZ 5.55 [default]
</pre>

Saya hanya memiliki satu buat bluetooth controller yang terpasang secara built-in di laptop saya.

Apabila terdapat lebih dari satu bluetooth controller, kalian harus memilih salah satu yang akan digunakan untuk menghubungkan dengan perangkat lain.

<pre>
<span class="cmd">[bluetooth]# </span><b>select 00:1C:26:D8:E0:18</b>
</pre>

## Melihat Detail dari Controller

Untuk melihat detail dari controller yang dipilih, gunakan perintah:

<pre>
<span class="cmd">[bluetooth]# </span><b>show 00:1C:26:D8:E0:18</b>
</pre>

<pre>
Controller 00:1C:26:D8:E0:18 (public)
        Name: BlueZ 5.55
        Alias: BlueZ 5.55
        Class: 0x003c010c
        Powered: yes
        Discoverable: no
        DiscoverableTimeout: 0x0000003c
        Pairable: yes
        UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
        UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
        UUID: Message Access Server     (00001132-0000-1000-8000-00805f9b34fb)
        UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
        UUID: Message Notification Se.. (00001133-0000-1000-8000-00805f9b34fb)
        UUID: Phonebook Access Server   (0000112f-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
        UUID: OBEX Object Push          (00001105-0000-1000-8000-00805f9b34fb)
        UUID: IrMC Sync                 (00001104-0000-1000-8000-00805f9b34fb)
        UUID: OBEX File Transfer        (00001106-0000-1000-8000-00805f9b34fb)
        UUID: Vendor specific           (00005005-0000-1000-8000-0002ee000001)
        UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
        UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
        UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
        Modalias: usb:v1D6Bp0246d0537
        Discovering: no
</pre>

Kalau, status **Powered: no**, bisa kita nyalakan dulu.

<pre>
<span class="cmd">[bluetooth]# </span><b>power on</b>
</pre>

Perintah di atas akan menyalakan controller yang kita set sebagai default dengan perintah **select**.

## Scanning Perangkat Bluetooth yang Lain

Untuk melakukan scanning terhadap perangkat bluetooth yang lain,

<pre>
<span class="cmd">[bluetooth]# </span><b>scan on</b>
</pre>

<pre>
Discovery started
[CHG] Controller 00:1C:26:D8:E0:18 Discovering: yes
</pre>

Nah, kalau outptunya seperti di atas, artinya bluetooth controller kita sedang mencari ~~jodoh~~ perangkat bluetooth yang lain.

Kalau ketemu, nanti akan seperti ini outputnya.

<pre>
Discovery started
[CHG] Controller 00:1C:26:D8:E0:18 Discovering: yes
[NEW] Device 44:D4:E0:EF:94:DD MBH20
</pre>

Dapat dilihat, bahwa ada perangkat bluetooth bernama **MBH20** yang terdeteksi oleh bluetooth controller kita.


## Pairing dengan Perangkat Lain

Kalau sudah terdeteksi, tinggal kita pairing saja.

<pre>
<span class="cmd">[bluetooth]# </span><b>pair 44:D4:E0:EF:94:DD</b>
</pre>

<pre>
Attempting to pair with 44:D4:E0:EF:94:DD
[CHG] Device 44:D4:E0:EF:94:DD Connected: yes
[CHG] Device 44:D4:E0:EF:94:DD UUIDs: 00001108-0000-1000-8000-00805f9b34fb
[CHG] Device 44:D4:E0:EF:94:DD UUIDs: 0000110b-0000-1000-8000-00805f9b34fb
[CHG] Device 44:D4:E0:EF:94:DD UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
[CHG] Device 44:D4:E0:EF:94:DD UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
[CHG] Device 44:D4:E0:EF:94:DD UUIDs: 0000111e-0000-1000-8000-00805f9b34fb
[CHG] Device 44:D4:E0:EF:94:DD ServicesResolved: yes
[CHG] Device 44:D4:E0:EF:94:DD Paired: yes
Pairing successful
[CHG] Device 44:D4:E0:EF:94:DD ServicesResolved: no
[CHG] Device 44:D4:E0:EF:94:DD Connected: no
</pre>

Nah, pairing successfull.

Status **Paired: yes**, namun **Connected: no**.

## Connect dengan Paired Device

Kalau sudah dipairing, sekarang kita bisa hubungkan.

<pre>
<span class="cmd">[bluetooth]# </span><b>connect 44:D4:E0:EF:94:DD</b>
</pre>

<pre>
Attempting to connect to 44:D4:E0:EF:94:DD
[CHG] Device 44:D4:E0:EF:94:DD Connected: yes
Connection successful
[CHG] Device 44:D4:E0:EF:94:DD ServicesResolved: yes
</pre>

Nah, sudah berhasil terhubung.

Ciri-cirinya adalah prompt akan berubah mengikuti nama device.

<pre>
[MBH20]# _
</pre>

<br>
Kita bisa lihat keterangan tentang device ini.


<pre>
<span class="cmd">[MBH20]# </span><b>info</b>
</pre>

<pre>
Device 44:D4:E0:EF:94:DD (public)
        Name: MBH20
        Alias: MBH20
        Class: 0x00240404
        Icon: audio-card
        Paired: yes
        Trusted: no
        Blocked: no
        Connected: yes
        LegacyPairing: yes
        UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
        UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
        UUID: Handsfree                 (0000111e-0000-1000-8000-00805f9b34fb)
        RSSI: -38
</pre>

Kalau ingin ditrust, tinggal jalankan perintah trust saja.

<pre>
<span class="cmd">[bluetooth]# </span><b>trust 44:D4:E0:EF:94:DD</b>
</pre>

<pre>
[CHG] Device 44:D4:E0:EF:94:DD Trusted: yes
Changing 44:D4:E0:EF:94:DD trust succeeded
</pre>


## Disconnect

Untuk memutuskan hubungan dengan device yang terhubung,

<pre>
<span class="cmd">[bluetooth]# </span><b>disconnect 44:D4:E0:EF:94:DD</b>
</pre>

<pre>
Attempting to disconnect from 44:D4:E0:EF:94:DD
[CHG] Device 44:D4:E0:EF:94:DD ServicesResolved: no
Successful disconnected
[CHG] Device 44:D4:E0:EF:94:DD Connected: no
</pre>

Prompt akan kembali ke semula

<pre>
[bluetooth]# _
</pre>


## Melihat Daftar Paired Devices

Untuk melihat daftar device yang sudah kita pair.

<pre>
<span class="cmd">[bluetooth]# </span><b>paired-devices</b>
</pre>

<pre>
Device 44:D4:E0:EF:94:DD MBH20
</pre>

Kebetulan saya hanya memiliki satu device saja.


## Menghapus Paired Device

Untuk menghapus device yang sudah pernah kita pair,

<pre>
<span class="cmd">[bluetooth]# </span><b>remove 44:D4:E0:EF:94:DD</b>
</pre>

<pre>
[<span class="is-danger">DEL</span>] Device 44:D4:E0:EF:94:DD MBH20
Device has been removed
</pre>


# Demonstrasi

{% youtube Bxc3e6lnEUg %}








# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Masih banyak option-option lain yang tidak saya demokan pada catatan ini. Silahkan teman-teman coba sendiri yaa.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)




# Referensi

1. [wiki.archlinux.org/index.php/Bluetooth](https://wiki.archlinux.org/index.php/Bluetooth){:target="_blank"}
<br>Diakses tanggal: 2021/01/13
