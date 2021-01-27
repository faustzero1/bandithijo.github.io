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
resume: "Bluetoothctl adalah interaktif shell yang dapat kita gunakan untuk berinteraksi dengan bluetooth device tanpa perlu menggunakan GUI tool seperti Blueman Manager atau Blueman applet (trayicon). Cukup dengan bermodalkan Terminal, kita dapat melakukan power on, scan on, pairing, connecting dan disconnecting."
---

# Latar Belakang

Selama ini saya masih menggunakan Blueman Manager untuk mengurusi hal-hal terkait bluetooth.

Satu-satunya bluetooth device yang saya gunakan adalah headset bluetooth yang jarang sekali saya pergunakan.

Karena jarang digunakan, maka ketika harus berurusan dengannya, saya memilih untuk gak ribet-ribet untuk mencoba workflow baru. Maka, saya gunakan Blueman Manager saja yang praktis.


# Terminologi

Kita samakan persepsi dulu yaa, agar teman-teman mudah memahami istilah-istilah yang ada dalam catatan ini.

**Bluetooth Controller**, adalah perangkah bluetooth yang berada di laptop/komputer kita.

**Bluetooth Device**, adalah perangkat bluetooth yang akan dihubungkan dengan bluetooth controller, seperti Bluetooth Headset, Bluetooth Keyboard, Blutooth Speaker, Smartphone, dll.


# Apa itu bluetoothctl?

Bluetoothctl adalah tools yang dapat kita pergunakan untuk melakukan pairing a device from the shell.

# Cara Penggunaan

## Nyalakan bluetoothd service

**systemd**

{% shell_cmd $ %}
sudo systemctl start bluetoothd.service
{% endshell_cmd %}

**OpenRC**

{% shell_cmd $ %}
sudo rc-service bluetoothd start
{% endshell_cmd %}

<br>
Pastikan **bluetoothd** service sudah dalam status aktif.


## Periksa Bluetooth Controller

Biasanya, kalau kita memiliki satu buah bluetooth controller, maka akan bernama **hci0**.

Periksa dengan peritah,

{% shell_cmd $ %}
hciconfig -a
{% endshell_cmd %}

<pre>
hci0:   Type: Primary  Bus: USB
        BD Address: 00:1C:26:D8:E0:18  ACL MTU: 1017:8  SCO MTU: 64:8
        DOWN
        RX bytes:488 acl:0 sco:0 events:20 errors:0
        TX bytes:82 acl:0 sco:0 commands:20 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
</pre>

Dapat terlihat, di laptop saya, terdapat Bluetooth Controller.

Namun, statusnya masih DOWN (bukan OFF).

Untuk dapat menggunakannya, kita perlu menjalankan langkah-langkah di bawah.



## Masuk bluetoothctl shell

Untuk mengakses bluetoothctl shell, cukup jalankan perintah di Termial:

{% shell_cmd $ %}
bluetoothctl
{% endshell_cmd %}

Kita akan dibawa ke dalam bluetoothctl shell, ditandai dengan prompt seperti ini:

{% shell_cmd [bluetooth]# %}
_
{% endshell_cmd %}

<br>
Gunakan perintah **help** untuk melihat perintah apa saja yang tersedia.

{% shell_cmd [bluetooth]# %}
help
{% endshell_cmd %}

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

{% shell_cmd [bluetooth]# %}
list
{% endshell_cmd %}

Hasilnya, kira-kira seperti ini.

<pre>
Controller 00:1C:26:D8:E0:18 BlueZ 5.55 [default]
</pre>

Saya hanya memiliki satu buat bluetooth controller yang terpasang secara built-in di laptop saya.

Apabila terdapat lebih dari satu bluetooth controller, kalian harus memilih salah satu yang akan digunakan untuk menghubungkan dengan perangkat lain.

{% shell_cmd [bluetooth]# %}
select 00:1C:26:D8:E0:18
{% endshell_cmd %}

## Melihat Detail dari Controller

Untuk melihat detail dari controller yang dipilih, gunakan perintah:

{% shell_cmd [bluetooth]# %}
show 00:1C:26:D8:E0:18
{% endshell_cmd %}

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

{% shell_cmd [bluetooth]# %}
power on
{% endshell_cmd %}

Perintah di atas akan menyalakan controller yang kita set sebagai default dengan perintah **select**.


{% box_info %}
<p>Pada tahap ini, kalau teman-teman buka Terminal lain dan mejalankan,</p>
{% shell_cmd $ %}
hciconfig -a
{% endshell_cmd %}
<p markdown=1>Maka, status yang tadinya **DOWN**, sudah berubah menjadi UP **RUNNING PSCAN**.</p>
<pre>
hci0:   Type: Primary  Bus: USB
        BD Address: 00:1C:26:D8:E0:18  ACL MTU: 1017:8  SCO MTU: 64:8
        UP RUNNING PSCAN
        RX bytes:1277 acl:0 sco:0 events:47 errors:0
        TX bytes:438 acl:0 sco:0 commands:47 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ 5.55'
        Class: 0x2c010c
        Service Classes: Rendering, Capturing, Audio
        Device Class: Computer, Laptop
        HCI Version: 2.0 (0x3)  Revision: 0x212b
        LMP Version: 2.0 (0x3)  Subversion: 0x41d3
        Manufacturer: Broadcom Corporation (15)
</pre>
<p markdown=1>\*Perintah di atas, dijalankan di luar dari bluetoothctl.</p>
{% endbox_info %}


## Scanning Perangkat Bluetooth yang Lain

Untuk melakukan scanning terhadap perangkat bluetooth yang lain,

{% shell_cmd [bluetooth]# %}
scan on
{% endshell_cmd %}

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

{% shell_cmd [bluetooth]# %}
pair 44:D4:E0:EF:94:DD
{% endshell_cmd %}

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

{% shell_cmd [bluetooth]# %}
connect 44:D4:E0:EF:94:DD
{% endshell_cmd %}

<pre>
Attempting to connect to 44:D4:E0:EF:94:DD
[CHG] Device 44:D4:E0:EF:94:DD Connected: yes
Connection successful
[CHG] Device 44:D4:E0:EF:94:DD ServicesResolved: yes
</pre>

Nah, sudah berhasil terhubung.

Ciri-cirinya adalah prompt akan berubah mengikuti nama device.

{% shell_cmd [MBH20]# %}
_
{% endshell_cmd %}

<br>
Kita bisa lihat keterangan tentang device ini.

{% shell_cmd [MBH20]# %}
info
{% endshell_cmd %}

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

{% shell_cmd [bluetooth]# %}
trust 44:D4:E0:EF:94:DD
{% endshell_cmd %}

<pre>
[CHG] Device 44:D4:E0:EF:94:DD Trusted: yes
Changing 44:D4:E0:EF:94:DD trust succeeded
</pre>


## Disconnect

Untuk memutuskan hubungan dengan device yang terhubung,

{% shell_cmd [bluetooth]# %}
disconnect 44:D4:E0:EF:94:DD
{% endshell_cmd %}

<pre>
Attempting to disconnect from 44:D4:E0:EF:94:DD
[CHG] Device 44:D4:E0:EF:94:DD ServicesResolved: no
Successful disconnected
[CHG] Device 44:D4:E0:EF:94:DD Connected: no
</pre>

Prompt akan kembali ke semula

{% shell_cmd [bluetooth]# %}
_
{% endshell_cmd %}


## Melihat Daftar Paired Devices

Untuk melihat daftar device yang sudah kita pair.

{% shell_cmd [bluetooth]# %}
paired-devices
{% endshell_cmd %}

<pre>
Device 44:D4:E0:EF:94:DD MBH20
</pre>

Kebetulan saya hanya memiliki satu device saja.


## Menghapus Paired Device

Untuk menghapus device yang sudah pernah kita pair,

{% shell_cmd [bluetooth]# %}
remove 44:D4:E0:EF:94:DD
{% endshell_cmd %}

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
