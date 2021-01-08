---
layout: 'post'
title: "Mudah Manajemen Service dengan OpenRC"
date: 2021-01-06 06:45
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Artix Linux']
pin:
hot:
contributors: []
---

# Latar Belakang

Akhir Desember 2020, saya memigrasikan Arch Linux yang sudah saya pakai sejak April 2020 -- karena Maret 2020, saya bermigrasi ke FreeBSD -- ke Artix Linux OpenRC.

Teman-teman dapat membaca catatan migrasi saya di sini, [**Memigrasikan Arch Linux ke Artix Linux (OpenRC)**](/blog/memigrasikan-arch-ke-artix-openrc){:target="_blank"}.

Menggunakan init system, selain **systemd** merupakan hal yang baru bagi saya. Karena sejak Desember 2014 -- awal migrasi saya menggunakan GNU/Linux dengan distribusi sistem operasi **Fedora Linux**, sudah menggunakan **systemd**.

Catatan kali ini saya ingin menyimpan bagaimana cara menggunakan OpenRC dalam memanajemen service.

{% box_perhatian %}
<p>Catatan ini bukan merupakan panduan atau tutorial.</p>
{% endbox_perhatian %}

# Cara Penggunaan

{% box_info %}
<p markdown=1>Selama proses catatan ini, saya akan menggunakan **sshd** sebagai contoh service.</p>
<p markdown=1>Di Artix Linux, paket **openssh** harus dipasang sesuai init yang digunakan.</p>
<p markdown=1>Misal, saya menggunakan OpenRC.</p>
{% shell_user %}
sudo pacman -S openssh openssh-openrc
{% endshell_user %}
{% endbox_info %}

## 1. Melihat Daftar Service yang Tersedia; RC-SERVICE(8)

<pre class="whiteboard">
NAME
     rc-service — locate and run an OpenRC service with the given arguments

DESCRIPTION
     Service scripts could be in different places on different systems.
     rc-service locates the specified service and runs it with the given argu‐
     ments.  If -i, --ifexists is given then rc-service returns 0 even if the
     service does not exist.  If -I, --ifinactive or -N, --ifnotstarted is given
     then rc-service returns 0 if the service exists but is in the wrong state.

     If given the -l, --list argument then rc-service will list all available
     services.
</pre>

Untuk melihat daftar service apa saja yang tersedia, kita dapat menggunakan perintah,

{% shell_user %}
rc-service -l
{% endshell_user %}

Atau,

{% shell_user %}
rc-service --list
{% endshell_user %}

<pre>
acpid
agetty
agetty.tty1
agetty.tty2
agetty.tty3
agetty.tty4
agetty.tty5
agetty.tty6
--- dipotong ---
udev
udev-settle
udev-trigger
urandom
virtlockd
virtlogd
wpa_supplicant
xinetd
</pre>

Atau kombinasikan dengan **grep**.

Misal, ingin mencari **wpa_supplicant** service.

{% shell_user %}
rc-service --list | grep wpa_supplicant
{% endshell_user %}

<pre>
<span style="color:red;">wpa_supplicant</span>
</pre>

## 2. Menambahkan Service ke runlevel; RC-UPDATE(8)

<pre class="whiteboard">
NAME
     rc-update — add and remove services to and from a runlevel

DESCRIPTION
     OpenRC uses named runlevels.  Rather than editing some obscure file or man‐
     aging a directory of symlinks, rc-update exists to quickly add or delete
     services to and from from different runlevels.  All services must reside in
     the /etc/init.d or /usr/local/etc/init.d directories.  They must also be
     standard OpenRC scripts, meaning they must use openrc-run.

     add service             Add the service to the runlevel or the current one
                             if none given.  Services added to the boot runlevel
                             must exist in /etc/init.d.

     delete service          Delete the service from the runlevel or the current
                             one if none given.

     show                    Show all enabled services and the runlevels they be‐
                             long to.  If you specify runlevels to show, then
                             only those will be included in the output.
</pre>

**runlevel** adalah level dimana service akan dijalankan.

**runlevel** merupakan direktori yang berlokasi di **/etc/runlevel/**.

Terdapat 3 internal runlevel dan 4 user defined runlevel.

<br>
**Internal runlevel**:

1. **sysinit**
2. **shutdown**
3. **reboot**

<br>
**User Defined runlevel**:

1. **boot**, Starts all system-necessary services for other runlevels
2. **default**, Used for day-to-day-operations
3. **nonetwork**, Used when no network connectivity is required
4. **single**, Single-user mode

<br>
Contoh:

<pre>
Runlevel: shutdown
 killprocs                                                            [  <span class="is-danger">stopped</span>  ]
 ...
 ...
Runlevel: default
 agetty.tty1                                     [  <span class="is-success">started 2 day(s) 06:11:21 (0)</span> ]
 agetty.tty2                                     [  <span class="is-success">started 2 day(s) 06:11:21 (0)</span> ]
 ...
 ...
Runlevel: nonetwork
 local                                                                [  <span class="is-success">started</span>  ]
Runlevel: sysinit
 dmesg                                                                [  <span class="is-success">started</span>  ]
 ...
 ...
Runlevel: boot
 root                                                                 [  <span class="is-success">started</span>  ]
 ...
 ...
</pre>

Biasanya, service-service yang kita tambahkan, apabila tidak diberikan argument spesifik runlevel apa yang akan digunakan, akan diletakkan di runlevel **default**.

Proses menambahkan service ke runlevel ini, mirip dengan proses pada systemd yang menggunakan option **enable**.

<pre class="url">
sudo rc-service add &lt;nama_service>
</pre>

Misal, saya ingin menjalankan service SSH.

Service SSH memiliki service name bernama **sshd**.

Cara menambahkan ke runlevel,

{% shell_user %}
sudo rc-update add sshd
{% endshell_user %}

<pre>
<span class="is-success">*</span> service sshd added to runlevel default
</pre>

Service **sshd** telah berhasil ditambahka ke runlevel **default**.

<pre>
Runlevel: default
 sshd                                                                 [  <span class="is-danger">stopped</span>  ]
</pre>

Tapi, statusnya masih **stopped**, kita akan jalankan di section selanjutnya.

## 3. Menjalankan, Menghentikan, Merestart Service; RC-SERVICE(8)

**Kok pakai `rc-service` lagi?**

Yak, benar! Selain kita gunakan untuk melihat daftar service, kita juga dapat gunakan untuk memanipulasi service, seperti:

Kalau pada systemd, proses ini mirip dengan **start**, **stop**, **reload**, **status**.

<br>
**Start Service**

<pre class="url">
sudo rc-service &lt;nama_service> start
</pre>

{% shell_user %}
sudo rc-service sshd start
{% endshell_user %}

<pre>
sshd              | * Starting sshd ...                                       [ <span class="is-success">ok</span> ]
</pre>

{% box_info %}
<p>Kita dapat menjalankan service tanpa perlu menambahkan ke dalam runlevel.</p>
<p markdown=1>Kalau kita jalankan tanpa terlebih dulu memasukkannya ke dalam runlevel **default**, maka akan dimasukkan ke runlevel **manual**.</p>
{% endbox_info %}

<br>
**Stop Service**

<pre class="url">
sudo rc-service &lt;nama_service> stop
</pre>

{% shell_user %}
sudo rc-service sshd stop
{% endshell_user %}

<pre>
sshd              | * Stopping sshd ...                                       [ <span class="is-success">ok</span> ]
</pre>

<br>
**Restart Service**

<pre class="url">
sudo rc-service &lt;nama_service> restart
</pre>

{% shell_user %}
sudo rc-service sshd restart
{% endshell_user %}

<pre>
sshd              | * Stopping sshd ...                                       [ <span class="is-success">ok</span> ]
sshd              | * Starting sshd ...                                       [ <span class="is-success">ok</span> ]
</pre>

<br>
**Status Service**

<pre class="url">
sudo rc-service &lt;nama_service> status
</pre>

{% shell_user %}
sudo rc-service sshd status
{% endshell_user %}

<pre>
<span class="is-success">*</span> status: started
</pre>

atau,

<pre>
<span class="is-success">*</span> status: stopped
</pre>

## 4. Menghapus Service dari runlevel; RC-UPDATE(8)

Untuk menghapus service dari runlevel, sangat mudah sekali.

Biasanya hal ini kita lakukan apabila ada service yang ingin kita hentikan secara permanent.

Misalnya, saya tidak memerlukan service SSH untuk berjalan terus menerus. Maka saya akan disable dari runlevel default.

Pada systemd, proses ini mirip seperti **disable** service.

<pre class="url">
rc-update del &lt;nama_service>
</pre>

{% shell_user %}
sudo rc-update del sshd
{% endshell_user %}

<pre>
<span clas="is-success">*</span> service sshd removed from runlevel default
</pre>


## 5. Melihat Service pada runlevel; RC-UPDATE(8)

Kita dapat gunakan perintah ini untuk melihat service tertentu ada pada runlevel apa saja.

{% shell_user %}
rc-update show
{% endshell_user %}

<pre>
          agetty.tty1 |      default
          agetty.tty2 |      default
              cgroups |                                 sysinit
               cronie |      default
                 dbus |      default
                devfs |                                 sysinit
               dhcpcd |      default
                dmesg |                                 sysinit
       dnscrypt-proxy |      default
              elogind | boot
                 fsck | boot
---------------------------- dipotong -------------------------
                 sshd |      default
                 swap | boot
               sysctl | boot
                sysfs |                                 sysinit
         termencoding | boot
                  tlp |      default
                 udev |                                 sysinit
         udev-trigger |                                 sysinit
              urandom | boot
       wpa_supplicant |      default
</pre>

<br>
Kita juga dapat menggunakan untuk melihat service yang ada pada runlevel tertentu, misal runlevel **default**.

{% shell_user %}
rc-update show default
{% endshell_user %}

<pre>
          agetty.tty1 | default
          agetty.tty2 | default
            alsasound | default
               cronie | default
                 dbus | default
               dhcpcd | default
       dnscrypt-proxy | default
                local | default
           postgresql | default
                 sshd | default
                  tlp | default
       wpa_supplicant | default
</pre>

## 6. Melihat Service Status; RC-STATUS(8)

<pre class="whiteboard">
NAME
     rc-status — show status info about runlevels

DESCRIPTION
     rc-status gathers and displays information about the status of services in
     different runlevels.  The default behavior is to show information about the
     current runlevel and any unassigned services that are not stopped, but any
     runlevel can be quickly examined.

     If an active service is being supervised by supervise-daemon(8,) the amount
     of time the daemon has been active along with the number of times it has
     been respawned in the current respawn period will be displayed.
</pre>

Option yang tersedia:

<pre class="whiteboard">
     The options are as follows:

     -a, --all             Show all runlevels and their services.

     -c, --crashed         List all services that have crashed.

     -f, --format          Select a format for the output. Currently, the only
                           one that can be specified is ini, which outputs in
                           *.ini format.

     -l, --list            List all defined runlevels.

     -m, --manual          Show all manually started services.

     -r, --runlevel        Print the current runlevel name.

     -S, --supervised      Show all supervised services.

     -s, --servicelist     Show all services.

     -u, --unused          Show services not assigned to any runlevel.

     -C, --nocolor         Disable color output.

     runlevel              Show information only for the named runlevel.
</pre>

Sudah sangat jelas yaa, **rc-status** kita gunakan untuk melihat service status.

Kalau kita hanya menjalankan tanpa option, akan ditampilkan runlevel default, manual, hotplugged, needed/wanted.

{% shell_user %}
rc-status
{% endshell_user %}

<pre>
Runlevel: default
 local                                                                 [  started  ]
 agetty.tty1                                      [  started 2 day(s) 10:15:05 (0) ]
 agetty.tty2                                      [  started 2 day(s) 10:15:05 (0) ]
 ...
 ...
Dynamic Runlevel: hotplugged
Dynamic Runlevel: needed/wanted
 virtlogd                                                              [  started  ]
Dynamic Runlevel: manual
 libvirtd                                                              [  started  ]
</pre>

<br>
Kalau ingin melihat service status dari semua runlevel, gunakan option `--all`.

## 7. Direktori Config

Untuk file-file konfigurasi dari init script, dapat dilihat pada direktori **/etc/conf.d/**

Misal,

Untuk configurasi dari **dnscrypt-proxy**.

{% highlight_caption /etc/conf.d/dnscrypt-proxy %}
{% highlight sh linenos %}
#rc_use="tor"
#DNSCRYPT_PROXY_OPTS="-config /etc/dnscrypt-proxy/dnscrypt-proxy.toml"
#DNSCRYPT_PROXY_USER="dnscrypt"
#DNSCRYPT_PROXY_GROUP="dnscrypt"
DNSCRYPT_PROXY_USER="root"
DNSCRYPT_PROXY_GROUP="root"
{% endhighlight %}

Selayaknya file config, isinya berupa variabel-variabel yang akan digunakan di init script.

Kita akan lihat init script dari **dnscrypt-proxy**.

{% highlight_caption /etc/init.d/dnscrypt-proxy %}
{% highlight sh linenos %}
#!/usr/bin/openrc-run
# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

command="/usr/bin/dnscrypt-proxy"
command_args="${DNSCRYPT_PROXY_OPTS:--config /etc/dnscrypt-proxy/dnscrypt-proxy.toml}"
command_user="${DNSCRYPT_PROXY_USER:-dnscrypt}:${DNSCRYPT_PROXY_GROUP:-dnscrypt}"
pidfile="/run/${RC_SVCNAME}.pid"
retry="SIGTERM/5/SIGTERM/5/SIGKILL/5"
start_stop_daemon_args="--background --make-pidfile"

depend() {
	use logger net
	provide dns
}

# start_pre() {
# 	checkpath -q -d -m 0775 -o "${command_user}" /var/cache/"${RC_SVCNAME}"
# 	checkpath -q -d -m 0775 -o "${command_user}" /var/log/"${RC_SVCNAME}"
# }
{% endhighlight %}

Nah, teman-teman dapat melihat variabel-variabel pada file config tersebut digunakan pada init script.


# Head to Head Table

| systemd | OpenRC | Description |
| :-- | :-- | :-- |
| <code>systemctl list-units</code> | <code>rc-status</code> | List running services status |
| <code>systemctl --failed</code> | <code>rc-status --crashed</code> | Check failed services |
| <code>systemctl --all</code> | <code>rc-update -v show</code> | Display all available services. |
| <code>systemctl (start, stop, restart, status) daemon.service</code> | <code>rc-service daemon (start, stop, restart, status)</code> | Change service state. |
| <code>systemctl (enable, disable) daemon.service</code> | <code>rc-update (add, del) daemon</code> | Turn service on or off. |
| <code>systemctl daemon-reload</code> | - | Create or modify configuration. |

Sumber: [Arch Wiki: OpenRC - Usage](https://wiki.archlinux.org/index.php/OpenRC#Usage){:target="_blank"}


# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)




# Referensi

1. [Gentoo Wiki: OpenRC](https://wiki.gentoo.org/wiki/OpenRC){:target="_blank"}
<br>Diakses tanggal: 2021/01/06

2. [Artix Wiki: OpenRC](https://wiki.artixlinux.org/Main/OpenRC){:target="_blank"}
<br>Diakses tanggal: 2021/01/06

3. [Arch Wiki: OpenRC](https://wiki.archlinux.org/index.php/OpenRC){:target="_blank"}
<br>Diakses tanggal: 2021/01/06

4. [GitHub/OpenRC/openrc: OpenRC Users Guide](https://github.com/OpenRC/openrc/blob/master/user-guide.md){:target="_blank"}
<br>Diakses tanggal: 2021/01/06
