---
layout: 'post'
title: 'Memperbaiki systemd-timesyncd Failed to Start Saat Booting pada Arch Linux'
date: 2019-04-24 20:34
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Arch Linux', 'Tips']
pin:
hot:
contributors: []
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Melakukan *restart* pada sistem operasi Arch Linux di laptop saya adalah hal yang sangat jarang saya lakukan. Apalagi *shutdown*.

*Restart* hanya akan saya lakukan apabila setelah melakukan proses *update* pada *system* (`$ sudo pacman -Syu`), saya mendapatkan pembaharuan kernel, systemd, firmware, maupun beberapa package yang memerlukan *restart*.

*Shutdown* pun saya sudah lupa kapan terakhir kali saya mematikan laptop ini (Lenovo ThinkPad X260).

# Permasalahan

Saat melakukan *restart* malam tadi (2019/04/24), saya mendapati kegagalan pada service yang bernama `systemd-timesyncd.service`.

Kira-kira seperti ini wujudnya.

<pre>
<span style="color:red;font-weight:bold;">systemd-timesyncd.service: Failed at step STATE_DIRECTORY spawning /usr/lib/systemd/systemd-timesyncd: Not a directory</span>
</pre>

# Pemecahan Masalah

**DWYOR (*Do with Your Own Risk*) !**

Remove symlink directory yang berada di `/var/lib/systemd/timesync`.

```
$ sudo rm /var/lib/systemd/timesync
```

Jangan khawatir untuk menghapus *symbolic link* dari direktori `timesync/` ini karena setelah *restart* akan secara otomatis di-*recovery* kembali oleh sistem.

Setelah dihapus, jangan lupa *restart* dulu, bosku!

Selesai.


# Referensi

1. [bbs.archlinux.org/viewtopic.php?id=245916](https://bbs.archlinux.org/viewtopic.php?id=245916){:target="_blank"}
<br>Diakses tanggal: 2019/04/24

