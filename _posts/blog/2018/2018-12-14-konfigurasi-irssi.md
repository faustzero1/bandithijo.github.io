---
layout: 'post'
title: 'Mengkonfigurasi Irssi, IRC Client Berbasis Terminal'
date: 2018-12-14 20:50
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Terminal', 'Tools', 'Tips']
pin:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="#" alt="banner"> -->

# Prakata

**IRC client? Serius nih?**

Yup! terdengar jadul yaa?

IRC client yang saya pergunakan adalah **Irssi**.

<br>
**Mengapa memilih Irssi sebagai IRC client?**

Hal pertama adalah, Irssi berjalan di atas Terminal yang dibuat dengan library ncurses sehingga dapat menampilkan "GUI-like" di dalam Terminal.

<!-- IMAGE CAPTION -->
![gambar_1](/assets/img/logo/logo_blank.png){:data-echo="https://i.postimg.cc/vBxPZQ8Y/gambar-01.png"}
<p class="img-caption">Gambar 1 - Antarmuka dari Irssi</p>

Hal kedua adalah, Irssi bersifat modular. Saya kurang begitu memahami maksud dari modular ini, namun apabila tidak salah menafsirkan, modular disini berarti kita bebas mencabut-pasang fitur-fitur yang kita ingin pergunakan. Enak sekali bukan. Fitur-fitur ini dapat kita tambahkan dengan menggunakan *scripts* yang ditulis dengan bahasa Perl.

Sejujurnya baru beberapa bulan ini saya menggunakan Irssi. Sebelumnya, saya sempat menggunakan **Polari** dan **HexChat**. Kanal **#ubuntu-id** pada server **chat.freenode.net**, sekitar tahun 2015 yang mengantarkan pertemuan saya dengan beberapa teman-teman admin yang sekarang ada di kanal BGLI (Belajar GNU/Linux Indonesia) di Telegram. Lebih jujur lagi, baru saat itulah saya menggunakan IRC. Jaman IRC terkenal dengan mIRC, saya belum mempunyai akses internet. Awal mencoba IRC malah saya baru tahu dari website forum Kali Linux Indonesia. Lalu mencoba-coba bagaimana saya dapat terhubung dengan kanal IRC mereka.

Oke, cukup dengan curhatnya. Kita langsung bahas konfigurasi Irssi.

# Konfigurasi Irssi

Mengkonfigurasi Irssi sebenarnya terbilang mudah apabila kita sudah pernah melakukannya. Untuk yang pertama kali mengkonfigurasi Irssi memang sedikit membuat frustasi. Hehehe.

Saya sudah menuliskan cara-cara yang saya kumpulkan agar Irssi dapat saya pergunakan dengan nyaman. Sejujurnya mengumpulkan semua materi konfigurasi agar Irssi dapat digunakan sesuai kemauan kita, memang melelahkan. Namun, jangan khawatir, kalian dapat mengikuti dan memodifikasi konfigurasi yang sudah saya tuliskan di bawah.

## Instalasi

Pasang paket Irssi pada distro masing-masing.
```
$ sudo pacman -S irssi
```
Untuk *scripts*, kita akan bahas beberapa *scripts* yang saya pergunakan pada pembahasan di bawah.

## Membuat App Launcher

Karena Irssi adalah program untuk dijalankan di atas Terminal, biasanya belum disertakan app launchernya. Kita perlu membuatnya sendiri.
```
$ vim ~/.local/share/applications/irssi.desktop
```
<pre>
[Desktop Entry]
Name=irssi
Comment=Chat with other people online
Keywords=IM;Chat;
<mark>Exec=termite -e irssi</mark>
Icon=hexchat
Terminal=false
Type=Application
Encoding=UTF-8
Categories=Network;IRCClient;
NoDisplay=false
</pre>
Pada bagian `Exec=` bagian `termite` dapat disesuaikan dengan Terminal Emulator yang teman-teman pergunakan. Perhatikan juga option `-e`. Beberpa Terminal memiliki option yang berbeda. Coba jalankan terlebih dahulu pada Terminal.

Sekarang coba jalankan. Kalian akan bertemu dengan tampilan awal dari Irssi.

<!-- IMAGE CAPTION -->
![gambar_2](/assets/img/logo/logo_blank.png){:data-echo="https://i.postimg.cc/h4VsVszD/gambar-02.png"}
<p class="img-caption">Gambar 2 - Antarmuka Default dari Irssi</p>


## Konfigurasi Dasar

Seperti kebanyakan aplikasi berbasil ncurses, kalau mau enak digunakan kita perlu melakukan konfigurasi terlebih dahulu sesuai pereserensi kita. Secara *default* Irssi akan membuat konfig directori di *home* kita `~/.irssi/`. Di dalam direktori ini terdapat file config.

<!-- PERHATIAN -->
<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
<p>Selama proses memasukkan perintah-perintah konfigurasi ke dalam Irssi di bawah. Sebaiknya jangan dulu membuka file <code>~/.irssi/config</code>. Karena perintah-perintah di bawah akan kita simpan ke dalam file <code>config</code> dengan perintah <code>/save</code>.</p>
</div>

### Registrasi Username

Apabila sudah memiliki username yang terregistrasi tidak perlu melakukan tahap ini.

Kita tidak harus memiliki username untuk dapat menggunakan IRC pada jaringan freenode.net, namun terdapat beberapa channel yang mengharuskan user yang sudah terregistrasi dapat bergabung. Beberapa yang saya ketahui **#archlinux**, **#fedora-workstation**, **#python**. Apabila kita tidak terregistrasi maka akan otomatis dialihkan ke channel **-unregistered**.

Caranya sangat mudah. Cukup ketikkan perintah di bawah pada bagian cosole dari Irssi (*bagian paling bawah, hanya pada bagian ini kita dapat menginputkan ketikan keyboard*) `[(status)]_`.

Kita harus terhubung dengan server chat.freenode.net.
```
/connect chat.freenode.net
```
Selanjutnya registerkan username kamu.
```
/msg NickServ REGISTER passwordkamu emailkamu@example.com
```
Nanti akan terbuat window baru pada window nomor 2, coba periksa dengan berpindah ke window 2 menggunakan <kbd>ALT</kbd> + <kbd>2</kbd>.

Perhatikan output-output yang diberikan. Apabila menampilkan seperti di bawah, maka proses registrasi terlah berhasil.
<pre>
00.00 bandithijo REGISTER mukaijo bandithijo@bandithijo.com
00.00 NickServ NickServ@services. An email containing nickname activation instructions has been sent to bandithijo@bandithijo.com.
00.00 NickServ NickServ@services. If you do not complete registration within one day, your nickname will expire.
00.00 NickServ NickServ@services. <mark>bandithijo is now registered to bandithijo@bandithijo.com, with the password mukaijo.</mark>
00.00 NickServ NickServ@services.
00.00 NickServ NickServ@services. For frequently-asked questions about the network, please see the
00.00 NickServ NickServ@services. Knowledge Base page (http://freenode.net/kb/all). Should you need more
00.00 NickServ NickServ@services. help you can /join #freenode to find network staff.
</pre>

Periksa kotak masuk email kita, akan terdapat email verifikasi dari Freenode (noreply.support@freenode.net)
<pre>
bandithijo,

In order to complete your account registration, you must type the following
command on IRC:

    <mark>/msg NickServ VERIFY REGISTER bandithijo xfvqrfxpjxrj</mark>

Thank you for registering your account on the freenode IRC network!
</pre>
Jalankan perintah yang diberikan di Irssi.
```
/msg NickServ VERIFY REGISTER bandithijo xfvqrfxpjxrj
```
Selanjutnya, identifikasi username kamu.
```
/msg NickServ IDENTIFY usernamekamu passwordkamu
```
```
00.00 bandithijo IDENTIFY bandithijo mukaijo
00.00 NickServ NickServ@services. You are already logged in as bandithijo.
```

### Memilih Layer Autentikasi Koneksi

Terdapat dua jenis layer authentikasi yang dapat kita pergunakan agar dapat terhubung dengan server, yaitu SASL (*Simple Authentication and Security Layer*) dan TLS (*Transport Layer Security*).

Pada tulisan ini saya hanya menggunakan TLS.

**TLS connection**

Freenode menggunakan port 6697, 7000, dan 7070 untuk koneksi SSl/TLS, bukan pada port 6667 yang merupana koneksi layer untuk 6667.

Masukkan perintah di bawah, untuk membuat koneksi secara otomatis menggunakan TLS ke server Freenode.

```
/server add -auto -tls -tls_verify -network freenode -port 6697 chat.freenode.net
```
Simpan konfigurasi dengan.
```
/save
```
Keluar dengan `/quit`, lalu masuk kembali `/connect chat.freenode.net`.

Apabila berhasil, akan terdapat huruf kapital "**Z**" mode. Akan ada output baris baru yang kira-kira berisi `Mode change [+Zi] for user bandithijo`.

### Membuat Sertifikat Klien

Kita dapat menggunakan autentikasi menggunakan **SSL** *certificates* sebagai alternatif plaintext password. Sehingga memungkinkan kita untuk login seolah-olah tanpa memasukkan password.

Untuk membuat sertifikat tanpa password, ikuti beberapa baris perintah di bawah pada Terminal.

Kode *Country Name* isikan saja `ID`, apabila diminta untuk memasukkan detail seperti *State* atau *Common Name*, kalian dapat isi sesukanya.
```
$ openssl req -newkey rsa:2048 -x509 -keyout irssi.key -out irssi.crt -nodes
$ cat irssi.crt irssi.key > ~/.irssi/irssi.pem
$ chmod 600 ~/.irssi/irssi.pem
$ rm irssi.crt irssi.key
```
Selanjutnya, menampilkan fingerprint dari `irssi.pem`.
```
openssl x509 -sha1 -fingerprint -noout -in ~/.irssi/irssi.pem | sed -e 's/^.*=//;s/://g;y/ABCDEF/abcdef/'
```
```
386b6c1eb8efb3a3617d1ffe7e6c0489e71a63be
```
Copy fingerprint di atas.

Selanjutnya, buka Irssi dan kita akan *disconnect* lalu memasukkan SSL sertifikasi pada konfigurasi untuk terhubung ke server Freenode.
```
/disconnect Freenode
/server add -ssl_cert ~/.irssi/irssi.pem -network freenode chat.freenode.net 6697
```
Sekarang, coba *connect* kembali (bukan `/reconnect`) ke Freenode, kemudian identify dan register fingerprint kita.
```
/connect Freenode
/msg NickServ identify passwordkamu
/msg NickServ cert add fingerprintpemkamu
```
Apabila berhasil, akan terdapat output pada window ke 2 [Freenode/NickServ].
```
00:00 NickServ NickServ@services. Added fingerprint 386b6c1eb8efb3a3617d1ffe7e6c0489e71a63be to your
                                  fingerprint list.
```
Selanjutnya jangan lupa di `/save`.

Apabila teman-teman mengecek isi dari `~/.irssi/config`. Akan terdapat baris seperti di bawah.
```
...
  {
    address = "chat.freenode.net";
    chatnet = "Freenode";
    port = "6697";
    use_tls = "yes";
    tls_cert = "~/.irssi/irssi.pem";
    tls_capath = "/etc/ssl/certs";
    tls_pass = "386b6c1eb8efb3a3617d1ffe7e6c0489e71a63be";
    tls_verify = "yes";
    autoconnect = "yes";
  },
...
```

Maka proses dari konfigurasi utama telah selesai.

## Konfigurasi Tambahan

### Tema

Untuk tema (*Theme*), teman-teman dapat melihat koleksi dari tema yang disediakan pada *official website* Irssi, [di sini](https://irssi-import.github.io/themes/){:target="_blank"}.

Cara instalasinya sangat mudah, langsung saja download dan letakkan pada direktori `~/.irssi/`.

Selanjutnya untuk mengaktifkannya, dengan perintah.
```
/set theme namatema
```
Perlu diperhatikan, terkadang tampilan yang ada pada *screenshot* tidak sesuai dengan hasil yang kita harapakan, hal tersebut dikarenakan banyak faktor yang tidak disertakan dalam bagian dari tema, seperti: *base color* dan *background color* dari Terminal, *font face*, *script* tambahan, dll.

Saya menggunakan tema hasil modifikasi dari [`solarized.theme`](https://github.com/huyz/irssi-colors-solarized){:target="_blank"} dari **Huy Z**.

<!-- IMAGE CAPTION -->
![gambar_3](/assets/img/logo/logo_blank.png){:data-echo="https://i.postimg.cc/Dzh0YRqZ/gambar-03.png"}
<p class="img-caption">Gambar 3 - Theme Solarized dari Huy Z</p>

Karena terdapat beberapa bagian yang kurang sesuai dengan selera saya, seperti indentasi pada username dan beberapa color, saya memodifikasi sesuai dengan preferensi saya.

<!-- IMAGE CAPTION -->
![gambar_4](/assets/img/logo/logo_blank.png){:data-echo="https://i.postimg.cc/P5s1T3WG/gambar-04.png"}
<p class="img-caption">Gambar 4 - Theme Solarized setelah dimodifikasi</p>

Tema ini dapat diunduh [di sini](https://raw.githubusercontent.com/bandithijo/dotfiles/master/.irssi/solarized-bandit.theme){:target="_blank"}.

Jangan lupa disimpan, `/save`.

### Autojoin Channel

Mungkin kita tidak mau setiap kali membuka Irssi selalu *join* channel secara manual. Tentunya ada beberapa channel yang kita selalu ikuti. Seperti saya, #freenode, #archlinux, #i3 dll.

Untuk membuat autojoin pada channel favorit kita caranya sangat mudah.

```
/channel add -auto #freenode Freenode
/channel add -auto #archlinux Freenode
```

Nah, saat kita menjalankan Irssi, maka akan terbuat window 1 untuk #freenode dan window 2 untuk #archlinux. Apabila kalian ingin merubah urutannya, dapat membuat perubahan pada file `config`.
```
$ vim ~/.irssi/config
```
Cari bagian seperti di bawah.
<pre>
channels = (
  { name = "#lobby"; chatnet = "EsperNet"; autojoin = "No"; },
  <mark>{ name = "#freenode"; chatnet = "Freenode"; autojoin = "yes"; },</mark>
  { name = "#irssi"; chatnet = "Freenode"; autojoin = "No"; },
  { name = "#gamesurge"; chatnet = "GameSurge"; autojoin = "No"; },
  { name = "#irssi"; chatnet = "IRCNet"; autojoin = "No"; },
  { name = "#ircsource"; chatnet = "IRCSource"; autojoin = "No"; },
  { name = "#netfuze"; chatnet = "NetFuze"; autojoin = "No"; },
  { name = "#oftc"; chatnet = "OFTC"; autojoin = "No"; },
  { name = "silc"; chatnet = "SILC"; autojoin = "No"; },
  <mark>{ name = "#archlinux"; chatnet = "Freenode"; autojoin = "yes"; }</mark>
);
</pre>
Perhatikan, terdapat #freenode pada urutan kedua dan #archlinux pada urutan terakhir yang memiliki nilai `autojoin= "yes"`. Teman-teman dapat merubah urutan-urutanya, sesuaikan dengan preferensi masing-masing.

Jangan lupa disimpan, `/save`.

### Notifikasi

Secara *default* Irssi belum mengkonfigurasi notifikasi, baik visual maupun suara. Tapi jangan khawatir, kita dapat menambahkannya dengan *script*.

**Apa kegunaan notifikasi?**

Di awal-awal saya menggunakan Irssi, saya belum menambahakn notifikasi. Sampai pada akhirnya saya mulai berinteraksi dengan orang-orang di channel. Saya mulai kesulitan mengetahui, apakah percakapan saya dibalas atau tidak? Akan lebih mudah apabila kita mendapatkan notifikasi saat user lain menyertakan nama kita (*mention*) pada pesan yang ia kirim.

#### Notifikasi Visual

Kita akan menggunakan [`irssi-libnotify`](https://github.com/stickster/irssi-libnotify){:targer="_blank"} untuk notifikasi dan membuatnya autorun saat Irssi dijalankan, langkah-langkahnya sebagai berikut.

1. Instal paket dependensi yang dibutuhkan, yaitu:
    * libnotify
    * perl-html-parser
    * pygobject

    Sesuaikan dengan distribusi sistem operasi masing-masing. (pada Arch linux, pygobject bernama paket `pygobject-devel` untuk Python 3 dan `pygobject2-devel` untuk Pyhton 2).
    ```
    $ sudo pacman -S libnotify perl-html-parser pygobject-devel pygobject2-devel
    ```
2. Konfigurasi untuk file *script* `notify.pl`.
    ```
    $ mkdir -p ~/.irssi/scripts/autorun
    $ cd ~/.irssi/scripts
    $ wget https://raw.githubusercontent.com/stickster/irssi-libnotify/master/notify.pl
    $ cd autorun
    $ ln -s ../notify.pl
    ```
3. Lakukan sedikit modifikasi pada *path* yang mengarah ke `~/bin/irssi-notifier.sh`.
    ```
    $ vim notify.pl
    ```
    Cari pada sekitar baris 41 bagian `sub notify_linux {` dan sekitar baris 73 bagian `sub notify {` terdapat baris yang berisi *path* dari file `irssi-notifier.sh` yang tidak sesuai dengan konfigurasi yang akan kita sesuaikan.
    <pre>
    sub notify_linux {
        ...
        ...
            <mark>" ~/bin/irssi-notifier.sh" .</mark>
            ...
        ...
    }
    ...
    ...

    sub notify {
        ...
        ...
            <mark>" ~/bin/irssi-notifier.sh" .</mark>
            ...
        ...
    }
    </pre>
    Ganti menjadi.
    <pre>
    sub notify_linux {
        ...
        ...
            <mark>" /usr/bin/irssi-notifier.sh" .</mark>
            ...
        ...
    }
    ...
    ...

    sub notify {
        ...
        ...
            <mark>" /usr/bin/irssi-notifier.sh" .</mark>
            ...
        ...
    }
    </pre>
    Simpan.
4. Download file `notify-listener.py` dan `irssi-notifies.sh`.
    ```
    $ cd /usr/bin
    $ sudo wget https://raw.githubusercontent.com/stickster/irssi-libnotify/master/notify-listener.py
    $ sudo wget https://raw.githubusercontent.com/stickster/irssi-libnotify/master/irssi-notifier.sh
    ```
5. Modifikasi pada file `notify-listener.py`, untuk membuat penyesuaian karena Python yang digunakan masih versi 2. Sedangkan Arch sudah menggunakan Python versi 3 secara *default*.
    ```
    $ sudo vim /usr/bin/notify-listener.py
    ```
    Ganti *shebang*.
    ```
    #!/usr/bin/python
    ```
    Menjadi Python versi 2.
    ```
    #!/usr/bin/python2
    ```
6. Kita perlu menjalankan `notify-listener.py` saat sistem startup (memasuki desktop).

    Untuk i3wm sangat mudah, cukup menambahkan perintah di bawah pada file config i3wm.
    ```
    exec_always --no-startup-id notify-listener.py
    ```
    Untuk desktop manager yang lain. Bisa mengkonfigurasi pada bagian **autorun**. Biasanya sih terdapat pada direktori `~/.config/autostart/` atau `~/.config/autostart-scripts/`. Saya kurang paham. Bisa teman-teman cari sendiri yaa. Mohon maaf karena sudah lama tidak menggunkan desktop environment.

Tahap notifikasi visual telah Selesai. Coba jalankan Irssi dan lakukan pengujian. Bisa coba ngobrol di channel, atau chat dengan saya.
```
/msg bandithijo permisi mas bandit. testing NOTIFIKASI VISUAL.
```

#### Notifikasi Suara

Selanjutnya kita juga memerlukan notifikais dalam bentuk suara. Biar tidak sepi aja.

1. Script ini tidak memerlukan dependensi tambahan.
    ```
    $ cd ~/.irssi/scripts
    $ wget https://scripts.irssi.org/scripts/beep_beep.pl
    $ wget https://github.com/bandithijo/dotfiles/raw/master/.irssi/scripts/gnome_beep.opus
    $ cd autorun
    $ ln -s ../beep_beep.pl
    ```
2. Modifikasi sedikit pada bagian perintah `play`, sekitar baris 51.
    ```
    $ vim beep_beep.pl
    ```
    <pre>
    Irssi::settings_add_str("lookandfeel", "beep_cmd", "<mark>play ~/.irssi/scripts/beep_beep.wav</mark> > /dev/null &");
    </pre>
    Ganti menjadi.
    <pre>
    Irssi::settings_add_str("lookandfeel", "beep_cmd", "<mark>play -q ~/.irssi/scripts/gnome_beep.opus</mark> > /dev/null &");
    </pre>
3. Selanjutnya tinggal memasukkan nilai dari `beep_msg_level` pada Irssi.

    Jalankan Irssi.
    ```
    /set beep_msg_level MSGS DCC DCCMSGS HILIGHT NOTICES
    ```

Tahap notifikasi suara telah Selesai. Coba jalankan Irssi dan lakukan pengujian. Bisa coba ngobrol di channel, atau chat dengan saya.
```
/msg bandithijo permisi mas bandit. testing NOTIFIKASI SUARA.
```
<br>
Konfigurasi tambahan segini dulu aja yaa. Untuk kegunaan *script* yang lain dapat dicoba sendiri.

Repositori untuk *scripts* Irssi dapat dilihat [di sini](https://scripts.irssi.org/){:target="_blank"}.

# Beberapa Pemecahan Masalah

## Error Closing Link

Selama menggunakan Irssi, saya mengalami hal ini beberapa kali.
```
ERROR Closing Link: 36.80.031.08 (SASL access only)
```
Awalnya saya langsung mengutak atik file konfigurasi, googling sana sini untuk mencari kasus yang sama dengan yang saya alami. Sampai akhirnya putus asa dan mencoba jalan terakhir. <mark><b>Turn OFF then Turn ON your Router</b></mark> adalah jawaban dari permasalahan ini.

Kecurigaan saya adalah, Freenode memblokir alamat IP publik saya. Karena saya selalu menyalan Irssi dan terhubung secara konstan dengan Freenode. Sepanjang hari, sepanjang minggu. Mungkin ada limitasi trafik keluar dan masuk dari sebuah IP. Mungkin...Hanya asumsi.

<!-- IMAGE CAPTION -->
![gambar_5](/assets/img/logo/logo_blank.png){:data-echo="https://i.postimg.cc/JzqMX79N/gambar-05.png"}
<p class="img-caption">Gambar 5 - Error Closing Link</p>

# Pesan Penulis

Menggunakan IRC di jaman modern seperti saat ini tidak juga tidak berarti apa-apa. Karena masih terdapat orang-orang yang berkompeten dalam bidangnya dan masih menggunakan IRC.

Saya sendiri masih suka nongkrong di channel #archlinux dan #freenode. Sempat juga pernah bertanya di channel #ranger mengenai permasalahan tag direktori yang tidak sengaja saya aktifkan.

Apabila dirasa-rasa Irssi terlalu sulit untuk dikonfigurasi, ada satu lagi alternatif IRC client di Terminal, yaitu [**WeeChat**](https://weechat.org/){:target="_blank"}.

# Rencana Kedepan

Masih terdapat banyak sekali hal yang belum dapat tercover oleh tulisan ini. Beberapa diantaranya :

1. Perintah-perintah dasar menggunakan IRC
2. Beberapa permasalahan yang pernah saya hadapi selama menggunakan Irssi
3. Me-request **Cloack** untuk menutupi ip address kita yang terlihat
4. Terkoneksi dengan multiple server
5. Logging
6. Proxy
7. dll.


# Referensi

1. [wiki.archlinux.org/index.php/Irssi](https://wiki.archlinux.org/index.php/Irssi){:target="_blank"}
<br>Diakses tanggal: 2018/12/14

2. [freenode.net/kb/answer/registration](http://freenode.net/kb/answer/registration){:target="_blank"}
<br>Diakses tanggal: 2018/12/14

3. [irssi.org/documentation/](https://irssi.org/documentation/){:target="_blank"}
<br>Diakses tanggal: 2018/12/14

4. [scripts.irssi.org/](https://scripts.irssi.org/){:target="_blank"}
<br>Diakses tanggal: 2018/12/14

5. [irssi-import.github.io/themes/](https://irssi-import.github.io/themes/){:target="_blank"}
<br>Diakses tanggal: 2018/12/14

6. [irssi.org/documentation/startup/](https://irssi.org/documentation/startup/){:target="_blank"}
<br>Diakses tanggal: 2018/12/14

7. [askubuntu.com/questions/470944/irssi-no-terminal-notification-sound-while-pinged](https://askubuntu.com/questions/470944/irssi-no-terminal-notification-sound-while-pinged){:target="_blank"}
<br>Diakses tanggal: 2018/12/14

