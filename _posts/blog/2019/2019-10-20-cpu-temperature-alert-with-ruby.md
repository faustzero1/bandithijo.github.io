---
layout: 'post'
title: "Membuat CPU Temperature Alert dengan Ruby"
date: 2019-10-20 21:29
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Ruby']
pin:
hot:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Pendahuluan

Sejak sekitar Maret 2019, saya menggunakan ThinkPad X61. Laptop yang dirilis tahun 2007 silam ini, masih dapat saya pergunakan untuk menunjang pekerjaan saya sehari-hari, sebagai Junior Backend Rails Developer.

Sebelum ini, saya menggunakan ThinkPad X260. Saya memiliki dua buah ThinkPad seri X, X61 (2007) dan X260 (2016). Namun, karena istri saya memerlukan laptop untuk menunjang pekerjaannya, maka saya pun memilih untuk menggunakan ThinkPad X61.

Cukup banyak beberapa kendala yang menuntut saya untuk harus pintar-pintar dalam mengadaptasikan *workflow* saya dalam menggunakan sistem komputer. Tentunya tidak seleluasa menggunakan X260.

Karena X61 ini adalah laptop yang berumur, maka hal yang paling saya perhatikan sekali adalah temperatur dari CPU.

Saya sangat menjaga dan memperhatikan sekali proses-proses yang berjalan di atas sistem agar tidak memberatkan CPU terlalu lama.

Kalaupun perlu proses yang berat, saya ingin dapat memonitor temperatur dari CPU yang sedang aktif bekerja.

Karena seperti yang teman-teman ketahui, Intel processor memiliki sistem yang dapat mematikan mesin apabila suhu CPU sudah mencapai ambang batas (100°C).

Beberapa hari ini, sudah kira-kira 2 kali dalam sehari saya mengalami mati mendadak. Saya curiga karena temperatur CPu yang tidak saya jaga pada konidisi yang aman.

Hal ini juga disebabkan karena minimalnya sistem notifikasi dari sistem yang saya gunakan.

Atas dasar ini, saya berinisiatif untuk menambahkan fitur notifikasi suara apabila CPU sudah mencapai suhu tertentu.

Langsung saja saya tuliskan script ~~sederhana~~ cupu, yang saya tulis menggunakan bahasa Ruby.

# Script

```ruby
#!/usr/bin/env ruby

# Copyright (C) 2019 Rizqi Nur Assyaufi <bandithijo@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

Process.setproctitle("notify-hightemp")

require 'open3'

CPU_TEMP_THRESHOLD = 80  # <- Normaly 90-100
NOTIF_DURATION = 2.5     # <- Second
NOTIF_VOLUME = 5         # <- Range 0-10

def notif_volume_converter(value)
  volume_rate = value * 6553.6
end

while true
  capture_temp = "cat /proc/acpi/ibm/thermal | tail -c +15 | head -c +2"
  temp = Open3.capture2(capture_temp)
  temp_cpu = temp[0].to_i
  temp_threshold = CPU_TEMP_THRESHOLD
  notif_duration = (NOTIF_DURATION * 1000).to_i
  notif_volume = notif_volume_converter(NOTIF_VOLUME)

  if temp_cpu > temp_threshold
    system("notify-send 'High CPU Temperature''!' 'The CPU has been hard at work in the past minute.' --urgency=critical --expire-time=#{notif_duration}")
    system("paplay /home/bandithijo/snd/Ringtones/Alert/aircraftalarm.wav --volume=#{notif_volume}")
  end

  sleep(5)
end
```

Saya berinama file `notify-hightemp`.

Saya tidak menggunakan ekstensi `.rb` karena saya sudah mendefinisikan *SheBang* <mark>#!/usr/bin/env ruby</mark> dari file ini, agar sistem dapat mengenali bahwa saya ingin mengeksekusi file ini dengan Ruby intepreter.

Kemudian, berikan permission untuk execute.

```
$ chmod +x notify-hightemp.rb
```

Copykan ke direktori `/usr/bin/` untuk dieksekusi semua user atau `~/.local/bin/` untuk user kita saja.

Selanjutnya tinggal meletakkan pada autorun.

# Autorun

Bagian ini akan tergantung dari DE atau WM yang teman-teman pergunakan.

Karena saya menggunakan BSPWM, kira-kira seperti ini cara saya menambahkan script yang baru saja kita buat ini kedalam sistem autorun.

```
$ vim ~/.config/bspwm/autostart
```

```
#!/usr/bin/env sh

...
...

kill -9 $(pidof notify-hightemp); notify-hightemp &
```

Penambahakan `kill -9 $(pidof notify-hightemp)` bertujuan agar ketika saya merestart WM, script ini tidak dipanggil lagi. Namun, akan dikill terlebih dahulu, kemudian baru dijalankan kembali.

# Akhir Kata

Kira-kira seperti ini saja Ruby script yang ~~sederhana~~ cupu ini.

Mungkin dilain waktu, berdasarkan kebutuhan-kebutuhan tertentu, akan mulai ditambahkan fitur-fitur dan kemampuan dari script ini agar lebih mudah dan interaktif untuk digunakan.

Mudah-mudahan bermanfaat.

Terima kasih (^_^)v
