---
layout: 'post'
title: 'Step 4: Set up Bootloader'
date: 2018-02-09 05:00
permalink: '/arch/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'arch'
tags:
pin:
---


# STEP 4 : Set up Bootloader

## 4.1 Install Bootloader \(systemd-boot\)

Saya memilih menggunakan `systemd-boot` ketimbang `GRUB` karena lebih mudah buat saya pahami. Sebelumnya `systemd-boot` ini bernama `gummiboot`, saya gunakan juga pada mesin MacBook Pro 8.1 \(_late_ 2011\). Menurut saya `systemd-boot` ini lebih sederhana dan simpel, serta sudah termasuk dalam paket `systemd`, yang mana sudah terpasang secara _default_ bersama _base system_ Arch.

Instalasi `systemd-boot` ke `/dev/sda1` yang telah di-_mount_ ke `/mnt/boot`.

```
# bootctl ––path=/boot install
```

```
Created “/boot/EFI”.
Created “/boot/EFI/systemd”.
Created “/boot/EFI/BOOT”.
Created “/boot/loader”.
Created “/boot/loader/entries”.
Copied “/usr/lib/systemd/boot/efi/systemd-bootx64.efi” to “/boot/EFI/systemd/systemd-bootx64.efi”.
Copied “/usr/lib/systemd/boot/efi/systemd-bootx64.efi” to “/boot/EFI/BOOT/BOOTX64.EFI”.
Created EFI boot entry “Linux Boot Manager”.
```

Pastikan **tidak terjadi **_**error**_ seperti “_File system “/boot” is not a FAT EFI System Partition \(ESP\) file system._”. Apabila terjadi _error_ seperti ini, maka besar kemungkinan terjadi kesalahan pada saat _mounting partition_ \(Step 3.1\). Kamu bisa kembali melakukan _mounting_ ulang dengan terlebih dahulu keluar dari `chroot` =&gt; `# exit`.

## 4.2 Bootloader Configuration

Setelah `systemd-boot` berhasil terpasang, langkah selanjutnya adalah mengkonfigurasi _file_ `loader.conf` dan membuat `arch.conf`.

Langkah ini membutuhkan _text editor_. Saya terbiasa menggunakan `vim`. Namun untuk kebutuhan dokumentasi ini, saya akan menggunakan _text editor_ `nano`.

```
# pacman -S nano
```

Sekarang, saatnya kita mengedit _file_ `/boot/loader/loader.conf`

```
# vim /boot/loader/loader.conf
```

Kemudian isikan seperti contoh yang ada di bawah.

```
default arch
timeout 3
```

> **\[ ! \] PERHATIAN**
>
> Secara _default_, _file_ `loader.conf` sudah terdapat isi di dalamnya. Kita dapat menghapus isi sebelumnya dan mengganti atau isikan persis sama seperti contoh di atas. Untuk isi dari `default` penamaan harus sama dengan _file_ preferensi yang akan kita buat pada langkah selanjutnya \(di bawah\). Saya menggunakan nama yang simple, yaitu `arch` , yang nantinya akan dibuatkan _file_ bernama `arch.conf`.
>
> `timeout 3` nilai ini dapat kalian sesuaikan dengan preferensi kalian masing-masing. Penulis biasanya menggunakan nilai `1` atau bahkan `0`.

Apabila sudah dipastikan tidak terdapat _typo_, kalian dapat keluar dari Nano dengan menekan tombol `CTRL`+`X`. Kemudian konfirmasi perubahan dengan menekan tombol `Y`, setelah itu `↲`.

Tahap selanjutnya terlebih dahulu siapkan _smartphone_ atau kertas dan pulpen untuk mencatat nomor UUID.

```
# blkid -s UUID -o value /dev/sda2
```

Catat atau untuk menghindari kesalahan, foto saja nomor UUID yang tampak di layar agar lebih mudah.

Kemudian kita akan membuat _file_ `arch.conf`

```
# nano /boot/loader/entries/arch.conf
```

Isikan persis sama seperti yang tertulis di bawah.

```
title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options cryptdevice=UUID=56fdc3fa-8a1c-4d4e-a13f-4af99bf6ae6a:volume root=/dev/mapper/volume-root rw
```

Ganti `UUID=56fdc3fa-8a1c-4d4e-a13f-4af99bf6ae6a` dengan UUID milikmu. Jangan sampai ada yang _typo_. Harus benar-benar sama persis. Apabila terjadi  kesalahan dapat menyebabkan sistem operasi yang tersimpan pada `/dev/sda2` tidak dapat dikeluarkan ke dalam RAM.

Setelah kalian memastikan tidak terdapat _typo_, kalian dapat keluar dari Nano dengan menekan tombol `CTRL`+`X`. Kemudian konfirmasi perubahan dengan menekan tombol `Y`, setelah itu `↲`.

Kemudian lakukan _update_ `systemd-boot`.

```
# bootctl update
```

Karena kita menggunakan partis LVM yang terenkripsi untuk itu kita perlu mengedit _file_ `/etc/mkinitcpio.conf` agar kita dapat menggunakan _keyboard_ untuk memasukkan _password_ sebelum sistem mencoba untuk menjalankan _filesystems_.

```
# nano /etc/mkinitcpio.conf
```

Cari baris yang bertuliskan `HOOKS=(base udev dst... )`

```
...
...

HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)
...
...
```

Pindahkan `keyboard` setelah `block` dan tambahkan `encrypt` dan `lvm2`, seperti contoh di bawah ini.

```
...
...

HOOKS=(base udev autodetect modconf block keyboard encrypt lvm2 filesystems fsck)
...
...
```

Setelah kalian memastikan tidak terdapat _typo_, kalian dapat keluar dari Nano dengan menekan tombol `CTRL`+`X`. Kemudian konfirmasi perubahan dengan menekan tombol `Y`, setelah itu `↲`.

Langkah terakhir pada proses _bootloader configuration_ ini adalah, _update_ `initramfs` dengan cara sebagai berikut.

```
# mkinitcpio -p linux
```

Untuk kalian yang menggunakan _processor_ Intel. Sebaiknya kita menambahkan paket yang bernama `intel-ucode`. Kegunaannya dapat dibaca [di sini](https://wiki.archlinux.org/index.php/Microcode).

```
# pacman -S intel-ucode
```

Kemudian tambahkan `initrd /intel-ucode.img` pada file `/boot/loader/entries/arch.conf` seperti contoh di bawah.

```
# nano /boot/loader/entries/arch.conf
```

```
title Arch Linux
linux /vmlinuz-linux
initrd /intel-ucode.img
initrd /initramfs-linux.img
options cryptdevice=UUID=56fdc3fa-8a1c-4d4e-a13f-4af99bf6ae6a:volume root=/dev/mapper/volume-root rw
```

Setelah kalian memastikan tidak terdapat _typo_, kalian dapat keluar dari Nano dengan menekan tombol `CTRL`+`X`. Kemudian konfirmasi perubahan dengan menekan tombol `Y`, setelah itu `↲`.

Kemudian lakukan _update_ `systemd-boot` dan _generate_ `mkinitcpio`.

```
# bootctl update
```

```
# mkinitcpio -p linux
```

Langkah di atas kita lakukan karena kita menggunakan `systemd-boot`. Untuk _bootloader_ `GRUB`, hanya tinggal melakukan _regenrate_ `grub-mkconfig` saja. Namun, saya kurang begitu memahaminya.

Sampai di sini, apabila kita _reboot_, sebenarnya kita sudah dapat masuk ke dalam Arch sistem. Namun sistem kita masih belum lengkap karena kita perlu melakukan beberapa konfigurasi dasar yang diperlukan oleh sebuah sistem operasi. Seperti, _locale_, _hostname_, _username_, _password_, _zoneinfo_ _time_, dll. Untuk itu, sementara kita lanjutkan saja pada _session_ ini.


<!-- NEXT PREV BUTTON -->
<div class="post-nav">
<a class="btn-blue-l" href="/arch/step-3-installing-arch-linux-base-packages"><img style="width:20px;" src="/assets/img/logo/logo_ap.png"></a>
<a class="btn-blue-c" href="/arch/"><img style="width:20px;" src="/assets/img/logo/logo_menu.png"></a>
<a class="btn-blue-r" href="/arch/step-5-set-language-and-time-zone"><img style="width:20px;" src="/assets/img/logo/logo_an.png"></a>
</div>
