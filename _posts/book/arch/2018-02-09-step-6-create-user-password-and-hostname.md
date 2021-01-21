---
layout: 'post'
title: 'Step 6: Create User, Password and Hostname'
date: 2018-02-09 07:00
permalink: '/arch/:title'
author: 'BanditHijo'
license: true
comments: false
toc: true
category: 'arch'
tags:
pin:
---


# STEP 6 : Create User, Password and Hostname

## 6.1 User and Password

Secara _default_, Arch Linux yang telah kita _install_ telah memiliki akun, yaitu `root`. Yang ditandai dengan tanda `#` pada Terminal. Dan saat ini pun kita sedang menggunakan akun `root`. Namun akun ini secara _default_ **belum memiliki password**. Oleh karena itu kita perlu bahkan lebih ke-**harus** mengeset _password_ untuk akun `root`.

{% shell_root %}
passwd root
{% endshell_root %}

Kemudian, masukkan _password_ untuk akun `root`. Karakter _password_ memang tidak akan ditampilkan. Kamu akan diminta memasukkan _password_ yang sama, sebanyak dua kali. Dan **jangan sampai lupa**, karena akun `root` ini adalah akun yang sangat penting.

```
New password:
Retype new password:
passwd: password updated successfully
```

Kita sudah membuat _password_ untuk akun `root`. Namun, untuk pengunaan sehari-hari sebaiknya kita tidak menggunakan akun ini. Sangat direkomendasikan untuk membuat akun `user`. Caranya sebagai berikut.

Buat _group_ `sudo` terlebih dahulu.

{% shell_root %}
groupadd sudo
{% endshell_root %}

Kemudian buat _username_.

{% shell_root %}
useradd -m -g users -G sudo,storage,wheel,power,input,network bandithijo
{% endshell_root %}

Saya menggunakan _username_ **bandithijo**. Kamu dapat mengganti dengan _username_ yang kamu inginkan. Sebagai catatan _username_ haruslah berupa karakter huruf, _lowercase_ \(huruf kecil\), dan tidak boleh ada spasi.

Setelah membuat akun `user`, kita akan mengeset _password_ untuk user baru ini.

{% shell_root %}
passwd bandithijo
{% endshell_root %}

```
New password:
Retype new password:
passwd: password updated successfully
```

Masukkan _password_ untuk akun **bandithijo**.

Selanjutnya, mengeset `/etc/sudoers`. Kita akan mengaktifkan perintah `sudo` agar dapat memiliki kemampuan seperti _superuser_.

Kemudian, _edit_ file `/etc/sudoers`.

{% shell_root %}
vi /etc/sudoers
{% endshell_root %}

_Scrolling_ ke bawah dan cari `# %sudo ALL = (ALL) ALL`. Lalu hapus tanda pagar `#` untuk meng-_enable_-kan user yang termasuk dalam _group_ `sudo` dapat mengeksekusi semua _command_ \(perintah\) pada Terminal. Hasilnya seperti contoh di bawah.

{% highlight_caption /etc/sudoers %}
{% pre_caption %}
...
...
## Uncomment to allow members of group sudo to execute any command
<mark>   %sudo    ALL=(ALL) ALL</mark>
...
...
{% endpre_caption %}

Simpan dan keluar.

Untuk Vi, simpan dengan `:w!` untuk memaksa menyimpan perubahan pada file dengan *read only permisson*.

## 6.2 Hostname

Pada _step_ ini, kita akan memberikan _hostname_ pada sistem kita. Sebenarnya ini bukan hal yang _crucial_, namun karena ini komputer atau laptop pribadi kita, ada baiknya kita memberikan preferensi tersendiri.

Untuk mengkonfigurasi `hostname`,

{% shell_root %}
echo 'arch.machine' > /etc/hostname
{% endshell_root %}

Perintah di atas akan menambahkan `arch.machine` pada _file_ `/etc/hostname`.

Ganti dan `arch.machine`, sesuai dengan keinginan kalian.

Kita dapat mengecek isi dari `/etc/hostname` dengan menggunakan perintah `$ cat /etc/hostname`.

{% box_info %}
<p markdown=1>Penamaan `hostname` berbeda dengan penamaan pada `username`. Pada `hostname`, kita dapat menggunakan _uppercase_ \(kapital\), angka, simbol dan tanpa spasi.</p>
{% endbox_info %}


<hr>
Oke, saat ini proses konfigurasi dasar dari sistem operasi Arch Linux sudah selesai. Namun, kita membutuhkan sistem operasi yang pengoperasiannya menggunakan GUI \(_Graphical User Interface_\) atau biasa dikenal dengan DE \(_Desktop Environment_\) agar kita dapat menggunakan sistem operasi ini dengan mudah. Karena saat ini, sudah sangat jarang ditemukan user yang masih menggunakan _text mode_ atau WM \(_Window Manager_\) pada komputer atau laptop pribadinya. Meskipun saya termasuk yang malah ketagihan menggunakan WM.

Langkah selanjutnya adalah melihat apakah proses instalasi kita berhasil atau tidak. Kita akan melakukan _reboot system_ untuk mengeceknya.

Namun sebelumnya, tambahkan dulu paket-paket di bawah ini. Agar memudahkan konektifitas jaringan. Saat kita sudah memasuki sistem dasar yang sudah kita bangun.

{% shell_root %}
pacman -S networkmanager network-manager-applet
{% endshell_root %}

Aktifkan servicenya saat boot.

{% shell_root %}
systemctl enable NetworkManager.service
{% endshell_root %}

{% box_info %}
<p>Paket <code>network-manager-applet</code> diperlukan untuk memberikan NetworkManager trayicon.</p>
{% endbox_info %}

{% box_perhatian %}
<p markdown=1>Penting agar sebelum melakukan restart, kita harus memasang *comprehensive network manager*, seperti **NetworkManager**, **ConnMan**, dan lain sebagainya.</p>
<p markdown=1>Kalau tidak, saat kembali dari restart, kita tidak akan memiliki akses networking.</p>
<p markdown=1>Untuk teman-teman yang sudah mahir, dapat menggunakan pilihan pengaturan networking sendiri.</p>
<p markdown=1>Seperti menggunakan **netctl**, **dhcp**, atau untuk Wi-Fi: **wpa_supplicant** atau **iwd**.</p>
{% endbox_perhatian %}

Setelah itu _exit_ dari **arch-chroot**.

{% shell_root %}
exit
{% endshell_root %}

_Unmounting_ semua partisi yang sebelumnya kita _mount_ ke direktori `/mnt`.

{% shell_root %}
umount -R /mnt
{% endshell_root %}

Lalu _restart_.

{% shell_root %}
reboot
{% endshell_root %}

{% box_info %}
<p markdown=1>Saat proses restart, kita akan diminta untuk memasukkan password dari disk **/dev/sda2** yang terenkripsi.</p>
<pre>
A password is required to access the volume volume:
Enter passphrase for /dev/sda2: _
</pre>
{% endbox_info %}

<br>
Setelah sampai di halaman _login_.

```
Arch Linux 5.10.4-1-arch2-1 (tty1)
arch login: _
```

_Login_ dengan akun yang telah kita buat pada Step 6.1.

```
[bandithijo@arch ~]$ _
```

Kalau pada tahap ini kalian berhasil. **Welcome to the BrotherHood !**



<!-- NEXT PREV BUTTON -->
{% assign btn-next = "/arch/step-5-set-language-and-time-zone" %}
{% assign btn-menu = "/arch/" %}
{% assign btn-prev = "/arch/step-7-install-gnome-and-complete-installation" %}
<div class="post-nav">
<a class="btn-blue-l" href="{{ btn-next }}"><img class="btn-img" src="/assets/img/logo/logo_ap.png"></a>
<a class="btn-blue-c" href="{{ btn-menu }}"><img class="btn-img" src="/assets/img/logo/logo_menu.svg"></a>
<a class="btn-blue-r" href="{{ btn-prev }}"><img class="btn-img" src="/assets/img/logo/logo_an.png"></a>
</div>
