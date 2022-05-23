---
layout: 'post'
title: "Bluetooth Headset Battery Status"
date: 2022-05-23 20:49
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
description: "Selama menggunakan Bluetooth Headset di Linux, saya tidak mengetahui berapa persentase battery yang tersisa. Ternyata kita perlu mengaktifkan flag experimental pada bluetoothd service agar status bluetooth headset battery dapat dibaca oleh UPower API"
---

# Pendahuluan

Selama menggunakan Bluetooth Headset di Linux, saya tidak mengetahui berapa persentase battery yang tersisa. Ternyata kita perlu mengaktifkan flag experimental pada bluetoothd service agar status bluetooth headset battery dapat dibaca oleh UPower API

Coba jalankan `upwer -e` dan lihat ada device apa saja yang tersedia.

{% shell_user %}
upower -e
{% endshell_user %}

```
/org/freedesktop/UPower/devices/line_power_AC
/org/freedesktop/UPower/devices/battery_BAT0
/org/freedesktop/UPower/devices/battery_BAT1
/org/freedesktop/UPower/devices/DisplayDevice
```

Pada hasil di atas, kita dapat melihat, hanya terdapat battery laptop, line power dan dispay. Tidak terdapat bluetooth device.

Pada catatan kali ini, kita akan meng-enable-kan fitur experimental agar Bluez memberikan Battery Power API.

# Disclaimer

{% box_perhatian %}
<p markdown=1>Catatan ini saya kerjakan pada distribusi Arch Linux. Mungkin akan sedikit berbeda dengan distribusi yang lain.</p>
{% endbox_perhatian %}

# Tahapan

## Copy file bluetooth.service dari /usr/lib/systemd/ ke /etc/systemd/

Secara default, file **bluetooth.service** apabila dijalankan, lokasinya diambil dari  **/usr/lib/systemd/**.

Kita akan pindahkan ke dalam direktori **/etc/systemd/**.

{% shell_user %}
sudo cp /usr/lib/systemd/system/bluetooth.service /etc/systemd/system/
{% endshell_user %}

## Tambahkan flag -E pada pemanggilan bluetoothd service

Secara default, bluetoothd sevice yang dijalankan pada file bluetooth.service tidak menggunakan flag apapun.

{% highlight_caption /etc/systemd/system/bluetooth.service %}
{% highlight bash linenos %}
[Service]
...
ExecStart=/usr/lib/bluetooth/bluetoothd
...
{% endhighlight %}

Kita akan menambahkan flag **-E** yang berarti **Experimental**.

Saya akan menggunakan `sed` agar lebih praktis

{% shell_user %}
sudo sed -i -r 's/ExecStart=.+/& -E/' /etc/systemd/system/bluetooth.service
{% endshell_user %}

Perintah `sed` di atas akan menambahkan flag `-E` pada pemanggilan library bluetoothd.

{% highlight_caption /etc/systemd/system/bluetooth.service %}
{% highlight bash linenos %}
[Service]
...
ExecStart=/usr/lib/bluetooth/bluetoothd -E
...
{% endhighlight %}

## Lakukan Daemon Reload

Prosedur standar yang dilakukan setiap mengubah file service, adalah dengan melakukan daemon reload.

{% shell_user %}
sudo systemctl daemon-reload
{% endshell_user %}

## Restart bluetooth.service

Setelah itu, restart bluetooth.service.

{% shell_user %}
sudo systemctl restart bluetooth
{% endshell_user %}

# Hasilnya

Sekarang coba kembali jalankan,

{% shell_user %}
upower -e
{% endshell_user %}

```
/org/freedesktop/UPower/devices/line_power_AC
/org/freedesktop/UPower/devices/battery_BAT0
/org/freedesktop/UPower/devices/battery_BAT1
/org/freedesktop/UPower/devices/headset_dev_00_00_00_00_00_00
/org/freedesktop/UPower/devices/DisplayDevice
```

Atau untuk melihat detailnya,

{% shell_user %}
upower -i `upower -e | grep '/org/freedesktop/UPower/devices/headset_dev_00_00_00_00_00_00'`
{% endshell_user %}

```
  native-path:          /org/bluez/hci0/dev_00_00_00_00_00_00
  model:                MBH20
  serial:               00:00:00:00:00:00
  power supply:         no
  updated:              Mon 23 May 2022 08:34:20 PM WITA (11117 seconds ago)
  has history:          yes
  has statistics:       no
  headset
    warning-level:       none
    percentage:          60%
    icon-name:          'battery-missing-symbolic'
```

Nah! Sekarang, device bluetooth headset yang kita gunakan sudah terbaca di UPower.

Dapat dilihat terdapat Battery persentase dari Bluetooth Headset yang saya gunakan.

# Pesan Penulis

Penggunaan lebih lanjut saya serahkan pada imajinasi dan kreatifitas teman-teman.

Terima kasih sudah mampir yaa.

# Referensi

1. [https://stackoverflow.com/a/70460138/4862516](https://stackoverflow.com/a/70460138/4862516){:target="_blank"}
<br>Diakses tanggal: 2022/05/22
