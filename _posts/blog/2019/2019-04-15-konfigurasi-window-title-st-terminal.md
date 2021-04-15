---
layout: 'post'
title: 'Konfigurasi Window Title untuk Simple/Suckless Terminal'
date: 2019-04-15 06:35
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Terminal']
pin:
hot:
contributors: []
description: "Simple Terminal (ST) adalah terminal yang sangat minimalis. Sampai-sampai untuk membuat window title menampilkan isi dari ST, kita perlu mengkonfigurasinya sendiri. Ya, memang beginilah tujuan dari ST. Apabila ada fitur lain yang ingin digunakan, user perlu menambahkan sendiri. Karena kebutuhan masing-masing user dapat berbeda satu dengan yang lain."
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Simple/Suckless Terminal (st) adalah Terminal Emulator yang saat ini menjadi anak kesayangan saya.

Meskipun, masih terdapat beberapa fungsi-fungsi yang belum bisa saya dapatkan pada st namun fungsi-fungsi mendasar dan ketepatan dalam menampilkan warna dan simbol, sudah lebih dari cukup untuk menyelesaikan pekerjaan rumah tangga.

Kisah migrasi, meng-*compile* dan mem-*patching*-nya dapat teman-teman baca pada posting ini, ["St, Simple Terminal yang Sudah Lama Saya Dambakan"]({{ site.url }}/blog/st-simple-terminal-dari-suckless){:target="_blank"}.

# Permasalahan

Saya baru-baru saja menyadari, ternyata terdapat kebutuhan lain lagi dari st yang saya perlukan. Yaitu, "detail" dari Window Title pada st.

Saat ini, Window Title pada st hanya menampilkan tulisan "st" saja. Sedangkan, saya membutuhkan Window Title yang dapat menampilkan detail dari perintah atau program yang sedang berjalan di dalam st.

{% image https://i.postimg.cc/RVVnXhvC/gambar-01.png | 1 | Window Title pada st yang statis, hanya menampilkan details berupa tulisan "st" %}

# Pemecahan Masalah

Langsung saja tanpa bertele-tele. Merujuk dari dokumentasi online yang bersumber dari **faqs.org** mengenai "Xterm Title", pada bagian "*Printing the current job name*" saya menemukan jawabannya.

Dan kebetulan, tertulis pada dokumentasi tersebut, bahwa hal tersebut di atas, lebih mudah dilakukan saat menggunakan Shell bertipe ZSH daripada Shell jenis lain.

Maka dari itu, saya pertegas kembali, <mark><b>Artikel ini hanya untuk pengguna ZSH Shell</b></mark>.

Berikut ini langkah-langkahnya.

Tambahkan baris perintah di bawah ini ke dalam file `~/.zshrc`.

{% highlight_caption $HOME/.zshrc %}
{% highlight shell linenos %}
# Untuk merubah titlebar dari st terminal
# Sumber: http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#s5
case $TERM in
    st*)
    precmd () {
        # menampilkan direktori aktif (kondisi default)
        print -Pn "\e]0;st:%~\a"
    }
    preexec () {
        # menampilkan program yang sedang berjalan
        print -Pn "\e]0;st:$1\a"
    }
    ;;
esac
{% endhighlight %}

Silahkan dimodifikasi sendiri bentuk format dari detail Window Title yang diinginkan.

Selesai.

Coba buka **st** Terminal yang baru dan perhatikan Window Titlenya.

<hr>

Apabila berhasil, akan menampilkan Window Title dengan detail seperti gambar di bawah ini.

{% image https://i.postimg.cc/Kvq3VbYP/gambar-02.png | 2 | Tampilan detail Window Title yang menampilkan direktori aktif (<i>Default</i>) %}

{% image https://i.postimg.cc/jSDnY1WG/gambar-03.png | 3 | Tampilan detail Window Title saat menjalankan program %}



# Pesan Penulis

Catatan ini bukan merupakan tandingan dari dokumentasi resmi yang ditulis oleh pengembang aplikasi di atas. Namun, sebagai catatan pribadi yang saya dokumentasikan untuk bahan pengingat di kemudian hari.

Apabila terdapat kekeliruan penulisan, kegagalan dalam konfigurasi, atau fungsi-fungsi yang lain, silahkan merujuk pada daftar referensi yang sudah saya sertakan di bawah.

Saya kira cukup seperti ini saja.

Terima kasih.


# Referensi

1. [www.faqs.org/docs/Linux-mini/Xterm-Title.html#s5](http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#s5){:target="_blank"}
<br>Diakses tanggal: 2019/04/15
