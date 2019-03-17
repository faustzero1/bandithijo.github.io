---
layout: 'post'
title: 'Fan pada ThinkPad Tidak Terdeteksi Setelah Power Adapter Dicabut'
date: 2018-12-08 22:50
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['ThinkPad', 'Tips']
pin:
hot:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="" alt="banner"> -->

<!-- OUTDATED POST -->
<p class="notif-post">Post ini Gagal dalam Tahap Pengujian!<br>
Sebaiknya Tidak Diaplikasikan pada Sistem Anda.
</p>

<!-- INFORMATION -->
<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p><code>tlp</code> sepertinya membuat efisiensi manajemen fan pada ThinkPad. Sehingga saya tidak lagi khawatir mengenai hasil output dari perintah <code>$ sensors</code> bernilai <code>0</code> karena mungkin memang saat bernilai <code>0</code> fan benar-benar tidak diperlukan untuk berputar. Karena sekali waktu saya melihat dari indikator fanspeed pada <code>Conky</code> yang saya pasang di desktop menunjukkan angka tertentu. (dalam keadaan tidak menggunakan paket <code>thinkfan</code>).</p>
<p><strong>Kesimpulannya, tulisan ini tidak benar-benar saya perlukan.</strong></p>
</div>

# Prakata

Hari ini saya me-*ricing* tampilan Conky karena sudah merasa jenuh dengan tampilan yang lama. Sembari menyusun _script_ Conky, saya berpindah-pindah tempat duduk. Saya mendapati, saat _power adapter_ saya lepas, _output_ dari _fan speed monitor_ saya _blank_ (tidak menampilkan _output_ apapun). Lantas saya coba jalankan `$ sensors` dan hasilnya pun _nihil_.

Berikut ini adalah ilustrasinya.

**Jika Power Adapter Terpasang**

```
$ sensors
```
```
thinkpad-isa-0000
Adapter: ISA adapter
fan1:        3076 RPM
```

**Jika Power Adapter Dilepas**
```
$ sensors
```
```
thinkpad-isa-0000
Adapter: ISA adapter
fan1:
```

# Solusi

Tentu saja untuk permasalahan-permasalahan terkait Arch Linux, yang menjadi bahan rujukan pertama kali adalah Arch Wiki.

Dengan keyword pencarian "_fanspeed did not respond aftar power adapter disconnected_" atau "_thinkpad fan arch wiki_", saya pun memilih untuk membuka rekomendasi tautan yang mengarah pada Arch Wiki.

Kemudian, saya melakukan pencarian kata spesifik "thinkpad", ternyata ketemu. Terdapat _section_ yang spesifik membahas _fan_ pada ThinkPad _laptops_.

Berikut langkah-langkahnya.

1. Instalasi paket bernama [`thinkfan`](https://aur.archlinux.org/packages/thinkfan/){:target="_blank"} dari (AUR)
```
$  yay thinkfan
```
2. Kemudian periksa file yang sudah terpasang dengan cara
```
$ sudo pacman -Ql thinkfan
```
```
thinkfan /usr/
thinkfan /usr/bin/
thinkfan /usr/bin/thinkfan
thinkfan /usr/lib/
thinkfan /usr/lib/modprobe.d/
thinkfan /usr/lib/modprobe.d/thinkpad_acpi.conf
thinkfan /usr/lib/systemd/
thinkfan /usr/lib/systemd/system/
thinkfan /usr/lib/systemd/system/thinkfan.service
thinkfan /usr/share/
thinkfan /usr/share/doc/
thinkfan /usr/share/doc/thinkfan/
thinkfan /usr/share/doc/thinkfan/NEWS
thinkfan /usr/share/doc/thinkfan/README
thinkfan /usr/share/doc/thinkfan/examples/
thinkfan /usr/share/doc/thinkfan/examples/thinkfan.conf.complex
thinkfan /usr/share/doc/thinkfan/examples/thinkfan.conf.simple
thinkfan /usr/share/man/
thinkfan /usr/share/man/man1/
thinkfan /usr/share/man/man1/thinkfan.1.gz
```
Perhatikan terdapat file bernama `/usr/lib/modprobe.d/thinkpad_acpi.conf`.
Apabila kita lihat isi di dalamnya akan terdapat baris seperti ini.
```
options thinkpad_acpi fan_control=1
```
3. Selanjutnya, me-*load* kernel module.
```
$ sudo modprobe thinkpad_acpi
```
```
$ sudo cat /proc/acpi/ibm/fan
```
```
status:		enabled
speed:		3068
level:		auto
```
4. Selanjutnya, tinggal mengaktifkan _service_ saat _startup_.
```
sudo vim /etc/default/thinkfan
```
Isikan dengan.
```
START=yes
```
5. Kemudian, _copy_ konfigurasi default `/usr/share/doc/thinkfan/examples/thinkfan.conf.simple` ke `/etc/thinkfan.conf`.
```
$ sudo cp /usr/share/doc/thinkfan/examples/thinkfan.conf.simple /etc/thinkfan.conf
```
**Perhatian!** Langkah di atas perlu dilakukan. Apabila tidak, maka _service_ dari `thinkfan.service` akan kebingungan mencari file konfigurasi default yang diperlukan setelah _system reboot_.
6. Langkah terakhir, tinggal meng-*enable*-kan *service*-nya.
```
$ sudo systemctl enable thinkfan
```
```
Created symlink /etc/systemd/system/multi-user.target.wants/thinkfan.service → /usr/lib/systemd/system/thinkfan.service.
```
Selesai.

Nah, sekarang coba lepas _power adapter_ dan lakukan pengecekan dengan menjalankan perintah `$ sensors`.

Apakah sudah berhasil terdeteksi?



# Referensi

1. [wiki.archlinux.org/index.php/Fan_speed_control#ThinkPad_laptops](https://wiki.archlinux.org/index.php/Fan_speed_control#ThinkPad_laptops){:target="_blank"}
<br>Diakses tanggal: 2018/12/08
