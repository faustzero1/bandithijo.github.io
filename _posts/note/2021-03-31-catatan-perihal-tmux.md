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

# Tips dan Trick

## Tmux Prefix

Default dari Tmux prefix adalah,

<kbd>Ctrl</kbd>-<kbd>b</kbd>

Pada catatan kali ini, apabila di awali dengan kombinasi keyboard tersebut, artinya adalah **Prefix**.

<br>
## Tmux List Keybindings

Tmux memmiliki banyak sekali keybindings, untuk melihat daftar tersebut,

<kbd>Ctrl</kbd>-<kbd>b</kbd> <kbd>?</kbd>

<br>
Untuk keluar dari list keybindings,

<kbd>q</kbd>

<br>
## Tmux Command Mode

Untuk masuk ke Tmux command mode,

<kbd>Ctrl</kbd>-<kbd>b</kbd> <kbd>:</kbd>

Kalau berhasil, Tmux akan menampilkan command mode pada Tmux statusbar seperti ini,

{% pre_url %}
:
{% endpre_url %}

Tinggal kita masukkan command yang ingin di-input-kan.

<br>
## Membuat Session Baru dari Terminal

Untuk membuat session baru dari Terminal,

{% shell_cmd $ %}
tmux new-session -s &lt;nama_session&gt;
{% endshell_cmd %}

**-s** adalah flag option untuk **name the session**.

<br>
## Membuat Session Baru dari dalam Tmux

Untuk membuat session baru dari dalam Tmux,

{% pre_url %}
:new-session -s &lt;nama_session&gt;
{% endpre_url %}

<br>
## Membuat Session Baru dengan Working Directory dari Terminal

Tmux session yang baru dibuat, akan dimulai dari WD (*Working Directory*) dimana session tersebut dibuat.

Jadi, kalau kita buat Tmux session pada direktori **~/Desktop**, maka setiap WD dari Tmux window pane yang ada di dalam Tmux session tersebut akan dimulai dari sana.

Namun, kita dapat membuat session baru, sambil mendefinisikan lokasi dari WD yang akan digunakan.

{% shell_cmd $ %}
tmux new-session -s &lt;nama_session&gt; -c /lokasi/working/directory/baru
{% endshell_cmd %}

**-c** adalah *specify working directory for the session*.

<br>
## Membuat Session Baru dengan Working Directory dari dalam Tmux

Kalau kita sudah berada di dalam Tmux, namun ingin membuat session lain (session baru yang lain) sambil mendefinisikan WD-nya,

{% pre_url %}
:new-session -s &lt;nama_session&gt; -c /lokasi/working/directory/baru
{% endpre_url %}

<br>
## Mengganti Working Directory pada Session yang Sudah Ada (di dalam Tmux)

Kalau kita sudah terlanjur membuat session baru, namun ingin menganti *working directory*-nya,

{% pre_url %}
:attach-session -t &lt;nama_session&gt; -c /lokasi/working/directory/baru
{% endpre_url %}

**-t** adalah *specify target session*.






{% comment %}
# Referensi

1. [](){:target="_blank"}
2. [](){:target="_blank"}
{% endcomment %}
