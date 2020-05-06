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

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/Cx6kK0qQ/gambar-01.png" onerror="imgError(this);"}
<p class="img-caption">Gambar 1 - Tampilan notifikasi Peringatan Hot CPU Temperature</p>

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

CPU_TEMP_THRESHOLD = 90  # <- Normaly 90-100
NOTIF_DURATION = 2.5     # <- Duration in second
NOTIF_VOLUME = 5         # <- Range between 0-10

def notif_volume_converter(value)
  volume_rate = value * 6553.6
end

begin
  while true
    capture_temp = "cat /sys/class/thermal/thermal_zone0/temp"
    temp = Open3.capture2(capture_temp)
    temp_cpu = (temp[0].to_i / 1000)
    temp_threshold = CPU_TEMP_THRESHOLD
    notif_duration = (NOTIF_DURATION * 1000).to_i
    notif_volume = notif_volume_converter(NOTIF_VOLUME)

    if temp_cpu >= temp_threshold
      system("notify-send 'High CPU Temperature''!' 'The CPU has been hard at work in the past minute.' --urgency=critical --expire-time=#{notif_duration}")
      system("paplay /home/bandithijo/snd/Ringtones/Alert/aircraftalarm.wav --volume=#{notif_volume}")
      if system("which thinkalert > /dev/null 2>&1") == true
        system("thinkalert 5")
      end
    end

    sleep(5)
  end
rescue Interrupt
  puts "\nExiting..."
end
```

Saya beri nama file `notify-hightemp`.

Saya tidak menggunakan ekstensi `.rb` karena saya sudah mendefinisikan *SheBang* <mark>#!/usr/bin/env ruby</mark> dari file ini, agar sistem dapat mengenali bahwa saya ingin mengeksekusi file ini dengan Ruby intepreter. Selain itu agar lebih mudah dipanggil di Terminal, hehe.

Saya menggunakan perintah `cat /sys/class/thermal/thermal_zone0/temp` agar lebih fleksibel digunakan pada mesin yang lain. Karena selain `/sys` kita juga dapat menggunakan `/proc`

Selain itu saya hanya menangkap nilai untuk `thermal_zone0` yang saya asumsikan sebagai temperatur untuk core0.

Teman-teman bisa mengolahnya sendiri untuk menangkap nilai dari core yang lain.

Selanjutnya, berikan permission untuk execute.

```
$ chmod +x notify-hightemp
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

Nama dari processs title berupa `notify_hightemp` ini saya set pada Ruby script di bagian

```
Process.setproctitle("notify-hightemp")
```

Sebenarnya bisa juga menggunakan,

```
$0="notify-hightemp"
```

Namun, terlihat seperti kurang Ruby banget, hehe.

# Tambahan

## ThinkAlert

Untuk pengguna ThinkPad jadul seperti saya (ThinkPad X61), saya menambahkan `thinkalert` bagi pengguna ThinkPad yang masih memiliki ThinkLight sebagai indikator tambahan.

Untuk pengguna distro selain Arch, mungkin tidak ada `thinkalert` di repository. Tinggal pasang saja dari GitHub repo dari thinkalert.

<pre>
$ <b>git clone https://github.com/floriandejonckheere/thinkalert.git</b>
$ <b>cd thinkalert</b>
</pre>

Isinya cuma dua file.

<pre>
$ <b>ls</b>
</pre>

```
README.md  thinkalert  thinkalert.c
```

Nah, `thinkalert.c` ini yang akan kita compile menjadi file binary.

<pre>
$ <b>gcc -c thinkalert thinkalert.c</b>
</pre>

Kalau ada warning (peringatan) mengenai penggunaan `setgroups`, bisa ganti menjadi `getgroups`

```c
// thinkalert.c

...
...

// Programming Cookbook for C and C++.
void dropPrivs() {

        ...
        ...

        // Drop ancillary group memberships.
        if (!olduid) getgroups(1, &newgid);
```

Kemudian compile ulang.

Selanjutnya, install ke `/usr/bin/`.

<pre>
$ <b>sudo install -Dm4755 thinkalert /usr/bin/thinkalert</b>
$ <b>rehash</b>
</pre>

Nah, coba jalankan **thinkalert**.

<pre>
$ <b>thinkalert</b>
</pre>

```
thinkalert <on|off|toggle>
thinkalert <times> [interval (microseconds)]
thinkalert <times> <on period (microseconds)> <off period (microseconds)>
```

Kalau keluar output seperti di atas, artinya **thinkalert** telah berhasil dipasang.

Coba test dengan menjalankan **thinkalert** kedip 5 kali.

<pre>
$ <b>thinkalert 5</b>
</pre>

Kalau berhaisl, thinklight akan berkedip 5 kali. Keren!


# Akhir Kata

Kira-kira seperti ini saja Ruby script yang ~~sederhana~~ cupu ini.

Mungkin dilain waktu, berdasarkan kebutuhan-kebutuhan tertentu, akan mulai ditambahkan fitur-fitur dan kemampuan dari script ini agar lebih mudah dan interaktif untuk digunakan.

Mudah-mudahan bermanfaat.

Terima kasih (^_^)v

Oh ya, kalo mau audio `aircraftalarm.wav`, dapat diunduh [di sini](https://freesound.org/people/guitarguy1985/sounds/57806/){:target="_blank"} yaa.

Tapi tidak saya rekomendasikan karena mungkin dapat menyebabkan serangan panik, hehe.


# Referensi

1. [github.com/floriandejonckheere/thinkalert](https://github.com/floriandejonckheere/thinkalert){:target="_blank"}
<br>Diakses tanggal: 2020/05/06

2. [aur.archlinux.org/packages/thinkalert](https://aur.archlinux.org/packages/thinkalert){:target="_blank"}
<br>Diakses tanggal: 2020/05/06
