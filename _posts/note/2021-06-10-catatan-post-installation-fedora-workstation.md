---
layout: 'post'
title: "Catatan Post Installation Fedora Workstation"
date: 2021-06-10 09:51
permalink: '/note/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'note'
tags: ['Tips', 'Fedora']
wip: true
pin:
contributors: []
description: "Catatan ini merupakan kumpulan packages dan beberapa konfigurasi yang saya lakukan setelah melakukan proses instalasi Fedora Workstation."
---

# Prakata

Catatan ini merupakan kumpulan packages dan beberapa konfigurasi yang saya lakukan setelah melakukan proses instalasi Fedora Workstation.

Saya memutuskan untuk mengkategorikan catatan ini sebagai "note" dan bukan sebagai "blog" karena kemungkinan saya akan terus memperbaharui isinya seiring dengan berjalannya waktu pemakaian apabila saya menemupak paket-paket yang menarik.

Selain itu, memiliki sebuah catatan "perjalanan" akan **menumbuhkan rasa percaya diri untuk terus maju ke depan**. Karena, apabila gagal, kita tidak takut untuk memulai lagi dari awal. Ataupun, kita dapat dengan mudah memulai percabangan untuk awal baru yang lain.

# Pre Install

## Verify your download with CHECKSUM files.

Setelah mengunduh file ISO, lakukan verifikasi untuk menguji keamanan dan integritas file ISO yang telah didownload.

Langkah awal, import Fedora's GPG key(s).

{% shell_term $ %}
curl https://getfedora.org/static/fedora.gpg | gpg --import
{% endshell_term %}

<pre>
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 12543  100 12543    0     0  10945      0  0:00:01  0:00:01 --:--:-- 10945
gpg: key 1161AE6945719A39: public key "Fedora (34) <fedora-34-primary@fedoraproject.org>" imported
gpg: key 49FD77499570FF31: public key "Fedora (33) <fedora-33-primary@fedoraproject.org>" imported
gpg: key 6C13026D12C944D0: public key "Fedora (32) <fedora-32-primary@fedoraproject.org>" imported
gpg: key 50CB390B3C3359C4: public key "Fedora (31) <fedora-31-primary@fedoraproject.org>" imported
gpg: key 7BB90722DBBDCF7C: public key "Fedora (iot 2019) <fedora-iot-2019@fedoraproject.org>" imported
gpg: key 21EA45AB2F86D6A1: public key "Fedora EPEL (8) <epel@fedoraproject.org>" imported
gpg: key 6A2FAEA2352C64E5: public key "Fedora EPEL (7) <epel@fedoraproject.org>" imported
gpg: key 3B49DF2A0608B895: public key "EPEL (6) <epel@fedoraproject.org>" imported
gpg: Total number processed: 8
gpg:               imported: 8
</pre>

Dapat dilihat, kita telah berhasil mengimport 8 public keys.

Kemudian, download file **CHECKSUM** dari yang dapat kita download di halaman ini, [**di sini**](https://getfedora.org/en/security/){:target="_blank"}. Download file CHECKSUM yang sesuai dengan file ISO yang teman-teman gunakan.

Kemudian, verifikasi file CHECKSUM tersebut.

{% pre_url %}
$ gpg --verify-files *-CHECKSUM
{% endpre_url %}

{% shell_term $ %}
gpg --verify-files Fedora-Workstation-34-1.2-x86_64-CHECKSUM
{% endshell_term %}

<pre>
gpg: Signature made Sat 24 Apr 2021 03:37:01 AM WITA
gpg:                using RSA key 8C5BA6990BDB26E19F2A1A801161AE6945719A39
gpg: Good signature from "Fedora (34) <fedora-34-primary@fedoraproject.org>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 8C5B A699 0BDB 26E1 9F2A  1A80 1161 AE69 4571 9A39
</pre>

CHECKSUM harus memiliki keterangan "Good signature"dari salah satu key.

Letakkan file ISO (\*.iso) dengan file checksum (\*-CHECKSUM) pada direktori yang sama.

<pre>
├─ Fedora-Workstation-34-1.2-x86_64-CHECKSUM
└─ Fedora-Workstation-Live-x86_64-34-1.2.iso
</pre>

Selanjutnya, lakukan pengecekan checksum terhadap file ISO yang telah kita download.

{% pre_url %}
$ sha256sum -c *-CHECKSUM
{% endpre_url %}

{% shell_term $ %}
sha256sum -c Fedora-Workstation-34-1.2-x86_64-CHECKSUM
{% endshell_term %}

<pre>
Fedora-Workstation-Live-x86_64-34-1.2.iso: OK
sha256sum: WARNING: 19 lines are improperly formatted
</pre>

\* Abaikan saja warning 19 lines are improperly formated, hal ini terjadi karena di dalam file *-CHECKSUM tersebut juga terdapat PGP Signature. Coba komentar saja baris-baris selain SHA256SUM valuenya (termasuk blankline), maka warningnya akan ~~berkurang~~ hilang.

# TODO:

## Enable fastest mirror and Delta RPM
Sumber: [https://www.linuxsec.org/2020/03/menggunakan-fastest-mirror-di-fedora.html](https://www.linuxsec.org/2020/03/menggunakan-fastest-mirror-di-fedora.html){:target="_blank"}

Edit file `/etc/dnf/dnf.conf`, lalu tambahkan baris,

{% highlight_caption /etc/dnf/dnf.conf %}
{% highlight shell linenos %}

[main]
...
...
...
fastestmirror=True
deltarpm=True
{% endhighlight %}

Kemudian, tambahkan "kode negara" `&country=ID` di belakang meta link repository yang ada di `/etc/yum.repos.d/`.

Repository utamanya adalah `fedora-updates.repo`.

{% highlight_caption /etc/yum.repos.d/fedora-updates.repo %}
{% highlight shell linenos %}
[updates]
...
metalink=https://mirrors.fedoraproject.org/metalink?repo=updates-released-f$releasever&arch=$basearch&country=ID
...
...

[updates-debuginfo]
...
metalink=https://mirrors.fedoraproject.org/metalink?repo=updates-released-debug-f$releasever&arch=$basearch&country=ID
...
...

[updates-source]
...
metalink=https://mirrors.fedoraproject.org/metalink?repo=updates-released-debug-f$releasever&arch=$basearch&country=ID
...
...
{% endhighlight %}

## Update system

Lakukan refresh dan update repository dengan perintah,

{% shell_term $ %}
sudo dnf upgrade --refresh
{% endshell_term %}

\* **dnf update** dan **dnf upgrade** sama, namun konvensi terbaru sudah menggunakan **dnf upgrade**.

## Enable RPMFusion Repository
Sumber: [https://docs.fedoraproject.org/en-US/quick-docs/setup_rpmfusion/](https://docs.fedoraproject.org/en-US/quick-docs/setup_rpmfusion/){:target="_blank"}

Free Repository

{% shell_term $ %}
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
{% endshell_term %}

Nonfrere Repository

{% shell_term $ %}
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
{% endshell_term %}

Enabling Appstream data from the RPM Fusion repositories (GNOME)

This procedure describes how to install the Appstream data provided by the RPM Fusion software repositories.

Prerequisites

- You have internet access.
- You are using the Gnome desktop environment.
- You have the RPMFusion repositories installed

Procedure

{% shell_term $ %}
sudo dnf group update core
{% endshell_term %}

## Install gnome-tweak-tool

{% shell_term $ %}
sudo dnf install gnome-tweak-tool
{% endshell_term %}

## Install Vim

{% shell_term $ %}
sudo dnf install vim
{% endshell_term %}

## Install downgrade package (sample: fprintd)
Sumber: [https://unix.stackexchange.com/a/408511](https://unix.stackexchange.com/a/408511){:target="_blank"}

Saya harus mendowngrade paket **fprintd** dikarenakan fingerprint device yang ada di laptop saya (ThinkPad X61 keluaran tahun 2007), tidak dapat berfungsi pada fprintd versi 1.0. Setidaknya saya memerlukan versi 0.9.

{% shell_term $ %}
sudo dnf downgrade --releasever=31 fprintd
{% endshell_term %}

## Exlude some packages

Edit file `/etc/dnf/dnf.conf`

{% highlight_caption /etc/dnf/dnf.conf %}
{% highlight shell linenos %}
[main]
exclude=fprintd fprintd-pam libfprint
{% endhighlight %}

## Htop

{% shell_term $ %}
sudo dnf install htop
{% endshell_term %}

## Iftop

{% shell_term $ %}
sudo dnf install iftop
{% endshell_term %}

## iperf

{% shell_term $ %}
sudo dnf install iperf
{% endshell_term %}

## Neofetch

{% shell_term $ %}
sudo dnf install w3m-img
{% endshell_term %}

{% shell_term $ %}
sudo dnf install neofetch
{% endshell_term %}

## Nmon

{% shell_term $ %}
sudo dnf install nmon
{% endshell_term %}

## Nethogs

{% shell_term $ %}
sudo dnf install nethogs
{% endshell_term %}

## LM Sensors

{% shell_term $ %}
sudo dnf install lm_sensors
{% endshell_term %}

## Sound Converter

{% shell_term $ %}
sudo dnf install soundconverter
{% endshell_term %}

## Audacity

{% shell_term $ %}
sudo dnf install audacity
{% endshell_term %}

##  Audacious

{% shell_term $ %}
sudo dnf install audacious
{% endshell_term %}

## Pass

{% shell_term $ %}
sudo dnf install pass
{% endshell_term %}

## Bash Completion

{% shell_term $ %}
sudo dnf install bash-completion
{% endshell_term %}

## Change ZSH to your shell

{% shell_term $ %}
sudo dnf install zsh
sudo dnf install util-linux-user
chsh -s $(which zsh)
{% endshell_term %}

## Arandr

{% shell_term $ %}
sudo dnf install arandr
{% endshell_term %}

## GIT-SVN

{% shell_term $ %}
sudo dnf install git-svn
{% endshell_term %}

## TIG

{% shell_term $ %}
sudo dnf install tig
{% endshell_term %}

## Git-Credential-Libsecret
Sumber: [https://discussion.fedoraproject.org/t/attention-git-credential-libsecret-for-storing-git-passwords-in-the-gnome-keyring-is-now-an-extra-package/18275](https://discussion.fedoraproject.org/t/attention-git-credential-libsecret-for-storing-git-passwords-in-the-gnome-keyring-is-now-an-extra-package/18275){:target="_blank"}

{% shell_term $ %}
sudo dnf install git-credential-libsecret
{% endshell_term %}

{% highlight_caption $HOME/.gitconfig %}
{% highlight shell linenos %}
...

[credential]
	helper = /usr/libexec/git-core/git-credential-libsecret
{% endhighlight %}

## SSH AskPass

{% shell_term $ %}
sudo dnf install lxqt-openssh-askpass
{% endshell_term %}

Saya memilih menggunakan versi **lxqt-openssh-askpass.x86_64**, daripada versi **openssh-askpass.x86_64** dan **x11-ssh-askpass.x86_64**.

## Glances

{% shell_term $ %}
sudo dnf install glances
{% endshell_term %}

## Wavemon

{% shell_term $ %}
sudo dnf install wavemon
{% endshell_term %}

## Transmission Daemon

{% shell_term $ %}
sudo dnf install transmission-daemon
{% endshell_term %}

## YouTube-DL

{% shell_term $ %}
sudo dnf install youtube-dl
{% endshell_term %}

## yt-dlp

{% shell_term $ %}
sudo dnf install yt-dlp
{% endshell_term %}

## Newsboat (RSS Reader)

{% shell_term $ %}
sudo dnf install newsboat
{% endshell_term %}

## Ranger File Manager

{% shell_term $ %}
sudo dnf install ranger
sudo dnf install python3-devel
sudo dnf install libX11-devel
sudo dnf install libXext-devel
pip install ueberzug
{% endshell_term %}

{% shell_term $ %}
sudo dnf install mediainfo
sudo dnf install highlight
sudo dnf install atool
sudo dnf install bsdtar
sudo dnf install unrar
sudo dnf install p7zip
sudo dnf install odt2txt
{% endshell_term %}

## Samba
Sumber: [https://docs.fedoraproject.org/en-US/quick-docs/samba/](https://docs.fedoraproject.org/en-US/quick-docs/samba/){:target="_blank"}

Install dan enable samba service.

{% shell_term $ %}
sudo dnf install samba
sudo systemctl enable smb --now
firewall-cmd --get-active-zones
sudo firewall-cmd --permanent --zone=FedoraWorkstation --add-service=samba
sudo firewall-cmd --reload
{% endshell_term %}

Membuat user samba.

{% shell_term $ %}
sudo smbpasswd -a bandithijo
{% endshell_term %}

Install samba support for file manager gui.

{% shell_term $ %}
sudo dnf install gvfs-smb
{% endshell_term %}

## Install Opus Audio Codec

{% shell_term $ %}
sudo dnf install libogg
sudo dnf install opus-tools
{% endshell_term %}

(RPMFusion - Nonfree)

{% shell_term $ %}
sudo dnf install audacious-plugins-freeworld-ffaudio
{% endshell_term %}

## Virt-Manager (libvirt)
Sumber: [https://fedoramagazine.org/full-virtualization-system-on-fedora-workstation-30/](https://fedoramagazine.org/full-virtualization-system-on-fedora-workstation-30/){:target="_blank"}

Sumber: [https://docs.fedoraproject.org/en-US/quick-docs/getting-started-with-virtualization/](https://docs.fedoraproject.org/en-US/quick-docs/getting-started-with-virtualization/){:target="_blank"}

Cek apakah CPU spport untuk virtualization,

{% shell_term $ %}
egrep '^flags.*(vmx|svm)' /proc/cpuinfo
{% endshell_term %}

Kalau tidak menampilkan apapun, berarti CPU yang kamu gunakan tidak mendukung fitur virtualization.

Cek group package untuk virtualization.

{% shell_term $ %}
dnf groupinfo virtualization
{% endshell_term %}

Install dengan cara,

{% shell_term $ %}
sudo dnf install @virtualization
{% endshell_term %}

Alternatively, to install the mandatory, default, and optional packages, run:

{% shell_term $ %}
sudo dnf group install --with-optional virtualization
{% endshell_term %}

Verifikasi KVM kernel module berhasil diload.

{% shell_term $ %}
lsmod | grep kvm
{% endshell_term %}

Edit file `/etc/libvirt/libvirtd.conf`

{% shell_term $ %}
sudo vi /etc/libvirt/libvirtd.conf
{% endshell_term %}

Set the domain socket group ownership to libvirt

{% highlight_caption /etc/libvirt/libvirtd.conf %}
{% highlight shell linenos %}
...
unix_sock_group = "libvirt"
...
{% endhighlight %}

Adjust the UNIX socket permissions for the R/W socket

{% highlight_caption /etc/libvirt/libvirtd.conf %}
{% highlight shell linenos %}
...
unix_sock_rw_perms = "0770"
...
{% endhighlight %}


Add user to libvirt gorup

{% shell_term $ %}
sudo usermod -a -G libvirt $(whoami)
{% endshell_term %}

This adds the current user to the group. You must log out and log in to apply the changes.

## Chromium browser

{% shell_term $ %}
sudo dnf install chromium
sudo dnf install chromium-libs-media-freeworld
{% endshell_term %}

If Chromium can't play video, replace chromium with chromium-freeworld by RPMFusion.

{% shell_term $ %}
sudo dnf swap chromium chromium-freeworld
{% endshell_term %}

## Chromedriver

{% shell_term $ %}
sudo dnf install chromedriver
{% endshell_term %}

## Google Chrome
Sumber: [https://docs.fedoraproject.org/en-US/quick-docs/installing-chromium-or-google-chrome-browsers/#installing-chrome](https://docs.fedoraproject.org/en-US/quick-docs/installing-chromium-or-google-chrome-browsers/#installing-chrome){:target="_blank"}

Click the following link: [https://www.google.com/chrome/browser/desktop/index.html](https://www.google.com/chrome/browser/desktop/index.html){:target="_blank"}

Click on Download Chrome and select Fedora 64 or 32 bits download and install the repo.

{% shell_term $ %}
sudo dnf install google-chrome-stable_current_x86_64.rpm
{% endshell_term %}

Enabling Chromium plugins (*under construction*).

{% shell_term $ %}
rpm2cpio ./google-chrome-stable_current_x86_64.rpm | cpio -idmv
{% endshell_term %}

## Codec from RPMFusion
Sumber: [https://docs.fedoraproject.org/en-US/quick-docs/assembly_installing-plugins-for-playing-movies-and-music/](https://docs.fedoraproject.org/en-US/quick-docs/assembly_installing-plugins-for-playing-movies-and-music/){:target="_blank"}

{% shell_term $ %}
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf install lame\* --exclude=lame-devel
sudo dnf group upgrade --with-optional Multimedia
{% endshell_term %}

## Another audio video support

{% shell_term $ %}
sudo dnf install ffmpegthumbnailer
sudo dnf install rpmfusion-free-obsolete-packages
{% endshell_term %}


## Install FFMPEG

{% shell_term $ %}
sudo dnf install ffmpeg
sudo dnf install ffmpeg-libs
sudo dnf install compat-ffmpeg28
{% endshell_term %}

## Tor

{% shell_term $ %}
sudo dnf install tor
{% endshell_term %}

## HandBrake

{% shell_term $ %}
sudo dnf install handbrake
{% endshell_term %}

## MPV

(RPMFusion - Free)

{% shell_term $ %}
sudo dnf install mpv
suod dnf install celluloid
{% endshell_term %}

User script that may help you steroid your mpv.

1. [mpv-playlistmanager](https://github.com/jonniek/mpv-playlistmanager){:target="_blank"}
2. [mpv-youtube-download](https://github.com/cvzi/mpv-youtube-download){:target="_blank"}
3. [mpv-youtube-quality](https://github.com/jgreco/mpv-youtube-quality){:target="_blank"}

Manual Build

{% shell_term $ %}
sudo dnf install ffmpeg-devel
{% endshell_term %}

{% shell_term $ %}
./bootstrap.py
./waf configure
./waf
sudo ./waf install
{% endshell_term %}

## DNSCrypt-Proxy
Sumber: [https://wiki.archlinux.org/title/Systemd-resolved#Manually](https://wiki.archlinux.org/title/Systemd-resolved#Manually){:target="_blank"}

{% shell_term $ %}
sudo dnf install dnscrypt-proxy
{% endshell_term %}

Edit file `/etc/dnscrypt-proxy/dnscrypt-proxy.toml`.

Kemudian, definisikan `server_names=` sesuai yang kalian pergunakan. Pada contoh ini, saya menggunakan cloudflare. Daftar dari public server yang menyediakan layanan dnscrypt, dapat teman-teman lihat [**di sini**](https://dnscrypt.info/public-servers/){:target="_blank"}.

{% highlight_caption /etc/dnscrypt-proxy/dnscrypt-proxy.toml %}
{% highlight shell linenos %}
server_names = ['cloudflare']
{% endhighlight %}

Edit file `/etc/systemd/resolved.conf`.

Cari bagian `#DNS=` dan `#Domains=`. Uncomment dan isikan seperti di bawah ini.

Atau, tambahkan saja dibagian paling bawah.

{% highlight_caption /etc/systemd/resolved.conf %}
{% highlight shell linenos %}
[Resolve]
#...
#...
DNS=127.0.0.1
Domains=~.
{% endhighlight %}

Kemudian, restart systemd-resolved service

{% shell_term $ %}
sudo systemctl restart systemd-resolved.service
{% endshell_term %}

## Adwaita-Qt5 theme

{% shell_term $ %}
sudo dnf install adwaita-qt5
{% endshell_term %}

## Qt5Ct

{% shell_term $ %}
sudo dnf install qt5ct
{% endshell_term %}

## Change default cursor on lightdm

ComixCursors: [https://www.gnome-look.org/p/999996](https://www.gnome-look.org/p/999996){:target="_blank"}

Change value of `/usr/share/icons/default/index.theme`

{% highlight_caption /usr/share/icons/default/index.theme %}
{% highlight shell linenos %}
[Icon Theme]
Inherits=ComixCursors-Opaque-White
{% endhighlight %}

## Change default cursor on GDM
Sumber: [https://wiki.archlinux.org/title/GDM#Changing_the_cursor_theme](https://wiki.archlinux.org/title/GDM#Changing_the_cursor_theme){:target="_blank"}

GDM disregards GNOME cursor theme settings and it also ignores the cursor theme set according to the XDG specification. To change the cursor theme used in GDM, either create the following keyfile

{% highlight_caption /etc/dconf/db/gdm.d/10-cursor-settings %}
{% highlight shell linenos %}
[org/gnome/desktop/interface]
cursor-theme='theme-name'
{% endhighlight %}

and then recompile the GDM database or alternatively log in to the GDM user and execute the following:

{% shell_term $ %}
sudo gsettings set org.gnome.desktop.interface cursor-theme 'theme-name'
{% endshell_term %}

## Neovim Nightly (build)

{% shell_term $ %}
sudo dnf install cmake
sudo dnf install gcc-c++
sudo dnf install luajit-devel
sudo dnf install libtool
sudo dnf install libvterm-devel
{% endshell_term %}

{% shell_term $ %}
sudo dnf install nodejs
sudo dnf install python3-neovim
{% endshell_term %}

{% shell_term $ %}
cd ~/.local/src
git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo -j3
sudo make install
{% endshell_term %}

For plugins,

{% shell_term $ %}
sudo dnf install ripgrep
{% endshell_term %}

## PostgreSQL

{% shell_term $ %}
sudo dnf install postgresql-server
{% endshell_term %}

{% shell_term $ %}
sudo /usr/bin/postgresql-setup --initdb
{% endshell_term %}

{% shell_term $ %}
sudo systemctl start postgresql.service
{% endshell_term %}

{% shell_term $ %}
sudo -iu postgres
{% endshell_term %}

{% shell_term [postgres@fedora-x61 ~]$ %}
createuser --interactive
{% endshell_term %}

<pre>
Enter name of role to add: bandithijo
Shall the new role be a superuser? (y/n) y
</pre>

{% shell_term [postgres@fedora-x61 ~]$ %}
createdb bandithijo
{% endshell_term %}

{% shell_term [postgres@fedora-x61 ~]$ %}
psql
{% endshell_term %}

{% shell_term postgres=# %}
ALTER DATABASE bandithijo OWNER TO bandithijo;
{% endshell_term %}

Tambahkan pada file `/var/lib/pgsql/data/pg_hba.conf`.

{% highlight_caption /var/lib/pgsql/data/pg_hba.conf %}
{% highlight shell linenos %}
# TYPE  DATABASE        USER            ADDRESS                 METHOD
...
...
#host   all             all              127.0.0.1/32            ident
host    all             bandithijo       127.0.0.1/32            trust
{% endhighlight %}

Or, using another way with Container.

Since, Fedora has built in container utility named as **Podman**. So, I decided to use this tool than using Docker.

I'll use **bitnami/postgresql** container image from **quay.io**.

{% shell_term # %}
podman pull quay.io/bitnami/postgresql:13.3.0
podman run --name postgresql --net host -v /var/lib/pgsql/data/userdata:/bitnami/postgresql/data:Z -e ALLOW_EMPTY_PASSWORD=yes bitnami/postgresql:13.3.0
{% endshell_term %}

postgresql container imge from bitnami is set **User: 1001**. So, for convenient purposes,

{% shell_term $ %}
sudo chown -R 1001:1001 /var/lib/pgsql
{% endshell_term %}

\* **/var/lib/pgsql** is where Fedora put postgresql data.

Generate systemd unit file.

{% shell_term # %}
podman generate systemd --new --files --name postgresql
mv container-postgresql.service /etc/systemd/system
systemctl daemon-reload
{% endshell_term %}

Stop and remove postgresql running container.

{% shell_term # %}
podman stop postgresql
podman rm postgresql
{% endshell_term %}

That's it! Now you're able to start and check the status of running container with systemct start and status.

## Ruby or Rails Developer

{% shell_term $ %}
sudo dnf install openssl-devel
sudo dnf install libpq-devel
sudo dnf install libxml2-devel
sudo dnf install libxslt-devel
sudo dnf install readline-devel
{% endshell_term %}

Reinstall all your ruby with rbenv (remove and install).

## Build ADVCMP
Sumber: [https://github.com/jarun/advcpmv](https://github.com/jarun/advcpmv){:target="_blank"}

{% shell_term $ %}
sudo dnf install patch
{% endshell_term %}

{% shell_term $ %}
wget http://ftp.gnu.org/gnu/coreutils/coreutils-8.32.tar.xz
tar xvJf coreutils-8.32.tar.xz
cd coreutils-8.32/
wget https://raw.githubusercontent.com/jarun/advcpmv/master/advcpmv-0.8-8.32.patch
patch -p1 -i advcpmv-0.8-8.32.patch
./configure
make
{% endshell_term %}

## TLP

{% shell_term $ %}
sudo dnf install tlp
{% endshell_term %}

{% shell_term $ %}
sudo dnf copr enable suhanc/tp_smapi
sudo dnf install tp_smapi
{% endshell_term %}

## Email Backend

{% shell_term $ %}
sudo dnf install isync
sudo dnf install msmtp
{% endshell_term %}

## Neomutt

{% shell_term $ %}
sudo dnf copr enable chriscowleyunix/neomutt
{% endshell_term %}

**Manual Build**

Sumber: [https://neomutt.org/dev/build/build](https://neomutt.org/dev/build/build){:target="_blank"}

Deps

{% shell_term $ %}
sudo dnf install libidn-devel
sudo dnf install gpgme-devel
sudo dnf install notmuch-devel
sudo dnf install sqlite-devel
sudo dnf install cyrus-sasl-devel
sudo dnf install tokyocabinet-devel
sudo dnf install tokyocabinet
sudo dnf install urlview
{% endshell_term %}

{% shell_term $ %}
./configure --ssl --lua --notmuch --gpgme --gss --autocrypt --sqlite --sasl --mixmaster --fmemopen --homespool --tokyocabinet --locales-fix
make
sudo make install
{% endshell_term %}

## RDP

{% shell_term $ %}
sudo dnf install freerdp
{% endshell_term %}

## Qutebrowser

{% shell_term $ %}
sudo dnf install qutebrowser
{% endshell_term %}

Install Breave adblock,

{% shell_term $ %}
pip install adblock
{% endshell_term %}

Kemudian, update list dengan `:adblock-update`.

Additional hints, Sumber: [https://github.com/qutebrowser/qutebrowser/blob/master/doc/install.asciidoc#on-fedora](https://github.com/qutebrowser/qutebrowser/blob/master/doc/install.asciidoc#on-fedora){:target="_blank"}

Fedora only ships free software in the repositories. To be able to play videos with proprietary codecs with QtWebEngine, you will need to install an additional package from the RPM Fusion Free repository.

{% shell_term $ %}
sudo dnf install qt5-qtwebengine-freeworld
{% endshell_term %}

## Setup Default Browser

Cek default browser yang digunakan saat ini.

{% shell_term $ %}
xdg-settings get default-web-browser
{% endshell_term %}

```
google-chrome.desktop
```

Kalau mau diganti ke qutebrowser,

{% shell_term $ %}
xdg-settings set default-web-browser org.qutebrowser.qutebrowser.desktop
{% endshell_term %}

## Rofi

{% shell_term $ %}
sudo dnf install rofi
{% endshell_term %}

## Rofi-Calc
Sumber: [https://github.com/svenstaro/rofi-calc](https://github.com/svenstaro/rofi-calc){:target="_blank"}

{% shell_term $ %}
sudo dnf install qalculate
{% endshell_term %}

Manual Build

{% shell_term $ %}
sudo dnf install rofi-devel
{% endshell_term %}

{% shell_term $ %}
autoreconf -i
mkdir build
cd build/
../configure
make
sudo make install
{% endshell_term %}

## LazyGit

{% shell_term $ %}
sudo dnf copr enable atim/lazygit
sudo dnf install lazygit
{% endshell_term %}

## LazyDocker

{% shell_term $ %}
sudo dnf copr enable atim/lazydocker
sudo dnf install lazydocker
{% endshell_term %}

## Seahorse

{% shell_term $ %}
sudo dnf install seahorse
{% endshell_term %}

## Crow translate
Sumber: [https://github.com/crow-translate/crow-translate](https://github.com/crow-translate/crow-translate){:target="_blank"}

{% shell_term $ %}
sudo dnf install extra-cmake-modules
sudo dnf install qt5-qtbase-devel
sudo dnf install qt5-qtx11extras-devel
sudo dnf install qt5-qtmultimedia-devel
sudo dnf install tesseract-devel
sudo dnf install libSM-devel
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/crow-translate/crow-translate.git
cd crow-translate
mkdir build
cd build
cmake ..
cmake --build .
{% endshell_term %}

## libva-intel-driver

Sumber: [https://github.com/intel/intel-vaapi-driver](https://github.com/intel/intel-vaapi-driver){:target="_blank"}

HW video decode support for Intel integrated graphics.

{% shell_term $ %}
sudo dnf install libva-intel-driver
sudo dnf install libva-intel-hybrid-driver
{% endshell_term %}

## Inkscape

{% shell_term $ %}
sudo dnf install inkscape
{% endshell_term %}

## WeeChat (build)
Sumber: [https://github.com/weechat/weechat](https://github.com/weechat/weechat){:target="_blank"}

{% shell_term $ %}
sudo dnf install gnutls-devel
sudo dnf install perl-ExtUtils-Embed
sudo dnf install libgcrypt-devel
sudo dnf install libcurl-devel
sudo dnf install ncurses-devel
sudo dnf install aspell-devel
sudo dnf install php-devel
sudo dnf install lua-devel
sudo dnf install tcl-devel
sudo dnf install guile-devel
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/weechat/weechat.git
cd weechat
mkdir build
cd build
cmake ..
make
sudo make install
{% endshell_term %}

Kalau masih ada warning error perihal language, bisa menggunakan,

{% shell_term $ %}
ccmake ..
{% endshell_term %}

Lalu set **OFF** untuk language support yang tidak ingin disertakan atau yang menyebabkan error.

## WeeChat-Matrix
Sumber: [https://github.com/poljar/weechat-matrix](https://github.com/poljar/weechat-matrix){:target="_blank"}

{% shell_term $ %}
sudo dnf install libolm-devel
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/poljar/weechat-matrix.git
cd weechat-matrix
pip install -r requirements.txt
{% endshell_term %}

Kalau kamu sudah pernah mengkonfigurasi weechat, tinggal jalankan,

{% shell_term $ %}
make install
{% endshell_term %}

Selanjutnya tinggal membuat plugin matrix menjadi autostart ketika weechat dijalankan.

{% shell_term $ %}
cd ~/.weechat/python/autoload
ln -s ../matrix.py ~/.weechat/python/autoload
{% endshell_term %}

## Flameshot

{% shell_term $ %}
sudo dnf install flameshot
{% endshell_term %}

## Optipng

{% shell_term $ %}
$ sudo dnf install optipng
{% endshell_term %}

## Scrot
Sumber: [https://github.com/resurrecting-open-source-projects/scrot](https://github.com/resurrecting-open-source-projects/scrot){:target="_blank"}

{% shell_term $ %}
sudo dnf install autoconf-archive
sudo dnf install imlib2-devel
sudo dnf install libtool
sudo dnf install libXcomposite-devel
sudo dnf install libXfixes-devel
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/resurrecting-open-source-projects/scrot.git
cd scrot
{% endshell_term %}

{% shell_term $ %}
./autogen.sh
./configure
make
sudo make install
{% endshell_term %}

## Maim

{% shell_term $ %}
sudo dnf install maim
{% endshell_term %}

## Change/Swap Pipewire with Pulseaudio
Sumber: [https://fedoraproject.org/wiki/Changes/DefaultPipeWire#Upgrade.2Fcompatibility_impact](https://fedoraproject.org/wiki/Changes/DefaultPipeWire#Upgrade.2Fcompatibility_impact){:target="_blank"}

{% shell_term $ %}
sudo dnf swap --allowerasing pipewire-pulseaudio pulseaudio
{% endshell_term %}

Install PulseAudio sound server utilities

{% shell_term $ %}
sudo dnf install pulseaudio-utils
{% endshell_term %}

## Pamixer

Sumber: [https://github.com/cdemoulins/pamixer](https://github.com/cdemoulins/pamixer){:target="_blank"}

{% shell_term $ %}
sudo dnf install boost-devel
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/cdemoulins/pamixer.git
meson setup build
meson compile -C build
meson install -C build
{% endshell_term %}

## DConf & GConf Editor

{% shell_term $ %}
sudo dnf install dconf-editor
sudo dnf install gconf-editor
{% endshell_term %}

## HexChat

{% shell_term $ %}
sudo dnf install hexchat
{% endshell_term %}

Install adwaita-gtk2-theme for fix issue theme,
Sumber: [https://bugzilla.redhat.com/show_bug.cgi?id=1963223](https://bugzilla.redhat.com/show_bug.cgi?id=1963223){:target="_blank"}

{% shell_term $ %}
sudo dnf install adwaita-gtk2-theme
{% endshell_term %}

## Gping
Sumber: [https://github.com/orf/gping](https://github.com/orf/gping){:target="_blank"}

{% shell_term $ %}
sudo dnf copr enable atim/gping
sudo dnf install gping
{% endshell_term %}

## PrettyPing
Sumber: [https://github.com/denilsonsa/prettyping](https://github.com/denilsonsa/prettyping){:target="_blank"}

{% shell_term $ %}
sudo dnf install prettyping
{% endshell_term %}

## Dunst

{% shell_term $ %}
sudo dnf install dunst
{% endshell_term %}

## Telegram TG
Sumber: [https://github.com/paul-nameless/tg.git](https://github.com/paul-nameless/tg.git){:target="_blank"}

{% shell_term $ %}
sudo dnf install tdlib
pip install python-telegram
pip install .
{% endshell_term %}

## SimpleScreenRecorder

{% shell_term $ %}
sudo dnf install simplescreenrecorder
{% endshell_term %}

## ps_mem

{% shell_term $ %}
sudo dnf install ps_mem
{% endshell_term %}

## How to disable Gnome Software autostart
Sumber: [https://forums.fedoraforum.org/showthread.php?315410-How-to-disable-Gnome-Software-autostart](https://forums.fedoraforum.org/showthread.php?315410-How-to-disable-Gnome-Software-autostart){:target="_blank"}

{% shell_term $ %}
sudo systemctl disable packagekit.service
{% endshell_term %}

Disable `download-updates` of Gnome Software with dcof-editor.

```
[org/gnome/software]
download-updates=false
```

Disable autostart gnome-software service.
Sumber: [https://askubuntu.com/questions/959353/disable-gnome-software-from-loading-at-startup](https://askubuntu.com/questions/959353/disable-gnome-software-from-loading-at-startup){:target="_blank"}

1. Copy of the `/etc/xdg/autostart/gnome-software-service.desktop` file to the `~/.config/autostart/` directory.

2. Open the copied `.desktop` file with a text editor and remove the `NoDisplay=true`

3. Now GNOME Software should appear in your Startup Applications list. Disable it. Alternatively, you may append an `X-GNOME-Autostart-enabled=false`

## Pavucontrol

{% shell_term $ %}
sudo dnf install pavucontrol
{% endshell_term %}

## GColor2

{% shell_term $ %}
sudo dnf install gcolor2
{% endshell_term %}

## Suckless

### st

{% shell_term $ %}
sudo dnf install libXft-devel
{% endshell_term %}

For Emoji support,

Sumber: [https://copr.fedorainfracloud.org/coprs/linuxredneck/libXft-bgra/](https://copr.fedorainfracloud.org/coprs/linuxredneck/libXft-bgra/){:target="_blank"}

{% shell_term $ %}
sudo dnf copr enable linuxredneck/libXft-bgra
sudo rpm -e --nodeps libXft libXft-bgra
sudo dnf install libXft-bgra libXft-bgra-devel
{% endshell_term %}

Add `libXft` to `exclude=` package on `/etc/dnf/dnf.conf`.

### dwm

{% shell_term $ %}
sudo dnf install libXinerama-devel
sudo dnf install xsetroot
{% endshell_term %}

Kalau ingin mendaftarkan dwm ke dalam session list yang ada di Display Manager seperti LightDM, GDM, SDDM, dll., tinggal buat saja file Desktop Entry Spec nya saja.

{% highlight_caption /usr/share/xsessions/dwm.desktop %}
{% highlight shell linenos %}
[Desktop Entry]
Name=dwm
Comment=Dynamic Window Manager
Exec=/home/bandithijo/.xinitrc
TryExec=/usr/local/bin/dwm
Type=Application
X-LightDM-DesktopName=dwm
Keywords=tiling;wm;windowmanager;window;manager;
DesktopNames=dwm
{% endhighlight %}

### pinentry-dmenu

{% shell_term $ %}
sudo dnf install libassuan-devel
sudo dnf install libconfig-devel
sudo dnf install gpgme-devel
{% endshell_term %}

Di Fedora, library `assuan.h` tidak berada di dalam directory `/usr/include/` tetapi masih berada di dalam satu level directory lagi, yaitu `/usr/include/libassuan2/`. Buat saja link agar proses make dapat menemukan header tersebut.

{% shell_term $ %}
sudo ln -sf /usr/include/libassuan2/assuan.h /usr/include/assuan.h
{% endshell_term %}

### sxiv

{% shell_term $ %}
sudo dnf install imlib2-devel
sudo dnf install libexif-devel
sudo dnf install giflib-devel
sudo dnf install libXft-bgra-devel
{% endshell_term %}

## Telegram Desktop

(RPMFusion - Free)

{% shell_term $ %}
sudo dnf install telegram-desktop
{% endshell_term %}

## Hide desktop icon on Application List
Sumber: [https://wiki.archlinux.org/title/desktop_entries#Hide_desktop_entries](https://wiki.archlinux.org/title/desktop_entries#Hide_desktop_entries){:target="_blank"}

Firstly, copy the desktop entry file in question to `~/.local/share/applications` to avoid your changes being overwritten.

Then, to hide the entry in all environments, open the desktop entry file in a text editor and add the following line: `NoDisplay=true`.

To hide the entry in a specific desktop, add the following line to the desktop entry file: `NotShowIn=desktop-name`.

where desktop-name can be option such as `GNOME`, `Xfce`, `KDE` etc.

A desktop entry can be hidden in more than desktop at once - simply separate the desktop names with a semi-colon.

## Flatpak via Flathub Remote

{% shell_term $ %}
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
{% endshell_term %}

## Gromit-MPX

(Flatpak - Flathub)

{% shell_term $ %}
flatpak install flathub net.christianbeier.Gromit-MPX
{% endshell_term %}

## Center window in GNOME
Sumber: [https://www.reddit.com/r/gnome/comments/aaqy2p/center_windows_in_gnome/](https://www.reddit.com/r/gnome/comments/aaqy2p/center_windows_in_gnome/){:target="_blank"}

By: carmanaughty

For a keyboard shortcut, there's a dconf key under `/org/gnome/desktop/wm/keybindings` which is `move-to-center` and it should be empty. Change that to whatever you want (for instance, I use ['<Super><Control><Shift>Home']).

By: [deleted]

Its also in GNOME Tweaks. It is under "Windows" -> "Center New Windows".

## Polybar

{% shell_term $ %}
sudo dnf install polybar
{% endshell_term %}

## Feh

Image viewer and cataloguer.

{% shell_term $ %}
sudo dnf install feh
{% endshell_term %}

## SXHKD

Simple HotKey Daemon.

{% shell_term $ %}
sudo dnf install sxhkd
{% endshell_term %}

## j4-dmenu-desktop (dmenu wrapper)

{% shell_term $ %}
sudo dnf install j4-dmenu-desktop
{% endshell_term %}

## XCompmgr

{% shell_term $ %}
sudo dnf install libXcomposite-devel
sudo dnf install libXdamage-devel
{% endshell_term %}

## Picom

{% shell_term $ %}
sudo dnf install meson
sudo dnf install libev-devel
sudo dnf install xcb-util-renderutil-devel
sudo dnf install xcb-util-image-devel
sudo dnf install pixman-devel
sudo dnf install uthash-devel
sudo dnf install libconfig-devel
sudo dnf install dbus-devel
{% endshell_term %}

## XBacklight

{% shell_term $ %}
sudo dnf install xbacklight
{% endshell_term %}

## Udiskie

{% shell_term $ %}
sudo dnf install udiskie
{% endshell_term %}

## Abduco

{% shell_term $ %}
sudo dnf install abduco
{% endshell_term %}

## dtach
Sumber: [https://github.com/crigler/dtach](https://github.com/crigler/dtach){:target="_blank"}

{% shell_term $ %}
sudo dnf install dtach
{% endshell_term %}

## LXappearance

{% shell_term $ %}
sudo dnf install lxappearance
{% endshell_term %}

## unclutter-xfixes
Sumber: [https://github.com/Airblader/unclutter-xfixes](https://github.com/Airblader/unclutter-xfixes){:target="_blank"}

{% shell_term $ %}
sudo dnf intall libXi-devel
sudo dnf install asciidoc
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/Airblader/unclutter-xfixes.git
cd unclutter-xfixes
make
sudo make install
{% endshell_term %}

## Calibre

{% shell_term $ %}
sudo dnf install calibre
{% endshell_term %}

## System Config Printer

{% shell_term $ %}
sudo dnf install system-config-printer
{% endshell_term %}

## PPD from foomatic-db

{% shell_term $ %}
sudo dnf install foomatic-db
sudo dnf install foomatic-db-ppds
{% endshell_term %}

## XSane (Scanner)

{% shell_term $ %}
sudo dnf install xsane
{% endshell_term %}

## Gparted

{% shell_term $ %}
sudo dnf install gparted
{% endshell_term %}

## Numix Solarized Theme Build

{% shell_term $ %}
sudo dnf install sassc
sudo dnf install gdk-pixbuf2-devel
{% endshell_term %}

Saya memiliki Codedark.colors

{% shell_term $ %}
sudo make THEME=Codedark install
{% endshell_term %}

Install dependensi numix theme,

{% shell_term $ %}
sudo dnf install numix-gtk-theme
{% endshell_term %}

## Aria2

{% shell_term $ %}
sudo dnf install aria2
{% endshell_term %}

{% shell_term $ %}
pip install "aria2p[tui]"
{% endshell_term %}

## Mate Polkit

{% shell_term $ %}
sudo dnf install mate-polkit
{% endshell_term %}

## LXpolkit

{% shell_term $ %}
sudo dnf install lxpolkit
{% endshell_term %}

## P7Zip

{% shell_term $ %}
sudo dnf install p7zip
{% endshell_term %}

## Screenkey

{% shell_term $ %}
sudo dnf install screenkey
{% endshell_term %}

## Development Group Packages

{% shell_term $ %}
sudo dnf group install "Development Tools"
{% endshell_term %}

## Docker
Sumber: [https://developer.fedoraproject.org/tools/docker/docker-installation.html](https://developer.fedoraproject.org/tools/docker/docker-installation.html){:target="_blank"}

Install the `docker-ce` package using the Docker repository:

To install the dnf-plugins-core package (which provides the commands to manage your DNF repositories) and set up the stable repository.

{% shell_term $ %}
sudo dnf install dnf-plugins-core
{% endshell_term %}

To add the `docker-ce` repository

{% shell_term $ %}
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
{% endshell_term %}

To install the docker engine. The Docker daemon relies on a OCI compliant runtime (invoked via the containerd daemon) as its interface to the Linux kernel namespaces, cgroups, and SELinux.

{% shell_term $ %}
sudo dnf install docker-ce docker-ce-cli containerd.io
{% endshell_term %}

Afterwards you need to enable the backward compatability for Cgroups. Docker Engine on Linux relies on control groups (cgroups). A cgroup limits an application to a specific set of resources. Control groups allow Docker Engine to share available hardware resources to containers and optionally enforce limits and constraints.

{% shell_term $ %}
sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"
{% endshell_term %}

You must reboot after running the command for the changes to take effect

To start the Docker service use:

{% shell_term $ %}
sudo systemctl start docker
{% endshell_term %}

Now you can verify that Docker was correctly installed and is running by running the Docker hello-world image.

{% shell_term $ %}
sudo docker run hello-world
{% endshell_term %}

{% box_pertanyaan %}
<p markdown=1><b>Why can’t I use docker command as a non root user, by default?</b></p>
<p markdown=1>The Docker daemon binds to a Unix socket instead of a TCP port. By default that Unix socket is owned by the user `root` and other users can access it with `sudo`. For this reason, Docker daemon always runs as the `root` user.</p>
<p markdown=1>You can either [set up sudo](http://www.projectatomic.io/blog/2015/08/why-we-dont-let-non-root-users-run-docker-in-centos-fedora-or-rhel){:target="_blank"} to give docker access to non-root users.</p>
<p markdown=1>Or you can create a Unix group called `docker` and add users to it. When the Docker daemon starts, it makes the ownership of the Unix socket read/writable by the `docker` group.</p>
<p markdown=1>**Warning**: The `docker` group is equivalent to the `root` user; For details on how this impacts security in your system, see [Docker Daemon Attack Surface](https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface){:target="_blank"} for details.</p>
<p markdown=1>To create the `docker` group and add your user:</p>
{% shell_term $ %}
sudo groupadd docker && sudo gpasswd -a ${USER} docker && sudo systemctl restart docker
newgrp docker
{% endshell_term %}
<p markdown=1>You have to log out and log back in (or restart Docker daemon and use `newgrp` command as mentioned here) for these changes to take effect. Then you can verify if your changes were successful by running Docker without `sudo`.</p>
{% endbox_pertanyaan %}

## KBBI-Qt
Sumber: [https://github.com/bgli/kbbi-qt](https://github.com/bgli/kbbi-qt){:target="_blank"}

{% shell_term $ %}
sudo dnf install qt5-qtbase-devel
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/bgli/kbbi-qt.git
cd kbbi-qt
qmake-qt5 KBBI-Qt.pro
make
sudo make install
{% endshell_term %}

## Zathura

{% shell_term $ %}
sudo dnf install zathura
sudo dnf install zathura-pdf-mupdf
{% endshell_term %}

## Kamus
Sumber: [https://github.com/abihf/kamus](https://github.com/abihf/kamus){:target="_blank"}

{% shell_term $ %}
sudo dnf install vala
sudo dnf install libvala-devel
sudo dnf install gtk3-devel
sudo dnf install libgee-devel
{% endshell_term %}

{% shell_term $ %}
./configure
make
sudo make install
{% endshell_term %}

## Thunderbird

{% shell_term $ %}
sudo dnf install thunderbird
{% endshell_term %}

## Evolution

{% shell_term $ %}
sudo dnf install evolution
{% endshell_term %}

Tray icon

Sumber: [https://superuser.com/questions/112210/how-do-i-minimize-evolution-to-the-system-tray-in-ubuntu](https://superuser.com/questions/112210/how-do-i-minimize-evolution-to-the-system-tray-in-ubuntu){:target="_blank"}

Sumber: [https://github.com/acidrain42/evolution-on/](https://github.com/acidrain42/evolution-on/){:target="_blank"}

{% shell_term $ %}
sudo dnf install evolution-devel
sudo dnf install intltool
sudo dnf install gettext-common-devel
sudo dnf install gettext-devel
sudo dnf install GConf2-devel
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/acidrain42/evolution-on.git
cd evolution-on
autoreconf -sivf
./configure
make
sudo make install
{% endshell_term %}

## Gucharmap (Character Map)

{% shell_term $ %}
sudo dnf install gucharmap
{% endshell_term %}

## Dragon (drag and drop helper)
Sumber: [https://github.com/mwh/dragon.git](https://github.com/mwh/dragon.git){:target="_blank"}

{% shell_term $ %}
git clone https://github.com/mwh/dragon.git
cd dragon
make
make install
{% endshell_term %}

## Zoom Meeting Client
Sumber: [https://support.zoom.us/hc/en-us/articles/204206269-Installing-or-updating-Zoom-on-Linux#h_825b50ac-ad15-44a8-9959-28c97e4803ef](https://support.zoom.us/hc/en-us/articles/204206269-Installing-or-updating-Zoom-on-Linux#h_825b50ac-ad15-44a8-9959-28c97e4803ef){:target="_blank"}

Sumber: [https://tecadmin.net/install-zoom-client-on-fedora/](https://tecadmin.net/install-zoom-client-on-fedora/){:target="_blank"}

{% shell_term $ %}
wget https://zoom.us/client/latest/zoom_x86_64.rpm
sudo dnf localinstall zoom_x86_64.rpm
{% endshell_term %}

## ffmulticonverter

{% shell_term $ %}
sudo dnf install ffmulticonverter
{% endshell_term %}

## HandBrake

{% shell_term $ %}
sudo dnf install HandBrake-gui
{% endshell_term %}

## x11vnc

{% shell_term $ %}
sudo dnf install x11vnc
{% endshell_term %}

## Discord

(RPMFusion - NonFree)
{% shell_term $ %}
sudo dnf install discord
{% endshell_term %}

## Slack
Sumber: [https://slack.com/intl/en-id/downloads/linux](https://slack.com/intl/en-id/downloads/linux){:target="_blank"}

{% shell_term $ %}
wget https://downloads.slack-edge.com/linux_releases/slack-4.17.0-0.1.fc21.x86_64.rpm
sudo dnf localinstall slack-4.17.0-0.1.fc21.x86_64.rpm
{% endshell_term %}

## PDF Arranger

{% shell_term $ %}
sudo dnf install pdfarranger
{% endshell_term %}

## Master PDF Editor 4
Sumber: [https://www.linuxuprising.com/2019/04/download-master-pdf-editor-4-for-linux.html](https://www.linuxuprising.com/2019/04/download-master-pdf-editor-4-for-linux.html){:target="_blank"}

{% shell_term $ %}
wget http://code-industry.net/public/master-pdf-editor-4.3.89_qt5.x86_64.rpm
sudo dnf localinstall master-pdf-editor-4.3.89_qt5.x86_64.rpm
{% endshell_term %}

## Intel GPU Tools

{% shell_term $ %}
sudo dnf install igt-gpu-tools
{% endshell_term %}

## Autocutsel
Sumber: [http://www.nongnu.org/autocutsel/](http://www.nongnu.org/autocutsel/){:target="_blank"}

Sumber: [https://github.com/sigmike/autocutsel](https://github.com/sigmike/autocutsel){:target="_blank"}

{% shell_term $ %}
sudo dnf install libXaw-devel
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/sigmike/autocutsel
cd autocutsel
./bootstrap
./configure
make
sudo make install
{% endshell_term %}

## XZoom
Sumber: [https://copr.fedorainfracloud.org/coprs/bgstack15/stackrpms/](https://copr.fedorainfracloud.org/coprs/bgstack15/stackrpms/){:target="_blank"}

{% shell_term $ %}
sudo dnf copr enable bgstack15/stackrpms
sudo dnf install xzoom
{% endshell_term %}

{% comment %}
Sumber: [https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=xzoom](https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=xzoom){:target="_blank"}

{% shell_term $ %}
sudo dnf install imake
{% endshell_term %}

{% shell_term $ %}
wget http://webdiis.unizar.es/pub/unix/X11/xzoom-0.3.tgz
wget ftp://ftp.acc.umu.se/mirror/cdimage/snapshot/Debian/pool/main/x/xzoom/xzoom_0.3-23.diff.gz
{% endshell_term %}

**md4sum**

```
d3a397e24aba7025f94e264fea0906d0  xzoom_0.3-23.diff.gz
c6ecc5fade34cf46cbe8c00b93d7ac78  xzoom-0.3.tgz
```

{% shell_term $ %}
gzip -f -d "xzoom_0.3-23.diff.gz"
{% endshell_term %}
{% endcomment %}

## Minder (mind mapping)

{% shell_term $ %}
sudo dnf install minder
{% endshell_term %}

## Taskell (Kanban Board)
Sumber: [https://github.com/smallhadroncollider/taskell](https://github.com/smallhadroncollider/taskell){:target="_blank"}

Command-line Kanban board/task manager with support for Trello boards and GitHub projects

{% shell_term $ %}
sudo dnf install ncurses-compat-libs
{% endshell_term %}

## Show/Hide GRUB Menu
Sumber: [https://fedoraproject.org/wiki/Changes/HiddenGrubMenu](https://fedoraproject.org/wiki/Changes/HiddenGrubMenu){:target="_blank"}

On systems with only a single OS installed, the grub menu does not offer any useful functionality, so we should hide it by default.

This new auto-hide functionality will be automatically enabled on new Fedora Workstation installs. This can be disabled by running:

{% shell_term $ %}
sudo grub2-editenv - unset menu_auto_hide
{% endshell_term %}

## Zeal

Offline documentation browser inspired by Dash

{% shell_term $ %}
sudo dnf install zeal
{% endshell_term %}

## xinput

{% shell_term $ %}
sudo dnf install xinput
{% endshell_term %}

## gThumb (image viewer, editor, organizer)

{% shell_term $ %}
sudo dnf install gthumb
{% endshell_term %}

## Speedtest CLI

{% shell_term $ %}
sudo dnf install speedtest-cli
{% endshell_term %}

## Spotify

(Flatpak - Flathub)

{% shell_term $ %}
flatpak install flathub com.spotify.Client
{% endshell_term %}

## rpkg
Sumber: [https://pagure.io/rpkg-util](https://pagure.io/rpkg-util){:target="_blank"}

{% shell_term $ %}
sudo dnf install rpkg
{% endshell_term %}

## asciidoc

{% shell_term $ %}
sudo dnf install asciidoc
{% endshell_term %}

{% shell_term $ %}
gem install asciidoctor
gem install asciidoctor-pdf --pre
gem install pygments.rb
{% endshell_term %}

## Tmux
Sumber: [https://github.com/tmux/tmux](https://github.com/tmux/tmux){:target="_blank"}

Manual build

{% shell_term $ %}
sudo dnf install libevent-devel
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
./configure
make
sudo make install
{% endshell_term %}

Fedora repo

{% shell_term $ %}
sudo dnf instal tmux
{% endshell_term %}

## Emacs

{% shell_term $ %}
sudo dnf install emacs
{% endshell_term %}

## Wireshark
Sumber: [https://fedoramagazine.org/how-to-install-wireshark-fedora/](https://fedoramagazine.org/how-to-install-wireshark-fedora/){:target="_blank"}

{% shell_term $ %}
sudo dnf install wireshark
{% endshell_term %}

Add user ke dalam group **wireshark**.

{% shell_term $ %}
sudo usermod -a -G wireshark bandithijo
{% endshell_term %}

\* Perlu restart

## Scrcpy
Sumber: [https://github.com/Genymobile/scrcpy](https://github.com/Genymobile/scrcpy){:target="_blank"}

{% shell_term $ %}
sudo dnf install SDL2-devel
sudo dnf install android-tools
sudo dnf install meson
sudo dnf install ffmpeg-devel
sudo dnf install libusb-devel
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/Genymobile/scrcpy
cd scrcpy
./install_release.sh
{% endshell_term %}

When a new release is out, update the repo and reinstall:

{% shell_term $ %}
git pull
./install_release.sh
{% endshell_term %}

To uninstall:

{% shell_term $ %}
sudo ninja -Cbuild-auto uninstall
{% endshell_term %}

## Faketime

Manipulate system time per process for testing purposes.

{% shell_term $ %}
sudo dnf install libfaketime
{% endshell_term %}

## Notion

Sumber: [https://github.com/notion-enhancer/notion-repackaged](https://github.com/notion-enhancer/notion-repackaged){:target="_blank"}

{% shell_term $ %}
sudo vim /etc/yum.repos.d/notion-repackaged.repo
{% endshell_term %}

{% highlight_caption /etc/yum.repos.d/notion-repackaged.repo %}
{% highlight shell linenos %}
[notion-repackaged]
name=Notion Repackaged Repo
baseurl=https://yum.fury.io/notion-repackaged/
enabled=1
gpgcheck=0
{% endhighlight %}

With that you will be able to install `notion-app` or `notion-app-enhanced` using `sudo dnf install <package name>`.

## Webcam

{% box_info %}
<p markdown=1>Langkah ini hanya optional.</p>
{% endbox_info %}

{% shell_term $ %}
sudo dnf install libwebcam
{% endshell_term %}

Cek apakah module **uvcvideo** sudah diload apa belum.

{% shell_term $ %}
sudo lsmod | grep uvcvideo
{% endshell_term %}

Seharusnya, memiliki output seperti ini.

```
uvcvideo              122880  0
videobuf2_vmalloc      20480  1 uvcvideo
videobuf2_v4l2         36864  1 uvcvideo
videobuf2_common       69632  4 videobuf2_vmalloc,videobuf2_v4l2,uvcvideo,videobuf2_memops
videodev              270336  3 videobuf2_v4l2,uvcvideo,videobuf2_common
mc                     65536  4 videodev,videobuf2_v4l2,uvcvideo,videobuf2_common
```

Kalau belum, jalankan,

{% shell_term $ %}
sudo modprobe uvcvideo
{% endshell_term %}

Namun, menggunakan cara `modprobe` di atas, tidak permanent. Untuk membuatnya permanent, buatlah file seperti contoh di bawah ini.

{% highlight_caption /etc/modules-load.d/uvcvideo.conf %}
{% highlight shell linenos %}
uvcvideo
{% endhighlight %}

Maka module uvcvideo akan diload saat booting.

## Planner

Sumber: [https://planner-todo.web.app/](https://planner-todo.web.app/){:target="_blank"}

Saya memilih memasang dari flathub, karena versi fedora repo memiliki user interface yang kurang sip.

{% shell_term $ %}
flatpak install flathub com.github.alainm23.planner
{% endshell_term %}

## Kdenlive

Sumber: [https://kdenlive.org/en/](https://kdenlive.org/en/){:target="_blank"}

Saya memilih memasang dari flathub.

{% shell_term $ %}
flatpak install flathub org.kde.kdenlive
{% endshell_term %}

## Clipnotify

Sumber: [https://github.com/cdown/clipnotify](https://github.com/cdown/clipnotify){:target="_blank"}

Install dependensi terlebih dahulu.

{% shell_term $ %}
sudo dnf install libXfixes-devel
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/cdown/clipnotify.git
cd clipnotify
sudo make install
{% endshell_term %}

## Bash-Language-Server

{% shell_term $ %}
sudo dnf install nodejs-bash-language-server
{% endshell_term %}

## OBS Studio

{% shell_term $ %}
sudo dnf install obs-studio
{% endshell_term %}

## Unified Remote (urserver)

Sumber: [https://www.unifiedremote.com/tutorials/how-to-install-unified-remote-server-rpm-via-terminal](https://www.unifiedremote.com/tutorials/how-to-install-unified-remote-server-rpm-via-terminal){:target="_blank"}

{% shell_term $ %}
wget -O urserver.rpm https://www.unifiedremote.com/d/linux-x64-rpm
sudo rpm -Uhv urserver.rpm
{% endshell_term %}

urserver akan diinstall di `/opt/urserver/`.

Untuk menjalankan urserver secara manual,

{% shell_term $ %}
./opt/urserver/urserver-start
{% endshell_term %}

Untuk menghentikan urserver secara manual,

{% shell_term $ %}
./opt/urserver/urserver-stop
{% endshell_term %}

Untuk uninstall,

{% shell_term $ %}
sudo rpm -e urserver
{% endshell_term %}

## Linux-Wifi-Hotspot

Sumber: [https://github.com/lakinduakash/linux-wifi-hotspot](https://github.com/lakinduakash/linux-wifi-hotspot){:target="_blank"}

{% shell_term $ %}
sudo dnf install gtk3-devel
sudo dnf install qrencode-devel
sudo dnf install hostapd
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/lakinduakash/linux-wifi-hotspot
cd linux-wifi-hotspot
make
sudo make install
{% endshell_term %}

## Clang / LLVM

{% shell_term $ %}
sudo dnf install clang
{% endshell_term %}

## Cockpit

Sumber: [https://www.redhat.com/sysadmin/intro-cockpit](https://www.redhat.com/sysadmin/intro-cockpit){:target="_blank"}

{% shell_term $ %}
sudo dnf install cockpit
{% endshell_term %}

Install module-module tambahan.

{% shell_term $ %}
sudo dnf install cockpit-podman
sudo dnf install cockpit-machines
sudo dnf install cockpit-networkmanager
sudo dnf install cockpit-packagekit
sudo dnf install cockpit-storaged
sudo dnf install cockpit-pcp
sudo dnf install virt-viewer
{% endshell_term %}

Nyalakan service.

{% shell_term $ %}
sudo systemctl enable --now cockpit.socket
sudo systemctl enable --now pmlogger.service
{% endshell_term %}

## aircrack-ng

{% shell_term $ %}
sudo dnf install aircrack-ng
{% endshell_term %}

## heroku-cli

{% shell_term $ %}
npm install -g heroku
{% endshell_term %}

## FreeCAD

{% shell_term $ %}
sudo dnf install freecad
{% endshell_term %}

Kalau tampilan UI nya tidak bagus. Coba mainkan env variable yang berhubungan dengan QT scaling.

{% shell_term $ %}
/usr/bin/env QT_AUTO_SCREEN_SCALE_FACTOR=0 QT_SCALE_FACTOR=1 FreeCAD
{% endshell_term %}

## Visual Studio Code

Sumber: [https://code.visualstudio.com/docs/setup/linux#_rhel-fedora-and-centos-based-distributions](https://code.visualstudio.com/docs/setup/linux#_rhel-fedora-and-centos-based-distributions){:target="_blank"}

{% shell_term $ %}
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install code
{% endshell_term %}

## GNOME Battery Bench

{% shell_term $ %}
sudo dnf install gnome-battery-bench
{% endshell_term %}

## GNOME Power Manager

{% shell_term $ %}
sudo dnf install gnome-power-manager
{% endshell_term %}




{% comment %}
# Referensi

1. [](){:target="_blank"}
2. [](){:target="_blank"}
3. [](){:target="_blank"}
{% endcomment %}
