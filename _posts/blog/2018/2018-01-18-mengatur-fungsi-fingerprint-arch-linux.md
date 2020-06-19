---
layout: 'post'
title: 'Mengatur Fungsi dari Fingerprint pada Arch Linux'
date: 2018-01-18
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['ThinkPad', 'Arch Linux', 'Tips']
pin:
hot:
---

<img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="https://2.bp.blogspot.com/-ivgbZvKVSI4/WmBTWBAqElI/AAAAAAAAG4g/QKm653CH2nQ89IabEC5hkfDd8kF1QFbtQCLcBGAs/s1600/Default%2BHeader%2BTemplate%2BPost%2B2X.png" onerror="imgError(this);" alt="banner">

# Latar Belakang
Untuk dapat menggunakan _fingerprint scanner_, terlebih dahulu kalian harus memastikan apakah tipe dari _fingerprint scanner_ yang kalian miliki telah didukung atau tidak. Kalian dapat melakukan pengecekan dengan mengunjungi link berikut ini: [libfprint_supported_devices](https://www.freedesktop.org/wiki/Software/fprint/libfprint/Supported_devices/){:target="_blank"}.

_FingerPrint scanner_ dapat digunakan secara _plug and play_ pada Arch Linux (dan beberapa distro tertentu yang saya sudah coba seperti Fedora) diatur oleh _fprint project_. Idenya adalah untuk membuat _built-in fingerprint scanner_ pada beberapa jenis laptop dapat melakukan _login_ dengan memanfaatkan [PAM](https://wiki.archlinux.org/index.php/PAM){:target="_blank"} (_Pluggable Authentication Modules_).

# Prasyarat
Untuk mengetahui tipe dan _brand_ dari _fingerprint scanner_ yang kalian miliki, gunakan _command_ berikut ini,
```
$ lsusb
```
<pre>
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
<mark>Bus 001 Device 004: ID 138a:0017 Validity Sensors, Inc. VFS 5011 fingerprint sensor</mark>
Bus 001 Device 003: ID 04f2:b52c Chicony Electronics Co., Ltd
Bus 001 Device 005: ID 046d:c52b Logitech, Inc. Unifying Receiver
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
</pre>
Dari keterangan di atas dapat terlihat bahwa _fingerprint_ saya ada pada baris kedua.

# Instalasi
Untuk dapat menggunakan _fingerprint scanner_, kalian membutuhkan paket bernama [fprintd](https://www.archlinux.org/packages/?name=fprintd){:target="_blank"}. Mungkin beberapa paket lain seperti [imagemagick](https://www.archlinux.org/packages/?name=imagemagick){:target="_blank"} juga akan diperlukan sebagai dependensi.

```
$ sudo pacman -S fprintd
```

# Konfigurasi
Setelah melakukan instalasi paket fprintd, lantas kita perlu melakukan beberapa konfigurasi. Kalian dapat memilih konfigurasi-konfigurasi apa saja yang kalian perlukan dari beberapa konfigurasi yang saya lakukan di bawah ini. Tidak harus semua dilakukan, pilih saja yang kalian butuhkan.

## Login
Untuk kalian yang menggunakan Gnome 3.26, _login manager_ diatur oleh GDM. Apabila kalian ingin menggunakan _fingerprint scanner_ untuk _login_ pada GDM, kalian dapat mengikuti langkah ini. Gnome sudah menyediakan _fingerprint option_ yang dapat kalian atur pada **Settings > Details > Users**. Kalian akan melihat window seperti di bawah ini,

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://2.bp.blogspot.com/-QCKqPEIkctA/WmBdqy0o-kI/AAAAAAAAG4w/39ie3sVWaCA7Cn5U0Mkmwbk2lhNE3TiHwCLcBGAs/s1600/gambar_1.png" onerror="imgError(this);"}
<p class="img-caption">Gambar 1 - Settings > Details > Users</p>

Kalian dapat melihat pada Gambar 1, terdapat _Fingerprint Login option_ dengan nilai “_Enabled_”. Bagi teman-teman yang belum melakukan konfigurasi maka akan tertulis “_Disabled_”.

Untuk dapat mengaktifkan _fingerprint login_, kalian perlu membuka kunci dari Settings dengan meng-klik tombol “_Unlock_” yang terdapat pada _top bar window Settings_ terlebih dahulu. Kemudian pilih _Fingerprint Login_, dan ikuti petunjuk untuk melakukan _enroll_ terhadap sidik jari kalian.

><p class="title-quote"> [ ! ] Perhatian </p>
>Apabila fingerprint option tidak terdapat pada menu Settings, kalian dapat menambahkan username kalian ke dalam input group. Dengan cara,
>
><code>$ sudo usermod -aG input <mark>username</mark></code>
>
>Ganti username dengan nama username kalian.

><p class="title-quote">Apakah penulis juga menggunakan fingerprint scanner saat login ?</p>
>Saya sendiri, menggunakan LightDM untuk login kedalam i3wm, dan saya tidak mengatur option fingerprint scanner untuk login ke dalam sistem. Karena alasan tertentu yang berhubungan dengan dekripsi direktori tertentu pada sistem, saya memilih untuk memasukkan password secara manual.
>
>Lagipula memasukkan password pada login manager juga tidak sering kita lakukan seperti halnya memasukkan password sudo atau permission yang lainnnya. Maka dari itu saya teteap memilih untuk memasukkan password login secara manual. Hehehe

## Membuat Fingerprint Signature secara Manual
Bagi teman-teman yang tidak menggunakan Gnome seperti di atas, Ada 2 cara untuk membuat _signature_ sidik jari kalian, yaitu dengan _signature_ hanya 1 jari dan _signature_ dengan semua jari (banyak jari).

<br>
**Satu Jari (satu jari tertentu)**

Untuk menambahkan _signature_ 1 jari, defaultnya adalah telunjuk kanan.
<pre>
$ <b>fprintd-enroll <mark>username</mark></b>
</pre>
*Ganti `username` dengan nama _username_ kamu.

Untuk jari tertentu, gunakan flag `-f` dikuti nama jarinya.

Berikut ini daftar nama jari.

| --- | --- |
| left-thumb | right-thumb |
| left-index-finger | right-index-finger |
| left-middle-finger | right-middle-finger |
| left-ring-finger | right-ring-finger |
| left-little-finger | right-little-finger |

<pre>
$ <b>fprintd-enroll <mark>username</mark> -f <mark>nama_jari</mark></b>
</pre>

<br>
**Semua Jari**

Atau, dengan membuat baru _signature_ untuk semua jari, namun terlebih dahulu kita perlu menghapus _signature_ yang sudah kita buat sebelumnya,

<pre>
$ <b>fprintd-delete <mark>username</mark></b>
</pre>
*Ganti `username` dengan nama _username_ kamu.

Selanjutnya, langkah memasukkan _signature_ untuk semua jari,
<pre>
$ for finger in {left,right}-{thumb,{index,middle,ring,little}-finger}; do fprintd-enroll -f $finger <mark>username</mark>; done
</pre>
*Ganti `username` dengan nama username kamu.

Kemudian, kalian akan diminta memasukkan 10 sidik jari dengan masing-masing 3x scan setiap jari.

## Konfirmasi Fingerprint

Setelah kita mendaftarkan sidik jari, kita perlu melakukan konfirmasi, apakah sidik jari yang usdah kita inputkan dapat digunakan atau tidak.

<pre>
$ <b>fprintd-verify <mark>username</mark></b>
</pre>

```
Using device /net/reactivated/Fprint/Device/0
Listing enrolled fingers:
 - #0: right-index-finger
```

Nah, kita diminta untuk melakukan scanning terhadap jari yang dimaksud.

Apabila benar, akan keluar tampilan seperti ini.

```
Verify result: verify-match (done)
```

## Mengamankan FingerPrint Signature
Secara _default_, hasil _enroll_ dari _fingerprint scanner_ yang sudah kita buat dapat dengan mudah ditimpa dengan yang baru atau dihapus dengan perintah `$ fprintd-delete`, tanpa perlu terlebih dahulu menggunakan `sudo` _permission_. Kalian dapat mengubah aturan ini dengan memanfaatkan pengaturan pada _Polkit rules_.

Kita akan membuat file baru pada `/etc/polkit-1/rules.d/` dengan isi hanya _superuser_ yang dapat melakukan perubahan pada _fingerprint signature_.

<pre>
$ <b>sudo vim /etc/polkit-1/rules.d/50-net.reactivated.fprint.device.enroll.rules</b>
</pre>

{% highlight config linenos %}
polkit.addRule(function (action, subject) {
    if (action.id == "net.reactivated.fprint.device.enroll") {
        return subject.user == "root" ? polkit.Result.YES : polkit.result.NO
    }
})
{% endhighlight %}

Sekarang, untuk melakukan _enroll fingerprint_ harus **membutuhkan _sudo permission_ terlebih dahulu**.

### PAM
Untuk menggunakan _fingerprint scanner_ pada saat Terminal meminta kita memasukan _password sudo_, atau saat sistem meminta kita memasukkan _password Polkit_, kita perlu mengedit dan melakukan penambahan beberapa baris perintah pada isi dari file-file yang terdapat pada direktori `/etc/pam.d/` berikut ini.

### Sudo
Untuk menggunakan _fingerprint_ pada saat menggunakan `sudo`,

```
$ sudo vim /etc/pam.d/sudo
```
<pre>
#%PAM-1.0

<mark>auth  	 sufficient  pam_unix.so try_first_pass likeauth nullok
auth     sufficient  pam_fprintd.so</mark>

auth     include    system-auth
account  include    system-auth
session  include    system-auth

</pre>
Letakkan pada bagian atas dari aturan (*rules*) yang sudah ada sebelumnya.

Tujuannya agar kita diminta untuk memasukkan *fingerprint* terlebih dahulu, apabila gagal, maka akan dilanjutkan dengan inputan sudo password.

### Polkit
Untuk menggunakan _fingerprint_ pada saat ada aplikasi GUI yang membutuhkan akses _superuser_ dengan bantuan _Polkit_,
```
$ sudo vim /etc/pam.d/polkit-1
```
<pre>
#%PAM-1.0

<mark>auth      sufficient  pam_fprintd.so</mark>
auth      include     system-auth
account   include     system-auth
password  include     system-auth
session   include     system-auth
</pre>
Tambahkan seperti yang tertulis pada line ke-3.

`auth sufficient pam_fprintd.so`.

### i3lock

~~Untuk membuka i3lock dengan menggunakan _fingerprint scanner_,~~

<s><pre>
$ <b>sudo vim /etc/pam.d/i3lock</b>
</pre></s>

<s><pre>
#
# PAM configuration file for the i3lock screen locker. By default, it includes
# the 'system-auth' configuration file (see /etc/pam.d/login)
#

#auth  include     system-auth

<mark>auth   sufficient  pam_unix.so    try_first_pass likeauth nullok
auth   sufficient  pam_fprintd.so</mark>
</pre></s>

~~*Disable isi sebelumnya dengan menambahkan tanda `#` pada awal baris, kemudian tambahkan 3 baris di bawahnya, seperti contoh di atas.~~

~~Untuk dapat menggunakannya, saat i3lock sudah aktif, terlebih dahulu kita harus menekan tombol <kbd>Enter</kbd>, maka _fingerprint scanner_ akan aktif, kemudian _unlock_ i3lock dengan melakukan _enroll fingerprint_.~~

# Referensi
1. [wiki.archlinux.org/index.php/Fprint](https://wiki.archlinux.org/index.php/Fprint)
<br>Diakses tanggal: 2018/01/18
2. [bbs.archlinux.org/viewtopic.php?id=176181](https://bbs.archlinux.org/viewtopic.php?id=176181)
<br>Diakses tanggal: 2018/01/18
