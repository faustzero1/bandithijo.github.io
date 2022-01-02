---
layout: 'post'
title: "Catatan Post Installation openSUSE Tumbleweed"
date: 2022-01-01 05:50
permalink: '/note/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'note'
tags: ['Tips', 'openSUSE']
wip: true
pin:
contributors: []
description: "Catatan ini merupakan kumpulan packages dan beberapa konfigurasi yang saya lakukan setelah melakukan proses instalasi openSUSE Tumbleweed."
---

# Prakata

Catatan ini merupakan kumpulan packages dan beberapa konfigurasi yang saya lakukan setelah melakukan proses instalasi openSUSE Tumbleweed.

Saya memutuskan untuk mengkategorikan catatan ini sebagai "note" dan bukan sebagai "blog" karena kemungkinan saya akan terus memperbaharui isinya seiring dengan berjalannya waktu pemakaian apabila saya menemukan paket-paket yang menarik.

Selain itu, memiliki sebuah catatan "perjalanan" akan **menumbuhkan rasa percaya diri untuk terus maju ke depan**. Maksud saya, apabila terjadi kegagalan karena satu dan lain hal, kita tidak segan untuk memulai lagi dari awal. Ataupun, kita dapat dengan mudah memulai percabangan untuk awal baru yang lain.

# NaN Things I Must Do

## Updating system

Lakukan refresh repositories,

{% shell_term $ %}
sudo zypper ref
{% endshell_term %}

**ref**, adalah *shorthand* dari **refresh**.

Kemudian, lakukan update,

{% shell_term $ %}
sudo zypper up
{% endshell_term %}

**up**, adalah *shorthand* dari **update**.

## Add additional package repositories (Packman)

Sumber: [https://en.opensuse.org/Additional_package_repositories](https://en.opensuse.org/Additional_package_repositories){:target="_blank"}

Packman merupakan repositori eksternal terbesar. Packman menawarkan berbagai macam paket-paket tambahan untuk openSUSE, khususnya tapi tidak terbatas hanya pada aplikasi yang berkaitan dengan multimedia dan library-library yang [di-"blacklist" di openSUSE Build Service](https://en.opensuse.org/openSUSE:Build_Service_application_blacklist){:target="_blank"}.

Packman terdiri dari 4 jenis repositori:

1. [**Essentials**](https://pmbs.links2linux.de/project/show/Essentials){:target="_blank"}, menyediakan codecs dan audio dan video player applications, untuk memenuhi kebutuhan yang paling penting
2. [**Multimedia**](https://pmbs.links2linux.de/project/show/Multimedia){:target="_blank"}, berisikan lebih banyak lagi aplikasi yang berkaitan dengan multimedia
3. [**Extra**](https://pmbs.links2linux.de/project/show/Extra){:target="_blank"}, berisikan tambahan aplikasi yang tidak berkaitan dengan multimedia, kebanyakan berkaitan dengan networking
4. [**Games**](https://pmbs.links2linux.de/project/show/Games){:target="_blank"}, berisikan aplikasi-aplikasi permainan

\
Keempat repositori di atas dapat kita tambahkan semuanya atau kita pilih-pilih yang mana yang mau kita tambahkan ke dalam sistem kita.

**All of Packman**:

{% shell_term $ %}
sudo zypper ar -cfp 90 https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman
{% endshell_term %}

atau,

**Only Essentials Repository**:

{% shell_term $ %}
sudo zypper ar -cfp 90 https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/Essentials packman-essentials
{% endshell_term %}

\
Setelah menambahkan Packman repository, pastikan untuk mengganti paket official yang terpasang di sistem dengan paket yang ada di daftar Packman repository, karena campuran keduanya dapat menyebabkan berbagai masalah.

Kita dapat mengautomatisasi proses penggantian tersebut dengan perintah,

**All of Packman**:

{% shell_term $ %}
sudo zypper dup --from packman --allow-vendor-change
{% endshell_term %}

atau,

**Only Packman-Essentials**:

{% shell_term $ %}
sudo zypper dup --from packman-essentials --allow-vendor-change
{% endshell_term %}

# NaN Packages That I Need

## make

Repository: Main Repository (OSS)

Summary : GNU make

Description: The GNU make command with extensive documentation.

```
$ sudo zypper in make
```

## cmake

Repository: Main Repository (OSS)

Summary: Cross-platform make system

Description: CMake is a cross-platform build system.

```
$ sudo zypper in cmake
```

## gcc-c++

Repository: Main Repository (OSS)

Summary: The system GNU C++ Compiler

Description: The system GNU C++ Compiler.

```
$ sudo zypper in gcc-c++
```

## luajit-devel

Repository: Main Repository (OSS)

Summary: Devel files for luajit

Description: Devel files for luajit package

```
$ sudo zypper in luajit-devel
```

## libX11-devel

```
$ sudo zypper in libX11-devel
```

## git-core

Repository: Main Repository (OSS)

Summary: Core git tools

Description: Git is a fast, scalable, distributed revision control system with an unusually rich command set that provides both high-level operations and full access to internals. These are the core tools with minimal dependencies.

```
$ sudo zypper in git-core
```

## git-credential-libsecret

```
$ sudo zypper in git-credential-libsecret
```

Edi file `$HOME/.gitconfig`.

```
...

[credential]
	helper = /usr/libexec/git/git-credential-libsecret
```

## tig

```
$ sudo zypper in tig
```

## systemd-zram-service

Sumber: [https://build.opensuse.org/package/show/openSUSE%3AFactory/systemd-zram-service](https://build.opensuse.org/package/show/openSUSE%3AFactory/systemd-zram-service)

```
$ sudo zypper in systemd-zram-service
```

## neofetch

Repository: Main Repository (OSS)

Summary: CLI system information tool written in BASH

Description: Displays information about the system next to an image, the OS logo, or any ASCII file of choice. The main purpose of Neofetch is to be used in screenshots to show other users what OS/Distro is running, what Theme/Icons are being used, etc.

```
$ sudo zypper in neofetch
```

## htop

Repository: Main Repository (OSS)

Summary: An Interactive text-mode Process Viewer for Linux

Description: htop is an interactive text-mode process viewer for Linux. It aims to be a better 'top' and requires ncurses.

```
$ sudo zypper in htop
```

## iftop

```
$ sudo zypper in iftop
```

## nmap

```
$ sudo zypper in nmap
```

## nmon

```
$ sudo zypper in nmon
```

## wavemon

```
$ sudo zypper in wavemon
```

## nethogs

```
$ sudo zypper in nethogs
```

## glances

```
$ sudo zypper in glances
```

## zenity

```
$ sudo zypper in zenity
```

## vizex

```
$ pip install --user vizex
```

## sensors (lm_sensors)

```
$ sudo zypper in sensors
```

## soundconverter

```
$ sudo zypper in soundconverter
```

## audaciy

```
$ sudo zypper in audacity
```

## audacious

```
$ sudo zypper in audacious
```

## telegram-desktop

Repository: Main Repository (OSS)

Summary: Messaging application with a focus on speed and security

Description: Telegram is a non-profit cloud-based instant messaging service.  Users can send messages and exchange photos, videos, stickers, audio and files of any type.  Its client-side code is open-source software but the source code for recent versions is not always immediately published, whereas its server-side code is closed-source and proprietary.  The service also provides APIs to independent developers.

```
$ sudo zypper in telegram-desktop
```

## password-store

Repository: Main Repository (OSS)

Summary: Utility to store, retrieve, generate and synchronize passwords

Description: With password-store, each password lives inside of a gpg encrypted file whose filename is the title of the website or resource that requires the password.  These encrypted files may be organized into meaningful folder hierarchies, copied from computer to computer, and, in general, manipulated using standard command line file management utilities.

```
$ sudo zypper in password-store
```

## pwgen

```
$ sudo zypper in pwgen
```

## hascat

```
$ sudo zypper in hashcat
```

## arandr

```
$ sudo zypper in arandr
```

## xcalib

```
$ sudo zypper in xcalib
```

## google-chrome

Sumber: [https://linuxhint.com/install_google_chrome_opensuse/](https://linuxhint.com/install_google_chrome_opensuse/)

Repository: Google-Chrome

Summary: Google Chrome

Description: The web browser from Google Google Chrome is a browser that combines a minimal design with sophisticated technology to make the web faster, safer, and easier.

Adding Google Chrome repo:

```
$ sudo zypper ar http://dl.google.com/linux/chrome/rpm/stable/x86_64 Google-Chrome
```

Add Google public signing key:

```
$ wget https://dl.google.com/linux/linux_signing_key.pub
$ sudo rpm --import linux_signing_key.pub
```

Update Zypper cache:

```
$ sudo zypper ref -f
```

Installing Google Chrome:

```
$ sudo zypper in google-chrome-stable
```

## neovim

Repository: Main Repository (OSS)

Summary: Vim-fork focused on extensibility and agility

Description: Neovim is a refactor - and sometimes redactor - in the tradition of Vim, which itself derives from Stevie. It is not a rewrite, but a continuation and extension of Vim. Many rewrites, clones, emulators and imitators exist; some are very clever, but none are Vim. Neovim strives to be a superset of Vim, notwithstanding some intentionally removed misfeatures; excepting those few and carefully-considered excisions, Neovim is Vim. It is built for users who want the good parts of Vim, without compromise, and more.

```
$ sudo zypper in neovim
```

```
$ sudo zypper in xsel
$ sudo zypper in xclip
$ sudo zypper in ctags
$ sudo zypper in nodejs
$ sudo zypper in python38-neovim
```

**manual built**

Deps,

```
$ sudo zypper in make
$ sudo zypper in cmake
$ sudo zypper in automake
$ sudo zypper in autoconf
$ sudo zypper in ninja
$ sudo zypper in gcc-c++
$ sudo zypper in gettext-tools
$ sudo zypper in curl
$ sudo zypper in libtool
```

```
$ git clone https://github.com/neovim/neovim.git
$ cd neovim
$ make CMAKE_BUILD_TYPE=RelWithDebInfo -j$(expr nproc + 1)
$ sudo make install
```

## tmux

Repository: Main Repository (OSS)

Summary: Terminal multiplexer

Description: tmux is a terminal multiplexer: it enables a number of terminals (or windows), each running a separate program, to be created, accessed, and controlled from a single screen. tmux may be detached from a screen and continue running in the background, then later reattached. tmux is intended to be a modern, BSD-licensed alternative to programs such as GNU screen.

```
$ sudo zypper in tmux
```

## clipnotify

Deps,

```
$ sudo zypper in libX11-devel
$ sudo zypper in libXfixes-devel
```

```
$ git clone https://github.com/cdown/clipnotify.git
$ cd clipnotify
$ sudo make install
```

## ffmpeg

```
$ sudo zypper in ffmpeg-4
```

## SimpleScreenRecorder

```
$ sudo zypper in simplescreenrecorder
```

## flameshot

```
$ sudo zypper in flameshot
```

## scrot

```
$ sudo zypper in scrot
```

## maim

```
$ sudo zypper in maim
```

## Qt5ct

```
$ sudo zypper in qt5ct
```

## calibre

```
$ sudo zypper in calibre
```

## rofi

```
$ sudo zypper in rofi
```

## dmenu

```
$ sudo zypper in dmenu
```

## jq

```
$ sudo zypper in jq
```

## dnscrypt-proxy

Karena di openSUSE Tumbleweed belum secara default memasang paket **systemd-network** (networkd & resolved), maka saya lebih *prefer* menggunakan paket **openresolv** sebagai alternatif.

```
$ sudo zypper in openresolv
```

Pasang dnscrypt-proxy:

```
$ sudo zypper in dnscrypt-proxy
```

Edit file dnscrypt-proxy.toml

```
$ sudo vim /etc/dnscrypt-proxy/dnscrypt-proxy.toml
```

Minimal edit 2 variabel yang diperlukan, yaitu: **server_names** dan **listen_addresses**.

```
server_names = ['cloudflare']
listen_addresses = []
```

\* **Info**: server_names bebas mau menggunakan server yang menyediakan service dnscrypt.

Kemudian, jalankan **dnscrypt-proxy.socket** (bukan **.service**).

```
$ sudo systemctl enable --now dnscrypt-proxy.socket
```

Kemudian, konfigurasi NetworkManager agar dapat menggunakan openresolv.

Edit file,

```
$ sudo vim /etc/NetworkManager/NetworkManager.conf
```

Tambahkan bari `rc-manager=resolvconf` di dalam section `[main]`

```
[main]
dhcp=dhclient
plugins=keyfile
rc-manager=resolveconf
dnf=none

[connectivity]
uri=http://conncheck.opensuse.org
```

Oke, urusan dengan NetworkManager selesai.

Selanjutnya, konfigurasi openresolv.

Edit file **/etc/resolvconf.conf**.

```
$ sudo vim /etc/resolvconf.conf
```

Uncomment bagian **name_servers=127.0.0.1**.

```
# Configuration for resolvconf(8)
# See resolvconf.conf(5) for details

resolv_conf=/etc/resolv.conf
# If you run a local name server, you should uncomment the below line and
# configure your subscribers configuration files below.
name_servers=127.0.0.1
```

Selanjutnya, restart NetworkManager.

```
$ sudo systemctl restart NetworkManager.service
```

Cek, apakah file **/etc/resolv.conf** sudah berubah isinya menjadi `nameserver 127.0.0.1`.

Atau, kalau belum jalankan perintah di bawah ini,

```
$ sudo resolvconf -u
```

Selesai.

## pavucontrol

```
$ sudo zypper in pavucontrol
```

## pulsemixer

```
$ pip install --user pulsemixer
```

## MozillaThunderbird

```
$ sudo zypper in MozillaThunderbird
```

## gparted

```
$ sudo zypper in gparted
```

## barrier

```
$ sudo zypper in barrier
```

## go

```
$ sudo zypper in go
```

## lazygit

Source: [https://github.com/jesseduffield/lazygit](https://github.com/jesseduffield/lazygit)

```
go get github.com/jesseduffield/lazygit
```

## lazydocker

Source: [https://github.com/jesseduffield/lazydocker](https://github.com/jesseduffield/lazydocker)

```
$ go get github.com/jesseduffield/lazydocker
```

## docker

```
$ sudo zypper in docker
```

Masukkan **docker** ke dalam groups user yang digunakan.

```
$ sudo gpasswd -a ${USER} docker
```

## freecad

```
$ sudo zypper in freecad
```

## blender

```
$ sudo zypper in blender
```

## transmission-daemon

```
$ sudo zypper in transmission-daemon
```

## youtube-dl

```
$ sudo zypper in youtube-dl
```

## yt-dlp

```
$ sudo zypper in yt-dlp
$ pip install --user yt_dlp
```

## newsboat

```
$ sudo zypper in newsboat
```

## ranger

```
$ sudo zypper in ranger
```

```
$ sudo zypper in python3-devel
$ sudo zypper in libX11-devel
$ sudo zypper in libXext-devel
$ pip install --user ueberzug
```

```
$ pip zypper in mediainfo
$ pip zypper in highlight
$ pip zypper in atool
$ pip zypper in bsdtar
$ pip zypper in unrar
$ pip zypper in p7zip
$ pip zypper in odt2txt
```

## tor

```
$ sudo zypper in tor
```

## handbrake-gtk

```
$ sudo zypper in handbrake-gtk
```

## mpv

```
$ sudo zypper in mpv
```

## celluloid

```
$ sudo zypper in celluloid
```

## nodejs

```
$ sudo zypper in nodejs
```

## yarn

```
$ npm i -g yarn
```

## Ruby on Rails Developer

```
$ sudo zypper in libopenssl-devel
$ sudo zypper in libxml2-devel
```

```
$ sudo zypper in postgresql-server-devel
```

## Flatpak via Flathub Remote

```
$ flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

## Spotify

```
$ flatpak install flathub com.spotify.Client
```

## fontforge

```
$ sudo zypper in fontforge
```

## tilix terminal emulator

```
$ sudo zypper in tilix
```






{% comment %}
# Referensi

1. [](){:target="_blank"}
2. [](){:target="_blank"}
3. [](){:target="_blank"}
{% endcomment %}
