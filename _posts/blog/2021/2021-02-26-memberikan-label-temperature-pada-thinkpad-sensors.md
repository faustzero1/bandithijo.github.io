---
layout: 'post'
title: "Memberikan Label Temperature pada ThinkPad Sensors"
date: 2021-02-26 07:19
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'ThinkPad']
pin:
hot:
contributors: []
resume: "Kalau kita mengecek temperature ThinkPad laptop dengan menggunakan perintah sensors, kita akan mendapati label-label seperti temp1, temp2, temp3, dst. Bagaimana kita tahu, kalau label-label tersebut menujuk pada objek-objek seperti CPU, GPU, dll? Nah, catatan kali ini, kita akan memberikan label terhadap sensor-sensor tersebut."
---

# Latar Belakang Masalah

Apakah kalian pernah mengecek temperatur pada ThinkPad dengan menggunakan perintah?

{% shell_cmd $ %}
sensors
{% endshell_cmd %}

Hasilnya akan sepertin ini,

<pre>
coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +55.0°C  (high = +100.0°C, crit = +100.0°C)
Core 1:       +56.0°C  (high = +100.0°C, crit = +100.0°C)

BAT0-acpi-0
Adapter: ACPI interface
in0:          15.19 V

thinkpad-isa-0000
Adapter: ISA adapter
fan1:        3383 RPM
fan2:           0 RPM
temp1:        +56.0°C
temp2:        +42.0°C
temp3:        +42.0°C
temp4:        +51.0°C
temp5:        +27.0°C
temp6:            N/A
temp7:        +32.0°C
temp8:            N/A
temp9:        +44.0°C
temp10:       +44.0°C
temp11:           N/A
temp12:           N/A
temp13:           N/A
temp14:           N/A
temp15:           N/A
temp16:           N/A

acpitz-acpi-0
Adapter: ACPI interface
temp1:        +56.0°C  (crit = +127.0°C)
temp2:        +57.0°C  (crit = +100.0°C)
</pre>

Apakah kalian dapat mengerti arti dari **temp1**, **temp2**, **temp3**, dan seterusnya?

Sejak menggunakan ThinkPad, saya membiarkan saja.

Untuk mendapatkan temperature CPU, saya mereferensikan dengan value dari **coretemp-isa-0000**.

Sekarang, saatnya saya mencari tahu sensor prop apa saja yang dimiliki oleh ThinkPad saya (X61) dan apa makna dibalik **temp1** dan kawan-kawanya.

# Pemecahan Masalah

Sebenarnya sudah ada page pada ThinkPad Wiki yang menjelaskan perihal **sensors** ini.

Teman-teman dapat melihatnya di sini, [**Thermal Sensors**](http://www.thinkwiki.org/wiki/Thermal_Sensors){:target="_blank"}.

Sayangnya, untuk ThinkPad X61 saya, belum ada keterangan yang jelas mengenai indikator apa-apa saja.

Yang baru terkonfirmasi adalah **temp1**, **temp2**, **temp5**, dan **temp7**.

|-----------|----------|
| Props     | Location |
| :--       | :--:     |
| **temp1** | CPU      |
| **temp2** | APS      |
| **temp5** | BAT      |
| **temp7** | BAT      |
|-----------|----------|

<br>
Setelah saya perhatikan, sepertinya, tidak terlalu jauh berbeda dengan milik ThinkPad T60.

Maka, saya pun mencoba mengambil saya file konfigurasinya. Agar sewaktu-waktu untuk seri X61 sudah ada keterangan props yang lebih jelas, tinggal saya ganti.

Kita perlu membuat sebuah file konfigurasi **/etc/sensors.d/tpsensors** agar dapat dibaca oleh **sensors**.

{% highlight_caption /etc/sensors.d/tpsensors %}
{% highlight lang linenos %}
chip "acpitz-acpi-0"
  label temp1  "CPU_0"
  label temp2  "CPU_1"
chip "thinkpad-isa-0000"
  label fan1   "FAN"
  label temp1  "CPU"
  label temp2  "APS"
  label temp3  "PCM"
  label temp4  "GPU"
  label temp5  "BAT"
  label temp6  "temp6"
  label temp7  "BAT"
  label temp8  "n/a"
  label temp9  "BUS"
  label temp10 "PCI"
  label temp11 "PWR"
  label temp12 "temp12"
  label temp13 "temp13"
  label temp14 "temp14"
  label temp15 "temp15"
  label temp16 "temp16"
{% endhighlight %}

<br>
Maka, ketika kita menjalakan **sensors**, sekarang **temp1** dan kawan-kawannya telah memiliki label.

<pre>
coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +55.0°C  (high = +100.0°C, crit = +100.0°C)
Core 1:       +56.0°C  (high = +100.0°C, crit = +100.0°C)

BAT0-acpi-0
Adapter: ACPI interface
in0:          15.19 V

thinkpad-isa-0000
Adapter: ISA adapter
FAN:         3402 RPM
fan2:           0 RPM
CPU:          +56.0°C
APS:          +44.0°C
PCM:          +44.0°C
GPU:          +52.0°C
BAT:          +27.0°C
temp6:            N/A
BAT:          +35.0°C
n/a:              N/A
BUS:          +47.0°C
PCI:          +47.0°C
PWR:              N/A
temp12:           N/A
temp13:           N/A
temp14:           N/A
temp15:           N/A
temp16:           N/A

acpitz-acpi-0
Adapter: ACPI interface
CPU_0:        +56.0°C  (crit = +127.0°C)
CPU_1:        +56.0°C  (crit = +100.0°C)
</pre>

<br>
Selesai!


# Tips

{% box_info %}
<p markdown=1>Ketika menjalankan command **sensors**, maka output akanlangsung ditampilkan sekali.<br>
Apabila kita ingin output terus diupdate secara periodik, kita dapat menggunakan **watch**</p>
{% shell_cmd $ %}
watch sensors
{% endshell_cmd %}
<p markdown=1>Maka, output akan diupdate setiap 2 detik.</p>
<p markdown=1>Untuk keluar, dapat menekan kombinasi keyboard <kbd>Ctrl</kbd>+<kbd>C</kbd></p>

{% endbox_info %}







<br>
# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Selanjutnya, saya serahkan kepada imajinasi dan kreatifitas teman-teman. Hehe.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)




# Referensi

1. [http://www.thinkwiki.org/wiki/Thermal_Sensors](http://www.thinkwiki.org/wiki/Thermal_Sensors){:target="_blank"}
<br>Diakses tanggal: 2021/02/26
