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
deltarpm=true
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
sudo dnf update --refresh
{% endshell_term %}

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

## Neofetch

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

## DNSCrypt-Proxy
Sumber: [https://wiki.archlinux.org/title/Systemd-resolved#Manually](https://wiki.archlinux.org/title/Systemd-resolved#Manually){:target="_blank"}

{% shell_term $ %}
sudo dnf install dnscrypt-proxy
{% endshell_term %}

Create file /etc/systemd/resolved.conf.d/dns_servers.conf

{% highlight_caption /etc/systemd/resolved.conf.d/dns_servers.conf %}
{% highlight shell linenos %}
[Resolve]
DNS=127.0.0.1
Domains=~.
{% endhighlight %}

Kemudian, restart systemd-resolved service

{% shell_term $ %}
sudo systemctl restart systemd-resolved.conf
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
gsettings set org.gnome.desktop.interface cursor-theme 'theme-name'
{% endshell_term %}

## Neovim (build)

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

## Ruby or Rails Developer

{% shell_term $ %}
sudo dnf install openssl-devel
sudo dnf install libpq-devel
sudo dnf install libxml2-devel
sudo dnf install libxslt-devel
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

## Rofi

{% shell_term $ %}
sudo dnf install rofi
{% endshell_term %}

## LazyGit

{% shell_term $ %}
sudo dnf copr enable atim/lazygit
sudo dnf install lazygit
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
mkdir build
cd build
cmake ..
cmake --build .
{% endshell_term %}

## libva-intel-driver

{% shell_term $ %}
sudo dnf install libva-intel-driver
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

## Flameshot

{% shell_term $ %}
sudo dnf install flameshot
{% endshell_term %}

## Optipng

{% shell_term $ %}
$ sudo dnf install optipng
{% endshell_term %}

## Scrot
Sumber: [https://github.com/dreamer/scrot](https://github.com/dreamer/scrot){:target="_blank"}

{% shell_term $ %}
git clone https://github.com/dreamer/scrot.git
{% endshell_term %}

{% shell_term $ %}
sudo dnf install meson imlib2-devel libX11-devel libXfixes-devel
{% endshell_term %}

{% shell_term $ %}
meson setup build
ninja -C build
sudo ninja -C build install
{% endshell_term %}

## Maim

{% shell_term $ %}
sudo dnf install maim
{% endshell_term %}

## Change/Swap Pipewire with Pulseaudio

{% shell_term $ %}
sudo dnf swap --allowerasing pipewire-pulseaudio pulseaudio
{% endshell_term %}

## Pamixer
Sumber: [https://copr.fedorainfracloud.org/coprs/opuk/pamixer/](https://copr.fedorainfracloud.org/coprs/opuk/pamixer/){:target="_blank"}

{% shell_term $ %}
sudo dnf copr enable opuk/pamixer
sudo dnf install pamixer
{% endshell_term %}

Atau manual build (my recomended).

{% shell_term $ %}
sudo dnf install boost-devel
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/cdemoulins/pamixer.git
make
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
sudo rpm -e --nodeps libXft-2.3.3-6.fc34.x86_64 libXft-devel-2.3.3-6.fc34.x86_64
sudo dnf install libXft-bgra
{% endshell_term %}

Add `libXft` to `exclude=` package on `/etc/dnf/dnf.conf`.

### dwm

{% shell_term $ %}
sudo dnf install libXinerama-devel
{% endshell_term %}

### pinentry-dmenu (still failed)

{% shell_term $ %}
sudo dnf install libassuan-devel
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
$ git clone https://github.com/bgli/kbbi-qt.git
$ cd kbbi-qt
$ qmake-qt5 KBBI-Qt.pro
$ make
$ sudo make install
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











{% comment %}
# Referensi

1. [](){:target="_blank"}
2. [](){:target="_blank"}
3. [](){:target="_blank"}
{% endcomment %}
