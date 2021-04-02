---
layout: 'post'
title: "Catatan dalam Berinteraksi dengan VBoxManage"
date: 2021-04-02 18:38
permalink: '/note/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'note'
tags: ['Tips']
wip: true
pin:
contributors: []
description: "Hal-hal terkait command line memang sering terlupakan apabila tidak selalu digunakan. Catatan ini hadir untuk mempermudah teman-teman apabila sedang berkepentigan dengan vboxmanage."
---

# Prakata

VBoxManage adalah command line interface dari VirtualBox. Lengkapnya adalah "*Oracle VM VirtualBox Command Line Management Interface*".

# Melihat daftar VM

Untuk melihat daftar vm yang ada,

{% shell_cmd $ %}
VBoxManage list vms
{% endshell_cmd %}

Outputnya akan seperti ini,

<pre>
"RDPWindows" {34a99d7f-e482-4f6b-86ba-e827998213f2}
</pre>

**RDPWindows** adalah nama dari vm yang saya berikan ketika membuat vm.

**34a99d7f-e482-4f6b-86ba-e827998213f2** adalah UUID dari vm.

# Power On/Off VM

## Menjalankan vm secara headless mode

Untuk menjalankan vm tanpa membuka window display yang menampilkan tampilan layar dari vm biasanya diperlukan apabila hanya ingin menggunakan vm sebagai server. Biasanya diakses menggunakan SSH. Atau kalau ingin mengakses tampilan layar, dapat menggunakan protokol RDP.

Cara menjalankan vm dengan headless mode,

{% pre_url %}
$ VBoxManage startvm &lt;nama_vm&gt; --type headless
{% endpre_url %}

{% shell_cmd $ %}
VBoxManage startvm RDPWindows --type headless
{% endshell_cmd %}

Outputnya akan seperti ini,

<pre>
Waiting for VM "RDPWindows" to power on...
VM "RDPWindows" has been successfully started.
</pre>


## Mematikan vm

Saya tidak merekomendasikan mematikan vm dengan cara ini, karena sering sekali Windows vm saya masuk ke "Recovery Mode".

{% pre_url %}
$ VBoxManage controlvm &lt;nama_vm> poweroff
{% endpre_url %}

{% shell_cmd $ %}
VBoxManage controlvm RDPWindows poweroff
{% endshell_cmd %}


# Konektifitas USB Host -> Guest VM

## Mengecek daftar device yang terhubung dengan USB port

{% shell_cmd $ %}
VBoxManage list usbhost
{% endshell_cmd %}

Outputnya akan seperti ini,

<pre>
Host USB Devices:

UUID:               <mark>dcab5dcf-37c1-4718-962f-0e54ff7cc80c</mark>
VendorId:           0x0483 (0483)
ProductId:          0x2016 (2016)
Revision:           0.1 (0001)
Port:               1
USB version/speed:  1/Full
Manufacturer:       STMicroelectronics
Product:            Biometric Coprocessor
Address:            sysfs:/sys/devices/pci0000:00/0000:00:1a.0/usb3/3-2//device:/dev/vboxusb/003/002
Current State:      Available
</pre>

**UUID** dari perangkat tersebut yang akan kita gunakan.

**UUID** dari sebuah perangkat, akan berubah-ubah meskipun perangkatnya sama.

Untuk membuat UUID yang permanen, dapat menggunakan USB filter.

\* Lain waktu saya akan catatat cara membuat USB filter yaa.

## Memindahkan attached USB dari Host ke Guest vm

Untuk memindahkan perangkat USB yang terhubung dengan Host ke Guest vm.

{% pre_url %}
$ VBoxManage controlvm &lt;nama_vm> usbattach &lt;UUID>
{% endpre_url %}

{% shell_cmd $ %}
VBoxManage controlvm RDPWindows usbattach dcab5dcf-37c1-4718-962f-0e54ff7cc80c
{% endshell_cmd %}

Untuk melepasnya, tinggal "Safely Remove" saja. Meskipun, ada command untuk *detach* juga.












{% comment %}
# Referensi

1. [schier.co/blog/start-virtualbox-vm-in-headless-mode](https://schier.co/blog/start-virtualbox-vm-in-headless-mode){:target="_blank"}
2. [www.virtualbox.org/manual/ch08.html](https://www.virtualbox.org/manual/ch08.html){:target="_blank"}
3. [superuser.com/questions/1301873/virtualbox-switch-access-to-an-attached-usb-device-between-guest-and-host-from](https://superuser.com/questions/1301873/virtualbox-switch-access-to-an-attached-usb-device-between-guest-and-host-from){:target="_blank"}
{% endcomment %}
