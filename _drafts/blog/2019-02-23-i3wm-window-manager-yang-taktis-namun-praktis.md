---
layout: 'post'
title: 'i3WM, Window Manager yang Taktis namun Praktis'
date: 2019-02-23 22:11
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['I3WM', 'Ulasan', 'Tips']
pin:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Setelah setahun lebih menggunakan **i3** Window Manager (selanjutnya akan saya sebut sebagai i3wm), saya merasa sudah waktunya untuk membagikan pengalaman dalam menggunakan Window Manager yang sekaligus merupakan Window Manager pertama yang saya gunakan sehari-hari.

Berdasarkan daftar log video pada [bandithijo.com/vlog]({{ site.url }}/vlog/){:target="_blank"}, saya menggunakan i3wm pada 30 Oktober 2017.

Saya merasa perlu untuk membuat catatan mengenai apa saja yang sudah saya manfaatkan dan pergunakan dengan i3wm. Mungkin dari catatan ini, teman-teman yang membaca mendapatkan informasi yang subjektif dari sudut pandang saya sebagai pengguna. Jujur saja, saya pun sangat menyukai tulisan-tulisan yang mengulas tentang suatu teknologi dari sudut pandang pengguna.

# Mengapa Menggunakan Window Manager?

Buat temen-temen yang belum mengetahui apa itu Window Manager. Window Manager adalah bagian dari Desktop Environment.

Saya akan coba jelaskan dengan menggunakan tabel, *insya Allah* dapat langsung dipahami dengan mudah.

| <center>Desktop Environment</center> | <center>Window Manager</center> |
| --: | :-- |
| GNOME2 | [Metacity](https://www.archlinux.org/packages/community/x86_64/metacity/){:target="_blank"} |
| GNOME3 | [Mutter](https://www.archlinux.org/packages/extra/x86_64/mutter/){:target="_blank"} |
| KDE Plasma | [KWin](https://www.archlinux.org/packages/extra/x86_64/kwin/){:target="_blank"} |
| Cinnamon | [Muffin](https://www.archlinux.org/packages/community/x86_64/muffin/){:target="_blank"} |
| Pantheon | [Gala](https://aur.archlinux.org/packages/gala/){:target="_blank"} |
| Deepin | [Deepin-Mutter](https://www.archlinux.org/packages/community/x86_64/deepin-mutter/){:target="_blank"} |
| XFCE | [xfwm4](https://www.archlinux.org/packages/extra/x86_64/xfwm4/){:target="_blank"} |
| LXDE | [Openbox](https://www.archlinux.org/packages/community/x86_64/openbox/){:target="_blank"} |
| dst... | dst...|

Karena saya sebutkan tadi, Window Manager ini adalah komponen, maka beberapa dari Desktop Environment tersebut ada yang mengijinkan user untuk mengganti Window Manager *default* yang sudah disertakan bersama Desktop Environment. Asik bukan?

Terdapat banyak sekali Window Manager yang dapat kita gunakan, tanpa harus menggunakan Desktop Environment.

Window Manager secara umum, terbagi dalam 3 tipe.

1. **Stacking**, atau *Floating* adalah Window Manager yang seperti Desktop Environment gunakan, yaitu dengan Window yang melayang dan dapat bertumpuk-tumpuk.
2. **Tiling**, adalah Window Manager yang tidak menumpuk Window antara satu dengan yang lain, dan tersusun kotak-kotak seperti lantai (*tile*).
3. **Dynamic**, adalah Window Manager yang dapat berganti-ganti diantara kedua tipe di atas menyesuaikan dengan kebutuhan user.

Berikut ini adalah tabel dari Window Manager yang akan memberikan gambaran bahwa GNU/Linux tidak hanya GNOME dan KDE.

| <center>Stacking</center> | <center>Tiling</center> | <center>Dynamic</center> |
| -- | -- | -- |
| 2bwm | Bspwm | awesome |
| aewm | EXWM | catwm |
| AfterStep | Herbstluftwm | dwm |
| BlackBox | howm | echinus |
| Compiz | i3 | FrankenWM |
| cwm | Ion3 | spectrwm |
| eggwm | Notion | Qtile |
| Enlightenment | Ratpoison | wmii |
| evilwm | Stumpwm | xmonad |
| Fluxbox | subtle |
| Flwm | sway |
| FVWM | way-cooler |
| Gala | WMFS |
| Goomwwm | WMFS2 |
| IceWM |
| jbwm |
| JWM |
| Karmen |
| KWin |
| lwm |
| Marco |
| Metacity |
| Muffin |
| Mutter |
| MWM |
| Openbox |
| pawm |
| PekWM |
| Sawfish |
| TinyWM |
| twm |
| UWM |
| Wind |
| WindowLab |
| Window Maker |
| WM2 |
| Xfwm |

Untuk detail dari masing-masing Window Manager tersebut dapat teman-teman lihat pada Arch Wiki, [di sini](https://wiki.archlinux.org/index.php/Window_manager){:target="_blank"}.

Ada begitu banyak Window Manager, bukan?

i3wm, yang saya gunakan termasuk ke dalam jajaran *Tiling* Window Manager. Meskipun sebenarnya i3wm juga dapat berganti-ganti *layout* menjadi *tiling*, *stacking*, *tabbed*, bahkan *scratchpad*.

**Jadi, mengapa saya menggunakan Window Manager?**

Berdasarkan data-data di atas,

1. Saya ingin mencoba memasuki dunia selain Desktop Environment. Dunia berbeda yang ternyata sangat luas sekali. Meskipun tidak mungkin saya cicipi semuanya.
2. Bnyak fitur-fitur yang terdapat di dalam Desktop Environment yang sebenarnya tidak saya perlukan.
3. Kebebasan memilih komponen-komponen aplikasi pendukung sistem operasi yang menurut saya lebih baik dari aplikasi pendukung bawaan Desktop Environment.



# Referensi

1. [wiki.archlinux.org/index.php/Window_manager](https://wiki.archlinux.org/index.php/Window_manager){:target="_blank"}
<br>Diakses tanggal: 2019/02/23

2. [wiki.archlinux.org/index.php/Desktop_environment](https://wiki.archlinux.org/index.php/Desktop_environment){:target="_blank"}
<br>Diakses tanggal: 2019/02/23

3. [](){:target="_blank"}
<br>Diakses tanggal: 2019/02/23

