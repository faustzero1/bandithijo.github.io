---
layout: 'post'
title: 'Generate Random Password menggunakan PWGEN'
date: 2018-03-27
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Security', 'Tips', 'Terminal', 'Tools']
pin:
---

<img class="post-body-img" src="/assets/img/logo/logo_blank_banner.png" data-echo="https://s20.postimg.cc/t810ca5cd/banner_post_00.png" alt="banner">

# Latar Belakang
_Password_ atau dalam bahasa Indonesia disebut kata sandi, merupakan hal yang penting untuk menjaga kerahasiaan sesuatu yang kita simpan di balik _password_ tersebut. Namun _password_ itu sendiri juga merupakan hal yang rahasia. Sebuah kunci rahasia untuk membuka sesuatu yang rahasia. Yang artinya, selain sesuatu yang dilindungin oleh _password_ tersebut harus aman, _password_ itu sendiri pun harus diamankan.

Bisa saya katakan, tidak semua orang sudah menerapkan cara membuat _password_ yang baik. Karena memang bukan perkara yang mudah. Apakah kalian cukup yakin dengan _password_ yang telah kalian buat ?

Sedikit saya akan membahas mengenai pengamanan _password_. Saya bisa mengambil satu contoh, dari [**Google Account Help**](https://support.google.com/accounts/answer/32040?hl=en){:target="_blank"}, di sana dikatakan bahwa,

# Membuat _Password_ yang Kuat

Membuat _password_ yang kuat akan membantu kalian :
1. Menjaga informasi pribadi tetap aman
2. Melindungi email, files, dan konten-konten lain
3. mencegah seseorang membobol akun kalian.

Pada halaman yang berjudul **Create a strong password** tersebut juga tertulis langkah-langkah untuk mengamankan _password_. Dibagi dalam 3 langkah.

<br>
**Langkah 1, Penuhi persyaratan pembuatan _password_**

Buatlah _password_ kalian dengan menggunakan **minimal 8 karakter** atau lebih. Bisa menggunakan kombinasi huruf, angka, atau simbol.

1. Sebaiknya hindari penggunaan _password_ yang sama untuk digunakan oleh banyak akun yang lain
2. Hindari pula menggunakan _password_ yang kalian pernah gunakan sebelumnya

<br>
**Langkah 2, Ikuti Saran untuk Membuat _Password_**

_Password_ yang kuat hampir tidak mungkin dapat ditebak oleh orang lain. Untuk itu, kalian dapat menggunakan kiat-kiat di bawah ini dalam membuat _password_.

1. Gunakan huruf, angka, dan simbol
2. Hindari menggunakan informasi pribadi dan kata-kata yang sudah umum
3. Jangan menggunakan kembali _password_ yang sudah pernah digunakan sebelumnya

<br>
**Langkah 3, Menjaga Keamanan _Password_**

Setelah kalian membuat _password_ yang kuat, selanjutnya kalian perlu mengamankannya.

1. Jangan tampilkan _password_ kalian
2. Gunakan alat bantu untuk mengelola _password_ kalian

<br>
**Plan B**

Buat rencana cadangan apabila kalian lupa dengan _password_ yang telah kalian buat. Namun hati-hati jangan sampai malah orang yang tidak berhak dapat memanfaatkan kelemahan yang kalian buat pada rencana cadangan kalian ini.

# Alat Bantu _Generate Password_
Pada dokumentasi ini saya akan membahas salah satu alat bantu yang saya gunakan untuk membuat _password_ yang sangat _random_.

## Pwgen
Dari manual yang ditulis, pwgen dirancang untuk menghasilkan _password_ yang mudah diingaat oleh manusia namun tetap seaman mungkin.

### Instalasi
Untuk distribusi Arch Linux
```
$ sudo pacman -S pwgen
```

Untuk distribusi sistem operasi yang lain, dapat menyesuaikan dan mencari paket yang bernama `pwgen`.

### Melihat Help
Kita perlu mengetahui opsi apa saja yang disediakan oleh pwgen sebelum kita dapat mengenerate _password_. _Help_ dari pwgen ini sangat sederhana dan mudah dipahami.
```
$ pwgen -h
```
```
Usage: pwgen [ OPTIONS ] [ pw_length ] [ num_pw ]

Options supported by pwgen:
  -c or --capitalize
	Include at least one capital letter in the password
  -A or --no-capitalize
	Don't include capital letters in the password
  -n or --numerals
	Include at least one number in the password
  -0 or --no-numerals
	Don't include numbers in the password
  -y or --symbols
	Include at least one special symbol in the password
  -r <chars> or --remove-chars=<chars>
	Remove characters from the set of characters to generate passwords
  -s or --secure
	Generate completely random passwords
  -B or --ambiguous
	Don't include ambiguous characters in the password
  -h or --help
	Print a help message
  -H or --sha1=path/to/file[#seed]
	Use sha1 hash of given file as a (not so) random generator
  -C
	Print the generated passwords in columns
  -1
	Don't print the generated passwords in columns
  -v or --no-vowels
	Do not use any vowels so as to avoid accidental nasty words
```

### Penggunaan
Seperti yang kalian lihat, pwgen menyediakan banyak sekali opsi untuk kita dapat meracik _password_. Kalian dapat memilih _preferensi_ opsi yang kalian perlukan. Saya biasa menggunakan opsi `-sy` dengan panjang karakter sebanyak 15.

`-s` : untuk mengacak _password_ yang benar-benar _random_.

`-y` : untuk menambahkan setidaknya satu simbol spesial di dalam _password_.

Hasilnya akan seperti ini.
```
$ pwgen -sy 15
```
```
I##3DKHZCA\[S:w (3::;s2P1!ABm7' !WS2LL)Jp[/].ob !1Z%K/E=Rt?1-TC /_,p}73!k|h&pDS
BmP:Xq#5P[(]BdW "%V1HoH?iR8V#PW wQTJXe6?Xe9$3H- *9{DLU3e-'!~shx I>@{`,[h]R)?h2\
t["(>OQ`h&hBE0} -Na"0+qOu\{Iotx /}a^x{!o@x{X#\3 8e\zd3[$VM^Hw}! ERGHx?3^60OidVu
rW9bg8P(D(4.dx} k|v':YaEr]9f/OR xc1gUf$A)FBX|JS 5zw7HZ6P/uD#:Eo %Q~o7'n(NGmH0&H
d9%e:zUeURz[(9Z Lm~3R2-U2gC.BLd `'Xy5e(k(gg'z,m kW\5NXROyg-Y14s ).I.Oh0AH3Bn\nB
W}w<CD8C{tQ;ea& EbLhVQtdtX8A[e# :ZROZ0)9kppC`|E {CQu")i!A[H}HA3 W"'IAX9L,3VH;IM
%3h)aG`SoG71h}> a.h-Ys>ii5=FUd( =&Lq(PPP]9?::3L $3eJZeig{ua2^u% W_E^gD;#":[S'9p
Wlj}?aNON;ZIK5R `b',vAOJ?2!mfgK *^z1yVhVS~[&2$B Me/WJy8f:o*0_?7 0s|Z1IggAKqpTC6
YPv@97Q1`3!~J8m =X9d0E;1\;p.)*4 @ytPu:jQ'8MN)9% }S4D._TbfN:@UY, dZ>_`8Gi*hWOaIX
60r,^r~xn>Cb3W( tdyxgF6])rIjTr\ Xx}+9B}8Xa-Bp:H Fq=~sT2svWr/O9q F:-7]'EOmtfB_ia
Si6Y*)ci$f;(Wwh kw{#"3iTR\Bxm,~ r&u-(,&@~6qDP.$ pU:>_S3]N'b(v16 l0;K0}.&YuCv/%S
k%Zm3Z'Wa7Nt~7J N>f4mhc1#]EDIil 9tcF~uE6stt]D.. /8}ZfUiu6xc@y4B &O-*_G8PY9Af$q>
)rNYOqh[k`74z^> c4iJlJ%\Klh;v0k 9Aoest6Z%^iIN?I R@}`3JW9Bfro+uU jD1J/w4"F$9[P\2
onhsS}cBLMD_5]+ 1Y7-%LMi#*wp;\k %_Zn5@.;B61Z3Zp j/L)nooB_Q+1s." QQ1cv1B=e@ZGVU=
3`[liL7D@4rkiLS 1g2Mw|RIdG!vf4\ Ewk,nH0L2Zx.QkM .S+B72!>ak*fFN% n{kh6]KwVu"z3jX
)7'QWW@qf:I)v&o 7.Y?'#lBzV\A;[k I{CkA;iM*eiH7+T 7e8W(|h*:a/60?k jj/=yg1]*/`xZtd
n!H{q@}[!+zgz4K 8ZBC6cPK2rLW|G5 L-,<@:<if8A,@YE L7!\Z5j'DnL6(Lx 4SByt!1=:S44?XG
?HU\LF)9W1nZ@&] /('fY@SX>bT#gn4 Mh%M]j'HFtY&3[h A@iB*9:$.X@eA&/ yX}n/,)q#0f/$cE
ip0|bE+&\S`-XvA fv8eRE>@.BVd/v) 09TFUyqyFnHqZH/ Y>`u*O^2WfHd"[7 XPus5[&mEb0y3Oz
[~qzByf#|/K4=g~ Lx@KlJ1&L4\5vKH lvjHx>\vq[r4WHl -GiVZ#Yio-c$8US OKFn"3QQ^L$jr(T
```

Kemudian, saya akan pilih satu dari 100 _random password_ yang sudah berhasil di _generate_. Setelah itu saya akan simpan pada alat yang saya khususkan untuk menyimpan _password_. Untuk pembahasan alat apa yang saya gunakan untuk menyimpan _password_ ([_Password Manager_](https://wiki.archlinux.org/index.php/List_of_applications/Security#Password_managers){:target="_blank"}) akan saya bahas pada dokumentasi yang lain.

# Referensi
1. [support.google.com/accounts/answer/32040?hl=en](https://support.google.com/accounts/answer/32040?hl=en){:target="_blank"}
<br>Diakses tanggal: 2018/03/27

2. [wiki.archlinux.org/index.php/Security](https://wiki.archlinux.org/index.php/Security){:target="_blank"}
<br>Diakses tanggal: 2018/03/27
