---
layout: 'post'
title: "Catatan dalam Berinteraksi dengan Tmux"
date: 2021-03-31 06:26
permalink: '/note/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'note'
tags: ['Tips']
wip: true
pin:
contributors: []
description: "Hal-hal terkait Tmux, cukup banyak sekali yang saya lupakan. Seperti beberapa kombinasi keyboard dan command tertentu. Apabila diperlukan, saya harus Googling kembali. Agar tidak membuang waktu mencari kembali, saya akan mencatatnya saja di sini."
---

# Prakata

Banyak sekali hal-hal terkait Tmux yang terlupakan karena tidak pernah saya catat. Saat diperlukan, saya harus Googling dan mencari kembali. Sangat membuang-buang waktu development.

Karena alasan tersebut, saya putuskan untuk mencatat beberapa hal terkait Tmux. Mungkin, teman-teman juga dapat memanfaatkannya.

# Morfologi

Ibarat sebuah pohon, **session** adalah pokok batangnya, kemudian cabangnya adalah **window** (tab) yang memiliki daun berupa **pane**.

## Sessions

{% pre_whiteboard %}
- BLOG: 2 windows (attached)
├─>   0: CANVAS* (1 panes)
└─> + 1: SERVER- (2 panes)
- DOJO: 2 windows
├─>   0: CANVAS* (1 panes)
└─> + 1: RUN-    (2 panes)
- PROJEKT: 2 windows
├─>   0: CANVAS* (1 panes)
└─> + 1: SERVER- (2 panes)
{% endpre_whiteboard %}

Dapat terlihat, kalau saya memiliki 3 buah session.

**- BLOG:**, adalah nama dari session.<br>
Yang memiliki **(attached)** artinya sedang aktif terbuka.

**0: CANVAS**, adalah nama dari window (bisa juga kita anggap sebagai tab).<br>
Window tersebut dapat pula kita berikan nama. (1 panes) artinya dalam tab tersebut sedang terbuka 1 buah pane.<br>
Tanda **\*** adalah indikator window yang sedang aktif terbuka (*selected window*).

**(1 panes)**, adalah jumlah dari pane.<br>

## Windows (Tabs)

{% pre_whiteboard %}
+-------------------+    +-------------------+    +-------------------+
|$                  |    |$                  |    |$                  |
|                   |    |                   |    |                   |
|                   |    |                   |    |                   |
|                   |    |                   |    |                   |
|                   |    |                   |    |                   |
|-------------------|    |-------------------|    |-------------------|
|0 0:AA*            |    |0 0:AA 1:BB*       |    |0 0:AA 1:BB 3:CC*  |
+-------------------+    +-------------------+    +-------------------+
       1 window                2 windows                3 windows
{% endpre_whiteboard %}

## Panes

{% pre_whiteboard %}
+-------------------+    +-------------------+    +-------------------+
|$                  |    |$        |$        |    |$        |$        |
|                   |    |         |         |    |         |         |
|                   |    |         |         |    |         |---------|
|                   |    |         |         |    |         |$        |
|                   |    |         |         |    |         |         |
|-------------------|    |-------------------|    |-------------------|
|0 0:AA*            |    |0 0:AA* 1:BB       |    |0 0:AA* 1:BB 3:CC  |
+-------------------+    +-------------------+    +-------------------+
       1 pane                   2 panes                  3 panes
{% endpre_whiteboard %}

Jadi secara garis besar dapat diurutkan seperti ini.

{% pre_whiteboard %}
server > sessions > windows > panes
{% endpre_whiteboard %}

**server** adalah bagian paling luar dari session, tempat dimana session berada.



# Mappings (Keyboard Shortcut)

## Tmux prefix

Default dari Tmux prefix adalah,

<kbd>Ctrl</kbd>-<kbd>b</kbd>

Pada catatan ini, apabila di awali dengan kombinasi keyboard tersebut, artinya adalah **Prefix**.

<br>
## Melihat daftar keybindings

Tmux memmiliki banyak sekali keybindings, untuk melihat daftar tersebut,

<kbd>Ctrl</kbd>-<kbd>b</kbd> <kbd>?</kbd>

<br>
Untuk keluar dari list keybindings,

<kbd>q</kbd>

<br>
## Masuk ke command mode

Untuk masuk ke Tmux command mode,

<kbd>Ctrl</kbd>-<kbd>b</kbd> <kbd>:</kbd>

Kalau berhasil, Tmux akan menampilkan command mode pada Tmux statusbar seperti ini,

<pre>
:
</pre>

Tinggal kita masukkan command yang ingin di-input-kan.

<br>
## Keluar/Close/Detach dari session yang sedang aktif

Untuk keluar/detach (melepaskan) session Tmux yang sedang aktif,

<kbd>Ctrl</kbd>-<kbd>b</kbd> <kbd>d</kbd>

Tmux akan langsung keluar dan kembali ke prompt Terminal.

Tmux session tersebut tidak akan hilang, tapi masih berjalan di background process.

Untuk mengakses Tmux session yang kita detach tersebut, gunakan [**cara ini**](#attachmemasang-kembali-session-yang-sudah-di-detach-dari-terminal)

<br>
## Memberikan/Mengganti nama session

Secara default, nama session akan otomatis digenerate secara incremental dalam bentuk integer mulai dari 0.

Kita, dapat mengganti nama session dengan cara,

<kbd>Ctrl</kbd>-<kbd>b</kbd> <kbd>$</kbd>

Pada command mode, akan tertulis seperti ini,

{% shell_cmd : %}
(rename-session) 0
{% endshell_cmd %}

Ganti **0** dengan nama yang kalian inginkan.

<br>
## Membuat window (tab) baru

Secara default, saat session baru dibuat, hanya akan ada 1 window (tab) yang biasanya bernama **0:zsh**.

Kita dapat membuat/manambah window baru dengan cara,

<kbd>Ctrl</kbd>-<kbd>b</kbd> <kbd>c</kbd>

Window (tab) baru akan secara otomatis ditambahkan ke bagian akhir dari windows stack.

<br>
## Memberikan/Mengganti nama window (tab)

Secara default, nama window akan otomatis diambil dari nama shell yang digunakan.

Kita, dapat mengganti nama window dengan cara,

<kbd>Ctrl</kbd>-<kbd>b</kbd> <kbd>,</kbd>

Pada command mode, akan tertulis seperti ini,

{% shell_cmd : %}
(rename-window) zsh
{% endshell_cmd %}

Ganti **zsh** dengan nama yang kalian inginkan.


<br>
# Command Mode

## Membuat session baru dari dalam Tmux

Untuk membuat session baru dari dalam Tmux,

{% shell_cmd : %}
new-session -s &lt;nama_session&gt;
{% endshell_cmd %}


<br>
## Membuat session baru dengan working directory dari dalam Tmux

Kalau kita sudah berada di dalam Tmux, namun ingin membuat session lain (session baru yang lain) sambil mendefinisikan *workding directory*-nya,

{% shell_cmd : %}
new-session -s &lt;nama_session&gt; -c /lokasi/working/directory/baru
{% endshell_cmd %}

<br>
## Mengganti working directory pada session yang sudah ada dari dalam Tmux

Kalau kita sudah terlanjur membuat session baru, namun ingin menganti *working directory*-nya,

{% shell_cmd : %}
attach-session -t . -c /lokasi/working/directory/baru
{% endshell_cmd %}

**-t .** adalah session yang saat ini sedang digunakan.

Atau bisa juga menggunakan tmux variable untuk cwd, yaitu `pane_current_path`.

Masuk dulu ke direktori yang ingin dijadikan cwd. Lalu jalankan perintah di bawah.

{% shell_cmd : %}
attach-sesson -t . -c "#{pane_current_path}"
{% endshell_cmd %}


<br>
# Command Line Terminal

## Membuat session baru dari Terminal

Untuk membuat session baru dari Terminal,

{% shell_term $ %}
tmux new-session -s &lt;nama_session&gt;
{% endshell_term %}

**-s** adalah flag option untuk **name the session**.

<br>
## Membuat session baru dengan working directory dari Terminal

Tmux session yang baru dibuat, akan dimulai dari WD (*Working Directory*) dimana session tersebut dibuat.

Jadi, kalau kita buat Tmux session pada direktori **~/Desktop**, maka setiap WD dari Tmux window pane yang ada di dalam Tmux session tersebut akan dimulai dari sana.

Namun, kita dapat membuat session baru, sambil mendefinisikan lokasi dari WD yang akan digunakan.

{% shell_term $ %}
tmux new-session -s &lt;nama_session&gt; -c /lokasi/working/directory/baru
{% endshell_term %}

**-c** adalah *specify working directory for the session*.

<br>
## Attach/Memasang kembali session yang sudah di-detach dari Terminal

Apabila kita memiliki session yang masih aktif di background karena kita melakukan proses [**detach**](#keluarclosedetach-dari-session-yang-sedang-aktif).

Kita dapat masuk kembali, ke dalam session tersebut dengan cara,

{% shell_term $ %}
tmux attach-session -t &lt;nama_session&gt;
{% endshell_term %}

Kita perlu mengetahui **nama_session** dari session yang akan kita attach.







{% comment %}
# Referensi

1. [](){:target="_blank"}
2. [](){:target="_blank"}
{% endcomment %}
