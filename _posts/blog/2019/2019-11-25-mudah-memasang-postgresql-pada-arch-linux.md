---
layout: 'post'
title: "Mudah Memasang PostgreSQL pada Arch Linux"
date: 2019-11-25 06:45
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Database', 'Arch Linux']
pin:
hot:
contributors: []
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Beberapa kali saya mendapati pertanyaan dari teman-teman seputar bagaimana cara memasang dan mengkonfigurasi PostgreSQL pada Arch Linux.

Sudah mengikuti Arch Wiki, namun tetap tidak mengerti.

Umm, saya mengerti, memang agak sedikit membingungkan membaca Arch Wiki, terutama bagi yang benar-benar tidak tahu alur dari konfigurasi PostgreSQL yang diperlukan hingga siap untuk digunakan.

Mungkin juga kebingungan, perintah (*command*) mana yang dijalankan, karena terlalu banyak tulisan yang terdapat pada panduan PostgreSQL pada Arch Wiki tersebut. Hehe.

Jujur saja, saya pertama kali dulu juga begitu. Bahkan sampai beberapa kali setiap melakukan instalasi PostgreSQL pada Arch Linux merupakan hal yang menantang dan bikin deg-degan.

Namun, setelah hampir setiap hari bergelut dengan PostgreSQL karena tuntutan pekerjaan, saya mulai terbiasa dengan proses pemasangan dan konfigurasi, yang ternyata sangat mudah sekali.


# Eksekusi

Pada catatan kali ini saya akan menuliskan tentang:

1. Bagaimana cara memasang PostgreSQL pada Arch Linux
2. Bagaimana cara mengkonfigurasi agar dapat digunakan

Dalam point kedua ini, bisa jadi akan sedikit banyak berbeda dengan konfigurasi yang sudah pernah teman-teman ketahui.

Menurut saya ini cara yang paling mudah, untuk mengkonfigurasi PostgreSQL yang <mark> hanya kita gunakan pada sistem pribadi kita</mark> (baca: bukan untuk level *production* yaa).

Pada catatan ini tidak akan jauh berbeda dengan Arch Wiki pada saat tulisan ini dibuat.

## Instalasi PostgreSQL

Pasang paket PostgreSQL yang sudah terdapat pada *official repo* Arch.

<pre>
$ <b>sudo pacman -S postgresql</b>
</pre>

Ikuti proses instalasi sampai selesai.

Pada proses instalasi tersebut juga akan dibuatkan secara otomatis *system user* yang bernama `postgres`.

User ini yang nantinya akan kita gunakan untuk melakukan konfigurasi awal seperti membuat user dan database atas nama username kita sendiri.

## Konfigurasi Awal

Setelah instalasi PostgreSQL, biasanya tidak dapat langsung digunakan. Karena kita perlu untuk mengkonfigurasi user dan database mana yang akan kita pergunakan.

Anggaplah saya akan menggunakan user dengan nama yang sama dengan username Linux yang kita gunakan. Maka kita perlu membuatnya terlebih dahulu. Karena pada saat proses instalasi PostgreSQL yang kita lakukan sebelumnya, hanya dibuat *system user* yang bernama `postgresql`. Akun inilah yang akan kita gunakan untuk melakukan konfigurasi awal.


### Berpindah User Postgres
Sekarang, kita perlu berpindah menggunkaan aku `postgres` ini dengna cara.

<pre>
$ <b>sudo -iu postgres</b>
</pre>

Saya anggap mayoritas dari teman-teman pasti menggunakan `sudo`.

Apabila berhasil, akan menampilkan shell akan diawali dengan bentuk seperti di bawah ini.

<pre>
[postgres]$
</pre>

Atau, apabila teman-teman sudah pernah mengkonfigurasi nama hostname pada Arch, akan menjadi seperti ini.

```
[postgres@THINKPAD-X61]$
```

Intinya adalah kita sudah berpindah menggunakan user `postgres`.

### Initialisasi Database Cluster

Kita perlu mengeset *default data directory*, biar mudah tidak usah *custom* deh, ikutin *default*-nya saja, seperti yang dicontohkan oleh Arch Wiki.

<pre>
[postgres]$ <b>initdb -D /var/lib/postgres/data</b>
</pre>

`-D` menunjukkan lokasi *default* dimana *database cluster* harus disimpan.

Secara *default* inisialisasi di atas akan menggunakan *default locale* dan *encoding* (`$ echo $LANG`) yang kita gunakan.

Namun, kalau teman-teman merasa tidak pernah mengesetnya dan tidak mengerti, sebaiknya gunakan cara di bawah ini saja untuk berjaga-jaga. Karena saya khawatir beberapa diantara teman-teman ada yang belum mengkonfigrasi *locale* secara benar karena hanya ikut-ikutan memasang Arch Linux.

<pre>
[postgres]$ <b>initdb --locale=en_US.UTF-8 -E UTF8 -D /var/lib/postgres/data</b>
</pre>

Setelah kita tekan tombol <kbd>ENTER</kbd>, makan akan keluar *output* seperti di bawah ini.

```
The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.

The database cluster will be initialized with locale "en_US.UTF-8".
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".

Data page checksums are disabled.

fixing permissions on existing directory /var/lib/postgres/data ... ok
creating subdirectories ... ok
selecting default max_connections ... 100
selecting default shared_buffers ... 128MB
selecting dynamic shared memory implementation ... posix
creating configuration files ... ok
running bootstrap script ... ok
performing post-bootstrap initialization ... ok
syncing data to disk ... ok

WARNING: enabling "trust" authentication for local connections
You can change this by editing pg_hba.conf or using the option -A, or
--auth-local and --auth-host, the next time you run initdb.

Success. You can now start the database server using:

    pg_ctl -D /var/lib/postgres/ -l logfile start
```

Apabila berhasil, kira-kira *output* yang ditampilkan akan seperti di atas.

Langkah selanjutnya kita perlu menjalankan service dari PostgreSQL.

Keluar dari user `postgres` dengan perintah

<pre>
[postgres]$ <b>exit</b>
</pre>

### Jalankan PostgreSQL Service

Pastikan kita sudah keluar dari user `postgres` seperti perintah di atas.

Kemudian jalankan perintah di bawah, untuk menjalankan service dari PostgreSQL.

<pre>
$ <b>sudo systemctl start postgresql.service</b>
</pre>

Apabila teman-teman ingin membuat service ini berjalan otomatis saat sistem kita dinyalakan/dijalankan, gunakan perintah `enable`.

<pre>
$ <b>sudo systemctl enable postgresql.service</b>
</pre>

Apabila berhasil akan menampilkan *output* seperti di bawah ini.
```
Created symlink /etc/systemd/system/multi-user.target.wants/postgresql.service → /usr/lib/systemd/system/postgresql.service.
```

Namun, saya lebih memilih untuk tidak menjalankannya secara otomatis saat sistem pertama kali dinyalakan. Karena saya tidak selalu membutuhkan service dari PostgreSQL.

Saya hanya menjalankan PostgreSQL service apabila akan bekerja atau ada beberapa tools yang memerlukan PostgreSQL service.

Tujuannya adalah agar sistem saya tidak perlu menjalankan service-service yang tidak diperlukan.

Untuk melihat apakah postgresql.serive sudah berhasil dijalankan, gunakan perintah di bawah ini.

<pre>
$ <b>sudo systemctl status postgresql.service</b>
</pre>

Apabila, service berhasil dijalankan, akan menampilkan output seperti ini.

<pre>
● postgresql.service - PostgreSQL database server
   Loaded: loaded (/usr/lib/systemd/system/postgresql.service; disabled; vendor preset: disabled)
   Active: <span style="font-weight:bold;color:#859900;">active (running)</span> since Mon 2019-11-25 08:53:31 WITA; 2s ago
  Process: 1084469 ExecStartPre=/usr/bin/postgresql-check-db-dir ${PGROOT}/data (code=exited, status=0/SUCCESS)
 Main PID: 1084471 (postgres)
    Tasks: 7 (limit: 4600)
   Memory: 21.3M
   CGroup: /system.slice/postgresql.service
           ├─1084471 /usr/bin/postgres -D /var/lib/postgres/data
           ├─1084473 postgres: checkpointer
           ├─1084474 postgres: background writer
           ├─1084475 postgres: walwriter
           ├─1084476 postgres: autovacuum launcher
           ├─1084477 postgres: stats collector
           └─1084478 postgres: logical replication launcher

Nov 25 08:53:30 BANDITHIJO-X61 systemd[1]: Starting PostgreSQL database server...
Nov 25 08:53:31 BANDITHIJO-X61 postgres[1084471]: 2019-11-25 08:53:31.099 WITA [1084471] LOG:  listening on IPv6 address "::1", port 5432
Nov 25 08:53:31 BANDITHIJO-X61 postgres[1084471]: 2019-11-25 08:53:31.099 WITA [1084471] LOG:  listening on IPv4 address "127.0.0.1", port 5432
Nov 25 08:53:31 BANDITHIJO-X61 postgres[1084471]: 2019-11-25 08:53:31.101 WITA [1084471] LOG:  listening on Unix socket "/run/postgresql/.s.PGSQL.5432"
Nov 25 08:53:31 BANDITHIJO-X61 postgres[1084471]: 2019-11-25 08:53:31.132 WITA [1084472] LOG:  database system was shut down at 2019-11-24 19:20:26 WITA
Nov 25 08:53:31 BANDITHIJO-X61 postgres[1084471]: 2019-11-25 08:53:31.144 WITA [1084471] LOG:  database system is ready to accept connections
</pre>

### Membuat User

Kalau saya pribadi, saya tidak suka menggunakan user `postgres`, karena tentu saja akan memiliki keterbatasan ruang gerak dalam hal *permission*.

Saya akan membuat user dengan nama yang sama seperti user Linux yang saya pergunakan. Dengan begini, saya tidak perlu pusing untuk mengakses PostgreSQL shell (`psql`) karena sudah memiliki username yang sama seperti user Linux.

Kita memerlukan bantuan user `postgres` lagi.

<pre>
$ <b>sudo -iu postgres</b>
</pre>

Kemudian, buat user baru.

<pre>
[postgres]$ <b>createuser --interactive</b>
</pre>

Kita akan disuguhkan 2 buah pertanyaan mengenai nama user dan role.

Isikan saja seperti contoh di bawah ini.

<pre>
Enter name of role to add: <mark>bandithijo</mark>
Shall the new role be a superuser? (y/n) y
</pre>

Perhatikan bagian yang saya <mark><i>marking</i></mark>! Ganti dengan username Linux teman-teman.

### Membuat Database untuk User

Kita **HARUS** membuat database untuk user yang baru saja kita buat. Kalau tidak, tentu saja tidak akan dapat kita gunakan.

<pre>
[postgres]$ <b>createdb <mark>bandithijo</mark></b>
</pre>

Perhatikan bagian yang saya <mark><i>marking</i></mark>! Ganti dengan username Linux teman-teman.

Proses tersebut akan membuat database baru dengan nama yang sama seperti username Linux yang kita gunakan.

Sekarang `exit` dan coba masuk ke dalam PostgreSQL shell menggunakan perintah,

<pre>
$ <b>psql</b>
</pre>

Kalau berhasil, akan seperti ini tampilan dari PostgreSQL shell.

```
psql (11.5)
Type "help" for help.

bandithijo=# _
```

Mantap!

Langkah selanjutnya, kita perlu merubah kepemilikan (*owner*) dari database atas nama username yang tadi kita buat menggunakan user `postgres`.

Cek dulu dengan perintah,

<pre>
bandithijo=# <b>\l</b>
</pre>

<pre>
                                            List of databases
        Name        |   Owner    | Encoding |   Collate   |    Ctype    |   Access privileges
--------------------+------------+----------+-------------+-------------+-----------------------
<mark> bandithijo         | postgres   </mark>| UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 postgres           | postgres   | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 template0          | postgres   | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
                    |            |          |             |             | postgres=CTc/postgres
 template1          | postgres   | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
                    |            |          |             |             | postgres=CTc/postgres
(4 rows)
</pre>

Lihat, pada bagian yang saya *marking*, database `bandithijo` masih dimiliki oleh user `postgres`.

Rubah kepemilikannya menjadi milik kita dengan perintah sql seperti ini,

<pre>
bandithijo=# <b>ALTER DATABASE <mark>bandithijo</mark> OWNER TO <mark>bandithijo</mark>;</b>
</pre>

Perhatikan bagian yang saya <mark><i>marking</i></mark>! Ganti dengan username Linux teman-teman.

Contoh perintah SQL-nya seperti ini,

```
```
<pre>
<b>ALTER DATABASE target_database OWNER TO new_onwer;</b>
</pre>

Kalau berhasil, akan menampilkan *output* seperti ini,

```
ALTER DATABASE
```

Selanjutnya periksa lagi, apakah database kita sudah berubah kepemilikan.

<pre>
bandithijo=# <b>\l</b>
</pre>

<pre>
                                            List of databases
        Name        |    Owner     | Encoding |   Collate   |    Ctype    |   Access privileges
--------------------+--------------+----------+-------------+-------------+-----------------------
<mark> bandithijo         | bandithijo   </mark>| UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 postgres           | postgres     | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 template0          | postgres     | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
                    |              |          |             |             | postgres=CTc/postgres
 template1          | postgres     | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
                    |              |          |             |             | postgres=CTc/postgres
(4 rows)
</pre>

Mantap!

Sekarang database kita sudah menjadi milik kita.

# Tambahan

## Menghapus Database dan User

Untuk menghapus database dan menghapus role (user), gunakan perintah ini.

Masuk menggunakan user `postgres`.

<pre>
$ <b>psql -U postgres</b>
</pre>

Lalu jalankan perintah `DROP DATABASE` dan `DROP USER`.

<pre>
psql (11.5)
Type "help" for help.

postgres=# <b>DROP DATABASE bandithijo;</b>
DROP DATABASE

postgres=# <b>DROP USER bandithijo;</b>
DROP ROLE
</pre>

# Upgrade

Salah satu hal merepotkan lain adalah proses upgrade.

Sejauh pengalaman saya, terdapat 2 jenis upgrade, yaitu upgrade minor dan upgrade major.

## Upgrade Minor

Apabila teman-teman mengupdate repo Arch dan mendapati versi upgrade Postgres 11.4 ke 11.5, ini diseut upgrade minor.

Untuk upgrade minor, seperti dari versi Postgres 11.4 ke 11.5, tidak memerlukan konfigurasi apapun. Semua berjalan otomatis dan tidak memerlukan konfigurasi apapun.

## Upgrade Major

Namun, apabila teman-teman menemukan versi major yang berbeda saat melakukan update repo.

Seperti Postgres versi 11.5 ke 12.1, ini disebut upgrade major.

Proses upgrade versi major untuk Postgres versi 11 ke versi 12, akan saya bahas pada catatan yang lain.

<!-- INFORMATION -->
<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>Saat tulisan ini dibuat, PostgreSQL sudah memasuki versi 12.1</p>
<p>Bagi teman-teman yang masih ingin menggunakan versi sebelumnya (11.5), sebaiknya perlu memasukkan kedalam <code>IgnorePkg=</code> pada konfigurasi <code>/etc/pacman.conf</code>.</p>
<pre>
IgnorePkg = postgresql postgresql-libs
</pre>
</div>

Sekian catatan mengenai proses instalasi dan konfigurasi awal dari PostgreSQL pada Arch Linux.

Mudah-mudahan dapat membantu teman-teman yang memerlukan.

Terima kasih.

(^_^)



# Referensi

1. [wiki.archlinux.org/index.php/PostgreSQL](https://wiki.archlinux.org/index.php/PostgreSQL){:target="_blank"}
<br>Diakses tanggal: 2019/11/25

2. [postgresqltutorial.com/postgresql-alter-database](http://www.postgresqltutorial.com/postgresql-alter-database/){:target="_blank"}
<br>Diakses tanggal: 2019/11/25
