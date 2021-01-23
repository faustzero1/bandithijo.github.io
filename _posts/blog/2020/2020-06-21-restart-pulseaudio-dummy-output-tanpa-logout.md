---
layout: 'post'
title: "Restart PulseAudio Dummy Output Tanpa Perlu Logout"
date: 2020-06-21 12:27
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
resume: "Sistem tiba-tiba tidak terdengar suara. Jangan panik, segera jalankan protokol pertolongan pertama untuk mengatasi audio yang hilang pada pulseaudio!"
---

# Pendahuluan

Terkadang, setelah kembali dari restart karena sebelumnya melakukan update Arch Linux, mungkin kita mendapatin sistem kita tidak dapat mengeluarkan suara.

Kalau kita cek di aplikasi seperti **pavucontrol** akan ada keterangan seperti **Dummy Output**.

Kondisi ini sangat jarang, bahkan saya baru pertama kalinya mengalami hal ini beberapa hari yang lalu.

Namun, saya perlu mencatat agar dikemudian hari mengalami hal ini lagi, saya tidak perlu jauh-jauh mencari.

# Penyelesaian Masalah

Buka Terminal dan jalankan perintah di bawah, satu-persatu.

{% shell_user %}
pulseaudio --check
pulseaudio --kill
pulseaudio --start
{% endshell_user %}

Atau, langsung jalankan bentuk satu baris, lebih praktis.

{% shell_user %}
pulseaudio --check; pulseaudio --kill; pulseaudio --start
{% endshell_user %}






# Referensi

1. [How can I restart pulseaudio without having to logout?](https://askubuntu.com/questions/15223/how-can-i-restart-pulseaudio-without-having-to-logout/15224#15224){:target="_blank"}
<br>Diakses tanggal: 2020/06/21
