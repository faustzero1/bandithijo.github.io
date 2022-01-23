---
layout: 'post'
title: "Menjalankan Distro Linux yang Lain dengan Distrobox di Fedora Linux"
date: 2022-01-21 17:41
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Container']
pin:
hot:
contributors: []
description: "Dengan adanya teknologi container, untuk menggunakan distribusi lain langsung dari dalam Terminal Emulator distro yang kita gunakan tidak lagi rumit. Mudahnya seperti berpindah shell dengan SSH. Distrobox adalah tool yang akan menjembatani kita masuk ke dalam distribusi lain dalam bentuk container. Cara ini, dapat saya manfaatkan untuk memasang paket yang tidak tersedia di distro yang saya gunakan."
---

# Pendahuluan

Dengan adanya teknologi container, untuk menggunakan distribusi lain langsung dari dalam Terminal Emulator distro yang kita gunakan tidak lagi rumit.

Mudahnya seperti berpindah shell dengan SSH.

Distrobox adalah tool yang akan menjembatani kita masuk ke dalam distribusi lain dalam bentuk container. Cara ini, dapat saya manfaatkan untuk memasang paket yang tidak tersedia di distro yang saya gunakan.


## Sekilas tentang Distrobox

Project Distrobox digaungi oleh [**Lucas Di Maio (89luca89)**](https://github.com/89luca89/){:target="_blank"} seorang Computer Scientist yang tertarik dengan unix sistem, devops, machine learning dan cyber security dari Universitas of Rome, La Sapienza. [1]

Distrobox menggunakan **podman** atau **docker** untuk membantu kita dalam mempermudah proses membuat container menggunakan image container dari distribusi yang tersedia. Container yang dibuat bukan sembarang container. Namun, container yang dibuat dengan Distrobox akan memiliki integrasi yang baik dengan host sistem (distribusi yang kita gunakan). Seperti: sharing HOME direktori, external storage, external USB devices, and graphical apps (X11/Wayland), dan juga audio. [2]

Praktis dan tidak perlu konfigurasi tambahan. Cukup buat distro container yang diinginkan, cari aplikasi yang ingin dipasang, dan voila! aplikasi dapat dinikmati dari host sistem. Semudah dan sepraktis itu!


# Target

Objektif atau tujuan catatan ini adalah untuk mencoba memasang aplikasi-aplikasi GUI yang tidak tersedia pada distribusi Fedora Linux.

Maka, untuk menyelesaikan objektif dari catatan ini, saya memilih menggunakan container Arch Linux. Untuk mempermudah saya dalam mendapatkan aplikasi yang saya inginkan. Sebagaimana yang ~~kita~~ saya tahu, Arch Linux memiliki koleksi paket yang cukup luas, mulai dari yang tersedia di official repo maupun resep-resep yang tersedia di AUR (Arch User Repository).

Beberapa dari aplikasi tersebut, antara lain:

1. [**Spotify**](https://aur.archlinux.org/packages/spotify/){:target="_blank"}, A proprietary music streaming service
1. [**Beekeeper Studio**](https://aur.archlinux.org/packages/beekeeper-studio-bin/){:target="_blank"}, Modern and easy to use SQL client for MySQL, Postgres, SQLite, SQL Server, and more
1. [**Figma Linux**](https://aur.archlinux.org/packages/figma-linux/){:target="_blank"}, The collaborative interface design tool. Unofficial Figma desktop client for Linux
1. [**WhatsApp Nativevier**](https://aur.archlinux.org/packages/whatsapp-nativefier/){:target="_blank"}, WhatsApp desktop built with nativefier (electron)


# Instalasi

Pada distribusi Fedora Linux, sudah terpasang **Podman**. Kita tinggal memasang **Distrobox**.

{% shell_term $ %}
sudo dnf in distrobox
{% endshell_term %}


# Penggunaan

Distrobox menyediakan 6 perintah yang dapat kita gunakan.

1. `distrobox-create`, untuk membuat container
1. `distrobox-enter`, untuk masuk (mengakses) ke dalam container
1. `distrobox-list`, untuk daftar container yang ada (pernah dibuat)
1. `distrobox-rm`, untuk menghapus container yang ada (pernah dibuat)
1. `distrobox-init`, ini adalah *entrypoint* dari container (tidak ditujukan untuk digunakan secara manual)
1. `distrobox-export`, ini ditujukan untuk digunakan di dalam container, berguna untuk mengekspor apps dan service yang dipasang di dalam container ke host

<br>
Selain menggunakan *single command* seperti di atas, dapat pula menggunakan `distrobox COMMAND`. Misal,

{% shell_term $ %}
distrobox-list
{% endshell_term %}

Akan memberikan hasil yang sama dengan,

{% shell_term $ %}
distrobox list
{% endshell_term %}


## Membuat Container

Untuk membuat container, kita dapat menggunakan perintah `distrobox-create IMAGE`.


### Tanpa nama image

Kalau digunakan tanpa parameter apapun,

{% shell_term $ %}
distrobox-create
{% endshell_term %}

```
Image not found.
Do you want to pull the image now? [y/N]: y
Trying to pull registry.fedoraproject.org/fedora-toolbox:35...
```

Maka, image yang dipilihkan akan menggunakan **fedora-toolbox:35** dari **registry.fedoraproject.org**.


### Dengan nama image

Apabila ingin menggunakan image lain, pada catatan ini saya menggunakan image Arch Linux Latest dari Docker Hub Registry.

{% shell_term $ %}
distrobox-create --name arch-distrobox --image archlinux:latest
{% endshell_term %}

`--name`, digunakan untuk memberikan nama container. Bebas mau memberikan nama apa saja.

`--image`, digunakan untuk mendefinisikan image yang akan kita gunakan. Kalau image tersebut belum ada di local, maka akan di-download-kan dari registry.

{% box_info %}
<p markdown=1>Untuk mengecek daftar images yang sudah pernah diunduh, dapat menggunakan perintah,</p>
{% shell_term $ %}
podman images
{% endshell_term %}
```
REPOSITORY                                 TAG         IMAGE ID      CREATED      SIZE
docker.io/library/archlinux                latest      2a4e5b8e6c26  2 weeks ago  397 MB
registry.fedoraproject.org/fedora-toolbox  35          40b181c70b73  4 weeks ago  573 MB
```
{% endbox_info %}


## Melihat daftar container

Untuk melihat daftar container yang sudah pernah dibuat, gunakan perintah,

{% shell_term $ %}
distrobox-list
{% endshell_term %}

```
 ID           | NAME                      | STATUS          | IMAGE
 ba3ee7918d87 | arch-distrobox            | Created         | docker.io/library/archlinux:latest
 59b59d5dcabc | fedora-toolbox-35         | Created         | registry.fedoraproject.org/fedora-toolbox:35
```


## Masuk ke dalam container

Untuk masuk ke dalam container, gunakan perintah,

{% pre_url %}
$ distrobox-enter --name NAMA_IMAGE
{% endpre_url %}

`NAMA_IMAGE` didapatkan dari perintah `distrobox-list`.

Misal, saya ingin masuk ke dalam container bernama `arch-distrobox` yang sudah saya buat sebelumnya,

{% shell_term $ %}
distrobox-enter --name arch-distrobox
{% endshell_term %}

```
Starting container arch-distrobox
run this command to follow along:
        podman --remote logs -f arch-distrobox
.
done!
[bandithijo@arch-distrobox ~]$ █
```

Perhatikan prompt shell bagian hostname sudah berubah dari `fedora-thinkpad` (Hostname sistem saya) menjadi `arch-distrobox` (Container name).

Artinya, saat ini saya sudah berhasil memasuki container dengan nama **arch-distrobox**.

Lakukan pengecekan dengan perintah,

{% shell_term $ %}
echo $HOSTNAME
{% endshell_term %}

```
arch-distrobox.fedora-thinkpad
```

`arch-distrobox` adalah nama container yang saat ini sedang digunakan.

`fedora-thinkpad` adalah hostname system yang saya pergunakan.


## Konfigurasi Package Manager

Karena saya menggunakan Arch Linux, saya akan merubah beberapa konfigurasi default yang dibuat oleh Arch Linux image container.

Namun, sebelumnya pasang dulu text editor seperti `vim` atau `nano` untuk memudahkan mengedit file config, karena text editor tidak terpasang secara default di Arch Linux image container.

{% shell_term [bandithijo@arch-distrobox] %}
sudo pacman -S vim
{% endshell_term %}

{% box_info %}
<p markdown=1>Apabila terdapat warning atau pesan error seperti di bawah ini, dapat diabaikan saja.</p>
```
Failed to check for chroot() environment: Permission denied
  Skipped: Current root is not booted.
```
<p markdown=1>Karena, sebenarnya paket sudah terpasang.</p>
{% endbox_info %}

Edit file konfigurasi pacman yang ada pada,

{% shell_term [bandithijo@arch-distrobox] %}
sudo vim /etc/pacman.conf
{% endshell_term %}

{% highlight_caption /etc/pacman.conf %}
{% highlight shell linenos %}
# ...

#
# GENERAL OPTIONS
#
[options]
# ...

# Misc options
#UseSyslog
Color
#NoProgressBar
# We cannot check disk space from within a chroot environment
#CheckSpace
VerbosePkgLists
ParallelDownloads = 5

# ...
{% endhighlight %}

Saya meng-enable **Color** dan men-disable **NoProgressBar**.

Tujuannya agar tampilan pacman lebih berwarna dan juga terdapat progressbar agar proses unduhan paket dapat tervisualisasikan.



## Pasang Aplikasi

### Aplikasi yang berjalan di Terminal

#### Case 1: neofetch

Saya akan coba pasang `neofetch`. Kebetulan **neofetch** tidak tersedia pada Arch Linux docker image yang kita pasang sebagai container.

{% shell_term [bandithijo@arch-distrobox] %}
neofetch
{% endshell_term %}

```
bash: neofetch: command not found
```

Nah, artinya **neofetch** memang belum tersedia pada container Arch Linux yang kita gunakan.

Karena kita menggunakan Arch Linux, kita bisa melakukan pencarian terlebih dahulu, untuk paket **neofetch** apakah terdapat di official repositori, mungkin ada di **community** repo.

{% shell_term [bandithijo@arch-distrobox] %}
sudo pacman -Ss neofetch
{% endshell_term %}

```
community/neofetch 7.1.0-2
    A CLI system information tool written in BASH that supports displaying images.
```

Oke, benar.

Tinggal dipasang saja,

{% shell_term [bandithijo@arch-distrobox] %}
sudo pacman -S neofetch
{% endshell_term %}

Tunggu proses instalasi sampai selesai.

Setelah selesai, kita bisa menjalankan `neofetch`.

{% shell_term [bandithijo@arch-distrobox] %}
neofetch
{% endshell_term %}

```
                   -`
                  .o+`
                 `ooo/
                `+oooo:                   Arch Linux x86_64
               `+oooooo:                  5.15.16-200.fc35.x86_64
               -+oooooo+:                 20F5S0W206 ThinkPad X260
             `/:-:++oooo+:                Intel i5-6300U (4)
            `/++++/+++++++:               Intel Skylake GT2 [HD Graphics 520]
           `/++++++++++++++:              1366x768
          `/+++ooooooooooooo/`            2477MiB / 7795MiB
         ./ooosssso++osssssso+`           2 hours, 40 mins
        .oossssso-````/ossssss+`          dwm
       -osssssso.      :ssssssso.         en_US.UTF-8
      :osssssss/        osssso+++.
     /ossssssss/        +ssssooo/-
   `/ossssso+/:-        -:/+osssso+-
  `+sso+:-`                 `.-/+oso:
 `++:.                           `-/+/
 .`                                 `/

[bandithijo@arch-distrobox ~]$ █
```

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/d1b3L9P6/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 1 - Shell default host system (kiri) & Shell pada arch-distrobox container (kanan)</p>

<br>
#### Case 2: gping

```
community/gping 1.2.7-1
    Ping, but with a graph
```

`gping` merupakan tool visualisasi ping yang belum tersedia di Fedora repositori. Sehingga sangat cocok untuk dijadikan contoh kasus untuk aplikasi terminal (TUI) yang dipasang dari dalam container yang diekspor ke host system.

Langkah pertama, pasang paket `gping`.

{% shell_term [bandithijo@arch-distrobox] %}
sudo pacaman -S gping
{% endshell_term %}

Setelah dipasang, coba langsung jalankan, seharusnya berhasil.

{% shell_term [bandithijo@arch-distrobox] %}
gping google.com
{% endshell_term %}

Kemudian, tentunya akan sangat merepotkan kalau hanya untuk menjalankan gping, kita perlu masuk dulu ke dalam container.

Maka, kita perlu mengekspor gping ke host system.

{% box_perhatian %}
<p markdown=1>Pastikan kalau kamu sudah memiliki **PATH** yang berlokasi di `~/.local/bin`.</p>
<p markdown=1>Kalau belum, coba Googling yaa.</p>
{% endbox_perhatian %}

{% shell_term [bandithijo@arch-distrobox] %}
distrobox-export --bin /usr/bin/gping --export-path ~/.local/bin
{% endshell_term %}

Kalau berhasil diekspor, akan menampilkan output seperti di bawah ini.

```
/usr/bin/gping from arch-distrobox exported successfully in /home/bandithijo/.local/bin/.
OK!
```

Kalau sudah, bisa dicoba jalankan `gping` pada Host system.

{% shell_term $ %}
gping google.com
{% endshell_term %}

Berikut ini demonstrasinya,

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/9X8fsVnV/gambar-02.gif" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 2 - Demonstrasi menjalankan gping hasil export dari distrobox-export</p>

Kalau file `gping` yang ada di `~/.local/bin/gping` kita buka, isiny akan seperti ini,

{% highlight_caption ~/.local/bin/gping %}
{% highlight bash linenos %}
#!/bin/sh
# distrobox_binary
# name: arch-distrobox
if [ ! -f /run/.containerenv ]; then
    /usr/bin/distrobox-enter -n arch-distrobox --  /usr/bin/gping  $@
else
    /usr/bin/gping $@
fi
{% endhighlight %}

<br>
#### Case 3: yay

Salah satu alasan saya memilih Arch Linux agar dapat memanfaatkan AUR.

Untuk mengakses AUR, kita memerlukan AUR helper untuk mempermudah bisnis kita. 😎

Saya biasa menggunakan **yay**.

{% shell_term [bandithijo@arch-distrobox] %}
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
{% endshell_term %}

Setelah proses instalasinya selesai, kita dapat menjalankannya dari dalam container,

{% shell_term [bandithijo@arch-distrobox] %}
yay
{% endshell_term %}

Atau, tinggal kita export untuk mempermudah menjalankannya dari Host system.

{% shell_term [bandithijo@arch-distrobox] %}
distrobox-export --bin /usr/bin/yay --export-path ~/.local/bin
{% endshell_term %}

```
/usr/bin/yay from arch-distrobox exported successfully in /home/bandithijo/.local/bin/.
OK!
```

Coba test update Arch Linux dengan `yay` dari Host.

{% shell_term $ %}
yay -Syu
{% endshell_term %}

Sip! Sekarang kita dapat memasang paket-paket dari AUR dengan menggunakan `yay` dari Host system.

{% box_info %}
<p markdown=1>Direktori **yay** hasil git clone sebelumnya, dapat kita hapus.</p>
{% endbox_info %}


### Aplikasi GUI

#### Case 1: Spotify (Electron)

`spotify` dapat kita temukan di AUR, dan kebetulan ada beberapa nama paket yang memiliki nama yang mirip.

Namun, yang ingin saya pasang adalah spotify yang memang bernama `spotify`.

```
aur/spotify 1:1.1.72.439-3 (+2296 31.40)
  A proprietary music streaming service
```

Tinggal dipasang menggunakan `yay`.

{% shell_term [bandithijo@arch-distrobox] %}
yay -S spotify
{% endshell_term %}

Setelah instalasi selesai, kita dapat menjalankan langsung dari dalam container,

{% shell_term [bandithijo@arch-distrobox] %}
spotify
{% endshell_term %}

Atau, lakukan export agar dapat dipanggil dengan mudah dari Host system.

{% shell_term [bandithijo@arch-distrobox] %}
distrobox-export --app spotify
{% endshell_term %}

```
Application spotify successfully exported.
OK!
spotify will appear in your applications list in a few seconds.
```

Perintah tersebut akan membuat file desktop entry spec pada `~/.local/share/applications/spotify.desktop` di Host system.

{% highlight_caption ~/.local/share/applications/spotify.desktop %}
{% highlight shell linenos %}
[Desktop Entry]
Type=Application
Name=Spotify
GenericName=Music Player
Icon=spotify-client
TryExec=true
Exec=/usr/bin/distrobox-enter -H -n arch-distrobox -- "  spotify --uri= %U"
Terminal=false
MimeType=x-scheme-handler/spotify;
Categories=Audio;Music;Player;AudioVideo;
StartupWMClass=spotify
{% endhighlight %}

Berikut ini demonstrasinya,

![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/dtG884Bz/gambar-03.gif" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 3 - Demonstrasi pemasangan Spotify menggunakan yay dengan Distrobox</p>

<br>
#### Case 2: Beekeeper Studio (AppImage)

{% box_perhatian %}
<p markdown=1>Paket yang menggunakan AppImage, memerlukan paket `fuse2` untuk dapat dijalankan.</p>
{% shell_term [bandithijo@arch-distrobox] %}
yay -S fuse2
{% endshell_term %}
<p markdown=1>Kalau belum dipasang, akan mengeluarkan warning error seperti ini,</p>
```
dlopen(): error loading libfuse.so.2

AppImages require FUSE to run.
You might still be able to extract the contents of this AppImage
if you run it with the --appimage-extract option.
See https://github.com/AppImage/AppImageKit/wiki/FUSE
for more information
```
<p markdown=1>Pasang terlebih dahulu paket `fuse2` sebelum memasang paket yang menggunakan AppImage.</p>
{% endbox_perhatian %}

Terdapat 2 macam paket `beekeeper-studio` di AUR, namun yang saya ingin pasang adalah yang menggunakan AppImage.

```
aur/beekeeper-studio-appimage 3.0.9-1 (+1 0.18)
  Cross platform SQL editor and database management app for Windows, Linux, and Mac
```

{% shell_term [bandithijo@arch-distrobox] %}
yay -S beekeeper-studio-appimage
{% endshell_term %}

Setelah selesai, kita dapat langsung menjalankan dari dalam container,

{% shell_term [bandithijo@arch-distrobox] %}
beekeeper-studio
{% endshell_term %}

Atau, tinggal kita export agar dapat dipanggil lebih mudah dari Host system.

{% shell_term [bandithijo@arch-distrobox] %}
distrobox-export --app beekeeper-studio
{% endshell_term %}

Berikut ini demonstrasinya,

![gambar_4]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/WzWxSsT1/gambar-04.gif" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 4 - Demonstrasi pemasangan Beekeeper Studio menggunakan yay pada Distrobox</p>


## Menghapus Container

Untuk menghapus container, kita perlu memastikan bahwa container tidak sedang berjalan dengan menggunakan perintah,

{% shell_term $ %}
distrobox-list
{% endshell_term %}

```
 ID           | NAME                      | STATUS                 | IMAGE
 59b59d5dcabc | fedora-toolbox-35         | Created                | registry.fedoraproject.org/fedora-toolbox:35
 7cdc389dd7f4 | arch-distrobox            | Up 12 hours ago        | docker.io/library/archlinux:latest
```

Dalam kasus ini, saya ingin menghapus **arch-distrobox** container.

Namun, container ini masih *running* karena memiliki **STATUS Up 12 hours ago**.

Untuk menghentikan container yang sedang *running*, kita gunakan bantuan **podman** (atau docker).

{% pre_url %}
$ podman stop CONTAINER_NAME
{% endpre_url %}

{% shell_term $ %}
podman stop arch-distrobox
{% endshell_term %}

Kemudian cek kembali apakah container sudah tidak *running*.

```
 ID           | NAME                      | STATUS                         | IMAGE
 59b59d5dcabc | fedora-toolbox-35         | Created                        | registry.fedoraproject.org/fedora-toolbox:35
 7cdc389dd7f4 | arch-distrobox            | Exited (143) 6 seconds ago     | docker.io/library/archlinux:latest
```

Sip, statusnya sudah **Exited**.

Sekarang container tersebut dapat kita hapus dengan menggunakan perintah,

{% pre_url %}
$ podman rm CONTAINER_NAME
{% endpre_url %}

{% shell_term $ %}
podman rm arch-distrobox
{% endshell_term %}

Proses menghapus container sudah selesai.

Panduan lebih lengkapnya dapat dilihat di `$ podman rm --help`.


## Menghapus Image Container

Container yang kita gunakan dibuat dengan menggunakan image.

Kita dapat melihat daftar image container yang kita miliki (yang pernah kita unduh) dengan menggunakan perintah,

{% shell_term $ %}
podman images
{% endshell_term %}

```
REPOSITORY                                 TAG         IMAGE ID      CREATED      SIZE
docker.io/library/archlinux                latest      9f9b229575b2  4 days ago   392 MB
registry.fedoraproject.org/fedora-toolbox  35          40b181c70b73  4 weeks ago  573 MB
```

Dalam kasus ini, saya ingin menghapus image **docker.io/library/archlinux** yang memiliki image ID **9f9b229575b2**.

{% pre_url %}
$ podman image rm IMAGE_ID
{% endpre_url %}

{% shell_term $ %}
podman image rm 9f9b229575b2
{% endshell_term %}

Kalau mendapati error seperti ini,

```
Error: Image used by 7cdc389dd7f46230e1afd0bebf54b224497a72433741220441392a6b15208442: image is in use by a container
```

Artinya, masih terdapat container yang menggunakan image tersebut, meskipun dalam keadaan Exited.

Kalau memang sudah dipastikan tidak digunakan, dan kita ingin menghapus image beserta container yang menggunakan image tersebut, kita dapat mnambahkan option `-f` atau `--force`.

{% shell_term $ %}
podman image rm 9f9b229575b2 -f
{% endshell_term %}

```
Untagged: docker.io/library/archlinux:latest
Deleted: 9f9b229575b2cb787cf104f4706142dcba61af1ed63f045e3bf7204a721de15f
```

Selesai, image beserta container yang menggunakan image tersebut telah berhasil dihapus.

Panduan lebih lengkapnya dapat dilihat di `$ podman image rm --help`.


## Menghapus Unused Data

{% box_perhatian %}
<p markdown=1>Command ini cukup beresiko.</p>
<p markdown=1>Perhatikan baik-baik instruksi yang ditampilkan oleh command yang dijalankan.</p>
{% endbox_perhatian %}

Command ini digunakan untuk menghapus data-data baik container maupun image yang sudah tidak lagi digunakan.

{% shell_term $ %}
podman styem prune
{% endshell_term %}

```
WARNING! This command removes:
        - all stopped containers
        - all networks not used by at least one container
        - all dangling images
        - all dangling build cache

Are you sure you want to continue? [y/N] █
```

Atau,

{% shell_term $ %}
podman system prune --all
{% endshell_term %}

```
WARNING! This command removes:
        - all stopped containers
        - all networks not used by at least one container
        - all images without at least one container associated with them
        - all build cache

Are you sure you want to continue? [y/N] █
```

Panduan lebih lengkapnya dapat dilihat di `$ podman system prune --help`.


# Tambahan

Tentu saja, catatan ini tidak dapat mengcover semua dari dokumentasi Distrobox, untuk melihat tips-tips yang lain dapat mengunjungi halaman [**github:distrobox:useful tips**](https://github.com/89luca89/distrobox/blob/main/docs/useful_tips.md){:target="_blank"}


# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)


# Referensi

1. [https://twitter.com/LucaDiMaio11](https://twitter.com/LucaDiMaio11){:target="_blank"}
<br>Diakses tanggal: 2022/01/22

1. [https://github.com/89luca89/distrobox](https://github.com/89luca89/distrobox){:target="_blank"}
<br>Diakses tanggal: 2022/01/22

1. [https://fedoramagazine.org/run-distrobox-on-fedora-linux/](https://fedoramagazine.org/run-distrobox-on-fedora-linux/){:target="_blank"}
<br>Diakses tanggal: 2022/01/22
