---
layout: 'post'
title: 'Instal dan Konfigurasi GNS3 pada Arch Linux'
date: 2018-04-16 04:22
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Arch Linux', 'Tools', 'Network']
pin:
---

<!-- BANNER OF THE POST -->
<img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="https://s20.postimg.cc/yln43s5fh/banner_post_03.png" alt="banner">

# Latar Belakang

Beberapa waktu yang lalu saya mengikuti webminar (web seminar) tentang *Network Automation* menggunakan Python. Aplikasi yang digunakan pada webminar tersebut adalah GNS3. Saya sudah mengenal aplikasi ini sejak 2016, namun belum pernah sama sekali menggunakannya.

Kebanyakan tutorial untuk melakukan instalasi GNS3 diperuntukkan untuk sistem operasi GNU/Linux yang berbasiskan Debian dan RedHat. Lantas bagaimana dengan Arch ?

Sebenarnya GNS3 sudah terdapat pada AUR (*Arch User Repository*) namun saya kesulitan untuk mengkonfigurasinya. Kemudian saya melakukan pencarian hingga menemukan dokumentasi yang langsung diarahkan oleh GNS3 untuk instalasi dan konfigurasi GNS3 pada Arch Linux, [di sini](https://gns3.com/news/article/install-and-configure-gns3-on-ar){:target="_blank"}.

# Komponen yang Diperlukan

Pada dokumentasi ini akan dibahas mengenai proses instalasi:

1. [GNS3](http://www.gns3.com/){:target="_blank"}
2. [Dynampis](https://aur.archlinux.org/packages/dynamips/){:target="_blank"}
3. [Virtual PC Simulator (VPCS)](https://aur.archlinux.org/packages/vpcs/){:target="_blank"}
4. [Docker](https://www.archlinux.org/packages/community/x86_64/docker/){:target="_blank"}
5. [VirtualBox](https://www.archlinux.org/packages/community/x86_64/virtualbox/){:target="_blank"}

# Prasyarat

Syarat minimal yang diperlukan adalah tentu saja distribusi sistem operasi Arch Linux.

# Instalasi & Konfigurasi Komponen

## Dynamips

Pasang dependensi untuk **Dynamips**.
```
$ sudo pacman -S libelf libcap cmake
```

Kemudian pasang **Dynamips** versi terbaru. Pada tulisan ini dibuat versi paling baru adalah **0.2.18**. Kamu dapat melakukan pengecekan versi paling baru [di sini](https://github.com/GNS3/dynamips/releases){:target="_blank"}.
```
$ cd /tmp
$ curl -L https://github.com/GNS3/dynamips/archive/v0.2.18.tar.gz | tar -xz
$ cd dynamips*
$ mkdir build && cd $_
$ cmake ..
$ sudo make install
$ sudo setcap cap_net_admin,cap_net_raw=ep $(which dynamips)
```
Kamu dapat mengganti versi dari **Dynamips** ke versi paling baru atau ke versi yang spesifik kamu inginkan. Pada contoh *command* di atas, saya menggunakan versi 0.2.18.

Kemudian, setelah berhasil dipasang, kita perlu melakukan verifikasi untuk memastikan apakah proses instalasi berjalan semestinya. Cek versi dari Dynampis yang terpasang.
```
$ cd $HOME
$ dynamips 2> /dev/null | grep version
```
```
Cisco Router Simulation Platform (version 0.2.18-amd64/Linux stable)
```
Cek *capabilities* Dynampis.
```
$ getcap $(which dynamips)
```
```
/usr/local/bin/dynamips = cap_net_admin,cap_net_raw+ep
```
Apabila tampil *output* seperti di atas, artinya proses instalasi **Dynamips** telah berhasil.

## VPCS

Saya akan menggunakan `subversion` *checkout* dari branch utama Virtual PC Simulator (VPCS).
```
$ sudo pacman -S subversion
$ cd /tmp
$ svn checkout svn://svn.code.sf.net/p/vpcs/code/trunk vpcs-code
$ cd vpcs-code/src
$ rgetopt='int getopt(int argc, char *const *argv, const char *optstr);'
$ sed -i "s/^int getopt.*/$rgetopt/" getopt.h
$ unset -v rgetopt
$ sed -i 's/i386/x86_64/' Makefile.linux
$ sed -i 's/-s -static//' Makefile.linux
$ make -f Makefile.linux
$ strip --strip-unneeded vpcs
$ sudo mv vpcs /usr/local/bin
```

Kemudian, lakukan verifikasi proses instalasi yang sudah kita lakukan tadi. Kita akan melakukan pengecekan lokasi.
```
$ cd $HOME
$ type vpcs
```
```
vpcs is /usr/local/bin/vpcs
```
Dan versi dari VPCS.
```
$ vpcs -v | grep version
```
```
Welcome to Virtual PC Simulator, version 0.8c
```
Apabila tampil *output* seperti di atas, artinya proses instalasi VPCS telah berhasil.

## IOUYAP

Pasang paket `iniparser` yang menjadi dependensi bagi IOUYAP.
```
$ sudo pacman -S iniparser
```

Saya akan memasang versi terbaru dari IOUYAP. Pada dokumentasi ini dibuat, versi paling baru adalah **0.97**. Kamu dapat melakukan pengecekan [di sini](https://github.com/GNS3/iouyap/releases){:target="_blank"}.
```
$ cd /tmp
$ curl -L https://github.com/GNS3/iouyap/archive/v0.97.tar.gz | tar -xz
$ cd iouyap*
$ bison -ydv netmap_parse.y
$ flex netmap_scan.l
$ gcc -Wall -g *.c -o iouyap -liniparser -lpthread
$ strip --strip-unneeded iouyap
$ sudo mv iouyap /usr/local/bin
```

Kemudian kita perlu mengeset *capabilities* dari IOUYAP.
```
$ cd $HOME
$ sudo setcap cap_net_admin,cap_net_raw=ep $(which iouyap)
```

Lakukan pengecekan versi.
```
$ iouyap -V
```
```
iouyap version 0.97.0
```
Dan *capabilities* dari IOYUAP.
```
$ getcap $(which iouyap)
```
```
/usr/local/bin/iouyap = cap_net_admin,cap_net_raw+ep
```
Apabila tampil *output* seperti di atas, maka kita telah sukses memasang IOYUAP.

## uBridge

Saya akan memasang versi terbaru dari uBridge. Pada dokumentasi ini dibuat, versi paling baru adalah **0.9.14**. Kamu dapat melakukan pengecekan [di sini](https://github.com/GNS3/ubridge/releases){:target="_blank"}.

Pilih uBridge yang sama dengan versi GNS3 dan Dynampis yang ingin kamu pasang.
```
$ cd /tmp
$ curl -L https://github.com/GNS3/ubridge/archive/v0.9.13.tar.gz | tar -xz
$ cd ubridge*
$ make
$ sudo make install
```

Lakukan verifikasi versi.
```
$ cd $HOME
$ ubridge -v
```
```
ubridge version 0.9.13
```
Dan *capabilities* dari uBridge yang baru kita pasang.
```
$ getcap $(which ubridge)
```
```
/usr/local/bin/ubridge = cap_net_admin,cap_net_raw+ep
```
Apabila tampil *output* seperti di atas, maka kita telah sukses memasang uBridge.

## Docker

Paket `docker` sudah terdapat pada *Official Repository* Arch Linux.
```
$ sudo pacman -S docker
```

Setelah itu kita perlu mengaktifkan *service* dari **Docker**. Apabila kalian ingin membuat service Docker dijalankan setiap kali sistem dijalankan, maka gunakan parameter `enable`, namun apabila hanya ingin dijalankan saat dibutuhkan saja, gunakan parameter `start`, maka setiap kali kita membutuhkan service Docker, kita perlu menjalankan servicenya terlebih dahulu.
```
$ sudo systemctl enable docker.service
$ sudo systemctl start docker.service
```

Tambahkan user kita kedalam `docker` group.
```
$ sudo gpasswd -a $(id -un) docker
```

**LOGOUT** and **LOGIN** kembali untuk mendapatkan efek dari penambahan user kita ke dalam `docker` group.

Verifikasi apakah user kita sudah termasuk di dalam `docker` group.
```
$ id -Gn
```
```
users wheel network storage input power docker
```
Perhatikan *output* yang ditampilkan, terdapat tambahan `docker` pada akhir dari baris.

Untuk menampilkan *system-wide information* dari Docker.
```
$ docker info
```

## VirtualBox

Untuk proses instalasi VirtualBox, saya akan merujuk pada dokumentasi yang terdapat pada Arch Wiki [di sini](https://wiki.archlinux.org/index.php/VirtualBox){:target="_blank"}.

Instalasi *core packages*.
```
$ sudo pacman -S virtualbox
```

Kita membutuhkan paket yang bertugas menyediakan *host modules* karena sistem kita bertindak sebagai *host*.

Untuk yang menggunakan `linux` vanilla kernel, dapat menggunakan,
```
$ sudo pacman virtualbox-host-modules-arch
```

Sedangkan untuk yang menggunakan [kernel yang lain](https://wiki.archlinux.org/index.php/Kernels){:target="_blank"}, dapat menggunakan,
```
$ sudo pacman -S virtualbox-host-dkms
```
Untuk *custom kernel* terdapat tambahan konfigurasi yang dapat langsung dilihat pada Arch Wiki.

Selanjutnya, kita perlu melakukan *load* semua VirtualBox modules agar dapat dijalankan secara otomatis saat proses *booting* berlangsung.
```
$ systemd-modules-load.service
```
Setelah itu, kita perlu melakukan *reboot* system untuk dapat menjalankan semua module tersebut.

Nah, untuk menjalankan secara manual kita dapat menjalankan satu persatu module tersebut, seperti tahapan yang akan dijelaskan di bawah.

Selain kernel module, VirtualBox juga menggunakan mandatory module yang bernama `vboxdrv` yang perlu di jalankan sebelum *virtual machine* di jalankan.
```
$ sudo modprobe vboxdrv
```
Selain module `vboxdrv`, module-module berikut ini bersifat opsional tetapi direkomendasikan jika kamu tidak ingin mengalami kendala saat melakukan konfigurasi tingkat lanjut. Module-module tersebut adalah, `vboxnetadp`, `vboxnetflt`, `vboxpci`.

`vboxnetadp` dan `vboxnetflt`, keduanya dibutuhkan saat kamu ingin menggunakan fitur **Network** berupa **Bridge** atau **Host-Only**. Sedangkan `vboxpci` diperlukan saat *virtual machine* harus menggunakan perangkan PCI pada mesin kamu.

Selanjutnya, hanya opsional saja, yaitu pengaturan port USB. Untuk dapat menghubungkan USB pada sistem kita (sebagai Host) dengan sistem virtual (sebagai Client) kita perlu menambahkan user kita kedalam `vboxusers` group.
```
$ sudo gpasswd -a $(id -un) vboxusers
```

**LOGOUT** and **LOGIN** kembali untuk mendapatkan efek dari penambahan user kita ke dalam `vboxusers` group.

Verifikasi apakah user kita sudah termasuk di dalam `vboxusers` group.
```
$ id -Gn
```
```
users wheel network storage input power docker vboxusers
```
Perhatikan *output* yang ditampilkan, terdapat tambahan `vboxusers`.

## GNS3

Pasang dependensi untuk GNS3.
```
$ sudo pacman -S qt5-svg qt5-websockets python-pip python-pyqt5 python-sip
```

Kita memerlukan Git untuk memasang paket-paket paling baru dari GNS3 yang terdapat pada GitHub dari GNS3.

Pasang **Git** dan *create*/*set Git working directory*.
```
$ sudo pacman -S git
$ mkdir -p $HOME/GNS3-Dev && cd $_
```

Pasang **GNS3 Server** dari GitHub.
```
$ git clone https://github.com/GNS3/gns3-server.git
$ cd gns3-server
$ git tag --list 'v2.1.*'
$ git checkout v2.1.4
$ sudo pip3 install -r requirements.txt
$ sudo python3 setup.py install
```

Pasang **GNS3 GUI** dari GitHub.
```
$ cd $HOME/GNS3-Dev
$ git clone https://github.com/GNS3/gns3-gui.git
$ cd gns3-gui
$ git tag --list 'v2.1.*'
$ git checkout v2.1.4
$ sudo pip3 install -r requirements.txt
$ sudo python3 setup.py install
```

Verifikasi apakah paket GNS3 sudah berhasil dipasang.
```
$ pip3 list | grep gns3
```
```
gns3-gui (2.1.4)
gns3-server (2.1.4)
```

Selanjutnya, kita perlu membuat *desktop dhosrtcut* agar GNS3 lebih mudah di aksis via *Desktop Environment*.
```
$ sudo tee -a /usr/share/applications/gns3.desktop > /dev/null << EOL
> [Desktop Entry]
> Type=Application
> Encoding=UTF-8
> Name=GNS3
> Comment=Graphical Network Simulator 3
> Exec=/usr/bin/gns3
> Icon=gns3
> Terminal=false
> Categories=Application;Network;Qt;
> EOL
```
*Script* di atas bertujuan untuk membuat file `gns3.desktop`. Ini merupakan file *launcher* untuk memanggil aplikasi melalui *desktop environment*.

# Upgrade GNS3 to Latest Version

Karena kita menggunakan GNS3 dari GitHub, maka kita perlu melakukan *upgrade* secara manual. Jangan khawatir, karena proses *upgrade* ini tidak begitu rumit. Tinggal mengikuti *command* yang sudah ditulis di sini.

Langkah awal terntu saja kita perlu *uninstall* versi GNS3 saat ini.
```
$ pip3 list | grep gns3
$ sudo pip3 uninstall -yv gns3-gui
$ sudo pip3 uninstall -yv gns3-server
$ pip3 list | grep gns3
```

Selanjutnya, pasang **GNS3 Server** yang paling baru. Keuntungannya kita menggunakan Git adalah kita cukup melakukan *git pull* untuk membuat repository Git yang sudah pernah kita *clone* memperbaharui paket-paket yang berada pada repositori asli yang ada di GitHub.
```
$ cd $HOME/GNS3-Dev/gns3-server
$ git pull
$ git tag --list 'v2.1.*'
$ git checkout v2.1.5
$ sudo python3 setup.py install
```

Pasang **GNS3 GUI**
```
$ cd $HOME/GNS3-Dev/gns3-gui
$ git pull
$ git tag --list 'v2.1.*'
$ git checkout v2.1.5
$ sudo python3 setup.py install
```

Verifikasi proses *upgrade* GNS3.
```
$ pip3 list | grep gns3
```
```
gns3-gui (2.1.5)
gns3-server (2.1.5)
```

<br>
Saya rasa cukup seperti ini saja proses instal dan konfigurasi GNS3 pada distribusi sistem operas Arch Linux. Dengan demikian proses instalasi dan konfigurasi ini telah selesai.


# Referensi

1. [binarynature.blogspot.com/2015/11/install-configure-gns3-arch-linux.html](http://binarynature.blogspot.com/2015/11/install-configure-gns3-arch-linux.html){:target="_blank"}
<br>Diakses tanggal: 2018/04/16

2. [sourceforge.net/projects/vpcs/](http://sourceforge.net/projects/vpcs/){:target="_blank"}
<br>Diakses tanggal: 2018/04/16

3. [wiki.archlinux.org/index.php/VirtualBox](https://wiki.archlinux.org/index.php/VirtualBox){:target="_blank"}
<br>Diakses tanggal: 2018/04/19
