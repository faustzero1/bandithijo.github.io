---
layout: 'post'
title: "Konfigurasi Sleep/Standby Ketika Lid Laptop Ditutup pada FreeBSD"
date: 2020-03-25 08:26
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'FreeBSD']
pin:
hot:
contributors: []
description: "Apakah kita dapat mengkonfigurasi FreeBSD untuk melakukan sleep/standby ketika lid laptop di tutup?"
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Pendahuluan

Karena FreeBSd masih menggunakan "Traditional BSD-style init"<super>1</super>, hal ini membuat kita dengan mudah dapat membaca dan memodifikasi atribut dari sistem kernel dengan menggunakan `sysctl`.

Misalnya seperti ini, untuk melihat semua semua list atribut.

{% shell_user %}
sysctl -a
{% endshell_user %}

```
kern.ostype: FreeBSD
kern.osrelease: 12.1-RELEASE-p2
kern.osrevision: 199506
kern.version: FreeBSD 12.1-RELEASE-p2 GENERIC

...
...
```

Hasilnya akan banyak sekali.

Nah, dengan ini, membuat pekerjaan kita lebih mudah untuk mengatur kernel state.

# Permasalahan

Pada awal-awal menggunakan FreeBSD, saya menggunakan XFCE. Pada saat itu, ketika lid laptop ditutup, laptop akan langsung standby karena pengaturan pada **xfce4-power-manager**. Namun, setelah bermigrasi ke BSPWM, laptop tidak lagi sleep/standby ketika lid ditutup.

# Identifikasi Masalah

Kemudian saya lakukan pengecekan terlebih dahulu pada atribute **hw.acpi**

{% shell_user %}
sysctl hw.acpi
{% endshell_user %}

<pre>
...
...
hw.acpi.s4bios: 0
hw.acpi.sleep_delay: 1
hw.acpi.suspend_state: S3
hw.acpi.standby_state: NONE
<mark>hw.acpi.lid_switch_state: NONE</mark>
hw.acpi.sleep_button_state: S3
hw.acpi.power_button_state: S5
hw.acpi.supported_sleep_state: S3 S4 S5
</pre>

Pada bagian bawah, terlihat output untuk atribut bernama **lid_switch_state** yang bernilai **NONE**.

Merujuk pada FreeBSD Handbook pada [Chapter 11. Configuration and Tuning - 11.13. Power and Resource Management](https://www.freebsd.org/doc/handbook/acpi-overview.html){:target="_blank"} pada subbab 11.13.2.2. Suspend/Resume, dijelaskan bahwa ACPI memiliki:

1. 3 STR (suspend to RAM) state, yaitu S1-S3
2. 1 STD (suspend to disk) state, yaitu S4
3. 1 Normal state (soft off), yaitu S5

Kita juga dapat melihat atribut bernama **supported_sleep_state** yang menunjukkan sleep state yang didukung oleh mesin kita.

Punya saya bernilai `S3 S4 S5`.

Nah, saya ingin ketika lid laptop ditutup maka laptop akan jatuh pada kondisi sleep to RAM.

Oleh karena itu, saya perlu mengganti nilai dari atribut `lid_switch_state=NONE` menjadi `lid_switch_state=S3`.

# Pemecahan Masalah

Untuk merubah nilai dari atribut tersebut sangat mudah sekali.

Cukup jalanka perintah seperti ini.

{% shell_user %}
doas sysctl hw.acpi.lid_switch_state=S3
{% endshell_user %}

Akan ada output seperti di bawah, apabila berhasil.

```
hw.acpi.lid_switch_state: NONE -> S3
```

Yang menunjukkan nilai dari atribut `lid_switch_state` sudah berubah dari NONE menjadi S3.

Sekarang coba periksa kembali nilainya. Kali ini dengan lebih spesifik saja agar tidak terlalu banyak output yang ditampilkan.

{% shell_user %}
sysctl hw.acpi | grep lid_switch_state
{% endshell_user %}

<pre>
hw.acpi.lid_switch_state: <b>S3</b>
</pre>

Hasilnya sudah sesuai dengan harapan.

Nah, kita perlu untuk membuat konfigurasi ini menjadi permanen.

Caranya sangat mudah. Tinggal tambahkan pada file `/etc/sysctl.conf`.

{% shell_user %}
doas vim /etc/sysctl.conf
{% endshell_user %}

{% highlight_caption /etc/sysctl.conf %}
{% highlight conf linenos %}
# ...
# ...

# ACPI sleep when lid closed
hw.acpi.lid_switch_state=S3
{% endhighlight %}

# Pengujian

Nah, enaknya lagi, tanpa perlu restart, kita langsung dapat mencoba pengaturan yang baru saja kita lakukan.

Coba sekarang tutup lid laptop.

Kalau berhasil, laptop akan jatuh pada keadaan sleep.

Mantap.

Berikut ini video demonstrasinya.

{% youtube 73eF71y_AxI %}

<br>
Pada video di atas, terlihat bahwa saya mendemonstrasikan proses sebelum dan sesudah mengubah atribut **lid_switch_state** tanpa perlu melakukan restart.

# Pesan Penulis

Catatan ini masih jauh dari kata baik.

Namun begitu, saya mencoba mencatat apa yang telah saya lakukan agar dikemudian hari dapat saya pergunakan kembali.

Saya menaruhnya pada media online seperti blog ini agar teman-teman yang memerlukan dapat dengan mudah menemukannya.

Apabila terdapat kekeliruan, dapat memastikan kembali pada referensi yang saya sertakan di bawah.

Terima kasih.

(^_^)







# Referensi

1. [freebsd.org/doc/en_US.ISO8859-1/articles/linux-users/startup.html](https://www.freebsd.org/doc/en_US.ISO8859-1/articles/linux-users/startup.html){:target="_blank"}
<br>Diakses tanggal: 2020/03/25

2. [FreeBSD Handkbook - Power and Resource Management](https://docs.freebsd.org/en/books/handbook/config/#acpi-overview){:target="_blank"}
<br>Diakses tanggal: 2021/04/23
