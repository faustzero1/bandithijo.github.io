---
layout: 'post'
title: "Lazygit, Terminal User Interface untuk Git Commands"
date: 2021-12-15 05:57
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Git', 'Terminal', 'Tools', 'Ulasan']
pin:
hot:
contributors: []
description: "Lazygit adalah Git Tools berupa Terminal User Interface yang dapat kita manfaatkan sebagai alat bantu yang mempermudah kita dalam berinteraksi dengan perintah-perintah Git. Saya lebih prefer menggunakan veri TUI ketimbang Git Tools lain yang menggunakan GUI karena dengan menggunakan TUI, saya masih dapat memanfaatkan keyboard shortcut untuk mengoperasikan tools tersebut."
---

# Tentang Lazygit

Lazygit adalah Terminal User Interface ~~sederhana~~ yang digunakan untuk mempermudah kita dalam menggunakan perintah-perintah Git. Ditulis dengan bahasa pemrograman Go oleh [Jesse Duffield](https://github.com/jesseduffield){:target="_blank"}.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/g01HkB1L/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}

# Skenario

Pada catatan kali ini, saya akan mendokumentasikan secara tertulis pemaparan tentang 15 fitur dari Lazygit yang dibawakan oleh Jesse Duffield dalam videonya yang diunggah ke YouTube dengan judul [15 Lazygit Features In Under 15 Minutes](https://www.youtube.com/watch?v=CPLdltN7wgE){:target="_blank"}.

# Navigasi

| Key | Deskripsi |
| --- + --- |
| <span class="nobr"><kbd>j</kbd> & <kbd>k</kbd></span> | Move selected cursor up & down |
| <span class="nobr"><kbd>h</kbd> & <kbd>l</kbd></span> | Move selected section up & down |
| <span class="nobr"><kbd>x</kbd> & <kbd>?</kbd></span> | Keybind help |

# Features

## 1. Staging files fast

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/yxjR9fpP/gambar-02.png" onerror="imgError(this);"}{:class="myImg"}

Pada section **Files**,

| Key | Deskripsi | Toggle On/Off |
| --- + --- + ---|
| <kbd>Space</kbd> | Selected file into staging | Yes |
| <kbd>a</kbd> | All files into staging | Yes |

Keterangan,

| Prefix | Deskripsi |
| --- + --- |
| ?? | Unstaged file |
| A | Staged file |
| M | Modified file |

### 1.1. Untuk membuat commit message

| Key | Deskripsi |
| --- + --- |
| <kbd>c</kbd> | Membuat commit message |

### 1.2. Untuk melakukan reset last commit (membatalkan commit terakhir)

Letakkan cursor (highlight cursor) pada commit hash setelah last commit (setelah commit terakhir) (Lihat Gambar 3 di bawah).

![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/5tmppmrX/gambar-03.png" onerror="imgError(this);"}{:class="myImg"}

Saya ingin melakukan reset terhadap commit hash **b5d7f96f**, maka cursor saya letakkan pada commit hash **8b27e34f**, kemudian tekan <kbd>g</kbd>.

| Key | Deskripsi |
| --- + --- |
| <kbd>g</kbd> | Reset to this commit |

Nanti akan keluar popup window,

![gambar_4]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/T3M96SMy/gambar-04.png" onerror="imgError(this);"}{:class="myImg"}

Pilih yang **soft reset**.

Kalau berhasil, stagging files yang berada di last commit kita akan muncul di section Files.

![gambar_5]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/t43zC5pB/gambar-05.png" onerror="imgError(this);"}{:class="myImg"}

## 2. Staging Lines

Pada section Files, pilih file yang ingin dilakukan commit pada baris tertentu saja.

Kemudian tekan <kbd>Enter</kbd>. Focus akan berpindah ke section Unstaged Changes.

![gambar_6]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/28w4s5wt/gambar-06.png" onerror="imgError(this);"}{:class="myImg"}

### 2.1. Single line

Pada section Unstaged Changes, tekan <kbd>Space</kbd> untuk memasukkan baris yang terseleksi (selected line) ke dalam secton Staged Changes.

![gambar_7]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/Bnnx4G7n/gambar-07.png" onerror="imgError(this);"}{:class="myImg"}

### 2.2. Multiline dengan Visual Block

Bisa juga gunakan Visual Block dengan menekan <kbd>v</kbd> (untuk mengaktifkan mode visual block), lalu tekan <kbd>j</kbd> (untuk memilih rentang line). Kalau sudah, tinggal tekan <kbd>Space</kbd> (untuk memasukkan rentang baris yang terlpilih ke dalam secton Staged Changes).

![gambar_8]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/43KVHQgC/gambar-08.png" onerror="imgError(this);"}{:class="myImg"}

### 2.3. Melakukan commit

untuk membuat commit, sama seperti pada feature no. 1 di atas, yaitu menggunakan tombol <kbd>c</kbd> untuk membuat commit message.

### 2.4. Undo staged changes

Untuk melakukan undo terhadap baris yang sudah terlanjur di-staging, kita perlu berpindah section ke secton Staged Changes dengan menekan <kbd>Tab</kbd> (toggle on/off).

![gambar_9]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/ryGW4pvp/gambar-09.png" onerror="imgError(this);"}{:class="myImg"}

Kemudian gunakan <kbd>d</kbd> atau <kbd>Space</kbd> untuk mengembalikan baris atau rentang baris yang tidak jadi di-staging ke section Unstaged Changes.

### 2.5. Delete unstaged changes

Pada section Unstaged Changes, kita dapat membatalkan perubahan pada baris yang terseleksi dengan menggunakan <kbd>d</kbd>.

## 3. Cherry Picking

Misalkan saat ini kita berada pada branch Master. Pada section Commits, tekan <kbd>c</kbd> (toggle on/off) pada commit yang ingin dilakukan *cherry picking*.

![gambar_10]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/jddWJ4H8/gambar-10.png" onerror="imgError(this);"}{:class="myImg"}

Kemudian pindah ke section Local Branches, dengan <kbd>h</kbd>. Pilih branch dengan <kbd>j</kbd> dan <kbd>k</kbd>, lalu aktifkan (berpindah) branch dengan <kbd>Space</kbd>.

Setelah berpindah branch di branch tujuan (misalkan branch tujuan saya adalah status2d), pindah ke section Commits dengan <kbd>l</kbd>. Untuk melakukan paste terhadap commit yang sudah kita lakukan *cherry pick* gunakan <kbd>v</kbd>.

Akan ada popup window,

![gambar_11]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/HLhwxP81/gambar-11.png" onerror="imgError(this);"}{:class="myImg"}

Yang bertuliskan, "**Are you sure you want to cherry-pick the copied commits onto this branch?**"

Tekan <kbd>Enter</kbd> untuk setuju.

Hasilnya akan seperti ini,

![gambar_12]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/rs65G09h/gambar-12.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">3 commit hash yang telah dipindahkan dari branch master ke branch status2d</p>

## 4. Nuking Working Tree

### 4.1. Nuke single file

Pada section Files, misalkan kita ingin mengembalikan file atau menghapus perubahan yang ada di dalam suatu file seperti keadaan sebelum dilakukan perubahan, kita dapat menggunakan <kbd>d</kbd>.

Akan ada popup window,

![gambar_13]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/rFN5WpRJ/gambar-13.png" onerror="imgError(this);"}{:class="myImg"}

Pilih **discard all changes**, untuk mengembalikan file seperti semula (sebelum di-edit).

Cara ini **tidak menghapus file** namun hanya mengembalikan file ke dalam keadaan semula sebelum dilakukan perubahan.

### 4.1. Nuke all files

Pada section Files, misalkan kita ingin membersihkan semua unstaging files dari daftar working tree, kita dapat menggunakan <span class="nobr"><kbd>Shift</kbd>+<kbd>d</kbd></span>.

Akan ada popup window,

![gambar_14]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/5t6zZq77/gambar-14.png" onerror="imgError(this);"}{:class="myImg"}

Pilih "**nuke working tree**". Maka, semua unstaged files akan hilang dari daftar working tree.

![gambar_15]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/W1tt3pGt/gambar-15.png" onerror="imgError(this);"}{:class="myImg"}

Cara ini **tidak menghapus file-file tersebut** namun hanya mengembalikan file ke dalam keadaan semula sebelum dilakukan perubahan.

## 5. Interactive rebasing

Pada section Commits, kita ingin melakukan rebase dari commit yang saya kotakin merah di bawah.

![gambar_16]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/4xD5QxQF/gambar-16.png" onerror="imgError(this);"}{:class="myImg"}

Untuk melakukan rebase, tekan <kbd>e</kbd>. Maka akan masuk ke dalam mode interaktif rebase seperti di bawah ini.

![gambar_17]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/QCYg98Mm/gambar-17.png" onerror="imgError(this);"}{:class="myImg"}

### 5.1. Beberapa rebase commands

Terdapat beberapa command yang dapat digunakan, seperti:

| Key | Deskripsi |
| --- + --- |
| <kbd>p</kbd> | Pick commit (when mid-rebase) |
| <kbd>s</kbd> | Squash down |
| <kbd>e</kbd> | Edit commit |
| <kbd>f</kbd> | Fixup commit |
| <kbd>d</kbd> | Delete/Drop commit |

### 5.2. Bertukar posisi commit (swap commit position)

Bertukar posisi/swap commit menggunakan,

| Key | Deskripsi |
| --- + --- |
| <kbd>Ctrl</kbd>+<kbd>j</kbd> | Swap selected commit down |
| <kbd>Ctrl</kbd>+<kbd>k</kbd> | Swap selected commit up |

Kalau sudah, tekan <kbd>m</kbd>, dan akan muncul popum window.

![gambar_18]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/L55LMcV1/gambar-18.png" onerror="imgError(this);"}{:class="myImg"}

Pilih **continue** jika ingin melakukan proses rebase. Pilih **abort** jika tidak ingin melakukan rebase.


## 6. Amending old commits

Pada section Files, sudah harus ada file yang masuk staging area.

Kemudian, pindah ke section Commits.

Pilih commit yang ingin dilakukan **ammending**. Lalu tekan <kbd>Shift</kbd>+<kbd>a</kbd>.

Akan ada popup window,

![gambar_19]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/mgCMRN78/gambar-19.png" onerror="imgError(this);"}{:class="myImg"}

Tekan <kbd>Enter</kbd> untuk menyetujui.

## 7. Open pull request

Pada section Local Branches, tekan <kbd>o</kbd>, untuk melakukan **Open a pull request** dari branch yang terseleksi.

Nanti akan dibukakan halaman GitHub Open Pull Request di Browser.

## 8. Revert commit

Pada section Commits, pilih commit yang ingin dilakukan *revert*. Kemudian tekan <kbd>t</kbd>, maka akan dibuatkan revert commit (commit kebalikan) dari commit yang dipilih. Revert commit tersebut akan dibuatkan commit message dengan prefix "Revert",

```
Revert "bla bla commit message bla bla"
```

![gambar_20]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/0N9CBHhp/gambar-20.png" onerror="imgError(this);"}{:class="myImg"}

## 9. Stash selected files

### 9.1. Membuat stash

Pada section Files, apabila ingin melakukan stash pada working tree, tekan <kbd>s</kbd> untuk stash changes, atau <kbd>Shift</kbd>+<kbd>s</kbd> untuk stash staged changes.

Kemudian buat stash message.

Maka, file yang di-stash akan masuk ke dalam section Stash.

![gambar_21]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/TYXQbwQ7/gambar-21.png" onerror="imgError(this);"}{:class="myImg"}

### 9.2. Menggunakan stash

Pada section Stash, pilih stash yang ingin digunakan. Untuk menggunakannya, ketik <kbd>Space</kbd> untuk mengeluarkan dari stash tanpa menghapus, atau ketik <kbd>g</kbd> untuk mengeluarkan dari stash sekaligus menghapus dari stash.

## 10. Moving code between old commits

[https://www.youtube.com/watch?v=CPLdltN7wgE&t=442s](https://www.youtube.com/watch?v=CPLdltN7wgE&t=442s){:target="_blank"}

## 11. Deleting code from old commits

[https://www.youtube.com/watch?v=CPLdltN7wgE&t=512s](https://www.youtube.com/watch?v=CPLdltN7wgE&t=512s){:target="_blank"}

## 12. Fixing merge conflicts

[https://www.youtube.com/watch?v=CPLdltN7wgE&t=547s](https://www.youtube.com/watch?v=CPLdltN7wgE&t=547s){:target="_blank"}

## 13. Easy rebase onto origin/master

[https://www.youtube.com/watch?v=CPLdltN7wgE&t=565s](https://www.youtube.com/watch?v=CPLdltN7wgE&t=565s){:target="_blank"}

## 14. Branch checkout without stashing changes

[https://www.youtube.com/watch?v=CPLdltN7wgE&t=613s](https://www.youtube.com/watch?v=CPLdltN7wgE&t=613s){:target="_blank"}

## 15. Theme customisation

[https://www.youtube.com/watch?v=CPLdltN7wgE&t=671s](https://www.youtube.com/watch?v=CPLdltN7wgE&t=671s){:target="_blank"}

# Thanks

Trima kasih kepada Jesse Duffield karena telah membuat Lazygit.

# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)


# Referensi

1. [https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase](https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase){:target="_blank"}
<br>Diakses tanggal: 2021/12/15
