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

Saya memutuskan untuk mengkategorikan catatan ini sebagai "note" dan bukan sebagai "blog" karena kemungkinan saya akan terus memperbaharui isinya seiring dengan berjalannya waktu pemakaian apabila saya menemukan paket-paket yang menarik.

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

## Install gnome-tweaks

GNOME Tweaks allows adjusting advanced configuration settings in GNOME 3. This includes things like the fonts used in user interface elements, alternative user interface themes, changes in window management behavior, GNOME Shell appearance and extension, etc.

Sebelumnya, paket ini bernama `gnome-tweak-tool`.

{% shell_term $ %}
sudo dnf install gnome-tweaks
{% endshell_term %}

## gnome-extensions-app

GNOME Extensions is an application for configuring and removing GNOME Shell extensions.

GNOME Shell Extension sudah dipisahkan dari GNOME Tweaks, kita perlu memasang tools tambahan untuk mengatur ekstensi2 tersebut selain menggunakan web apps [https://extensions.gnome.org/local/](https://extensions.gnome.org/local/){:target="_blank"}.

{% shell_term $ %}
sudo dnf install gnome-extensions-app
{% endshell_term %}

## DConf Editor

Graphical tool for editing the dconf configuration database.

{% shell_term $ %}
sudo dnf install dconf-editor
{% endshell_term %}

## GConf Editor

gconf-editor allows you to browse and modify GConf configuration sources.

{% shell_term $ %}
sudo dnf install gconf-editor
{% endshell_term %}

## How to disable Gnome Software autostart

Sumber: [https://forums.fedoraforum.org/showthread.php?315410-How-to-disable-Gnome-Software-autostart](https://forums.fedoraforum.org/showthread.php?315410-How-to-disable-Gnome-Software-autostart){:target="_blank"}

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

## Disable Super+P on GNOME for Switch Monitor by default

Sumber: [https://askubuntu.com/a/1038869/777616](https://askubuntu.com/a/1038869/777616){:target="_blank"}

## Development Group Packages

These tools include general development tools such as git and CVS.

{% shell_term $ %}
sudo dnf group install "Development Tools"
{% endshell_term %}

<details markdown="1" style="width:100%;">
<summary style="cursor:pointer;">Detail packages</summary>

```
 Mandatory Packages:
   gettext
 Default Packages:
   diffstat
   doxygen
   git
   patch
   patchutils
   subversion
   systemtap
 Optional Packages:
   buildbot
   colordiff
   cvs
   cvs2cl
   cvsgraph
   cvsps
   darcs
   dejagnu
   expect
   gambas3-ide
   git-annex
   git-cola
   git2cl
   gitg
   gtranslator
   highlight
   lcov
   manedit
   meld
   monotone
   myrepos
   nemiver
   qgit
   quilt
   rapidsvn
   rcs
   robodoc
   scanmem
   subunit
   svn2cl
   tig
   tkcvs
   tortoisehg
   translate-toolkit
   utrac
```
</details>

## Install Vim

Fedora Workstation sudah preinstalled `vim-mimimal` dengan file binary bernama `vi`.

Karena saya lebih sering menggunakan Neovim, maka saya tidak akan memasang paket `vim`.

## Install downgrade package (sample: fprintd)

Sumber: [https://unix.stackexchange.com/a/408511](https://unix.stackexchange.com/a/408511){:target="_blank"}

Saya harus mendowngrade paket **fprintd** dikarenakan fingerprint device yang ada di laptop saya (ThinkPad X61 keluaran tahun 2007), tidak dapat berfungsi pada fprintd versi 1.0. Setidaknya saya memerlukan versi 0.9.

{% shell_term $ %}
sudo dnf downgrade --releasever=31 fprintd
{% endshell_term %}

Add into exclude packages.

Edit file `/etc/dnf/dnf.conf`

{% highlight_caption /etc/dnf/dnf.conf %}
{% highlight shell linenos %}
[main]
exclude=fprintd fprintd-pam libfprint
{% endhighlight %}

\* Saya sudah menggunakan ThinkPad x260 dan tidak lagi perlu melakukan exclude terhadap paket ini.

## htop

Official site: [http://hisham.hm/htop/](http://hisham.hm/htop/){:target="_blank"}

htop is an interactive text-mode process viewer for Linux, similar to top.

{% shell_term $ %}
sudo dnf install htop
{% endshell_term %}

## iftop

Official site: [http://www.ex-parrot.com/~pdw/iftop/](http://www.ex-parrot.com/~pdw/iftop/){:target="_blank"}

iftop does for network usage what top(1) does for CPU usage. It listens to network traffic on a named interface and displays a table of current bandwidth usage by pairs of hosts. Handy for answering the question "why is our ADSL link so slow?".

{% shell_term $ %}
sudo dnf install iftop
{% endshell_term %}

## iperf

Official site: [http://sourceforge.net/projects/iperf2](http://sourceforge.net/projects/iperf2){:target="_blank"}

Iperf is a tool to measure maximum TCP bandwidth, allowing the tuning of various parameters and UDP characteristics. Iperf reports bandwidth, delay jitter, datagram loss.

{% shell_term $ %}
sudo dnf install iperf
{% endshell_term %}

## nmap

Official site: [http://nmap.org/](http://nmap.org/){:target="_blank"}

Nmap is a utility for network exploration or security auditing. It supports ping scanning (determine which hosts are up), many port scanning techniques (determine what services the hosts are offering), and TCP/IP fingerprinting (remote host operating system identification). Nmap also offers flexible target and port specification, decoy scanning, determination of TCP sequence predictability characteristics, reverse-identd scanning, and more.

{% shell_term $ %}
sudo dnf install nmap
{% endshell_term %}

## nmon

Official site: [http://nmon.sourceforge.net](http://nmon.sourceforge.net){:target="_blank"}

nmon is a systems administrator, tuner, benchmark tool, which provides information about CPU, disks, network, etc., all in one view.

{% shell_term $ %}
sudo dnf install nmon
{% endshell_term %}

## wavemon

Official site: [https://github.com/uoaerg/wavemon](https://github.com/uoaerg/wavemon){:target="_blank"}

wavemon is a wireless device monitoring application that allows you to watch all important information like device configuration, encryption, and power management parameters and network information at once. Adaptive level bargraphs for link quality, signal/noise strength and signal-to-noise ratio. The customizeable "level alarm" feature that notices the user of changes in signal level strength audibly and/or visually. wavemon is able to list of access points in range and shows full-screen level histogram displaying signal/noise levels and SNR.

{% shell_term $ %}
sudo dnf install wavemon
{% endshell_term %}

## nethogs

Official site: [https://github.com/raboof/nethogs/](https://github.com/raboof/nethogs/){:target="_blank"}

NetHogs is a small "net top" tool. Instead of breaking the traffic down per protocol or per subnet, like most such tools do, it groups bandwidth by process and does not rely on a special kernel module to be loaded. So if there's suddenly a lot of network traffic, you can fire up NetHogs and immediately see which PID is causing this, and if it's some kind of spinning process, kill it.

{% shell_term $ %}
sudo dnf install nethogs
{% endshell_term %}

## Glances

Official site: [https://github.com/nicolargo/glances](https://github.com/nicolargo/glances){:target="_blank"}

Glances is a CLI curses based monitoring tool for both GNU/Linux and BSD. Glances uses the PsUtil library to get information from your system.

{% shell_term $ %}
sudo dnf install glances
{% endshell_term %}

## Zenith

Official site: [https://github.com/bvaisvil/zenith](https://github.com/bvaisvil/zenith){:target="_blank"}

Zenith - sort of like top or htop but with zoom-able charts, CPU, GPU, network, and disk usage.

**Manual Build**

Deps,

{% shell_term $ %}
sudo dnf install rust
sudo dnf install rust-std-static
sudo dnf install cargo
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/bvaisvil/zenith
cd zenith
make
sudo make install
{% endshell_term %}

## LM Sensors

Official site: [http://github.com/lm-sensors/lm-sensors/](http://github.com/lm-sensors/lm-sensors/){:target="_blank"}

The lm_sensors package includes a collection of modules for general SMBus access and hardware monitoring.

{% shell_term $ %}
sudo dnf install lm_sensors
{% endshell_term %}

## Neofetch

Official site: [https://github.com/dylanaraps/neofetch](https://github.com/dylanaraps/neofetch){:target="_blank"}

Neofetch displays information about your system next to an image, your OS logo, or any ASCII file of your choice. The main purpose of Neofetch is to be used in screenshots to show other users what OS/distribution you're running, what theme/icons you're using and more.

{% shell_term $ %}
sudo dnf install w3m-img
{% endshell_term %}

{% shell_term $ %}
sudo dnf install neofetch
{% endshell_term %}

## Sound Converter

Official site: [http://soundconverter.org](http://soundconverter.org){:target="_blank"}

SoundConverter is the leading audio file converter for the GNOME Desktop. It reads anything GStreamer can read (Ogg Vorbis, AAC, MP3, FLAC, WAV, AVI, MPEG, MOV, M4A, AC3, DTS, ALAC, MPC, Shorten, APE, SID, MOD, XM, S3M, etc...), and writes to Opus, Ogg Vorbis, FLAC, WAV, AAC, and MP3 files, or use any GNOME Audio Profile.

SoundConverter aims to be simple to use, and very fast. Thanks to its multithreaded design, it will use as many cores as possible to speed up the conversion. It can also extract the audio from videos.

{% shell_term $ %}
sudo dnf install soundconverter
{% endshell_term %}

## Audacity

Official site: [https://www.audacityteam.org/](https://www.audacityteam.org/){:target="_blank"}

Audacity is a cross-platform multitrack audio editor. It allows you to record sounds directly or to import files in various formats. It features a few simple effects, all of the editing features you should need, and unlimited undo. The GUI was built with wxWidgets and the audio I/O supports PulseAudio, OSS and ALSA under Linux.

{% shell_term $ %}
sudo dnf install audacity
{% endshell_term %}

##  Audacious

Official site: [https://audacious-media-player.org/](https://audacious-media-player.org/){:target="_blank"}

Audacious is an advanced audio player. It is free, lightweight, currently based on GTK+ 2, runs on Linux and many other *nix platforms and is focused on audio quality and supporting a wide range of audio codecs. It still features an alternative skinned user interface (based on Winamp 2.x skins). Historically, it started as a fork of Beep Media Player (BMP), which itself forked from XMMS.

{% shell_term $ %}
sudo dnf install audacious
{% endshell_term %}

## pass

Official site: [http://zx2c4.com/projects/password-store/](http://zx2c4.com/projects/password-store/){:target="_blank"}

Stores, retrieves, generates, and synchronizes passwords securely using gpg and git.

{% shell_term $ %}
sudo dnf install pass
{% endshell_term %}

## pwgen

Official site: [http://sf.net/projects/pwgen](http://sf.net/projects/pwgen){:target="_blank"}

pwgen generates random, meaningless but pronounceable passwords. These passwords contain either only lowercase letters, or upper and lower case, or upper case, lower case and numeric digits. Upper case letters and numeric digits are placed in a way that eases memorizing the password.

{% shell_term $ %}
sudo dnf install pwgen
{% endshell_term %}

## hashcat

Official site: [https://github.com/hashcat/hashcat](https://github.com/hashcat/hashcat){:target="_blank"}

Hashcat is the world's fastest and most advanced password recovery utility, supporting five unique modes of attack for over 200 highly-optimized hashing algorithms. hashcat currently supports CPUs, GPUs, and other hardware accelerators on Linux, Windows, and Mac OS, and has facilities to help enable distributed password cracking.

{% shell_term $ %}
sudo dnf install hashcat
{% endshell_term %}

## FileRoller

Official site: [https://wiki.gnome.org/Apps/FileRoller](https://wiki.gnome.org/Apps/FileRoller){:target="_blank"}

File Roller is an application for creating and viewing archives files, such as tar or zip files.

{% shell_term $ %}
sudo dnf install file-roller
{% endshell_term %}

## Bash Completion

Official site: [https://github.com/scop/bash-completion](https://github.com/scop/bash-completion){:target="_blank"}

bash-completion is a collection of shell functions that take advantage of the programmable completion feature of bash.

{% shell_term $ %}
sudo dnf install bash-completion
{% endshell_term %}

## Change ZSH to your shell

Official site: [http://zsh.sourceforge.net/](http://zsh.sourceforge.net/){:target="_blank"}

The zsh shell is a command interpreter usable as an interactive login shell and as a shell script command processor. Zsh resembles the ksh shell (the Korn shell), but includes many enhancements. Zsh supports command line editing, built-in spelling correction, programmable command completion, shell functions (with autoloading), a history mechanism, and more.

{% shell_term $ %}
sudo dnf install zsh
sudo dnf install util-linux-user
chsh -s $(which zsh)
{% endshell_term %}

## Arandr

Official site: [http://christian.amsuess.com/tools/arandr/](http://christian.amsuess.com/tools/arandr/){:target="_blank"}

ARandR is designed to provide a simple visual front end for XRandR 1.2/1.3. Relative monitor positions are shown graphically and can be changed in a drag-and-drop way.

{% shell_term $ %}
sudo dnf install arandr
{% endshell_term %}

## xcalib

Official site: [http://xcalib.sourceforge.net/](http://xcalib.sourceforge.net/){:target="_blank"}

Tiny monitor calibration loader for X.org.

{% shell_term $ %}
sudo dnf install xcalib
{% endshell_term %}

## GIT-SVN

Official site: [https://git-scm.com/](https://git-scm.com/){:target="_blank"}

Git tools for interacting with Subversion repositories.

{% shell_term $ %}
sudo dnf install git-svn
{% endshell_term %}

## TIG

Official site: [https://jonas.github.io/tig/](https://jonas.github.io/tig/){:target="_blank"}

Tig is a repository browser for the git revision control system that additionally can act as a pager for output from various git commands.

When browsing repositories, it uses the underlying git commands to present the user with various views, such as summarized revision log and showing the commit with the log message, diffstat, and the diff.

Using it as a pager, it will display input from stdin and colorize it.

{% shell_term $ %}
sudo dnf install tig
{% endshell_term %}

## Git-Credential-Libsecret

Official site: [https://git-scm.com/](https://git-scm.com/){:target="_blank"}

Git helper for accessing credentials via libsecret.

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

Official site: [http://lxqt.org/](http://lxqt.org/){:target="_blank"}

Askpass openssh transition dialog for LXQt desktop suite.

{% shell_term $ %}
sudo dnf install lxqt-openssh-askpass
{% endshell_term %}

Saya memilih menggunakan versi **lxqt-openssh-askpass.x86_64**, daripada versi **openssh-askpass.x86_64** dan **x11-ssh-askpass.x86_64**.

## Transmission Daemon

Official site: [http://www.transmissionbt.com](http://www.transmissionbt.com){:target="_blank"}

Transmission BitTorrent client daemon.

{% shell_term $ %}
sudo dnf install transmission-daemon
{% endshell_term %}

## tremc

Official site: [https://github.com/tremc/tremc](https://github.com/tremc/tremc){:target="_blank"}

Curses interface for transmission

{% shell_term $ %}
git clone https://github.com/tremc/tremc.git
cd tremc
sudo make install
{% endshell_term %}

## YouTube-DL

Official site: [https://yt-dl.org](https://yt-dl.org){:target="_blank"}

Small command-line program to download videos from YouTube and other sites.

{% shell_term $ %}
sudo dnf install youtube-dl
{% endshell_term %}

## yt-dlp

Official site: [https://github.com/yt-dlp/yt-dlp](https://github.com/yt-dlp/yt-dlp){:target="_blank"}

yt-dlp is a command-line program to download videos from many different online video platforms, such as youtube.com. The project is a fork of youtube-dl with additional features and fixes.

{% shell_term $ %}
sudo dnf install yt-dlp
{% endshell_term %}

## Newsboat (RSS Reader)

Official site: [https://www.newsboat.org](https://www.newsboat.org){:target="_blank"}

Newsboat is a fork of Newsbeuter, an RSS/Atom feed reader for the text console.

{% shell_term $ %}
sudo dnf install newsboat
{% endshell_term %}

## Ranger File Manager

Official site: [https://ranger.github.io/](https://ranger.github.io/){:target="_blank"}

Ranger is a free console file manager that gives you greater flexibility and a good overview of your files without having to leave your *nix console. It visualizes the directory tree in two dimensions: the directory hierarchy on one, lists of files on the other, with a preview to the right so you know where you'll be going.

{% shell_term $ %}
sudo dnf install ranger
sudo dnf install python3-devel
sudo dnf install libX11-devel
sudo dnf install libXext-devel
pip install ueberzug
{% endshell_term %}

For enhanced file previews.

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

Official site: [https://www.samba.org](https://www.samba.org){:target="_blank"}

Samba is the standard Windows interoperability suite of programs for Linux and Unix.

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

Official site: [https://virt-manager.org/](https://virt-manager.org/){:target="_blank"}

Virtual Machine Manager provides a graphical tool for administering virtual machines for KVM, Xen, and LXC. Start, stop, add or remove virtual devices, connect to a graphical or serial console, and see resource usage statistics for existing VMs on local or remote machines. Uses libvirt as the backend management API.

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

chromium-freeworld is an open-source web browser, powered by WebKit (Blink).

{% shell_term $ %}
sudo dnf swap chromium chromium-freeworld
{% endshell_term %}

## Chromedriver

WebDriver is an open source tool for automated testing of webapps across many browsers. It provides capabilities for navigating to web pages, user input, JavaScript execution, and more. ChromeDriver is a standalone server which implements WebDriver's wire protocol for Chromium. It is being developed by members of the Chromium and WebDriver teams.

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

## Qutebrowser

Official site: [http://www.qutebrowser.org](http://www.qutebrowser.org){:target="_blank"}

qutebrowser is a keyboard-focused browser with a minimal GUI. It’s based on Python, PyQt5 and QtWebEngine and free software, licensed under the GPL. It was inspired by other browsers/addons like dwb and Vimperator/Pentadactyl.

{% shell_term $ %}
sudo dnf install qutebrowser
{% endshell_term %}

Install Breave adblock,

{% shell_term $ %}
pip install --user adblock
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

Official site: [http://ffmpeg.org/](http://ffmpeg.org/){:target="_blank"}

FFmpeg is a complete and free Internet live audio and video broadcasting solution for Linux/Unix. It also includes a digital VCR. It can encode in real time in many formats including MPEG1 audio and video, MPEG4, h263, ac3, asf, avi, real, mjpeg, and flash.

{% shell_term $ %}
sudo dnf install ffmpeg
sudo dnf install ffmpeg-libs
sudo dnf install compat-ffmpeg28
{% endshell_term %}

## Tor

Official site: [https://www.torproject.org](https://www.torproject.org){:target="_blank"}

The Tor network is a group of volunteer-operated servers that allows people to improve their privacy and security on the Internet. Tor's users employ this network by connecting through a series of virtual tunnels rather than making a direct connection, thus allowing both organizations and individuals to share information over public networks without compromising their privacy. Along the same line, Tor is an effective censorship circumvention tool, allowing its users to reach otherwise blocked destinations or content. Tor can also be used as a building block for software developers to create new communication tools with built-in privacy features.

This package contains the Tor software that can act as either a server on the Tor network, or as a client to connect to the Tor network.

{% shell_term $ %}
sudo dnf install tor
{% endshell_term %}

## HandBrake

Official site: [http://handbrake.fr/](http://handbrake.fr/){:target="_blank"}

HandBrake is a general-purpose, free, open-source, cross-platform, multithreaded video transcoder software application. It can process most common multimedia files and any DVD or Bluray sources that do not contain any kind of copy protection.

This package contains the command line version of the program.

{% shell_term $ %}
sudo dnf install handbrake
{% endshell_term %}

## MPV

Official site: [https://mpv.io/](https://mpv.io/){:target="_blank"}

Mpv is a movie player based on MPlayer and mplayer2. It supports a wide variety of video file formats, audio and video codecs, and subtitle types. Special input URL types are available to read input from a variety of sources other than disk files. Depending on platform, a variety of different video and audio output methods are supported.

(RPMFusion - Free)

{% shell_term $ %}
sudo dnf install mpv
sudo dnf install celluloid
{% endshell_term %}

User script that may help you steroid your mpv.

1. [mpv-playlistmanager](https://github.com/jonniek/mpv-playlistmanager){:target="_blank"}
2. [mpv-youtube-download](https://github.com/cvzi/mpv-youtube-download){:target="_blank"}
3. [mpv-youtube-quality](https://github.com/jgreco/mpv-youtube-quality){:target="_blank"}

<br>
**Manual Build**

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

Official site: [https://github.com/jedisct1/dnscrypt-proxy](https://github.com/jedisct1/dnscrypt-proxy){:target="_blank"}

A flexible DNS proxy, with support for modern encrypted DNS protocols such as DNSCrypt v2 and DNS-over-HTTP/2.

<details markdown="1" style="width:100%;">
<summary style="cursor:pointer;">Features...</summary>
- DNS traffic encryption and authentication. Supports DNS-over-HTTPS (DoH)
and DNSCrypt.
- DNSSEC compatible
- DNS query monitoring, with separate log files for regular and suspicious
queries
- Pattern-based local blocking of DNS names and IP addresses
- Time-based filtering, with a flexible weekly schedule
- Transparent redirection of specific domains to specific resolvers
- DNS caching, to reduce latency and improve privacy
- Local IPv6 blocking to reduce latency on IPv4-only networks
- Load balancing: pick a set of resolvers, dnscrypt-proxy will automatically
measure and keep track of their speed, and balance the traffic across the
fastest available ones.
- Cloaking: like a HOSTS file on steroids, that can return preconfigured
addresses for specific names, or resolve and return the IP address of other
names. This can be used for local development as well as to enforce safe
search results on Google, Yahoo and Bing.
- Automatic background updates of resolvers lists
- Can force outgoing connections to use TCP; useful with tunnels such as Tor.
</details>

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

\* Perlu restart/reboot system.

## Adwaita-Qt5 theme

Official site: [https://github.com/FedoraQt/adwaita-qt](https://github.com/FedoraQt/adwaita-qt){:target="_blank"}

Adwaita theme variant for applications utilizing Qt5.

{% shell_term $ %}
sudo dnf install adwaita-qt5
{% endshell_term %}

## Qt5Ct

Official site: [https://sourceforge.net/projects/qt5ct/](https://sourceforge.net/projects/qt5ct/){:target="_blank"}

qt5ct allows users to configure Qt5 settings (theme, font, icons, etc.) under DE/WM without Qt integration.

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

## Switch Between Java Versions

Memeriksa versi java yang terpasang.

{% shell_term $ %}
java -version
{% endshell_term %}

```
openjdk version "11.0.13" 2021-10-19
OpenJDK Runtime Environment 18.9 (build 11.0.13+8)
OpenJDK 64-Bit Server VM 18.9 (build 11.0.13+8, mixed mode, sharing)
```

Untuk melakukan switch antara versi Java yang terpasang.

{% shell_term $ %}
sudo alternatives --config java
{% endshell_term %}

```
There is 1 program that provides 'java'.

  Selection    Command
-----------------------------------------------
*+ 1           java-11-openjdk.x86_64 (/usr/lib/jvm/java-11-openjdk-11.0.13.0.8-2.fc35.x86_64/bin/java)

Enter to keep the current selection[+], or type selection number: █
```

Kebetulan saya hanya punya 1 versi Java, yaitu Java 11 dengan OpenJDK.

## Neovim

Official site: [https://neovim.io](https://neovim.io){:target="_blank"}

Neovim is a refactor - and sometimes redactor - in the tradition of Vim, which itself derives from Stevie. It is not a rewrite, but a continuation and extension of Vim. Many rewrites, clones, emulators and imitators exist; some are very clever, but none are Vim. Neovim strives to be a superset of Vim, notwithstanding some intentionally removed misfeatures; excepting those few and carefully-considered excisions, Neovim is Vim. It is built for users who want the good parts of Vim, without compromise, and more.

{% shell_term $ %}
sudo dnf install neovim
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
make CMAKE_BUILD_TYPE=RelWithDebInfo -j$(expr nproc + 1)
sudo make install
{% endshell_term %}

Rebuild.

{% shell_term $ %}
make distclean
{% endshell_term %}

Saya menggunakan ripgrep,

Official site: [https://crates.io/crates/ripgrep](https://crates.io/crates/ripgrep){:target="_blank"}

Line-oriented search tool that recursively searches the current directory for a regex pattern while respecting gitignore rules. ripgrep has first class support on Windows, macOS and Linux.

{% shell_term $ %}
sudo dnf install ripgrep
{% endshell_term %}

## PostgreSQL

Official site: [http://www.postgresql.org/](http://www.postgresql.org/){:target="_blank"}

PostgreSQL is an advanced Object-Relational database management system (DBMS). The base postgresql package contains the client programs that you'll need to access a PostgreSQL DBMS server, as well as HTML documentation for the whole system.  These client programs can be located on the same machine as the PostgreSQL server, or on a remote machine that accesses a PostgreSQL server over a network connection.  The PostgreSQL server can be found in the postgresql-server sub-package.

{% box_info %}
<p markdown=1>Saya lebih memilih menggunakan container untuk memasang PostgreSQL.</p>
<p markdown=1>Bisa baca catatannya di sini, [Mudah Banget! PostgreSQL dengan Podman untuk Development](/blog/postgresql-dengan-podman-untuk-development){:target="_blank"}</p>
{% endbox_info %}

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

## SQLite3

Official site: [http://www.sqlite.org/](http://www.sqlite.org/){:target="_blank"}

SQLite is a C library that implements an SQL database engine. A large subset of SQL92 is supported. A complete database is stored in a single disk file. The API is designed for convenience and ease of use. Applications that link against SQLite can enjoy the power and flexibility of an SQL database without the administrative hassles of supporting a separate database server.  Version 2 and version 3 binaries are named to permit each to be installed on a single host.

{% shell_term $ %}
sudo dnf install sqlite
sudo dnf install sqlite-devel
sudo dnf install libsqlite3x
sudo dnf install libsqlite3x-devel
{% endshell_term %}

Saya memerlukan install juga package `-devel`.

## yarnpkg

Official site: [https://github.com/yarnpkg/yarn](https://github.com/yarnpkg/yarn){:target="_blank"}

Fast, reliable, and secure dependency management.

{% shell_term $ %}
sudo dnf install yarnpkg
{% endshell_term %}

## Ruby or Rails Developer

Saya lebih suka menggunakan **rbenv** untuk mendevelop Ruby apps.

Paket-paket yang diperlukan untuk rbenv-install mem-build Ruby.

{% shell_term $ %}
sudo dnf install openssl-devel
sudo dnf install libxml2-devel
sudo dnf install libxslt-devel
sudo dnf install readline-devel
{% endshell_term %}

Reinstall all your Ruby with rbenv (remove and install).

For database support library (PostgreSQL, MySQL/MariaDB, SQLite).

{% shell_term $ %}
sudo dnf install libpq-devel
sudo dnf install mysql++-devel
sudo dnf install libsqlite3x-devel
{% endshell_term %}

## Build ADVCMP

Sumber: [https://github.com/jarun/advcpmv](https://github.com/jarun/advcpmv){:target="_blank"}

A patch for GNU Core Utilities cp, mv to add progress bars.

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

{% box_info %}
<p markdown=1>Saya tidak lagi menggunakan **tlp** sejak Fedora 35 sudah menggunakan [**Power Profiles Daemon**](https://fedoraproject.org/wiki/Changes/Power_Profiles_Daemon){:target="_blank"}.</p>
{% endbox_info %}

Official site: [http://linrunner.de/en/tlp/tlp.html](http://linrunner.de/en/tlp/tlp.html){:target="_blank"}

TLP is an advanced power management tool for Linux. It comes with a default configuration already optimized for battery life. At the same time it is highly customizable to fulfill specific user requirements.

TLP supplies separate settings profiles for AC and battery power and can enable or disable Bluetooth, WiFi and WWAN radio devices upon system start-up.

For ThinkPads it provides a unified way to configure charging thresholds and re-calibrate the battery for all models which support it (via tp-smapi or acpi-call).

TLP is a pure command line tool with automated background tasks, it does not contain a GUI.

{% shell_term $ %}
sudo dnf install tlp
{% endshell_term %}

Untuk ThinkPad lama, seperti seri X61 yang saya gunakan.

{% shell_term $ %}
sudo dnf copr enable suhanc/tp_smapi
sudo dnf install tp_smapi
{% endshell_term %}

Untuk ThinkPad baru, seperti X260 yang saya gunakan.

{% shell_term $ %}
git clone https://github.com/teleshoes/tpacpi-bat
cd tpacpi-bat
./install.pl
{% endshell_term %}

Beberapa catatan tentang tlp:

1. [https://linrunner.de/tlp/faq/battery.html#how-to-choose-good-battery-charge-thresholds](https://linrunner.de/tlp/faq/battery.html#how-to-choose-good-battery-charge-thresholds){:target="_blank"}

2. [https://forums.lenovo.com/t5/Windows-10/Power-Manager-for-Windows-10/m-p/2113645?page=3#2129075](https://forums.lenovo.com/t5/Windows-10/Power-Manager-for-Windows-10/m-p/2113645?page=3#2129075){:target="_blank"}

## Cronie (Cronjob)

Official site: [https://github.com/cronie-crond/cronie](https://github.com/cronie-crond/cronie){:target="_blank"}

Cronie contains the standard UNIX daemon crond that runs specified programs at scheduled times and related tools. It is a fork of the original vixie-cron and has security and configuration enhancements like the ability to use pam and SELinux.

{% shell_term $ %}
sudo dnf install cronie
{% endshell_term %}

Jalankan & enable-kan `crond.service`.

{% shell_term $ %}
sudo systemctl enable --now crond.service
{% endshell_term %}

## Email Backend

### imap

Official site: [http://isync.sourceforge.net/](http://isync.sourceforge.net/){:target="_blank"}

mbsync is a command line application which synchronizes mailboxes. Currently Maildir and IMAP4 mailboxes are supported. New messages, message deletions and flag changes can be propagated both ways. mbsync is suitable for use in IMAP-disconnected mode.

{% shell_term $ %}
sudo dnf install isync
{% endshell_term %}

### smtp

Official site: [https://marlam.de/msmtp/](https://marlam.de/msmtp/){:target="_blank"}

It forwards messages to an SMTP server which does the delivery.

{% shell_term $ %}
sudo dnf install msmtp
{% endshell_term %}

## Neomutt

Official site: [https://neomutt.org/](https://neomutt.org/){:target="_blank"}

NeoMutt is a small but very powerful text-based MIME mail client. NeoMutt is highly configurable, and is well suited to the mail power user with advanced features like key bindings, keyboard macros, mail threading, regular expression searches and a powerful pattern matching language for selecting groups of messages.

{% shell_term $ %}
sudo dnf copr enable chriscowleyunix/neomutt
sudo dnf install neomutt
{% endshell_term %}

<br>
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

## FreeRDP

Official site: [http://www.freerdp.com/](http://www.freerdp.com/){:target="_blank"}

The xfreerdp & wlfreerdp Remote Desktop Protocol (RDP) clients from the FreeRDP project.

xfreerdp & wlfreerdp can connect to RDP servers such as Microsoft Windows machines, xrdp and VirtualBox.

{% shell_term $ %}
sudo dnf install freerdp
{% endshell_term %}

## x11vnc

Official site: [https://github.com/LibVNC/x11vnc](https://github.com/LibVNC/x11vnc){:target="_blank"}

What WinVNC is to Windows x11vnc is to X Window System, i.e. a server which serves the current X Window System desktop via RFB (VNC) protocol to the user.

Based on the ideas of x0rfbserver and on LibVNCServer it has evolved into a versatile and productive while still easy to use program.

{% shell_term $ %}
sudo dnf install x11vnc
{% endshell_term %}

## Rofi

Official site: [https://github.com/DaveDavenport/rofi](https://github.com/DaveDavenport/rofi){:target="_blank"}

Rofi is a dmenu replacement. Rofi, like dmenu, will provide the user with a textual list of options where one or more can be selected. This can either be, running an application, selecting a window or options provided by an external script.

{% shell_term $ %}
sudo dnf install rofi
{% endshell_term %}

## Rofi-Calc

**Manual Build**

Sumber: [https://github.com/svenstaro/rofi-calc](https://github.com/svenstaro/rofi-calc){:target="_blank"}

Deps,

{% shell_term $ %}
sudo dnf install rofi-devel
sudo dnf install qalculate
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/svenstaro/rofi-calc
cd rofi-calc
autoreconf -i
mkdir build
cd build/
../configure
make
sudo make install
{% endshell_term %}

## LazyGit

Official site: [https://github.com/jesseduffield/lazygit](https://github.com/jesseduffield/lazygit){:target="_blank"}

A simple terminal UI for git commands, written in Go with the gocui library.

<details markdown="1" style="width:100%;">
<summary style="cursor:pointer;">from Author...</summary>
<p>Rant time: You've heard it before, git is powerful, but what good is that power when everything is so damn hard to do? Interactive rebasing requires you to edi a goddamn TODO file in your editor? Are you kidding me? To stage part of a file you need to use a command line program to step through each hunk and if a hunk can't be split down any further but contains code you don't want to stage, you have to edit an arcane patch file by hand? Are you KIDDING me?! Sometimes you get asked to stash your changes when switching branches only to realise that after you switch and unstash that there weren't even any conflicts and it would have been fine to just checkout the branch directly? YOU HAVE GOT TO BE KIDDING ME!</p>
<p>If you're a mere mortal like me and you're tired of hearing how powerful git is when in your daily life it's a powerful pain in your ass, lazygit might be for you.</p>
</details>

{% shell_term $ %}
sudo dnf copr enable atim/lazygit
sudo dnf install lazygit
{% endshell_term %}

## LazyDocker

Official site: [https://github.com/jesseduffield/lazydocker](https://github.com/jesseduffield/lazydocker){:target="_blank"}

A simple terminal UI for both docker and docker-compose, written in Go with the gocui library.

<details markdown="1" style="width:100%;">
<summary style="cursor:pointer;">from Author...</summary>
<p>Memorising docker commands is hard. Memorising aliases is slightly less hard. Keeping track of your containers across multiple terminal windows is near impossible. What if you had all the information you needed in one terminal window with every common command living one keypress away (and the ability to add custom commands as well). Lazydocker's goal is to make that dream a reality.</p>
</details>

{% shell_term $ %}
sudo dnf copr enable atim/lazydocker
sudo dnf install lazydocker
{% endshell_term %}

## Seahorse

Official site: [https://wiki.gnome.org/Apps/Seahorse](https://wiki.gnome.org/Apps/Seahorse){:target="_blank"}

Seahorse is a graphical interface for managing and using encryption keys. It also integrates with nautilus, gedit and other places for encryption operations. It is a keyring manager.

{% shell_term $ %}
sudo dnf install seahorse
{% endshell_term %}

## Crow translate

Official site: [https://crow-translate.github.io/](https://crow-translate.github.io/){:target="_blank"}

A simple and lightweight translator that allows you to translate and speak text using Google, Yandex Bing, LibreTranslate and Lingva.

Sumber: [https://github.com/crow-translate/crow-translate](https://github.com/crow-translate/crow-translate){:target="_blank"}

Deps,

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
sudo make install
{% endshell_term %}

## libva-intel-driver

Official site: [https://github.com/intel/intel-vaapi-driver](https://github.com/intel/intel-vaapi-driver){:target="_blank"}

HW video decode support for Intel integrated graphics. [https://01.org/intel-media-for-linux](https://01.org/intel-media-for-linux){:target="_blank"}

{% shell_term $ %}
sudo dnf install libva-intel-hybrid-driver
{% endshell_term %}

<br>
Official site: [https://github.com/01org/intel-hybrid-driver](https://github.com/01org/intel-hybrid-driver){:target="_blank"}

libva-intel-hybrid-driver is the VA-API implementation for Intel G45 chipsets and Intel HD Graphics for Intel Core processor family.

It allows to accelerate VP9 videos on Skylake and Kabylake architectures.

{% shell_term $ %}
sudo dnf install libva-intel-hybrid-driver
{% endshell_term %}

## Vulkan Hardware Capability Viewer

Sumber: [http://vulkan.gpuinfo.org/listdevices.php](http://vulkan.gpuinfo.org/listdevices.php){:target="_blank"}

Download: [http://vulkan.gpuinfo.org/download.php](http://vulkan.gpuinfo.org/download.php){:target="_blank"}

## GIMP

GIMP (GNU Image Manipulation Program) is a powerful image composition and editing program, which can be extremely useful for creating logos and other graphics for web pages. GIMP has many of the tools and filters you would expect to find in similar commercial offerings, and some interesting extras as well. GIMP provides a large image manipulation toolbox, including channel operations and layers, effects, sub-pixel imaging and anti-aliasing, and conversions, all with multi-level undo.

{% shell_term $ %}
sudo dnf install gimp
{% endshell_term %}

## Inkscape

Inkscape is a vector graphics editor, with capabilities similar to Illustrator, CorelDraw, or Xara X, using the W3C standard Scalable Vector Graphics (SVG) file format.  It is therefore a very useful tool for web designers and as an interchange format for desktop publishing.

Inkscape supports many advanced SVG features (markers, clones, alpha blending, etc.) and great care is taken in designing a streamlined interface. It is very easy to edit nodes, perform complex path operations, trace bitmaps and much more.

{% shell_term $ %}
sudo dnf install inkscape
{% endshell_term %}

## Figma for Linux

Official site: [https://github.com/Figma-Linux/figma-linux](https://github.com/Figma-Linux/figma-linux){:target="_blank"}

Figma is the first interface design tool based in the browser, making it easier for teams to create software.

(flatpak - flathub)

{% shell_term $ %}
flatpak install flathub io.github.Figma_Linux.figma_linux
{% endshell_term %}

## WeeChat

WeeChat (Wee Enhanced Environment for Chat) is a portable, fast, light and extensible IRC client. Everything can be done with a keyboard. It is customizable and extensible with scripts.

{% shell_term $ %}
sudo dnf install weechat
{% endshell_term %}

<br>
**Manual Build**

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

Official site: [https://github.com/poljar/weechat-matrix](https://github.com/poljar/weechat-matrix){:target="_blank"}

Weechat Matrix protocol script written in python

Deps,
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

Official site: [https://github.com/lupoDharkael/flameshot](https://github.com/lupoDharkael/flameshot){:target="_blank"}

Powerful and simple to use screenshot software with built-in editor with advanced features.

{% shell_term $ %}
sudo dnf install flameshot
{% endshell_term %}

## Optipng

Official site: [http://optipng.sourceforge.net/](http://optipng.sourceforge.net/){:target="_blank"}

OptiPNG is a PNG optimizer that recompresses image files to a smaller size, without losing any information. This program also converts external formats (BMP, GIF, PNM and TIFF) to optimized PNG, and performs PNG integrity checks and corrections.

{% shell_term $ %}
sudo dnf install optipng
{% endshell_term %}

## Scrot

Official site: [https://github.com/resurrecting-open-source-projects/scrot](https://github.com/resurrecting-open-source-projects/scrot){:target="_blank"}

scrot is a simple command line screen capture utility.

{% shell_term $ %}
sudo dnf install scrot
{% endshell_term %}

<br>
**Manual Build**

Sumber: [https://github.com/resurrecting-open-source-projects/scrot](https://github.com/resurrecting-open-source-projects/scrot){:target="_blank"}

Deps,

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
./autogen.sh
./configure
make
sudo make install
{% endshell_term %}

## Maim

Official site: [https://github.com/naelstrof/maim](https://github.com/naelstrof/maim){:target="_blank"}

maim (make image) is a screenshot utility that provides options for capturing predetermined or user selected regions of your desktop.

{% shell_term $ %}
sudo dnf install maim
{% endshell_term %}

## pulseaudio-utils

Official site: [http://www.freedesktop.org/wiki/Software/PulseAudio](http://www.freedesktop.org/wiki/Software/PulseAudio){:target="_blank"}

This package contains command line utilities for the PulseAudio sound server.

{% shell_term $ %}
sudo dnf install pulseaudio-utils
{% endshell_term %}

{% box_info %}
<p markdown=1>**Change/Swap Pipewire with Pulseaudio**</p>
<p markdown=1>Sumber: [https://fedoraproject.org/wiki/Changes/DefaultPipeWire#Upgrade.2Fcompatibility_impact](https://fedoraproject.org/wiki/Changes/DefaultPipeWire#Upgrade.2Fcompatibility_impact){:target="_blank"}</p>
{% shell_term $ %}
sudo dnf swap --allowerasing pipewire-pulseaudio pulseaudio
{% endshell_term %}
<p markdown=1>\* Sejak Fedora 35, saya sudah menetap dengan **Pipewire**.</p>
{% endbox_info %}

## pavucontrol

Official site: [http://freedesktop.org/software/pulseaudio/pavucontrol](http://freedesktop.org/software/pulseaudio/pavucontrol){:target="_blank"}

PulseAudio Volume Control (pavucontrol) is a simple GTK based volume control tool ("mixer") for the PulseAudio sound server. In contrast to classic mixer tools this one allows you to control both the volume of hardware devices and of each playback stream separately.

{% shell_term $ %}
sudo dnf install pavucontrol
{% endshell_term %}

## pamixer

Sumber: [https://github.com/cdemoulins/pamixer](https://github.com/cdemoulins/pamixer){:target="_blank"}

pamixer is like amixer but for pulseaudio. It can control the volume levels of the sinks.

Deps,

{% shell_term $ %}
sudo dnf install boost-devel
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/cdemoulins/pamixer.git
cd pamixer
meson setup build
meson compile -C build
meson install -C build
sudo make install
{% endshell_term %}

## easyeffects

Official site: [https://github.com/wwmm/easyeffects](https://github.com/wwmm/easyeffects){:target="_blank"}

Limiters, compressor, reverberation, high-pass filter, low pass filter, equalizer many more effects for PipeWire applications.

{% shell_term $ %}
sudo dnf install easyeffects
{% endshell_term %}

## helvum

Official site: [https://gitlab.freedesktop.org/ryuukyu/helvum](https://gitlab.freedesktop.org/ryuukyu/helvum){:target="_blank"}

Helvum is a GTK-based patchbay for pipewire, inspired by the JACK tool catia.

**Manual Build**

The recommended way to build is using flatpak, which will take care of all dependencies and avoid any problems that may come from different system configurations.

If you don't have the flathub repo in your remote-list for flatpak you will need to add that first:

{% shell_term $ %}
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
{% endshell_term %}

Then install the required flatpak platform and SDK, if you dont have them already:

{% shell_term $ %}
flatpak install org.gnome.{Platform,Sdk}//41 org.freedesktop.Sdk.Extension.rust-stable//21.08 org.freedesktop.Sdk.Extension.llvm12//21.08
{% endshell_term %}

To compile and install as a flatpak, run:

{% shell_term $ %}
sudo flatpak-builder --install flatpak-build/ build-aux/org.freedesktop.ryuukyu.Helvum.json
{% endshell_term %}

You can then run the app via:

{% shell_term $ %}
flatpak run org.freedesktop.ryuukyu.Helvum
{% endshell_term %}

## HexChat

Official site: [https://hexchat.github.io](https://hexchat.github.io){:target="_blank"}

HexChat is an easy to use graphical IRC chat client for the X Window System. It allows you to join multiple IRC channels (chat rooms) at the same time, talk publicly, private one-on-one conversations etc. Even file transfers are possible.

{% shell_term $ %}
sudo dnf install hexchat
{% endshell_term %}

Install adwaita-gtk2-theme for fix issue theme,
Sumber: [https://bugzilla.redhat.com/show_bug.cgi?id=1963223](https://bugzilla.redhat.com/show_bug.cgi?id=1963223){:target="_blank"}

{% shell_term $ %}
sudo dnf install adwaita-gtk2-theme
{% endshell_term %}

## Gping

Official site: [https://github.com/orf/gping](https://github.com/orf/gping){:target="_blank"}

Ping, but with a graph.

Sumber: [https://github.com/orf/gping](https://github.com/orf/gping){:target="_blank"}

{% shell_term $ %}
sudo dnf copr enable atim/gping
sudo dnf install gping
{% endshell_term %}

## PrettyPing

Official site: [http://denilson.sa.nom.br/prettyping](http://denilson.sa.nom.br/prettyping){:target="_blank"}

Sumber: [https://github.com/denilsonsa/prettyping](https://github.com/denilsonsa/prettyping){:target="_blank"}

prettyping runs the standard ping in background and parses its output, showing ping responses in a graphical way at the terminal, by using colors and Unicode characters.

**Don’t have support for UTF-8 in your terminal?**<br>
No problem, you can disable it and use standard ASCII characters instead.

**Don’t have support for colors?**<br>
No problem, you can also disable them.

{% shell_term $ %}
sudo dnf install prettyping
{% endshell_term %}

## Dunst

Official site: [https://dunst-project.org](https://dunst-project.org){:target="_blank"}

Dunst is a lightweight replacement for the notification daemons provided by most desktop environments. It’s very customizable, isn’t dependent on any toolkits, and therefore fits into those window manager centric setups we all love to customize to perfection.

{% shell_term $ %}
sudo dnf install dunst
{% endshell_term %}

## SimpleScreenRecorder

Official site: [https://www.maartenbaert.be/simplescreenrecorder/](https://www.maartenbaert.be/simplescreenrecorder/){:target="_blank"}

It is a screen recorder for Linux. Despite the name, this program is actually quite complex. It's 'simple' in the sense that it's easier to use than ffmpeg/avconv or VLC.

{% shell_term $ %}
sudo dnf install simplescreenrecorder
{% endshell_term %}

## Vokoscreen

Official site: [https://github.com/vkohaupt/vokoscreen](https://github.com/vkohaupt/vokoscreen){:target="_blank"}

vokoscreen is an easy to use screencast creator to record educational videos, live recordings of browser, installation, videoconferences, etc.

{% shell_term $ %}
sudo dnf install vokoscreen
{% endshell_term %}

Or -NG

{% shell_term $ %}
sudo dnf install vokoscreenNG
{% endshell_term %}

{% shell_term $ %}
sudo dnf install alsa-lib-devel
{% endshell_term %}

## ps_mem

Official site: [https://github.com/pixelb/ps_mem](https://github.com/pixelb/ps_mem){:target="_blank"}

The ps_mem tool reports how much core memory is used per program (not per process). In detail it reports: sum(private RAM for program processes) + sum(Shared RAM for program processes) 

The shared RAM is problematic to calculate, and the tool automatically selects the most accurate method available for the running kernel.

{% shell_term $ %}
sudo dnf install ps_mem
{% endshell_term %}

## GColor2

Official site: [http://gcolor2.sourceforge.net/](http://gcolor2.sourceforge.net/){:target="_blank"}

gcolor2 is a simple color selector that was originally based on gcolor, ported to use GTK+2, and now has a completely new UI.

{% shell_term $ %}
sudo dnf install gcolor2
{% endshell_term %}

## Suckless

### st

Official site: [http://st.suckless.org/](http://st.suckless.org/){:target="_blank"}

st is a simple terminal implementation for X.

**Manual Build**

Deps,

{% shell_term $ %}
sudo dnf install libXft-devel
{% endshell_term %}

{% shell_term $ %}
git clone https://git.suckless.org/st
cd st
make
sudo make install
{% endshell_term %}

For Emoji support,

Sumber: [https://copr.fedorainfracloud.org/coprs/linuxredneck/libXft-bgra/](https://copr.fedorainfracloud.org/coprs/linuxredneck/libXft-bgra/){:target="_blank"}

{% shell_term $ %}
sudo dnf copr enable linuxredneck/libXft-bgra
sudo rpm -e --nodeps libXft libXft-devel
sudo dnf install libXft-bgra libXft-bgra-devel
{% endshell_term %}

Add `libXft` to `exclude=` package on `/etc/dnf/dnf.conf`.

### dwm

Official site: [http://dwm.suckless.org/](http://dwm.suckless.org/){:target="_blank"}

dwm is a dynamic window manager for X. It manages windows in tiled, monocle and floating layouts. All of the layouts can be applied dynamically, optimising the environment for the application in use and the task performed.

**Manual Build**

Deps,

{% shell_term $ %}
sudo dnf install libXinerama-devel
sudo dnf install xsetroot
{% endshell_term %}

{% shell_term $ %}
git clone https://git.suckless.org/dwm
cd dwm
make
sudo make install
{% endshell_term %}

Kalau ingin mendaftarkan dwm ke dalam session list yang ada di Display Manager seperti LightDM, GDM, SDDM, dll., tinggal buat saja file Desktop Entry Spec nya saja.

{% shell_term $ %}
sudo vi /usr/share/xsessions/dwm.desktop
{% endshell_term %}

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

GitHub source: [https://github.com/ritze/pinentry-dmenu](https://github.com/ritze/pinentry-dmenu){:target="_blank"}

pinentry-dmenu is a pinentry program with the charm of dmenu.

Deps,

**Manual Build**

Deps,

{% shell_term $ %}
sudo dnf install libassuan-devel
sudo dnf install libconfig-devel
sudo dnf install gpgme-devel
{% endshell_term %}

Di Fedora, library `assuan.h` tidak berada di dalam directory `/usr/include/` tetapi masih berada di dalam satu level directory lagi, yaitu `/usr/include/libassuan2/`. Buat saja link agar proses make dapat menemukan header tersebut.

{% shell_term $ %}
sudo ln -sf /usr/include/libassuan2/assuan.h /usr/include/assuan.h
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/ritze/pinentry-dmenu
cd pinentry-dmenu
make
sudo make install
{% endshell_term %}

Ubah/tambahkan/arahkan value dari variable `pinentry-program` di dalam file `~/.gnupg/gpg-agent.conf` menjadi `pinentry-dmenu`.

{% highlight_caption ~/.gnupg/gpg-agent.conf %}
{% highlight shell linenos %}
pinentry-program /usr/local/bin/pinentry-dmenu
{% endhighlight %}

### pinentry-rofi

Official site: [https://github.com/plattfot/pinentry-rofi](https://github.com/plattfot/pinentry-rofi){:target="_blank"}

Rofi frontend to pinentry.

**Manual Build**

Deps,

{% shell_term $ %}
sudo dnf install autoconf
sudo dnf install autoconf-archive
sudo dnf install automake
sudo dnf install pkg-config
sudo dnf install texinfo
sudo dnf install guile
sudo dnf install guile-devel
{% endshell_term %}

### sxiv

Official site: [https://github.com/muennich/sxiv](https://github.com/muennich/sxiv){:target="_blank"}

Simple X Image Viewer is a lightweight and scriptable image viewer written in C.

**Manual Build**

Deps,

{% shell_term $ %}
sudo dnf install imlib2-devel
sudo dnf install libexif-devel
sudo dnf install giflib-devel
sudo dnf install libXft-bgra-devel
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/muennich/sxiv
cd sxiv
make
sudo make install
{% endshell_term %}

## GTK3-NOCSD

Official site: [https://github.com/PCMan/gtk3-nocsd](https://github.com/PCMan/gtk3-nocsd){:target="_blank"}

gtk3-nocsd is a small module used to disable the client side decoration of Gtk+ 3.

{% shell_term $ %}
sudo dnf install gtk3-nocsd
{% endshell_term %}

{% highlight_caption ~/.profile %}
{% highlight shell linenos %}
# A hack to disable gtk+ 3 client side decoration
export LD_PRELOAD=/usr/lib64/libgtk3-nocsd.so.0
export GTK_CSD=0
{% endhighlight %}

{% box_info %}
<p markdown=1>Sejak GNOME 41, beberapa aplikasi GNOME seperti `gnome-calculator` terdapat keanehan pada bagian border.</p>
<p markdown=1>Karenanya, saya tidak lagi menggunakan cara ini.</p>
{% endbox_info %}

## Flatpak via Flathub Remote

Flatpak is a tool for managing applications and the runtimes they use. In the Flatpak model, applications can be built and distributed independently from the host system they are used on, and they are isolated from the host system ('sandboxed') to some degree, at runtime.

Flatpak uses OSTree to distribute and deploy data. The repositories it uses are OSTree repositories and can be manipulated with the ostree utility. Installed runtimes and applications are OSTree checkouts.

{% shell_term $ %}
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
{% endshell_term %}

## Gromit-MPX

Official site: [https://github.com/bk138/gromit-mpx](https://github.com/bk138/gromit-mpx){:target="_blank"}

Gromit-MPX is an on-screen annotation tool that works with any Unix desktop environment under X11 as well as Wayland.

(Flatpak - Flathub)

{% shell_term $ %}
flatpak install flathub net.christianbeier.Gromit-MPX
{% endshell_term %}

## Telegram Desktop

Official site: [https://desktop.telegram.org/](https://desktop.telegram.org/){:target="_blank"}

Fast and secure desktop app, perfectly synced with your mobile phone.

(RPMFusion - Free)

{% shell_term $ %}
sudo dnf install telegram-desktop
{% endshell_term %}

Kalau ingin versi yang lebih up-to-date bisa menggunakan versi flatpak.

(Flatpak - Flathub)

{% shell_term $ %}
flatpak install flathub org.telegram.desktop
{% endshell_term %}

## Hide desktop icon on Application List

Sumber: [https://wiki.archlinux.org/title/desktop_entries#Hide_desktop_entries](https://wiki.archlinux.org/title/desktop_entries#Hide_desktop_entries){:target="_blank"}

Firstly, copy the desktop entry file in question to `~/.local/share/applications` to avoid your changes being overwritten.

Then, to hide the entry in all environments, open the desktop entry file in a text editor and add the following line: `NoDisplay=true`.

To hide the entry in a specific desktop, add the following line to the desktop entry file: `NotShowIn=desktop-name`.

where desktop-name can be option such as `GNOME`, `Xfce`, `KDE` etc.

A desktop entry can be hidden in more than desktop at once - simply separate the desktop names with a semi-colon.

## Center window in GNOME

Sumber: [https://www.reddit.com/r/gnome/comments/aaqy2p/center_windows_in_gnome/](https://www.reddit.com/r/gnome/comments/aaqy2p/center_windows_in_gnome/){:target="_blank"}

By: carmanaughty

For a keyboard shortcut, there's a dconf key under `/org/gnome/desktop/wm/keybindings` which is `move-to-center` and it should be empty. Change that to whatever you want (for instance, I use ['<Super><Control><Shift>Home']).

By: [deleted]

Its also in GNOME Tweaks. It is under "Windows" -> "Center New Windows".

## Polybar

Official site: [https://polybar.github.io/](https://polybar.github.io/){:target="_blank"}

Polybar aims to help users build beautiful and highly customizable status bars for their desktop environment, without the need of having a black belt in shell scripting.

{% shell_term $ %}
sudo dnf install polybar
{% endshell_term %}

## Feh

Official site: [http://feh.finalrewind.org](http://feh.finalrewind.org){:target="_blank"}

feh is a versatile and fast image viewer using imlib2, the premier image file handling library. feh has many features, from simple single file viewing, to multiple file modes using a slide-show or multiple windows. feh supports the creation of montages as index prints with many user-configurable options.

{% shell_term $ %}
sudo dnf install feh
{% endshell_term %}

## SXHKD

Official site: [https://github.com/baskerville/sxhkd](https://github.com/baskerville/sxhkd){:target="_blank"}

Simple HotKey Daemon.

sxhkd is an X daemon that reacts to input events by executing commands. Its configuration file is a series of bindings that define the associations between the input events and the commands. The format of the configuration file supports a simple notation for mapping multiple shortcuts to multiple commands in parallel.

{% shell_term $ %}
sudo dnf install sxhkd
{% endshell_term %}

## j4-dmenu-desktop (dmenu wrapper)

Official site: [https://github.com/enkore/j4-dmenu-desktop](https://github.com/enkore/j4-dmenu-desktop){:target="_blank"}

j4-dmenu-desktop is a replacement for i3-dmenu-desktop. It's purpose is to find .desktop files and offer you a menu to start an application using dmenu. It should work just fine on about any desktop environment. You can also execute shell commands using it.

{% shell_term $ %}
sudo dnf install j4-dmenu-desktop
{% endshell_term %}

## XCompmgr

Official site: [https://gitlab.freedesktop.org/xorg/app/xcompmgr](https://gitlab.freedesktop.org/xorg/app/xcompmgr){:target="_blank"}

xcompmgr is a sample compositing manager for X servers supporting the XFIXES, DAMAGE, and COMPOSITE extensions. It enables basic eye-candy effects

{% shell_term $ %}
sudo dnf install libXcomposite-devel
sudo dnf install libXdamage-devel
{% endshell_term %}

{% shell_term $ %}
sudo dnf install xcompmgr
{% endshell_term %}

{% box_info %}
<p markdown=1>Saya tidak lagi menggunakan paket ini. Sejak menggunakan x260, saya menggunakan picom.</p>
{% endbox_info %}

## Picom

Official site: [https://github.com/yshui/picom](https://github.com/yshui/picom){:target="_blank"}

This is forked from the original Compton because that seems to have become unmaintained.

The current battle plan of this fork is to refactor it to make the code possible to maintain, so potential contributors won't be scared away when they take a look at the code.

We also try to fix bugs.

{% shell_term $ %}
sudo dnf install picom
{% endshell_term %}

<br>
**Manual Build**

Deps,

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

I'm using picom with rounded corner by [https://github.com/ibhagwan/picom](https://github.com/ibhagwan/picom){:target="_blank"}.

Sumber: [https://github.com/yshui/picom/blob/next/README.md#build](https://github.com/yshui/picom/blob/next/README.md#build){:target="_blank"}

{% shell_term $ %}
git clone https://github.com/ibhagwan/picom
cd picom
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install
{% endshell_term %}

## xmodmap

Official site: [https://www.x.org](https://www.x.org){:target="_blank"}

The xmodmap program is used to edit and display the keyboard modifier map and keymap table that are used by client applications to convert event keycodes into keysyms.

{% shell_term $ %}
sudo dnf install xmodmap
{% endshell_term %}

## xcape

Official site: [https://github.com/alols/xcape](https://github.com/alols/xcape){:target="_blank"}

xcape allows you to use a modifier key as another key when pressed and released on its own. Note that it is slightly slower than pressing the original key, because the pressed event does not occur until the key is released. The default behaviour is to generate the Escape key when Left Control is pressed and released on its own. (If you don't understand why anybody would want this, I'm guessing that Vim is not your favourite text editor ;)

(copr - dawid/xcape )

{% shell_term $ %}
sudo dnf copr enable dawid/xcape
sudo dnf install xcopr
{% endshell_term %}

<br>
**Manual Build**

Deps,

{% shell_term $ %}
sudo dnf install git
sudo dnf install gcc
sudo dnf install make
sudo dnf install pkgconfig
sudo dnf install libX11-devel
sudo dnf install libXtst-devel
sudo dnf install libXi-devel
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/alols/xcape.git
cd xcape
make
sudo make install
{% endshell_term %}

## xev

Official site: [https://www.x.org](https://www.x.org){:target="_blank"}

X Event utility. xev displays the X11 protocol events sent to a given window.

## xdotool

Official site: [http://www.semicomplete.com/projects/xdotool/](http://www.semicomplete.com/projects/xdotool/){:target="_blank"}

Fake keyboard/mouse input. This tool lets you programmatically (or manually) simulate keyboard input and mouse activity, move and re-size windows, etc.

{% shell_term $ %}
sudo dnf install xdotool
{% endshell_term %}

## brightlight

Official site: [https://github.com/multiplexd/brightlight](https://github.com/multiplexd/brightlight){:target="_blank"}

brightlight gets and sets the screen back-light brightness on Linux systems using the kernel sysfs interface.

{% shell_term $ %}
sudo dnf install brightlight
{% endshell_term %}

## Udiskie

Official site: [https://pypi.org/project/udiskie](https://pypi.org/project/udiskie){:target="_blank"}

udiskie is a front-end for UDisks written in python. Its main purpose is automatically mounting removable media, such as CDs or flash drives. It has optional mount notifications, a GTK tray icon and user level CLIs for manual mounting and unmounting operations.

{% shell_term $ %}
sudo dnf install udiskie
{% endshell_term %}

## abduco

Official site: [http://www.brain-dump.org/projects/abduco/](http://www.brain-dump.org/projects/abduco/){:target="_blank"}

abduco provides session management i.e. it allows programs to be run independently from its controlling terminal. That is programs can be detached - run in the background - and then later reattached. Together with dvtm it provides a simpler and cleaner alternative to tmux or screen.

{% shell_term $ %}
sudo dnf install abduco
{% endshell_term %}

## dtach

Official site: [https://github.com/crigler/dtach](https://github.com/crigler/dtach){:target="_blank"}

dtach is a program that emulates the detach feature of screen, with less overhead. It is designed to be transparent and un-intrusive; it avoids interpreting the input and output between attached terminals and the program under its control. Consequently, it works best with full-screen applications such as emacs.

{% shell_term $ %}
sudo dnf install dtach
{% endshell_term %}

## LXappearance

Official site: [http://lxde.org/](http://lxde.org/){:target="_blank"}

Feature-rich GTK+ theme switcher for LXDE.

LXAppearance is a new GTK+ theme switcher developed for LXDE, the Lightweight X11 Desktop Environment. It is able to change GTK+ themes, icon themes, and fonts used by applications. All changes done by the users can be seen immediately in the preview area. After clicking the "Apply" button, the settings will be written to gtkrc, and all running programs will be asked to reload their themes.

{% shell_term $ %}
sudo dnf install lxappearance
{% endshell_term %}

## unclutter-xfixes

Official site: [https://github.com/Airblader/unclutter-xfixes](https://github.com/Airblader/unclutter-xfixes){:target="_blank"}

Hides the cursor on inactivity (rewrite of unclutter).

**Manual Build**

Deps,

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

Official site: [https://calibre-ebook.com/](https://calibre-ebook.com/){:target="_blank"}

Calibre is meant to be a complete e-library solution. It includes library management, format conversion, news feeds to ebook conversion as well as e-book reader sync features.

Calibre is primarily a ebook cataloging program. It manages your ebook collection for you. It is designed around the concept of the logical book, i.e. a single entry in the database that may correspond to ebooks in several formats. It also supports conversion to and from a dozen different ebook formats.

{% shell_term $ %}
sudo dnf install calibre
{% endshell_term %}

## System Config Printer

Official site: [https://github.com/OpenPrinting/system-config-printer](https://github.com/OpenPrinting/system-config-printer){:target="_blank"}

system-config-printer is a graphical user interface that allows the user to configure a CUPS print server.

{% shell_term $ %}
sudo dnf install system-config-printer
{% endshell_term %}

## PPD from foomatic-db

Official site: [http://www.openprinting.org](http://www.openprinting.org){:target="_blank"}

This is the database of printers, printer drivers, and driver options for Foomatic.

{% shell_term $ %}
sudo dnf install foomatic-db
sudo dnf install foomatic-db-ppds
{% endshell_term %}

## XSane (Scanner)

Official site: [http://www.xsane.org/](http://www.xsane.org/){:target="_blank"}

XSane is an X based interface for the SANE (Scanner Access Now Easy) library, which provides access to scanners, digital cameras, and other capture devices. XSane is written in GTK+ and provides control for performing the scan and then manipulating the captured image.

{% shell_term $ %}
sudo dnf install xsane
{% endshell_term %}

## Gparted

Official site: [http://gparted.org](http://gparted.org){:target="_blank"}

GParted stands for Gnome Partition Editor and is a graphical frontend to libparted. Among other features it supports creating, resizing, moving and copying of partitions. Also several (optional) filesystem tools provide support for filesystems not included in libparted. These optional packages will be detected at runtime and don't require a rebuild of GParted.

{% shell_term $ %}
sudo dnf install gparted
{% endshell_term %}

## Numix Solarized Theme Build

Official site: [https://github.com/numixproject/numix-gtk-theme](https://github.com/numixproject/numix-gtk-theme){:target="_blank"}

A modern flat theme with a combination of light and dark elements.

Install deps buat ngebuild.

{% shell_term $ %}
sudo dnf install sassc
sudo dnf install gdk-pixbuf2-devel
{% endshell_term %}

Install deps numix theme,

{% shell_term $ %}
sudo dnf install numix-gtk-theme
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/numixproject/numix-gtk-theme
cd numix-gtk-theme
{% endshell_term %}

Saya memiliki Codedark.colors

{% shell_term $ %}
sudo make THEME=Codedark install
{% endshell_term %}

## Aria2

Official site: [http://aria2.github.io/](http://aria2.github.io/){:target="_blank"}

aria2 is a download utility with resuming and segmented downloading. Supported protocols are HTTP/HTTPS/FTP/BitTorrent. It also supports Metalink version 3.0.

{% shell_term $ %}
sudo dnf install aria2
{% endshell_term %}

Install juga TUI nya biar nyaman.

{% shell_term $ %}
pip install --user "aria2p[tui]"
{% endshell_term %}

## Mate Polkit

Official site: [http://mate-desktop.org](http://mate-desktop.org){:target="_blank"}

Integrates polkit with the MATE Desktop environment.

{% shell_term $ %}
sudo dnf install mate-polkit
{% endshell_term %}

## LXpolkit

Official site: [http://lxde.sourceforge.net/](http://lxde.sourceforge.net/){:target="_blank"}

LXPolKit is a simple PolicyKit authentication agent developed for LXDE, the Lightweight X11 Desktop Environment.

{% shell_term $ %}
sudo dnf install lxpolkit
{% endshell_term %}

## p7zip

Official site: [http://www.7-zip.org/](http://www.7-zip.org/){:target="_blank"}

p7zip is a port of 7za.exe for Unix. 7-Zip is a file archiver with a very high compression ratio.

{% shell_term $ %}
sudo dnf install p7zip
sudo dnf install p7zip-plugins
{% endshell_term %}

## Screenkey

Official site: [https://www.thregr.org/~wavexx/software/screenkey](https://www.thregr.org/~wavexx/software/screenkey){:target="_blank"}

A screencast tool to display your keys.

<details markdown="1" style="width:100%;">
<summary style="cursor:pointer;">Features...</summary>
* Several keyboard translation methods
* Key composition/input method support
* Configurable font/size/position
* Highlighting of recent keystrokes
* Improved backspace processing
* Normal/Emacs/Mac caps modes
* Multi-monitor support
* Dynamic recording control etc.
</details>

{% shell_term $ %}
sudo dnf install screenkey
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

Official site: [https://github.com/bgli/kbbi-qt](https://github.com/bgli/kbbi-qt){:target="_blank"}

KBBI Qt adalah aplikasi Kamus Besar Bahasa Indonesia berbasis Graphical User Interface (GUI) yang dikembangkan menggunakan bahasa pemrograman C++ dan Framework Qt. KBBI Qt memiliki antarmuka grafis yang dapat digunakan dengan mudah di desktop GNU/Linux. KBBI Qt merupakan perangkat lunak bebas (free software) berlisensi GNU GPL v3.0. Saat ini KBBI Qt siap untuk dipasang pada distribusi GNU/Linux Fedora 23/24/25/Rawhide, CentOS 7/RHEL 7, Debian dan distro-distro turunan Debian serta sistem operasi Windows.

{% shell_term $ %}
sudo dnf install qt5-qtbase-devel
sudo dnf install qtchooser
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/bgli/kbbi-qt.git
cd kbbi-qt
qmake-qt5 KBBI-Qt.pro
make
sudo make install
{% endshell_term %}

## Zathura

Official site: [http://pwmt.org/projects/zathura/](http://pwmt.org/projects/zathura/){:target="_blank"}

Zathura is a highly customizable and functional document viewer. It provides a minimalistic and space saving interface as well as an easy usage that mainly focuses on keyboard interaction.

Zathura requires plugins to support document formats. For instance:

* zathura-pdf-poppler to open PDF files,
* zathura-ps to open PostScript files,
* zathura-djvu to open DjVu files, or
* zathura-cb to open comic book files.

All of these are available as separate packages in Fedora. A zathura-plugins-all package is available should you want to install all available plugins.

{% shell_term $ %}
sudo dnf install zathura
sudo dnf install zathura-pdf-mupdf
{% endshell_term %}

## Kamus

Official site: [https://github.com/abihf/kamus](https://github.com/abihf/kamus){:target="_blank"}

Simple English <=> Indonesia Dictioanry Application.

{% shell_term $ %}
sudo dnf install vala
sudo dnf install libvala-devel
sudo dnf install gtk3-devel
sudo dnf install libgee-devel
{% endshell_term %}

{% shell_term $ %}
git clone https://github.com/abihf/kamus.git
cd kamus
./configure
make
sudo make install
{% endshell_term %}

## Thunderbird

Official site: [http://www.mozilla.org/projects/thunderbird/](http://www.mozilla.org/projects/thunderbird/){:target="_blank"}

Mozilla Thunderbird is a standalone mail and newsgroup client.

{% shell_term $ %}
sudo dnf install thunderbird
{% endshell_term %}

## Evolution

Official site: [https://wiki.gnome.org/Apps/Evolution](https://wiki.gnome.org/Apps/Evolution){:target="_blank"}

Evolution is the GNOME mailer, calendar, contact manager and communications tool. The components which make up Evolution are tightly integrated with one another and act as a seamless personal information-management tool.

{% shell_term $ %}
sudo dnf install evolution
{% endshell_term %}

<br>
For **Tray icon**

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

Official site: [https://wiki.gnome.org/Apps/Gucharmap](https://wiki.gnome.org/Apps/Gucharmap){:target="_blank"}

This program allows you to browse through all the available Unicode characters and categories for the installed fonts, and to examine their detailed properties. It is an easy way to find the character you might only know by its Unicode name or code point.

{% shell_term $ %}
sudo dnf install gucharmap
{% endshell_term %}

## Zoom Meeting Client

Sumber: [https://support.zoom.us/hc/en-us/articles/204206269-Installing-or-updating-Zoom-on-Linux](https://support.zoom.us/hc/en-us/articles/204206269-Installing-or-updating-Zoom-on-Linux#h_825b50ac-ad15-44a8-9959-28c97e4803ef){:target="_blank"}

Sumber: [https://tecadmin.net/install-zoom-client-on-fedora/](https://tecadmin.net/install-zoom-client-on-fedora/){:target="_blank"}

{% shell_term $ %}
wget https://zoom.us/client/latest/zoom_x86_64.rpm
sudo dnf localinstall zoom_x86_64.rpm
{% endshell_term %}

## ffmulticonverter

Official site: [https://sites.google.com/site/ffmulticonverter/home](https://sites.google.com/site/ffmulticonverter/home){:target="_blank"}

Graphical application which enables you to convert audio, video, image and
document files between all popular formats using ffmpeg, unoconv, and
ImageMagick.

<details markdown="1" style="width:100%;">
<summary style="cursor:pointer;">Features...</summary>
- Conversions for several file formats.
- Very easy to use interface.
- Access to common conversion options.
- Audio/video ffmpeg-presets management.
- Options for saving and naming files.
- Recursive conversions
</details>

{% shell_term $ %}
sudo dnf install ffmulticonverter
{% endshell_term %}

## HandBrake

Official site: [http://handbrake.fr/](http://handbrake.fr/){:target="_blank"}

HandBrake is a general-purpose, free, open-source, cross-platform, multithreaded video transcoder software application. It can process most common multimedia files and any DVD or Bluray sources that do not contain any kind of copy protection.

This package contains the command line version of the program.

{% shell_term $ %}
sudo dnf install HandBrake-gui
{% endshell_term %}

## Discord

Official site: [https://discordapp.com/](https://discordapp.com/){:target="_blank"}

Linux Release for Discord, a free proprietary VoIP application designed for gaming communities.

(RPMFusion - NonFree)

{% shell_term $ %}
sudo dnf install discord
{% endshell_term %}

## Slack

Official site: [https://slack.com/intl/en-id/downloads/linux](https://slack.com/intl/en-id/downloads/linux){:target="_blank"}

Slack is the collaboration hub that brings the right people, information, and tools together to get work done.

{% shell_term $ %}
wget https://downloads.slack-edge.com/linux_releases/slack-4.17.0-0.1.fc21.x86_64.rpm
sudo dnf localinstall slack-4.17.0-0.1.fc21.x86_64.rpm
{% endshell_term %}

## PDF Arranger

Official site: [https://github.com/pdfarranger/pdfarranger](https://github.com/pdfarranger/pdfarranger){:target="_blank"}

PDF Arranger is a small python-gtk application, which helps the user to merge or split pdf documents and rotate, crop and rearrange their pages using an interactive and intuitive graphical interface. It is a frontend for pikepdf.

PDF Arranger is a fork of Konstantinos Poulios’s PDF-Shuffler.

{% shell_term $ %}
sudo dnf install pdfarranger
{% endshell_term %}

## Master PDF Editor 4

Sumber: [https://www.linuxuprising.com/2019/04/download-master-pdf-editor-4-for-linux.html](https://www.linuxuprising.com/2019/04/download-master-pdf-editor-4-for-linux.html){:target="_blank"}

Master PDF Editor is a proprietary application to edit PDF documents on Linux, Windows and macOS. It can create, edit (insert text or images), annotate, view, encrypt, and sign PDF documents.

{% shell_term $ %}
wget http://code-industry.net/public/master-pdf-editor-4.3.89_qt5.x86_64.rpm
sudo dnf localinstall master-pdf-editor-4.3.89_qt5.x86_64.rpm
{% endshell_term %}

## Intel GPU Tools

Official site: [https://gitlab.freedesktop.org/drm/igt-gpu-tools](https://gitlab.freedesktop.org/drm/igt-gpu-tools){:target="_blank"}

igt-gpu-tools (formerly known as intel-gpu-tools) is the standard for writing test cases for DRM drivers. It also includes a handful of useful tools for various drivers, such as Intel's GPU tools for i915.

{% shell_term $ %}
sudo dnf install igt-gpu-tools
{% endshell_term %}

## Autocutsel

Sumber: [http://www.nongnu.org/autocutsel/](http://www.nongnu.org/autocutsel/){:target="_blank"}

Sumber: [https://github.com/sigmike/autocutsel](https://github.com/sigmike/autocutsel){:target="_blank"}

X servers use two schemes to copy text between applications. The first one (old and deprecated) is the cutbuffer. It is a simple buffer in which any application can store text. The other scheme is the selection and works differently. There may be many selections in a single server. An application does not copy data in a selection, it "owns" it. When another application wants to retreive the content of a selection, it asks the owner.

**Manual Build**

Deps,

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

Like xmag, xzoom magnifies a section of the X display. Xzoom is different because it will continuously update the magnified area as the display changes. It is fast enough to enlarge small animations, for example.

It can also mirror or rotate a part of the screen.

{% shell_term $ %}
sudo dnf copr enable bgstack15/stackrpms
{% endshell_term %}

{% shell_term $ %}
sudo dnf install xzoom
{% endshell_term %}

## Dragon (drag and drop helper)

Official site: [https://github.com/mwh/dragon.git](https://github.com/mwh/dragon.git){:target="_blank"}

Many programs, particularly web applications, expect files to be dragged into them now. If you don't habitually use a file manager that is a problem. dragon is a lightweight drag-and-drop source for X that solves this problem.

(copr - bgstack15/stackrpms)

{% shell_term $ %}
sudo dnf copr enable bgstack15/stackrpms
sudo dnf install dragon-drag-and-drop
{% endshell_term %}

<br>
**Manual Build**

{% shell_term $ %}
git clone https://github.com/mwh/dragon.git
cd dragon
sudo make install
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

Official site: [https://github.com/phase1geo/Minder](https://github.com/phase1geo/Minder){:target="_blank"}

Use the power of mind-mapping to make your ideas come to life.

{% shell_term $ %}
sudo dnf install minder
{% endshell_term %}

## Taskell (Kanban Board)

Sumber: [https://github.com/smallhadroncollider/taskell](https://github.com/smallhadroncollider/taskell){:target="_blank"}

Command-line Kanban board/task manager with support for Trello boards and GitHub projects.

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

Official site: [https://zealdocs.org/](https://zealdocs.org/){:target="_blank"}

Zeal is a simple offline documentation browser inspired by Dash.

{% shell_term $ %}
sudo dnf install zeal
{% endshell_term %}

## xinput

Official site: [https://www.x.org](https://www.x.org){:target="_blank"}

xinput is a commandline utility to query and configure X11 X Input Extension devices. It is commonly used to change driver properties at runtime.

{% shell_term $ %}
sudo dnf install xinput
{% endshell_term %}

## gThumb (image viewer, editor, organizer)

Official site: [https://wiki.gnome.org/Apps/gthumb](https://wiki.gnome.org/Apps/gthumb){:target="_blank"}

gthumb is an application for viewing, editing, and organizing collections of images.

{% shell_term $ %}
sudo dnf install gthumb
{% endshell_term %}

## Speedtest CLI

Official site: [https://github.com/sivel/speedtest-cli](https://github.com/sivel/speedtest-cli){:target="_blank"}

Command line interface for testing internet bandwidth using speedtest.net.

{% shell_term $ %}
sudo dnf install speedtest-cli
{% endshell_term %}

## Spotify

Official site: [https://www.spotify.com/](https://www.spotify.com/){:target="_blank"}

Online music streaming service.

(Flatpak - Flathub)

{% shell_term $ %}
flatpak install flathub com.spotify.Client
{% endshell_term %}

## rpkg

Official site: [https://pagure.io/rpkg-util](https://pagure.io/rpkg-util){:target="_blank"}

This is an RPM packaging utility that can work with both DistGit and standard Git repositories and handles packed directory content as well as unpacked one.

{% shell_term $ %}
sudo dnf install rpkg
{% endshell_term %}

## asciidoc

Official site: [http://asciidoc.org](http://asciidoc.org){:target="_blank"}

AsciiDoc is a text document format for writing short documents, articles, books and UNIX man pages. AsciiDoc files can be translated to HTML and DocBook markups using the asciidoc(1) command.

{% shell_term $ %}
sudo dnf install asciidoc
{% endshell_term %}

(after install rbenv)

{% shell_term $ %}
gem install asciidoctor
gem install asciidoctor-pdf --pre
gem install pygments.rb
{% endshell_term %}

## Tmux

Official site: [https://tmux.github.io/](https://tmux.github.io/){:target="_blank"}

tmux is a "terminal multiplexer."  It enables a number of terminals (or windows) to be accessed and controlled from a single terminal.  tmux is intended to be a simple, modern, BSD-licensed alternative to programs such as GNU Screen.

{% shell_term $ %}
sudo dnf install tmux
{% endshell_term %}

<br>
**Manual Build**

Sumber: [https://github.com/tmux/tmux](https://github.com/tmux/tmux){:target="_blank"}

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

## Emacs

Official site: [http://www.gnu.org/software/emacs/](http://www.gnu.org/software/emacs/){:target="_blank"}

Emacs is a powerful, customizable, self-documenting, modeless text editor. Emacs contains special code editing features, a scripting language (elisp), and the capability to read mail, news, and more without leaving the editor.

This package provides an emacs binary with support for X windows.

{% shell_term $ %}
sudo dnf install emacs
{% endshell_term %}

## Wireshark

Official site: [http://www.wireshark.org/](http://www.wireshark.org/){:target="_blank"}

Wireshark allows you to examine protocol data stored in files or as it is captured from wired or wireless (WiFi or Bluetooth) networks, USB devices, and many other sources.  It supports dozens of protocol capture file formats and understands more than a thousand protocols.

It has many powerful features including a rich display filter language and the ability to reassemble multiple protocol packets in order to, for example, view a complete TCP stream, save the contents of a file which was transferred over HTTP or CIFS, or play back an RTP audio stream.

Sumber: [https://fedoramagazine.org/how-to-install-wireshark-fedora/](https://fedoramagazine.org/how-to-install-wireshark-fedora/){:target="_blank"}

{% shell_term $ %}
sudo dnf install wireshark
{% endshell_term %}

Add user ke dalam group **wireshark**.

{% shell_term $ %}
sudo usermod -a -G wireshark bandithijo
{% endshell_term %}

\* Perlu restart/reboot system.

## Scrcpy

Official site: [https://github.com/Genymobile/scrcpy](https://github.com/Genymobile/scrcpy){:target="_blank"}

Display and control your Android device.

**Manual Build**

Deps,

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

Official site: [https://github.com/wolfcw/libfaketime](https://github.com/wolfcw/libfaketime){:target="_blank"}

Manipulate system time per process for testing purposes.

libfaketime intercepts various system calls which programs use to retrieve the current date and time. It can then report faked dates and times (as specified by you, the user) to these programs. This means you can modify the system time a program sees without having to change the time system- wide.

{% shell_term $ %}
sudo dnf install libfaketime
{% endshell_term %}

## Notion

Official site: [https://github.com/notion-enhancer/notion-repackaged](https://github.com/notion-enhancer/notion-repackaged){:target="_blank"}

Notion Desktop builds with Notion Enhancer for Windows, MacOS and Linux. Direct port of Notion is also available for Linux.

{% shell_term $ %}
sudo vi /etc/yum.repos.d/notion-repackaged.repo
{% endshell_term %}

{% highlight_caption /etc/yum.repos.d/notion-repackaged.repo %}
{% highlight shell linenos %}
[notion-repackaged]
name=Notion Repackaged Repo
baseurl=https://yum.fury.io/notion-repackaged/
enabled=1
gpgcheck=0
{% endhighlight %}

With that you will be able to install `notion-app` or `notion-app-enhanced`.

Silahkan pilih,

{% shell_term $ %}
sudo dnf install notion-app
{% endshell_term %}

Atau,

{% shell_term $ %}
sudo dnf install notion-app-enhanced
{% endshell_term %}

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

## Kdenlive

Official site: [https://kdenlive.org/en/](https://kdenlive.org/en/){:target="_blank"}

Kdenlive is a non linear video editor. It is based on the MLT framework and accepts many audio and video formats, allows you to add effects, transitions and render into the format of your choice.

Saya memilih memasang dari ~~flathub~~ appimage.

{% shell_term $ %}
flatpak install flathub org.kde.kdenlive
{% endshell_term %}

## Olive

Official site: [https://www.olivevideoeditor.org](https://www.olivevideoeditor.org){:target="_blank"}

olive is a free non-linear video editor aiming to provide a fully-featured
alternative to high-end professional video editing software.

olive is in Alpha stage, so expect bugs/crashes and feel free to report them.
Builds for Linux, Mac, and Windows are available.

{% shell_term $ %}
sudo dnf install olive
{% endshell_term %}

## Clipnotify

Sumber: [https://github.com/cdown/clipnotify](https://github.com/cdown/clipnotify){:target="_blank"}

clipnotify is a simple program that, using the XFIXES extension to X11, waits until a new selection is available and then exits.

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

Official site: [https://github.com/bash-lsp/bash-language-server](https://github.com/bash-lsp/bash-language-server){:target="_blank"}

Bash language server implementation based on Tree Sitter and its grammar for Bash with explainshell integration.

{% shell_term $ %}
sudo dnf install nodejs-bash-language-server
{% endshell_term %}

## OBS Studio

Official site: [https://obsproject.com/](https://obsproject.com/){:target="_blank"}

Open Broadcaster Software is free and open source software for video recording and live streaming.

(rpmfusion-free)

{% shell_term $ %}
sudo dnf install obs-studio
{% endshell_term %}

## Unified Remote (urserver)

Sumber: [https://www.unifiedremote.com/tutorials/how-to-install-unified-remote-server-rpm-via-terminal](https://www.unifiedremote.com/tutorials/how-to-install-unified-remote-server-rpm-via-terminal){:target="_blank"}

Turn your smartphone into a universal remote control.

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

Official site: [https://github.com/lakinduakash/linux-wifi-hotspot](https://github.com/lakinduakash/linux-wifi-hotspot){:target="_blank"}

Feature-rich wifi hotspot creator for Linux which provides both GUI and command-line interface. It is also able to create a hotspot using the same wifi card which is connected to an AP already ( Similar to Windows 10).

**Manual Build**

Deps,

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

Official site: [http://llvm.org](http://llvm.org){:target="_blank"}

The goal of the Clang project is to create a new C, C++, Objective C
and Objective C++ front-end for the LLVM compiler. Its tools are built
as libraries and designed to be loosely-coupled and extensible.

{% shell_term $ %}
sudo dnf install clang
{% endshell_term %}

## Cockpit

Official site: [https://cockpit-project.org/](https://cockpit-project.org/){:target="_blank"}

The Cockpit Web Console enables users to administer GNU/Linux servers using a web browser.

It offers network configuration, log inspection, diagnostic reports, SELinux troubleshooting, interactive command-line sessions, and more.

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

{% shell_term $ %}
sudo systemctl enable --now cockpit.socket
sudo systemctl enable --now pmlogger.service
{% endshell_term %}

{% box_info %}
<p markdown=1>Saya tidak ingin menjalankan service-service cockpit pada saat booting.</p>
<p markdown=1>Saya hanya menyalakan service apabila saya perlukan saja.</p>
{% endbox_info %}

## aircrack-ng

Official site: [https://github.com/aircrack-ng/aircrack-ng](https://github.com/aircrack-ng/aircrack-ng){:target="_blank"}

aircrack-ng is a set of tools for auditing wireless networks. It's an enhanced/reborn version of aircrack. It consists of airodump-ng (an 802.11 packet capture program), aireplay-ng (an 802.11 packet injection program), aircrack (static WEP and WPA-PSK cracking), airdecap-ng (decrypts WEP/WPA capture files), and some tools to handle capture files (merge, convert, etc.).

{% shell_term $ %}
sudo dnf install aircrack-ng
{% endshell_term %}

## heroku-cli

Official site: [https://devcenter.heroku.com/articles/heroku-cli](https://devcenter.heroku.com/articles/heroku-cli){:target="_blank"}

The Heroku Command Line Interface (CLI) makes it easy to create and manage your Heroku apps directly from the terminal. It’s an essential part of using Heroku.

{% shell_term $ %}
npm install -g heroku
{% endshell_term %}

## FreeCAD

Official site: [http://freecadweb.org/](http://freecadweb.org/){:target="_blank"}

FreeCAD is a general purpose Open Source 3D CAD/MCAD/CAx/CAE/PLM modeler, aimed directly at mechanical engineering and product design but also fits a wider range of uses in engineering, such as architecture or other engineering specialties. It is a feature-based parametric modeler with a modular software architecture which makes it easy to provide additional functionality without modifying the core system.

{% shell_term $ %}
sudo dnf install freecad
{% endshell_term %}

Kalau tampilan UI nya tidak bagus. Coba mainkan env variable yang berhubungan dengan QT scaling.

{% shell_term $ %}
/usr/bin/env QT_AUTO_SCREEN_SCALE_FACTOR=0 QT_SCALE_FACTOR=1 FreeCAD
{% endshell_term %}

## Visual Studio Code

Official site: [https://code.visualstudio.com/](https://code.visualstudio.com/){:target="_blank"}

Code editing. Redefined. Free. Built on open source. Runs everywhere.

Sumber: [https://code.visualstudio.com/docs/setup/linux#_rhel-fedora-and-centos-based-distributions](https://code.visualstudio.com/docs/setup/linux#_rhel-fedora-and-centos-based-distributions){:target="_blank"}

{% shell_term $ %}
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install code
{% endshell_term %}

## GNOME Battery Bench

Official site: [https://git.gnome.org/browse/gnome-battery-bench](https://git.gnome.org/browse/gnome-battery-bench){:target="_blank"}

This application is designed for measuring power usage. It does it by recording the reported battery statistics as it replays recorded event logs, and then using that to estimate power consumption and total battery lifetime.

{% shell_term $ %}
sudo dnf install gnome-battery-bench
{% endshell_term %}

## GNOME Power Manager

Official site: [https://projects.gnome.org/gnome-power-manager/](https://projects.gnome.org/gnome-power-manager/){:target="_blank"}

GNOME Power Manager uses the information and facilities provided by UPower displaying icons and handling user callbacks in an interactive GNOME session.

{% shell_term $ %}
sudo dnf install gnome-power-manager
{% endshell_term %}

## Systool

Official site: [https://github.com/linux-ras/sysfsutils](https://github.com/linux-ras/sysfsutils){:target="_blank"}

This package's purpose is to provide a set of utilities for interfacing with sysfs.

{% shell_term $ %}
sudo dnf install sysfsutils
{% endshell_term %}

## inxi

Official site: [http://smxi.org/docs/inxi.htm](http://smxi.org/docs/inxi.htm){:target="_blank"}

Inxi offers a wide range of built-in options, as well as a good number of extra features which require having the script recommends installed on the system.

{% shell_term $ %}
sudo dnf install inxi
{% endshell_term %}

## lshw

Official site: [http://ezix.org/project/wiki/HardwareLiSter](http://ezix.org/project/wiki/HardwareLiSter){:target="_blank"}

lshw is a small tool to provide detailed informaton on the hardware configuration of the machine. It can report exact memory configuration, firmware version, mainboard configuration, CPU version and speed, cache configuration, bus speed, etc. on DMI-capable x86 systems and on some PowerPC machines (PowerMac G4 is known to work).

{% shell_term $ %}
sudo dnf install lshw
{% endshell_term %}

## cpupower-gui

Sumber: [https://github.com/vagnum08/cpupower-gui](https://github.com/vagnum08/cpupower-gui){:target="_blank"}

cpupower-gui is a graphical program that is used to change the scaling frequency limits of the cpu, similar to cpupower.

You can install cpupower-gui by adding the repository from OpenSUSE build service. For example, in Fedora 32 run the following as root:

{% shell_term $ %}
sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/home:erigas:cpupower-gui/Fedora_32/home:erigas:cpupower-gui.repo
sudo dnf install cpupower-gui
{% endshell_term %}

## Klavaro

Official site: [http://klavaro.sourceforge.net/en/](http://klavaro.sourceforge.net/en/){:target="_blank"}

Klavaro  is a touch typing tutor that is very flexible and supports customizable keyboard layouts. Users can edit and save new or unknown keyboard layouts, as the basic course provided by the program was designed to not depend on specific layouts.

{% shell_term $ %}
sudo dnf install klavaro
{% endshell_term %}

## Rust Lang

Official site: [https://www.rust-lang.org](https://www.rust-lang.org){:target="_blank"}

Rust is a systems programming language that runs blazingly fast, prevents segfaults, and guarantees thread safety.

This package includes the Rust compiler and documentation generator.

{% shell_term $ %}
sudo dnf install rust
{% endshell_term %}

## XAMPP from Apachefriends

Official site: [https://www.apachefriends.org/index.html](https://www.apachefriends.org/index.html){:target="_blank"}

XAMPP is the most popular PHP development environment.

Download terlebih dahulu file **xamp-*.run**.

{% shell_term $ %}
chmod +x xampp-*
sudo ./xampp-*
{% endshell_term %}

Install deps for Apache Web Server.

{% shell_term $ %}
sudo dnf install libnsl
{% endshell_term %}

Jalankan GUI dengan,

{% shell_term $ %}
sudo /opt/lampp/manager-linux-x64.run
{% endshell_term %}

## live-server

Sumber: [https://www.chrisatmachine.com/Neovim/20-live-server/](https://www.chrisatmachine.com/Neovim/20-live-server/){:target="_blank"}

Live-server is an npm package that will allow you to see real time changes for .html files in your browser.

{% shell_term $ %}
npm install -g live-server
{% endshell_term %}

## fd-find

Official site: [https://crates.io/crates/fd-find](https://crates.io/crates/fd-find){:target="_blank"}

Fd is a simple, fast and user-friendly alternative to find.

{% shell_term $ %}
sudo dnf install fd-find
{% endshell_term %}






{% comment %}
# Referensi

1. [](){:target="_blank"}
2. [](){:target="_blank"}
3. [](){:target="_blank"}
{% endcomment %}
