---
layout: 'post'
title: "Catatan dalam Berinteraksi dengan Emacs Tutorial"
date: 2021-04-17 10:24
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
description: "Catatan ini merupakan snippets atau cheatsheet atau dapat pula disebut sebagai rangkuman untuk keyboard shortcut yang dijelaskan di dalam Emacs Tutorial."
---

# Prakata

Buat teman-teman yang baru pertama kali mencoba Emacs dan sedang belajar Emacs Tutorial, mudah-mudahan catatan ini dapat membantu untuk mengingat kembali mapping keyboard apa saja / keyboard shortcut apa saja yang telah dijelaskan.

Karena Emacs Tutorial berbentuk narasi, sehingga tidak mudah bagi saya untuk mencari kembali apabila terdapat keyboard shortcut yang sedang saya perlukan. Saya yakin, hal ini karena saya belum terbiasa dengan workflow yang ada di Emacs.

Namun, demikian, saya teteap ingin menuliskan catatan perihal Emacs Tutorial di sini. Mudah-mudahan dapat mempermudah teman-teman apabila mengalami kesulitan yang sama.

# Keyboard Shortcut

## Penyamaan Persepsi

CONTROL atau CTRL atau CTL, diwakilkan sebagai **C**.

ALT atau EDIT atau META, diwakilkan sebagai **M**.

<br>
Bila keduanya berkombinasi dengan key yang lain, maka akan ditampilkan seperti ini:

**C-x**, artinya tekan dan tahan CONTROL, lalu tekan x.

**M-x**, artinya tekan dan tahan ALT, lalu tekan x.

**C-x C-c**, artinya tekan dan tahan CONTROL, lalu tekan x, masih tekan CONTROL, lalu tekan c.

**C-x k**, artinya tekan dan tahan CONTROL, lalu tekan x, lepas semua tombol sebelumnya, lalu tekan k.

<br>
SPACE, akan diwakilkan sebagai &lt;SPC&gt;.

DELETE, akan diwakilkan sebagai &lt;DEL&gt;.

RETURN atau ENTER, akan diwakilkan sebagai &lt;RET&gt;

## Keluar dari Emacs Tutorial

Dapat pula digunakan sebagai "kill buffer", karena buffer yang sedang terbuka adalah Emacs Tutorial.

{% keymap %}
C-x k
{% endkeymap %}

Command ini akan memberikan kita pertanyaan,

Apakah ingin menyimpan posisi cursor di Tutorial? Jawab saja **y**.

## Mengakhiri Emacs Session

{% keymap %}
C-x C-c
{% endkeymap %}

## View Next/Previous Screen

**Next screen / Page down**

{% keymap %}
C-v
{% endkeymap %}

**Previous screen / Page up**

{% keymap %}
M-v
{% endkeymap %}

## Positioning Cursor on Center/Top/Bottom

Kita dapat melakukan scrolling pada screen tanpa memindahkan cursor berfokus pada baris tertentu.

{% keymap %}
C-l
{% endkeymap %}

Akan dimulai dari tengah screen, kemudian atas, lalu bawah.

## Basic Cursor Control (Basic Movement)

### Memindahkan cursor per character

{% pre_whiteboard %}
                      Previous line, C-p
                             :
                             :
Backward, C-b .... Current cursor position .... Forward, C-f
                             :
                             :
                        Next line, C-n
{% endpre_whiteboard %}

**Forward 1 character**

{% keymap %}
C-f
{% endkeymap %}

**Backward 1 character**

{% keymap %}
C-b
{% endkeymap %}

**Next 1 line**

{% keymap %}
C-n
{% endkeymap %}

**Previous 1 line**

{% keymap %}
C-p
{% endkeymap %}

### Memindahkan cursor perkata

**Forward 1 word**

{% keymap %}
M-f
{% endkeymap %}

**Backward 1 word**

{% keymap %}
M-b
{% endkeymap %}

### Memindahkan cursor ke awal baris

{% keymap %}
C-a
{% endkeymap %}

### Memindahkan cursor ke akhir baris

{% keymap %}
C-e
{% endkeymap %}

### Memindahkan cursor ke awal kalimat

{% keymap %}
M-a
{% endkeymap %}

Dapat diteruskan untuk berpindah ke kalimat selanjutnya.

### Memindahkan cursor ke akhir kalimat

{% keymap %}
M-e
{% endkeymap %}

Dapat diteruskan untuk berpindah ke kalimat sebelumnya.

### Memindahkan cursor ke baris pertama

{% keymap %}
M-&lt;
{% endkeymap %}

### Memindahkan cursor ke baris terakhir

{% keymap %}
M-&gt;
{% endkeymap %}

### Jump to

Perintah-perintah movement di atas, juga dapat kita berikan argument berupa angka.

Kita dapat menggunakan prefix **C-u**, diikutin dengan **n** (jumlah) lompatan dalam angka, kemudian **arahnya**.

**n jumlah lompatan**, disebut dengan **repeat count**

**arah**, disebut dengan **direction**.

<br>
Misal, kita ingin bergerak 10 baris ke bawah.

{% keymap %}
C-u 10 C-n
{% endkeymap %}

<br>
Cara lain, selain menggunakan prefix **C-u**, dapat pula menggunakan **ALT-&lt;repeat count&gt;**

Misal, kita ingin bergerak 20 character ke depan.

{% keymap %}
M-20 C-f
{% endkeymap %}

## Jika Emacs Berhenti Merespon

Beberapa hal yang dapat menyebabkan Emacs berhenti merespon:

1. Tidak merespon saat kita memasukkan inputan
2. Menghentikan command yang berjalan terlalu dieksekusi
3. Membatalkan command dengan *numeric argument* yang tidak ingin kita eksekusi

Dapat kita atasi dengan,

{% keymap %}
C-g
{% endkeymap %}

## Disabled Commands

{% keymap %}
C-g
{% endkeymap %}

Pda command display mode, Emacs akan menampilkan **Quit**.

## Manipulation Windows

### Delete other windows

Saya asumsikan sebagai *maximize current focused selected window*.

{% keymap %}
C-x 1
{% endkeymap %}

Command ini akan membuat current focuses selected window akan menjadi maximize.

## Inserting

### Insert repeating character with repeat count

Sama sepertin repeat count pada movement, kita dapat menggunakannya untuk memasukkan karakter sejumlah **n**.

Misal, kita ingin memasukkan karakter "+" (tambah) sebanyak 20.

{% keymap %}
C-u 20 +
{% endkeymap %}

Maka, hasilnya akan menjadi,

{% pre_whiteboard %}
++++++++++++++++++++
{% endpre_whiteboard %}

## Deleting

### Delete 1 karakter di depan cursor

{% keymap %}
C-d
{% endkeymap %}

### Delete 1 kata sebelum cursor

{% keymap %}
M-&lt;DEL&gt;
{% endkeymap %}

### Delete 1 kata setelah cursor

{% keymap %}
M-d
{% endkeymap %}

### Hapus seluruh karakter mulai dari posisi cursor sampai akhir baris

{% keymap %}
C-k
{% endkeymap %}

### Hapus 1 paragraf mulai dari posisi cursor sampai akhir paragraph

{% keymap %}
M-k
{% endkeymap %}

## Text Selection

Akan melakukan selection dimulai dari posisi cursor berada.

{% keymap %}
C-&lt;SPC&gt;
{% endkeymap %}

Pada command display mode, Emacs akan menampilkan tulisan **Mark set**.












{% comment %}
# Referensi

1. [](){:target="_blank"}
2. [](){:target="_blank"}
3. [](){:target="_blank"}
{% endcomment %}
