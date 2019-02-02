---
layout: 'post'
title: 'Step 7: Install Gnome and Complete Installation'
date: 2018-02-09 08:00
permalink: '/arch/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'arch'
tags:
pin:
---


# STEP 7 : Install GNOME and Complete Installation

## 7.1 Check Internet Connection

Sebelum memasang paket **GNOME** _desktop_, pastikan dulu kalian telah terhubung dengan Internet.

```
$ ping google.com
```

Apabila keluar hasil seperti di bawah.

```
ping: google.com: Name or service not known
```

Menandakan bahwa kita belum terhubung ke Internet. Lakukan perintah di bawah untuk menjalankan `dhcpcd`.

```
$ sudo dhcpcd
```
Atau kalian dapat kembali merujuk pada _Step 1 : Connecting to the Internet_ untuk dapat kembali melakukan konfigurasi Internet.

Pada perintah di atas, kita menambahkan perintah `sudo` tepat sebelum _command_\(perintah\) `dhcpcd`, karena saat ini kita bukan lagi berada pada `root` _previlege_.  Kita berada pada akun kita sendiri yang hak aksesnya lebih terbatas. Ditandai dengan simbol `$` . Maka dari itu kita memerlukan bantuan `sudo` untuk membuat kita dapat mengeksekusi _command_ yang seharusnya hanya bisa dijalankan oleh `root` saja.

Kemudian kita akan diminta memasukkan _password_. Masukkan _password_ `user` kita \(bukan _password_ `root`\).

```
[sudo] password for archer: _
```

Setelah itu akan muncul pemberitahuan seperti di bawah.

```
dev: loaded udev
no interfaces have a carrier
forked to background, child pid 342
```

Sekarang coba lakukan ping lagi dengan cara `ping google.com`

Mungkin diperlukan 1 - 2 menit untuk menunggu sampai `ping` berhasil didapatkan. Apabila berhasil, artinya kita sudah terhubung ke Internet. Saatnya melangkah ke _step_ selanjutnya.

## 7.2 GNOME Desktop Environment

Pada dokumentasi kali ini saya memilih menggunakan **GNOME** _desktop environment_, ketimbang **XFCE** ataupun **KDE**. Karena menurut saya _desktop environment_ yang satu ini lebih mudah untuk diajarkan maupun digunakan karena _interface_-nya yang simpel dan minimalis. Selain itu cukup banyak distribusi sistem operasi GNU/Linux yang lain, yang juga menyertakan GNOME _desktop_ menjadi _default environment_ mereka.

Untuk teman-teman yang ingin menggunakan _desktop environment_ yang lain, dapat merujuk pada [Arch Wiki](https://wiki.archlinux.org/index.php/Desktop_environment) untuk proses instalasinya.

Untuk menginstal GNOME _desktop environment_, sangat mudah karena kita cukup mengetikkan _command_ di bawah ini.

```
$ sudo pacman -S gnome gnome-extra
```

_Command_ di atas dimaksudkan bahwa kita akan memasang dua buah paket aplikasi, `gnome` dan `gnome-extra`. `gnome` berisi paket-paket dasar dari GNOME _desktop_ sedangkan `gnome-extra` adalah paket-paket tambahan pendukung GNOME _desktop_.

Apabila keluar daftar paket-paket dari _group_ `gnome`.

```
Enter a selection (default=all): _
```

Maka kita memilih `all` dengan menekan tombol `ENTER`.

Selanjutnya akan keluar daftar paket-paket dari _group_ `gnome-extra`.

```
Enter a selection (default=all): _
```

Sekali lagi, kita hanya perlu memilih `all` dengan menekan tombol `ENTER`.

Apabila masih keluar pemberitahuan yang lain untuk memilih _default option_ dari _repository extra_ \(seperti: `libx264`, `xdg-desktop-portal-gtk`, dll\), saya memilih nomor **1 (default)** saja, jadi tinggal tekan tombol `ENTER`.

Setelah itu akan keluar daftar semua paket-paket dari GNOME _desktop_ yang akan kita pasang.

```
...
...
Total Download  Size:  591.06 MiB
Total Installed Size: 2786.74 MiB

:: Proceed with installation? [Y/n]
```

Tekan tombol  `Y`  → `ENTER`, atau langsung tekan `ENTER` untuk memilih Yes. Tunggu proses _download_ dan instalasi hingga selesai.

## 7.3 Enable GNOME Desktop Manager \(Login Manager\)

_Desktop Manager_ adalah aplikasi GUI yang menyediakan _interface_ kepada kita untuk dapat _login_ ke dalam sistem kita. Terdapat banyak _Desktop Manager_ pada sistem operasi GNU/Linux. **GDM**, **KDM**, **LightDM**, **SDM**, dan masih banyak lagi. Karena dokumentasi ini menggunakan GNOME _desktop environment_, maka kita akan menggunakan _desktop manager_ yang sudah termasuk dalam GNOME _base package_, yaitu GDM \(_GNOME Desktop Manager_\).

Untuk mengaktifkan dan membuat GDM otomatis dijalankan saat sistem pertama kali dinyalakan, kita perlu membuat _symlink service_ dari GDM terlebih dahulu.

```
$ sudo systemctl enable gdm.service
```

```
Created sysmlink /etc/systemd/system/display-manager.service → /usr/lib/ ...
```

Apabila keluar _output_ seperti di atas, maka proses instalasi GDM telah berhasil.

## 7.4 Manage Network with GUI

Secara _default_ GNOME _desktop_ belum meiliki aplikasi GUI untuk mengatur konfigurasi _network_. Maka, kita perlu untuk menambahkan beberapa paket yang mungkin ~~belum~~ termasuk dari _base package_ GNOME _desktop_. Meskipun paket pendukung _networking_ ini biasanya sudah termasuk dalam paket instalasi saat kita memasang _desktop environment_.

```
$ sudo pacman -S networkmanager network-manager-applet wpa_supplicant wpa_actiond dialog iw
```

Kemudian setelah proses instalasi selesai, kita perlu mengaktifkan _service_ dari `networkmanager` agar dapat berjalan saat sistem _startup_.

```
$ sudo systemctl enable NetworkManager.service
```

```
Created sysmlink /etc/systemd/system/dbus-org.freedesktop.NetworkManager.serv ...
Created sysmlink /etc/systemd/system/multi-user.target.wants/NetworkManager. ...
Created sysmlink /etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.servi ...
```

Maka pada _next reboot_, kalian sudah dapat menikmati konfigurasi _network_ melalui GUI. Termasuk konfigurasi _wifi_ juga telah tersedia.

Untuk teman-teman yang _wifi adapter_-nya tidak terdeteksi. Dapat mencari solusinya di Google yaa. Hehehe. Hal yang dapat kalian jadikan sebagai _keyword_ adalah :

1. Apa nama _vendor_ dari _network_ _adapter_ kalian \(misal: Intel, Atheros, Broadcom, Realtek, dll\)
2. Apa _type_ dari _network adapter_ \(misal : BCM43XX, rt3573, ath5k, ath9k, dll\)

Sumber bacaan lebih lanjut tentang _wireless network configuration_ dapat dibaca [di sini](https://wiki.archlinux.org/index.php/Wireless_network_configuration).

## 7.5 Enable Multilib Support for 32 bit Architecture

Meskipun laptop atau komputer kalian sudah menggunakan 64 bit, namun tidak ada salahnya untuk tetap mengaktifkan dukungan _library_ terhadap _processor_ 32 bit. Karena beberapa aplikasi terkadang masih membawa dependensi _library_ 32 bit.

```
$ sudo nano /etc/pacman.conf
```

Kemudian _scrolling_ ke bawah, cari bagian `[multilib]`, lalu aktifkan \(_uncommenting_\) baris tersebut dengan cara menghapus tanda pagar `#`.

<pre>
...
...
# If you want to run 32 bit applications on your x86_64 system,
# enable the multilib repositories as required here.

#[multilib-testing]
#Include = /etc/pacman.d/mirrorlist

<mark>[multilib]
Include = /etc/pacman.d/mirrorlist</mark>

...
...
</pre>

Setelah disimpan, lakukan _update repository_.

```
$ sudo pacman -Sy
```

## 7.6 Enable AUR \(Arch User Repository\)

Arch Linux selain memiliki _official repository_ yang dikelola oleh tim pengembang, tentu saja juga memiliki _repository_ yang di _maintenance_ oleh Arch _user_. AUR _package_ yang mempunyai popularitas yang baik akan dipertimbangkan dan berkesempatan untuk masuk ke dalam _official repository_. AUR _repository_ tidak langsung secara _default_ ada pada daftar _repository_ kita. Kita perlu mengaktifkannya terlebih dahulu.

Terdapat banyak cara, sejauh ini yang saya ketahui ada dua cara untuk mengaktifkan AUR _repository_. Namun saya hanya akan menuliskan satu saja cara yang menurut saya paling mudah. Yaitu dengan menambahkan _custom repository_ dari _archlinuxfr_.

```
$ sudo nano /etc/pacman.conf
```

Kemudian tambahkan _archlinuxfr repository_ ke bagian paling bawah.

```
...
...
[archlinuxfr]
Server = http://repo.archlinux.fr/$arch
SigLevel = Never
```

Setelah menambahkan _archlinuxfr repository_, saatnya melakukan sinkronisasi.

```
$ sudo pacman -Sy
```

Untuk dapat melakukan instalasi paket-paket yang terdapat pada AUR, kita memerlukan _package manager_ tambahan, _package manager_ ini sama seperti `pacman` yang juga di jalankan pada Terminal. Selama ini, saya menggunakan dua `package manager` untuk memasang paket pada repositori AUR yaitu `yaourt` dan `pacaur`. Namun kali ini saya hanya akan mendokumentasikan penggunaan `yaourt` saja,  untuk mempersingkat dan menyederhanakan kerumitan dari dokumentasi ini.

```
$ sudo pacman -S yaourt rsync customizepkg
```

<!-- INFORMATION -->
<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>Paket <b>Yaourt</b> sudah <i>deprecated</i> (usang). Saya lebih merekomendasikan untuk menggunakan <b>Yay</b>.</p>
<p>Untuk menginstall Yay, sangat mudah, dan tidak perlu menambahkan repo <code>[archlinuxfr]</code> seperti di atas.</p>
<pre>
$ git clone https://aur.archlinux.org/yay.git
$ cd yay
$ makepkg -si
</pre>
</div>

Setelah paket-paket di atas selesai di-*install*, saya merekomendasikan untuk men-*disable* kembali _archlinuxfr repository_, agar tidak terjadi bentrokan atau tumpang tindih paket antar _official repository_ dengan _archlinuxfr repository_.

Selanjutnya kita perlu untuk melakukan pengaturan pada `yaourt` sebelum dapat kita gunakan. Kita akan menjadikan Vim sebagai _default_ text editor untuk melihat PKGBUILD dari paket AUR yang kita _install_ dengan `yaourt`. PKGBUILD ini semacam resep yang berisi bahan-bahan dan cara meng-*install* paket ke dalam sistem Arch Linux kita.

Untuk BASH _shell_,

```
$ nano ~/.bashrc
```

Kita akan menambahkan pada baris terakhir \(atau pada baris mana saja\)

```
# PKGBUILD YAOURT
export VISUAL="vim"
```

_Save_ dan _exit_.

Cara di atas dimaksudkan apabila nanti `yaourt` menampilkan PKGBUILD saat proses instalasi paket, maka akan ditampilkan menggunakan Vim, dan kita bisa langsung _exit_ dengan `:q`.

Proses instalasi paket/aplikasi dengan menggunakan `yaourt` ini sedikit berbeda dengan menggunakan `pacman`. Mungkin kalian dapat mencari informasi pada dokumentasi Archer lain di Google atau Youtube tentang bagaimana proses instalasi paket/aplikasi menggunakan `yaourt`.

<!-- PERTANYAAN -->
<div class="blockquote-yellow">
<div class="blockquote-yellow-title">Mengapa perlu meng-enable-kan AUR ?</div>
<p>Karena kita membutuhkan paket-paket yang belum tersedia pada <i>official repositry</i>, sedangkah sudah tersedia pada AUR <i>repository</i>.</p>
<p>Beberapa paket pada AUR terkadang dibutuhkan untuk keleluasaan kita menggunakan distribusi sistem operasi Arch Linux.</p>
<p>Contohnya paket yang tidak terdapat pada <i>official repository</i> adalah: Google Chrome, Spotify, dan masih banyak lagi.</p>
</div>

## 7.7 ZSH Shell

Biasanya secara _default_, _shell_ yang dibawa setelah proses instalasi adalah BASH s_hell_. Kita dapat melakukan pengecekan dengan perintah di bawah.

```
$ echo $SHELL
```

_Shell_ adalah _environment_ pada Terminal _emulator_ tempat kita memasukkan baris-baris _command_. Terdapat berbagai macam jenis _shell_ dengan kelebihan fitur masing-masing, seperti BASH, ZSH, FISH, DASH, dsb. Saya pribadi lebih _prefer_ menggunakan ZSH _shell_. ZSH _shell_ fungsinya sama dengan BASH _shell_ namun dengan penambahan fitur-fitur lain, seperti _auto completion_ yang lebih memanjakan jari-jari. Hanya dengan mengetikkan 2 - 3 huruf awalan dari _command_, kemudian tekan tombol **TAB**, dengan pintar, ZSH akan melengkapi _command_ yang kita masukkan.

```
$ sudo pacman -S zsh zsh-completions
```

Selanjutnya kita akan buat ZSH _shell_ mejadi _default shell_, agar kita tidak perlu repot mengaktifkan ZSH _shell_ dengan mengetikkan `$ zsh` pada Terminal setiap saat.

```
$ chsh -s /usr/bin/zsh
```

Untuk me-_restart_ _shell_ tanpa harus mengeluarkan Terminal, cukup masukkan _command_ berikut.

```
$ exec $SHELL
```

Biasanya pada kondisi-kondisi tertentu kita perlu melakukan _restart_ terhadap Terminal, seperti sehabis instalasi program via `pacman` dan `yaourt` untuk dapat memanggil program-program yang baru saja di-_install_ atau di-_update_ tersebut, kita perlu melakukan _restart_ pada Terminal.

Pengaturan terakhir, jangan lupa pindahkan pengaturan _shell_ tambahan yang sudah pernah kita buat pada `~/.bashrc` ke dalam `~/.zshrc`.

```
$ nano ~/.zshrc
```

```
# PKGBUILD YAOURT
export VISUAL="vim"
```

Simpan dan _exit_.

## 7.8 Touchpad Driver

Untuk kalian yang menggunakan laptop, dapat meng-_install driver_ `libinput`. `libinput` adalah _library_ yang menangani _input devices_ pada `Wayland` _compositor_ dan `X.org`. `libinput` dapat mendeteksi dan mengatur pemrosesan _device_. Jadi sebenarnya `libinput` ini tidak khusus untuk _touchpad driver_ saja.

```
$ sudo pacman -S xf86-input-libinput
```

## 7.9 Graphic Card Driver

Sejak Intel menyediakan dan men-_support_ driver-driver yang _open source_, Intel graphics sudah secara langsung dapat di-_plug and play_ \(pasang tanpa membutuhkan driver\). Intel Kernel Module akan berjalan secara otomatis pada saat _system boot_.

Namun untuk kenyamanan berkomputasi yang lebih baik saya menyarankan untuk tetap meng_intall_ beberapa _package_ pendukung di bawah ini.

### 7.9.1 Mesa Driver

Pertama, kita perlu meng-_install_ `mesa` _package_, yang menyediakan dukungan terhadap DRI \(_Direct Rendering Infrastructur_\) driver untuk akselarasi gambar 3D.

```
$ sudo pacman -S mesa
```

### 7.9.2 DDX Driver \(xf86-video\)

Untuk dukungan terhadapr DDX driver \(yang menyediakan akselarasi gambar 2D pada `Xorg`\), kita membutuhkan `xf86-video-intel` _package_.

<!-- PERHATIAN -->
<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
<p>Debian & Ubuntu, Fedora, KDE, merekomendasikan untuk tidak meng-<i>install</i> <code>xf86-video-intel</code>. Dan tetap menggunakan <i>modesetting driver</i> yang sudah disertakan pada Intel GPU generasi ke 4 dan yang lebih baru.</p>
<p>Namun, bagaimanapun juga <i>modesetting</i> driver ini dapat pula menyebabkan problem seperti <a href="https://bugs.chromium.org/p/chromium/issues/detail?id=370022" target="_blank">Chromium Issue 370022</a>.</p>
</div>

```
$ sudo pacman -S xf86-video-intel
```

### 7.9.3 Vulkan Driver

Untuk dukungan terhadap Vulkan 3D _rendering_, kita perlu meng-_install_ `vulkan-intel` _package_.

```
$ sudo pacman -S vulkan-intel
```

Untuk kalian yang menggunakan Intel Processor generasi ke 4 \(Skylake\), kita perlu menambahkan konfigurasi `Xorg` tambahan agar kita dapat mengambil keuntungan dari beberapa _driver_ yang tersedia. Caranya, dengan membuat _file_ konfigurasi pada _file_ `/etc/X11/xorg.conf/20-intel.conf`.

```
$ sudo nano /etc/X11/xorg.conf/20-intel.conf
```

_File_ `20-intel.conf` ini masih kosong, karena baru saja kita buat. Selanjutnya, isikan seperti contoh di bawah.

```
Section "Device"
  Identifier  "Intel Graphics"
  Driver      "intel"
  Option      "DRI"   "2"          # DRI3 is now default
  #Option      "AccelMethod" "sna" # default
  #Option      "AccelMethod" "uxa" # fallback
EndSection
```

Preferensi di atas adalah preferensi yang direkomendasi saat pertama kali kita memasang paket `vulkan-intel`.

Namun saya mencoba untuk menggunakan DRI3.

```
Section "Device"
  Identifier  "Intel Graphics"
  Driver      "intel"
  # Option      "DRI"   "2"
  Option      "DRI"   "3"         # DRI 3 is now default
  Option      "AccelMethod" "sna" # default
  # Option      "AccelMethod" "uxa" # fallback
  Option      "TearFree"  "true"
EndSection
```

Konfigurasi di atas adalah hasil preferensi saya dari mencari solusi di Arch Forum karena permasalahan hasil _video screencast_ yang _flickering_. Jadi apabila ternyata tidak cocok atau menyebabkan masalah pada sistem kalian, maka kalian dapat mengikuti preferensi yang direkomendasikan.

Sumber bacaan lebih lanjut dapat dipelajari sendiri pada Arch Wiki [di sini](https://wiki.archlinux.org/index.php/Intel_graphics) \(Intel Graphic\).

Untuk teman-teman yang menggunakan _dual graphic card_, seperti Nvidia dan ATI dapat mempelajarinya [di sini](https://wiki.archlinux.org/index.php/NVIDIA) \(NVIDIA\) dan [di sini](https://wiki.archlinux.org/index.php/ATI) \(ATI\).

Sampai pada tahap ini mungkin kita bisa melakukan _restart system_ terlebih dahulu. Sekalian melakukan pengecekan apakah langkah-langkah konfigurasi yang telah kita lakukan telah berhasil.

```
$ reboot
```

![]()

Gambar 1 - Tampilan GNOME _Desktop Environment_

Nah, kalau kalian berhasil mencapai _dekstop_ **GNOME** seperti pada tampilan di atas. Artinya proses langkah-langkah konfigurasi berjalan sukses.

### 7.10 Encrypt Home Directory

Selain kita melakukan enkripsi terhadap partisi `/` , saya merekomendasikan untuk melakukan enkripsi pada `/home` direktori. Tujuannya tentu saja untuk memberikan pengamanan data yang berlapis-lapis. Namun meskipun pengamanannya berlapis, kita cukup memasukkan satu kali _password_ pada saat _login_ dan `/home` _directory_ kita sudah otomatis ter-_mounting_.

Pemberian enkripsi pada direktori `/home` ini memang sebaiknya dilakukan saat sistem baru pertama kali dipasang. Karena direktori `/home` dari `user` belum terdapat data-data di dalamnya.

Langkah pertama, kita perlu _logout_ dari sistem.

Setelah sampai di halaman GDM _Login Manager_, tekan kombinasi tombol **CTRL + ALT + F2** untuk berpindah ke `tty2` _shell_.

Kemudian _login_ sebagai `root`.

```
Arch Linux 4.13.12-1-ARCH (tty2)

Archer-Computer login: root
Password: _
```

Selanjutnya, lakukan pengecekan apakah `user` kamu masih memiliki proses yang _running_.

```
# Ps -U archer
```

```
PID  TTY      TIME  CMD
```

Apabila mengeluarkan _output_ seperti di atas, artinya sudah tidak ada lagi proses yang _runnning_ pada _user_ **archer** \(ganti dengan _username_ kalian\). Dan kita dapat melangkah ke tahap selanjutnya.

Instal _package_ yang diperlukan untuk melakukan enkripsi.

```
# pacman -S rsync lsof ecryptfs-utils
```

Tunggu proses instalasinya hingga selesai.

Selanjutnya, `modprobe ecryptfs` yang sudah kita instal tadi.

```
# modprobe ecryptfs
```

Kalau tidak ada _output_ apa-apa yang keluar, artinya sudah benar.

Selanjutnya, proses menggunakan `ecryptfs` untuk mengenkripsi direktori `/home`.

```
# ecryptfs-migrate-home -u archer
```

**archer** adalah nama `username` saya, ganti dengan `username` kalian.

<!-- PERHATIAN -->
<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
<p>Masukkan <b>password</b> yang sama dengan <b>login password username</b> kalian.</p>
</div>


```
INFO: Checking disk space, this may take a few minutes. Please be patient.
INFO: Checkingfor open files in /home/archer
Enter your login passphrase [archer]: _
```

Perhatikan dengan seksama _output_ tersebut. Kita diminta memasukkan _passphrase_ atau _password_ yang sama seperti _password username_ kita. Tujuannya agar saat kita login dengan menggunakan akun username kita, secara otomatis `ecryptfs` akan men-dekripsi direktori `/home` kita yang terenkripsi \(baca: auto-mounting `/home` directory\).

Proses ini akan menghabiskan ~~sedikit~~ waktu, tergantung dari banyaknya _file_ yang ada di dalam direktori `/home`.

Setelah selesai, kita dapat _logout_.

```
# exit
```

Kemudian _login_ kembali sebagai _user_ kita.

```
Arch Linux 4.13.12-1-ARCH (tty2)

Archer-Computer login: archer
Password: _
```

Kemudian, _mounting_ direktori `/home` yang terenkripsi dengan cara,

```
$ ecryptfs-mount-private
```

```
Enter your login passphrase: _
```

Masukkan _password login user_ kita untuk mendekripsi direktori `/home`  dan otomatis akan di _auto-mounting_ ke direktori `/home`.

Kemudian mungkin kalian ingin melihat `wrapped-passphrase` dalam bentuk yang tidak terenkripsi `unwrapped-passphrase`.

```
$ ecryptfs-unwrap-passphrase
```

Kalian dapat mencatatnya pada secarik kertas dan simpan baik-baik. Kalian dapat menggunakannya untuk me-*recovery* data-data yang terenkripsi pada kasus misalkan `wrapped-passphrase` tiba-tiba hilang atau _corrputed_ atau bahkan kalian lupa _login password_.

Selanjutnya lakukan pengecekan `auto-mount`, `auto-unmount`, `wrapped-passphrase`.

```
$ ls .ecryptfs
```

```
Private.mnt Private.sig auto-mount auto-unmount wrapped-passphrase
```

Apabila ada, akan menunjukkan _output_ seperti di atas.

Kemudian kita perlu menambahkan tiga baris propertis pada `/etc/pam.d/system-auth`. Ketiga baris propertis ini masing-masing memiliki penempatan yang berbeda-beda. Perhatikan dengan baik susunannya dan tidak boleh asal.

Gunakan _text editor_ Vim atau Nano.

```
$ sudo nano /etc/pam.d/system-auth
```

<pre>
#%PAM-1.0

auth      required  pam_unix.so     try_first_pass nullok
<mark>auth      required  pam_ecryptfs.so unwrap</mark>
auth      optional  pam_permit.so
auth      required  pam_env.so

account   required  pam_unix.so
account   optional  pam_permit.so
account   required  pam_time.so

<mark>password  optional  pam_ecryptfs.so</mark>
password  required  pam_unix.so     try_first_pass nullok sha512 shadow
password  optional  pam_permit.so

session   required  pam_limits.so
session   required  pam_unix.so
<mark>session   optional  pam_ecryptfs.so unwrap</mark>
session   optional  pam_permit.so
</pre>

_Reboot system_, dan pastikan kalian dapat _login_ ke _user desktop_ kalian.

Langkah terakhir adalah menghapus _backup_ dari direktori `/home` .

```
$ cd /home
```

Kemudian tampilkan isi dari direktori `/home`.

```
$ ls
```

```
archer archer.p7o6p7R2
```

Perhatikan bahwa terdapat direktori yang sama dengan direktori `username` kita, namun terdapat penambahan _random character_ di belakangnya. Ini adalah hasil _backup_ dari proses enkripsi kita sebelumnya.

Kita dapat menghapusnya dengan aman.

```
$ sudo rm -rvf archer.p7o6p7R2
```

Maka proses enkripsi direktori `/home` kita telah selesai.

## 7.11 Set Up Firewall

Cara terbaik untuk mengkonfigurasi firewall adalah dengan menggunakan [iptables](https://wiki.archlinux.org/index.php/Iptables), namun untuk user biasa seperti kita, rasanya sedikit terlalu rumit apabila menggunakan `iptables`. Kita akan menggunakan `ufw` \(_Uncomplicated Firewall_\) saja yang konfigurasinya lebih mudah.

```
$ sudo pacman -S ufw
```

Setelah selesai diinstall coba diaktifkan.

```
$ sudo ufw enable
```

Lalu buat `ufw.service` _running_ secara otomatis saat sistem start up.

```
$ sudo systemctl enable ufw.service
```

Sumber bacaan lebih lanjut dapat kalian temuka di Arch Wiki [di sini](https://wiki.archlinux.org/index.php/Uncomplicated_Firewall).

## 7.12 GUI Package Manager

Mungkin teman-teman bertanya, apakah Arch Linux mempunyai package manger yang tidak text mode namun mempunyai GUI seperti : `Synaptic` \(Ubuntu\), `Yumex-DNF` \(Fedora\), `YaST` \(OpenSUSE\), dan sebagainya. Jawabannya, tentu saja ada. Namun bukan merupakan official package dari Arch Linux, jadi kita dapat menginstallnya dari AUR \(_Arch User Repository_\).

```
$ yaourt pamac-aur
```

`pamac-aur` ini adalah sebuah aplikasi package manager yang mempunyai GUI yang dikembangkan oleh distribusi sistem operasi **Manjaro** yang juga merupakan turunan dari Arch Linux.

## 7.13 Daily Applications

<span class="font-latin">Sedang dalam proses penulisan ...</span>


<!-- NEXT PREV BUTTON -->
<div class="post-nav">
<a class="btn-blue-l" href="/arch/step-6-create-user-password-and-hostname"><img style="width:20px;" src="/assets/img/logo/logo_ap.png"></a>
<a class="btn-blue-c" href="/arch/"><img style="width:20px;" src="/assets/img/logo/logo_menu.png"></a>
<a class="btn-blue-r" href="/arch/bonus-backup-restore-and-recovery"><img style="width:20px;" src="/assets/img/logo/logo_an.png"></a>
</div>
