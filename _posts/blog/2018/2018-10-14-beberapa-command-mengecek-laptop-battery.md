---
layout: 'post'
title: 'Beberapa Command untuk Mengecek Kondisi Battery Laptop pada GNU/Linux'
date: 2018-10-14 18:38
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Terminal']
pin:
hot:
contributors: []
resume:
---

<!-- BANNER OF THE POST -->
<img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="https://i.postimg.cc/TwdxFcR8/banner-post-21.png" onerror="imgError(this);" alt="banner">

# Prakata
Karena tidak memiliki PC dan keseharian saya menggunakan laptop dalam menyelesaikan pekerjaan, saya merasa butuh untuk mencatat beberapa hal penting terkait dengan perintah-perintah yang biasa digunakan untuk membantu menegakkan diagnosis dalam pemeriksaan kondisi laptop.

Karena kerterbatasan waktu, yang akan saya bahas terlebih dahulu dalam post ini adalah "**mengecek kondisi laptop battery**".

{% box_info %}
Sebagai informasi, laptop yang saya gunakan menggunakan dua buah <i>battery</i>, BAT0 (internal) dan BAT1 (eksternal).
<br>
<br>
Untuk teman-teman yang hanya memiliki satu buah <i>battery</i>, biasanya memiliki kode device BAT0.
{% endbox_info %}

# Perintah-perintah

## upower
Perintah **Upower** pada Terminal hampir sudah terdapat pada sebagian besar distribusi sistem operasi GNU/Linux.

{% shell_user %}
upower -i /org/freedesktop/UPower/devices/battery_BAT0
{% endshell_user %}

```
native-path:           BAT0
vendor:                SONY
model:                 45N1111
serial:                14768
power supply:          yes
updated:               Fri 26 Oct 2018 10:45:16 PM WITA (16 seconds ago)
has history:           yes
has statistics:        yes
battery
  present:             yes
  rechargeable:        yes
  state:               discharging
  warning-level:       none
  energy:              19.89 Wh
  energy-empty:        0 Wh
  energy-full:         22.97 Wh
  energy-full-design:  23.2 Wh
  energy-rate:         0 W
  voltage:             12.234 V
  percentage:          86%
  capacity:            99.0086%
  technology:          lithium-polymer
  icon-name:          'battery-full-symbolic'
```

Apabila perintah di atas tidak bekerja karena alasan tertentu, kalian dapat melakukan perintah di bawah.

{% shell_user %}
upower -i `upower -e | grep 'BAT'`
{% endshell_user %}

Maka, akan menampilkan hasil yang sama.

Untuk penjelasan lebih lengkap dapat melihat pada manual dari `upower`.

{% shell_user %}
man upower
{% endshell_user %}

## acpi

Perintah selanjutnya adalah `acpi`. Perintah ini, selain digunakan untuk melihat status dari *battery* juga dapat kita melihat informasi lain yang diberikan oleh ACPI.

Untuk dapat menggunakan perintah ini, mungkin kalian perlu menginstal paket bernama `acpi` terlebih dahulu.

{% shell_user %}
sudo pacman -S acpi
{% endshell_user %}

\*sesuaikan dengan distribusi GNU/Linux kalian

Setelah `acpi` berhasil dipasang, coba jalankan perintah di bawah, untuk melihat informasi setiap devices yang diberikan oleh ACPI.

{% shell_user %}
acpi -V
{% endshell_user %}

```
Battery 0: Unknown, 86%
Battery 0: design capacity 1896 mAh, last full capacity 1878 mAh = 99%
Battery 1: Discharging, 87%, 02:34:43 remaining
Battery 1: design capacity 1945 mAh, last full capacity 1480 mAh = 76%
Adapter 0: off-line
Thermal 0: ok, 47.0 degrees C
Thermal 0: trip point 0 switches to mode critical at temperature 128.0 degrees C
Cooling 0: Processor 0 of 10
Cooling 1: iwlwifi 0 of 19
Cooling 2: Processor 0 of 10
Cooling 3: pch_skylake no state information available
Cooling 4: Processor 0 of 10
Cooling 5: iwlwifi no state information available
Cooling 6: intel_powerclamp no state information available
Cooling 7: Processor 0 of 10
Cooling 8: x86_pkg_temp no state information available
```

Dapat terlihat hasil informasi yang diberikan oleh ACPI seperti yang ditampilkan di atas.

Untuk melihat hanya status dari *battery* saja, gunakan hanya perintah `acpi`.

{% shell_user %}
acpi
{% endshell_user %}

```
Battery 0: Unknown, 86%
Battery 1: Discharging, 74%, 02:24:03 remaining
```

Untuk mendapatkan temperatur dari *battery*.

{% shell_user %}
acpi -t
{% endshell_user %}

```
Thermal 0: ok, 44.0 degrees C
```

Untuk mengetahui apakah *ac power* terkoneksi atau tidak.

{% shell_user %}
acpi -a
{% endshell_user %}

Jika terhubung dengan *ac power*.

```
Adapter 0: on-line
```

Namun, saat ini laptop saya sedang tidak terhubung dengan *ac power*.

```
Adapter 0: off-line
```

Kira-kira seperti ini cara pemanfaatan menggunakan perintah `acpi`. Untuk detail yang lebih lengkap, dapat dibaca sendiri di manual.

{% shell_user %}
man acpi
{% endshell_user %}

## tlp-stat

Apabila teman-teman ada yang menggunakan `tlp` sebagai manajemen power pada laptopnya, dapat menggunakan `tlp-stat` untuk melihat sistem informasi dari laptop yang kita gunakan.

{% shell_user %}
sudo tlp-stat -h
{% endshell_user %}

```
Usage: tlp-stat [ -b | --battery   | -c | --config    |
                  -d | --disk      | -e | --pcie      |
                  -g | --graphics  | -p | --processor |
                  -r | --rfkill    | -s | --system    |
                  -t | --temp      | -u | --usb       |
                  -w | --warn      | -v | --verbose   |
                  -P | --pev       |    | --psup      |
                  -T | --trace ]
```

Saya biasa menggunakn `tlp-stat` untuk mengecek *battery*.

{% shell_user %}
sudo tlp-stat -b
{% endshell_user %}

```
--- TLP 1.1 --------------------------------------------

+++ ThinkPad Battery Features
tp-smapi   = inactive (unsupported hardware)
tpacpi-bat = active

+++ ThinkPad Battery Status: BAT0 (Main / Internal)
/sys/class/power_supply/BAT0/manufacturer                   = SONY
/sys/class/power_supply/BAT0/model_name                     = 45N1111
/sys/class/power_supply/BAT0/cycle_count                    = (not supported)
/sys/class/power_supply/BAT0/energy_full_design             =  23200 [mWh]
/sys/class/power_supply/BAT0/energy_full                    =  22970 [mWh]
/sys/class/power_supply/BAT0/energy_now                     =  19840 [mWh]
/sys/class/power_supply/BAT0/power_now                      =      0 [mW]
/sys/class/power_supply/BAT0/status                         = Unknown (threshold effective)

tpacpi-bat.BAT0.startThreshold                              =     70 [%]
tpacpi-bat.BAT0.stopThreshold                               =     90 [%]
tpacpi-bat.BAT0.forceDischarge                              =      0

Charge                                                      =   86.4 [%]
Capacity                                                    =   99.0 [%]

+++ ThinkPad Battery Status: BAT1 (Ultrabay / Slice / Replaceable)
/sys/class/power_supply/BAT1/manufacturer                   = SANYO
/sys/class/power_supply/BAT1/model_name                     = 45N1775
/sys/class/power_supply/BAT1/cycle_count                    = (not supported)
/sys/class/power_supply/BAT1/energy_full_design             =  23200 [mWh]
/sys/class/power_supply/BAT1/energy_full                    =  17650 [mWh]
/sys/class/power_supply/BAT1/energy_now                     =   7800 [mWh]
/sys/class/power_supply/BAT1/power_now                      =   5826 [mW]
/sys/class/power_supply/BAT1/status                         = Discharging

tpacpi-bat.BAT1.startThreshold                              =     70 [%]
tpacpi-bat.BAT1.stopThreshold                               =     90 [%]
tpacpi-bat.BAT1.forceDischarge                              =      0

Charge                                                      =   44.2 [%]
Capacity                                                    =   76.1 [%]

+++ Charge total                                            =   68.0 [%]
```

Nah, dengan demikian, hanya seperti ini dulu catatan saya mengenai perintah-perintah yang biasa saya gunakan untuk melakukan pengecekan terhadap status *battery* laptop saya.

Semoga bermanfaat buat yang membutuhkan.

# Referensi
1. [ostechnix.com/how-to-check-laptop-battery-status-in-terminal-in-linux/](https://www.ostechnix.com/how-to-check-laptop-battery-status-in-terminal-in-linux/){:target="_blank"}
<br>Diakses tanggal: 2018/10/17
