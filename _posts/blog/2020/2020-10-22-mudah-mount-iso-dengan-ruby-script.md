---
layout: 'post'
title: "Mudah Mount & Unmount File ISO Image dengan Ruby Script"
date: 2020-10-22 06:52
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Ruby', 'Tips']
pin:
hot:
contributors: []
---

# Latar Belakang

Sejak 2018 hingga saat ini (2020), saya sudah jarang sekali memanfaatkan file manager GUI, seperti Thunar, PCMANFM, ataupun Nautlius untuk mengurusi pekerjaan manajemen file. Hal-hal seperti explorasi file dokumen, file gambar, video, audio, semuanya dapat saya lakukan di **ranger** --[baca tentang ranger](/blog/ranger-file-manager){:target="_blank"}.

# Masalah

Namun, ada beberapa hal yang salah satunya masih saya kerjakan menggunakan file manager GUI, yaitu **mount & unmount file ISO image**.

Kadang saya perlu untuk melakukan inspeksi terhadap file ISO yang akan saya jalankan di Virt-Manager. Untuk melihat apakah terdapat hal-hal yang janggal atau tidak.

# Pemecahan Masalah

Pada catatan ini, saya akan menunjukkan 2 cara.

## 1. Manual dengan mount & umount command

Cara ini adalah cara yang menjadi hal dasar sebagai pengguna sistem operasi GNU/Linux atau Unix like.

Kita perlu mengetahui bagaimana cara menggunakan command `mount` & `umount`.

**Mount ISO image**

<pre class="url">
$ <b>sudo mount -l -o loop /source/path/iso /target/path</b>
</pre>

Misal,

<pre>
$ <b>sudo mount -l -o loop archlinux.iso /run/media/bandithijo</b>
</pre>

<pre>
$ lsblk
NAME   FSTYPE    SIZE TYPE LABEL       MOUNTPOINT
<mark>loop0  iso9660   681M loop ARCH_202010 /run/media/bandithijo</mark>
sda            447.1G disk
└─sda1 ext4    447.1G part             /
</pre>

Maka, isi dari direktori `/run/media/bandithijo/` adalah

<pre>
$ ls -l /run/media/bandithijo
total 697396
-rw-r--r-- 1 bandithijo users 714080256 Oct 20 02:11 archlinux-2020.10.01-x86_64.iso
drwxr-xr-x 2 bandithijo users      4096 May  3 08:54 Backup
-rw-r--r-- 1 bandithijo users        66 Feb 14  2019 cek_md5
-rwxr-xr-x 1 bandithijo users       246 Oct  9 18:57 lazymigrate.rb
drwxr-xr-x 3 bandithijo users     12288 May  3 08:54 Manual
</pre>

Keterangan perintah:

`-l`, untuk memberikan label yang disertakan oleh ISO image.

`-o loop`, untuk option menggunakan **loopback** device.

<br>
**Unmount ISO image**

<pre class="url">
$ <b>sudo umount /target/path</b>
</pre>

Misal,

<pre>
$ <b>sudo umount /run/media/bandithijo</b>
</pre>

Atau, bisa juga menggunakan ISO image yang dimount sebelumnya.

<pre>
$ <b>sudo umount archlinux.iso</b>
</pre>

<!-- PERHATIAN -->
<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
<p markdown="1">Perlu diperhatikan, perintah yang digunakan untuk melakukan proses *unmount*.</p>
<p markdown="1">Bukan `unmount` tapi `umount`.</p>
</div>

## 2. Otomatis dengan Ruby script

Kalau teman-teman perhatikan, proses mount & unmount menggunakan file manager GUI, akan memberikan path dengan nama label sebagai akhirnya.

Misal, file archlinux.iso sebelumnya, maka nama pathnya akan menjadi seperti ini.

<pre class="url">
/run/media/bandithijo/ARCH_202010/
</pre>

Cantik bukan.

Sedangkan kalau kita mount manual, kita perlu membuat direktori dengan nama label atau nama tertentu terlebih dahulu. Tidak praktis.

Maka dari itu, agar proses tersebut dapat saya tiru, tanpa perlu repot, saya buat Ruby script saja.

{% highlight ruby linenos %}
#!/usr/bin/env ruby

target_image = ARGV[0].strip
request      = ARGV[1]&.strip

ARGV.clear

# mount & unmount method
def mount_process(request, target_image)
  username     = `echo $USER`&.strip
  target_path  = "/run/media/#{username}"
  target_label = `file '#{target_image}' | cut -d \\\' -f2`&.strip
  if request == 'm'
    system "
    if [[ ! -d #{target_path}/#{target_label} ]]; then
      sudo mkdir -p #{target_path}/#{target_label}
      sudo mount -l -o loop '#{target_image}' #{target_path}/#{target_label} 1> /dev/null 2>&1
      echo '=> MOUNTED on #{target_path}/#{target_label}'
    elif [[ -d #{target_path}/#{target_label} ]]; then
      sudo mount -l -o loop '#{target_image}' #{target_path}/#{target_label} 1> /dev/null 2>&1
      echo '=> MOUNTED on #{target_path}/#{target_label}'
    else
      echo '=> WAS MOUNTED'
    fi
    "
  elsif request == 'u'
    system "
    if [[ -d #{target_path}/#{target_label} ]];
    then
      sudo umount '#{target_image}'
      sudo rm -rf #{target_path}/#{target_label}
      echo '=> UNMOUNTED'
    else
      echo '=> NOT MOUNTED'
    fi
    "
  else
    puts '=> WRONG REQUEST'
    exit
  end
end

# interface
begin
  if request
    mount_process(request, target_image)
  elsif target_image
    puts "
  Options:

    press m for mount
    press u for unmount
    "
    print '=> '
    request = gets.chomp

    mount_process(request, target_image)
  else
    puts "
  => YOU SHOULD ADD IMAGE AS ATTRIBUTE

  Example:

    $ imagemounter <image_name.iso>    (interactive)

    OR

    $ imagemounter <image_name.iso> m  (mounting)
    $ imagemounter <image_name.iso> u  (unmount)
    "
    exit
  end
rescue Interrupt
  puts "\b" * 2 + 'Exit...'
  exit
end
{% endhighlight %}

Output

<pre>
$ isomounter archlinux.iso

Options:

  press m for mount
  press u for unmount

=> m
=> MOUNTED on /run/media/bandithijo/ARCH_202010
</pre>

<pre>
$ isomounter archlinux.iso

Options:

  press m for mount
  press u for unmount

=> u
=> UNMOUNTED
</pre>

# Kekurangan

Kekurangan terbesar dari Ruby wrapper script ini adalah proses dari script ini memerlukan hak akses root.

Karena terdapat perintah `mkdir` untuk membuat direktori di alamat `/run/media/<username>/`, serta `mount` ke alamat tersebut juga memerlukan hak akses root sehingga mau tidak mau, kita harus menggunakan sudo.

# Alternatif (Recommended)

## 1. Memanfaatkan Udisks2

Kalau proses mount memerlukan hak akses root, kita dapat memanfaatkan **udisks2** (**udisksctl**) --[baca tentang **udisks**](https://bandithijo.github.io/blog/menggunakan-udiskctl){:target="_blank"}.

Selain untuk Disk/Drive, Udisks juga dapat kita gunakan untuk melakukan mount & unmount file ISO.

Sebelumnya, kita samakan persepsi dulu yaa.

<pre class="url">
NAME
loop0        <== disebut, <b>block_device</b>
├─loop0p1    <== disebut, <b>block_partition</b>
└─loop0p2    <== disebut, <b>block_partition</b>
</pre>

### Mount file ISO

Sekenario untuk proses mount dengan udiskctl, adalah:

1. Setup loop block device dengan `loop-setup -p`
2. Mounting block partition dengan `mount -p`

#### 1. Setup loop block device dengan `loop-setup`
<pre class="url">
$ <b>udisksctl loop-setup -f file_image.iso</b>
</pre>

<pre>
$ <b>udisksctl loop-setup -f archlinux.iso</b>
</pre>

<pre>
$ lsblk
NAME      FSTYPE    SIZE TYPE LABEL       MOUNTPOINT
loop0     iso9660   681M loop ARCH_202010
├─loop0p1 iso9660   681M part ARCH_202010
└─loop0p2 vfat       56M part ARCHISO_EFI
</pre>

Terlihat bahwa hasil yang diberikan berbeda dengan perintah mount biasa.

Pada konidisi ini, label dari **ARCH_202010** sudah muncul di File Manager GUI, namun belum dimount.

Proses ini mirip saat kita melakukan, klik kanan pada ISO image dan memilih menu "**Open With Disk Image Mounter** (Nautilus)".

Bisa langsung diklik untuk mount.

#### 2. Mounting block partition dengan `mount`

Atau, kalau kita tidak ingin membuka file manager, atau tidak memiliki aplikasi file manager GUI, kita juga dapat menggunakan udisksctl saja untuk melakukan proses mounting.

<pre class="url">
$ <b>udisksctl mount -p block_devices/block_partition</b>
</pre>

<pre>
$ <b>udisksctl mount -p block_devices/loop0p1</b>
</pre>

<pre>
$ lsblk
NAME      FSTYPE    SIZE TYPE LABEL       MOUNTPOINT
loop0     iso9660   681M loop ARCH_202010
<mark>├─loop0p1 iso9660   681M part ARCH_202010 /run/media/bandithijo/ARCH_202010</mark>
└─loop0p2 vfat       56M part ARCHISO_EFI
</pre>

Maka, udisks secara otomatis membuat mount point ke path tersebut.

### Unmount File ISO

Sekenario yang sama berlaku untuk proses unount, namun kebalikan dari proses mount.

1. Unmounting block partition dengan `unmount -p`
2. Delete loop block device dengan `loop-delete -b`

#### 1. Unmounting block partition dengan `unmount`

<pre class="url">
$ <b>udisksctl unmount -p block_devices/block_partition</b>
</pre>

<pre>
$ <b>udisksctl unmount -p block_devices/loop0p1</b>
</pre>

Pilih block partition yang memiliki mount point.

<pre>
$ lsblk
NAME      FSTYPE    SIZE TYPE LABEL       MOUNTPOINT
loop0     iso9660   681M loop ARCH_202010
├─loop0p1 iso9660   681M part ARCH_202010
└─loop0p2 vfat       56M part ARCHISO_EFI
</pre>

Terlihat bahwa `loop0p1` sudah tidak lagi memiliki mount point.


#### 2. Delete loop block device dengan `loop-delete`

Sekarang tinggal melepaskan block device `loop0`.

Dengan cara.

<pre class="url">
$ <b>udisksctl loop-delete -b block_devices/block_device</b>
</pre>

<pre>
$ <b>udisksctl loop-delete -b block_devices/loop0</b>
</pre>

## 2. Memanfaatkan Udiskie

Udiskie adalah udisks2 front-end yang ditulis dengan bahasa Python.

Tujuan dari dibuatnya udiskie adalah untuk mengautomatisasi proses mount **removable media**, seperti CD atau flash drive.

Saat ini, udiskie belum dapat digunakan untuk memounting file ISO.

Link repo: [**coldfix/udiskie**](https://github.com/coldfix/udiskie){:target="_blank"}.

### 3. Memanfaatkan udiskie-dmenu

**Udiskie-dmenu** adalah front-end dari udiskie yang menggunakan dmenu sebagai interfacenya.

Link repo: [**fogine/udiskie-dmenu**](https://github.com/fogine/udiskie-dmenu){:target="_blank"}.


# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)

# Referensi

1. [linuxize.com/post/how-to-mount-iso-file-on-linux/](https://linuxize.com/post/how-to-mount-iso-file-on-linux/){:target="_blank"}
<br>Diakses tanggal: 2020/10/22
