---
layout: 'post'
title: "Catatan Daftar CLI dan TUI Tools"
date: 2021-05-04 04:17
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
description: "Catatan ini merupakan kumpulan dari daftar nama-nama CLI dan TUI tools yang dapat memudahkan pekerjaan kita sehari-hari."
---

# Prakata

Seperti yang teman-teman ketahui, sebenarnya ada banyak sekali nama-nama CLI dan TUI tools yang dapat kita gunakan untuk mempermudah pekerjaan kita sehari-hari, tidak hanya dalam hal monitoring.

Yang sangat terkenal dan sangat serig kita lihat dipajang di setiap desktop-desktop yang melakukan "show-off" adahal **htop**, **neofetch**, **ranger**, **pipes**, **cmatrix**, dan masih banyak lagi. Nama-nama tersebut, baru sebagian kecil saja.

Catatan ini hadir, dari penulis untuk teman-teman, sebagai catatan untuk mengingatkan penulis akan nama-nama tools-tools tersebut. Karena, apabila tidak sering digunakan, mesti akan terlupakan, dan ketika diperlukan, perlu waktu untuk mengingatnya kembali.

# System Monitor

## htop

An interactive process viewer

{% image https://i.postimg.cc/bwj3RHrR/gambar-htop.png | gambar-htop %}

htop is a cross-platform interactive process viewer.

htop allows scrolling the list of processes vertically and horizontally to see their full command lines and related information like memory and CPU consumption.

The information displayed is configurable through a graphical setup and can be sorted and filtered interactively.

Tasks related to processes (e.g. killing and renicing) can be done without entering their PIDs.

[https://github.com/htop-dev/htop](https://github.com/htop-dev/htop){:target="_blank"}

## gotop

## gtop

## ytop

## bashtop

## bottom (btm)

## glances

## nmon


# Disk Monitor

## vizex

Visualize disk space and disk usage in your UNIX\Linux terminal

{% image https://i.postimg.cc/1zDSjKr5/gambar-vizex.png | gambar-vizex %}

vizex is the terminal program for the UNIX/Linux systems which helps the user to visualize the disk space usage for every partition and media on the user's machine. vizex is highly customizable and can fit any user's taste and preferences.

[https://github.com/bexxmodd/vizex](https://github.com/bexxmodd/vizex){:target="_blank"}


# Network Monitor

## iftop

## nethogs

Net top tool grouping bandwidth per process.

{% image https://i.postimg.cc/L6Pxf09X/gambar-nethogs.png | gmabar-htop %}

NetHogs is a small 'net top' tool. Instead of breaking the traffic down per protocol or per subnet, like most tools do, it groups bandwidth by process.

[https://github.com/raboof/nethogs](https://github.com/raboof/nethogs){:target="_blank"}

{% box_info %}
<p markdown=1>Untuk "unknown TCP" dapat dibaca di sini.</p>

<p markdown=1>The "Nethogs" package will always show a fake process called "unknown TCP", that corresponds to everything it can't identify. Notice that it doesn't have a process ID, and the amount of data is shown as 0, indicating that there isn't any unknown traffic.</p>

<p markdown=1>Here's the line from the nethogs source code where that line gets initialised:</p>

```
unknowntcp = new Process (0, "", "unknown TCP");
```

([Source code download ](http://archive.ubuntu.com/ubuntu/pool/universe/n/nethogs/nethogs_0.8.0-1.debian.tar.gz){:target="_blank"}, look in process.cpp)
</p>
{% endbox_info %}

## gping

Ping, but with a graph.

{% image https://i.postimg.cc/85sHCZXT/gambar-gping.png | gambar-gping %}

[https://github.com/orf/gping](https://github.com/orf/gping){:target="_blank"}


## wavemon

wavemon is an ncurses-based monitoring application for wireless network devices on Linux.

{% image https://i.postimg.cc/N08h4jQK/gambar-wavemon-01.png | gambar-wavemon-01 %}

{% image https://i.postimg.cc/k5P3KbPr/gambar-wavemon-02.png | gambar-wavemon-02 %}

{% image https://i.postimg.cc/9Mc6NHfJ/gambar-wavemon-03.png | gambar-wavemon-03 %}

wavemon is a wireless device monitoring application that allows you to watch signal and noise levels, packet statistics, device configuration and network parameters of your wireless network hardware. It should work (though with varying features) with all devices supported by the Linux kernel.

[https://github.com/uoaerg/wavemon](https://github.com/uoaerg/wavemon){:target="_blank"}


# Torrent Client

## tremc

Curses interface for transmission

{% image https://i.postimg.cc/13xYj1Cw/gambar-tremc-01.png | gambar-tremc-01 %}

{% image https://i.postimg.cc/K8nsXpwV/gambar-tremc-02.png | gambar-tremc-02 %}

{% image https://i.postimg.cc/rpjns08N/gambar-tremc-03.png | gambar-tremc-03 %}

{% image https://i.postimg.cc/Dznp7dKz/gambar-tremc-04.png | gambar-tremc-04 %}

A console client for the BitTorrent client Transmission.

tremc is the python3 fork of transmission-remote-cli.

[https://github.com/tremc/tremc](https://github.com/tremc/tremc){:target="_blank"}


# Git Client

## lazygit

Simple terminal UI for git commands

{% image https://i.postimg.cc/prwk4KZR/gambar-lazygit.png | gambar-lazygit %}

A simple terminal UI for git commands, written in Go with the gocui library.

[https://github.com/jesseduffield/lazygit](https://github.com/jesseduffield/lazygit){:target="_blank"}

## tig

Text-mode interface for git

{% image https://i.postimg.cc/ZRg1YBcD/gambar-tig-01.png | gambar-tig-01 %}

{% image https://i.postimg.cc/qRgPdX83/gambar-tig-02.png | gambar-tig-02 %}

Tig is an ncurses-based text-mode interface for git. It functions mainly as a Git repository browser, but can also assist in staging changes for commit at chunk level and act as a pager for output from various Git commands.

[https://github.com/jonas/tig](https://github.com/jonas/tig){:target="_blank"}


# Docker Client

## lazydocker


# Font

## fontpreview-ueberzug


# Science

## periodic-table-tui


# Messaging

## Weechat (IRC Client)


# Audio Player

## cmus

## ncmpcpp

## mpd


# Video Player

## youtube-dl

## youtube-viewer

## ytfzf


# Battery Monitor

## battop













{% comment %}
# Referensi

1. [](){:target="_blank"}
2. [](){:target="_blank"}
3. [](){:target="_blank"}
{% endcomment %}
