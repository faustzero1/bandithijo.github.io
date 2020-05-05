---
layout: 'post'
title: "DWM, Window Manager yang Gak Pake Ribet"
date: 2020-04-24 14:23
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Ulasan']
pin:
hot:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Pendahuluan

Sejak Oktober 2017, saya mulai masuk ke dunia Window Manager. Diawali dengan i3WM. Hingga April 2019, Saya mulai berpindah menggunakan BSPWM. Dan April 2020, saya kembali melangkahkan kaki ke Window Manger yang lain, yaitu DWM.

i3WM dan BSPWM masuk dalam Window Manager yang berkelas "Manual Tilling". Dimana penggunanya diberikan kebebasan untuk mengatur dan menempatkan window. Lain hal dengan DWM, yang masuk dalam kelas "Dynamic Tilling". Dengan mengusung konsep "Master & Slave", pengguna tidak perlu dipusingkan untuk mengatur sendiri dimana window akan ditampilkan. Namun, Window yang baru, akan secara otomatis masuk ke dalam stack (tumpukan) "Master", sedangkan window yang lain, akan masuk ke dalam stack "Slave"

Inilah alasan, mengapa saya memberi judul catatan ini sebagai "DWM, Window Manager yang Gak Pake Ribet".
Anti ribet-ribet kleb! lah pokoknya!

Tapi...

Untuk mencapai tahap "gak ribet" ini, kita perlu ribet-ribet dulu di awal, mas Bro.

Seperti pepatah lama, "Berakit-rakit ke hulu, bersenang-senang kemudian."

<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>Menurut pendapat saya,</p>
<p>"Gak pake ribet" di sini juga saya maksudkan kepada perilaku dari tilling layout yang menganut prinsip "Master & Slave" tadi. Karena apabila dibandingkan berdasarkan kemampuan untuk mengelola window, i3WM dan BSPWM "jauh" lebih mumpuni.</p>
</div>

# Alasan Migrasi ke DWM

**Lah, kalau i3WM dan BPSWM jauh lebih mumpuni untuk mengelola window, kenapa pindah, mas Bro?**

Sama halnya seperti saat menggunakan i3WM, seiring berjalannya waktu, perilaku saya dalam mengelola window pun berubah. Tidak lagi banyak memerlukan layout yang *complicated* seperti pada saat saya mengerjakan soal-soal CCNA (lihat videonya di sini, ["Bagaimana i3wm Menghandle Banyak Window"](https://www.youtube.com/watch?v=Iw2t_k1QqJ8){:target="_blank"}).

Saat berpindah dari i3WM ke BSPWM, saya lebih banak menggunakan susunan tilling seperti ini.

```
+-----+-----+ +----------+ +-----+-----+ +-----+-----+
|     |     | |    1     | |     |  2  | |  1  |  2  |
|  1  |  2  | +----------+ +  1  +-----+ |-----+-----+
|     |     | |    2     | |     |  3  | |  4  |  3  |
+-----+-----+ +----------+ +-----+-----+ +-----+-----+
```

Nah, karena itu, saya berpikir, kenapa tidak coba untuk bermigrasi menggunakan window manager yang lebih sederhana dalam perilaku membuat layout? Maka saya pun melakukan riset kecil-kecilan, dan pilihan jatuh pada BSPWM.

Awalnya saya sempat mencoba DWM lebih dahulu, namun ternyata kebutuhan saya masih terlalu tinggi. Dengan ilmu saya saat itu, saya kesulitan mengkonfigurasi DWM agar dapat mengikuti keinginan saya. Maka saya memutuskan untuk menggunakan BSPWM. BSPWM, dapat mengikuti dan memenuhi kebutuhan saya dalam mengatur komposisi window.

Kemudian, sampai pada tahap perubahan perilaku saya dalam menyusun Window. Saya lebih banyak menggunakan tilling layout seperti ini.

```
+-----+-----+ +-----+-----+
|     |     | |     |  2  |
|  1  |  2  | +  1  +-----+
|     |     | |     |  3  |
+-----+-----+ +-----+-----+
```

Karena kebutuhan yang lebih sederhana, maka saya pun merasa cukup untuk menggunakan DWM tanpa perlu melakukan banyak *patching*. Karena saya sendiri masih kesulitan apabila memasang terlalu banyak *patching*.

Saya lebih banyak menggunakan model tilling layout yang mana window ke-1 lebih sering digunakan. Maka ini sangat cocok dengan filosofi "Master & Slave" milik DWM.

Eits! Namun, bukan berarti DWM hanya sesederhana itu. Buat yang menggemari kompleksitas dalam menggunakan Tilling Window Manager, kalian masih dapat meracik DWM sesuai keinginan yang kalian perlukan dengan menambah *patch*.

# Patching

Ada banyak sekali daftar *patch* yang tersedia.

Namun, jujur saja, saya tidak sanggup mengujicobanya satu persatu saat ini. Dari sekian banyak *patch* yang tesedia, saya memilah-milah, kira-kira *patch* mana saja yang saya benar-benar perlukan. Kenapa saya memilah-milah? Ada beberapa alasan, diantaranya:

1. Dengan banyaknya *patch* yang tersedia, saya tidak ingin dibingungkan dengan fungsi yang sama namun saling tumpang tindih.
2. Mengelola banyak *patch* sangat melelahkan. Mungkin dikarenakan saya belum memahami, bagaimana *best practice* dalam mengelola dan mengaplikasikan *patch.
3. Saya tidak ingin menambahkan *patch* yang saya tidak benar-benar perlukan.

Dengan beberapa alasan tersebut, selama tulisan ini dibuat saya ~~hanya~~ menggunakan 11 *patches*. yaitu:

1. actualfullscreen
2. autostart
3. center
4. cfacts
5. focusonnetactive
6. fullgaps
7. movestack
8. pertag
9. resizecorners
10. statusallmons
11. zoomswap

Saya meracik semua *patches* tersebut menjadi Git branches. Masing-masing *patch*, memiliki satu branch. Setelah itu, untuk mengcompila mejadi dwm yang utuh, saya menggunakan bantuan beberapa script. Script ini bertugas mengautomatisasi proses yang berulang-ulang. Tujuannya jelas untuk mempermudah saya agar tidak kelelahan berlama-lama depan laptop.

Berikut ini daftar script yang saya gunakan.

1. **suckclean** : untuk mereset master
2. **suckdiff** : untuk membuat backup branch dalam bentuk *patch* yang tersimpan di `~/.config/suckless/`
3. **suckmerge-dwm** : untuk me-*merge*-kan branch-branch terpilih ke master branch, sekaligus mengcompilenya

Nah, berikut ini adalah isi dari script-script tersebut.

# Suckless Script

**suckclean** - Created by: HexDSL
```bash
#!/usr/bin/env bash

make clean &&
rm -f config.h && git reset --hard origin/master
```

**suckdiff** - Created by: HexDSL
```bash
#!/usr/bin/env bash

git checkout master &&
dotfiles="$HOME/.config/suckless"
project=$(basename $(pwd))
diffdir="${dotfiles}/${project}_diffs/"
olddiffdir="${dotfiles}/${project}_diffs/old/"
rm -rf "$olddiffdir" &&
mkdir -p "$olddiffdir" &&
mkdir -p "$diffdir" &&
mv "$diffdir"*.diff "$olddiffdir" || true &&
make clean && rm -f config.h && git reset --hard origin/master &&
for branch in $(git for-each-ref --format='%(refname)' refs/heads/ | cut -d'/' -f3); do
	if [ "$branch" != "master" ];then
		git diff master..$branch > "${diffdir}${project}_${branch}.diff"
	fi
done
```

**suckmerge-dwm** - Created by: BanditHijo
```ruby
#!/usr/bin/env ruby

puts "=> Convert All Branch to Patch"
system """
suckdiff &&
git checkout master
git reset --hard origin/master
"""
puts "=> Converting COMPLETE!"

branches = [
# Enable branch
'config',
'actualfullscreen',
'autostart',
'movestack',
'pertag',
'resizecorners',
'focusonnetactive',
'statusallmons',
'zoomswap',
'center',
'rules',              # merge /w: config, center
'fullgaps',           # merge /w: config
'cfacts',             # merge /w: config, movestack, fullgaps
'keys',               # merge /w: config

# Disable branch
#'singularborders',
#'noborder',
#'gaps',
#'attachbottom',
]

puts "\n=> Patching All Branch to Master"
for branch in branches do
  print "Patching #{branch}... "
  `git merge #{branch} -m #{branch}`
  print "DONE\n"
end
puts "=> Patching COMPLETE!"

puts "\n=> Installing"
system """
make && sudo make clean install
"""
puts "=> Installation COMPLETE!"
```

Cara penggunannya gampang. Saya akan tuliskan dalam bentuk runutan.

1. Setelah selesai meracik *patch* di dalam masing-masing branch, kembali ke master branch.
2. Jalankan `suckmerge-dwm`
3. Apabila berhasil, restart dwm.
4. Saat ini master branch dalam keadaan kotor, jalankan `suckclean` untuk mereset dan membersihkannya.
5. Untuk mengedit *patch* branch dengan cara `git checkout <nama_branch>`, wajib menjalankan `suckclean` terlebih dahulu.

Apabila terdapat perubahan di dalam branch *patch*, ulangi lagi dari langkah ke dua. Mudah bukan?

**Apakah akan terdapat conflict?**

Jelas! Pasti akan ada kalau kita menggunakan banyak *patch*.

Biasanya kalau terjadi *conflict*, saya selesaikan dengan me-*merge*-kan kedua *patch* branch yang berkonflik, lalu saya selesaikan baris-baris kode yang *conflict* dengan cara manual.

Bisa dilihat, beberapa *patch* branch yang berkonflik pada script **suckmerge-dwm** di atas, saya catat branch apa dan merge dengan branch apa saja.

Nah, berikut ini adalah tangkapan layar dari DWM yang saat ini saya pergunakan.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/8kyg5LVJ/gambar-01.png" onerror="imgError(this);"}
<p class="img-caption">Gambar 1 - RicingShow: DeWayEm Project 2020-05</p>

Repositorinya dapat dilihat [di sini](https://github.com/bandithijo/dwm){:target="_blank"}.

*Bersambung...*





# Referensi

1. [suckless.org/](http://suckless.org/){:target="_blank"}
<br>Diakses tanggal: 2020/04/24

2. [dwm.suckless.org/](https://dwm.suckless.org/){:target="_blank"}
<br>Diakses tanggal: 2020/04/24
