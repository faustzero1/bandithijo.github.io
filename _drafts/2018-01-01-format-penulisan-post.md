---
layout: 'post'
title: 'Format Penulisan Post'
date: 2018-01-01 00:00
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags:
# Android, Arch Linux, BSPWM, Database, Django, Dwm, FreeBSD, I3WM, Java, Javascript,
# Jekyll, jQuery, Network, Python, Rails, Ruby, Script, Security, Terminal, ThinkPad,
# Tips, Tools, Ulasan, Vim, Wine, XFCE
pin:
hot:
contributors: []
---

# REREFENSI
1. [kramdown.gettalong.org/syntax.html](https://kramdown.gettalong.org/syntax.html){:target="_blank}

# COMMENT ON MARKDOWN
<!-- SINGLE COMMENT -->
[comment]: # (PERBAIKI BAGIAN INI)

<!-- MULTILINE COMMENT -->
{::comment}
Ini adalah
contoh dari
multi line
comment
{:/}

# OUTDATED POST
<!-- OUTDATED POST -->
<p class="notif-post" style="margin-bottom: -20px;">Post ini sudah tidak up to date !</p>

# BANNER OF THE POST
<!-- BANNER OF THE POST -->
<img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="#" onerror="imgError(this);" alt="banner">

# BLOCKQUOTE

<!-- QUOTE BIASA -->
>Saya sendiri, menggunakan LightDM untuk login kedalam i3wm, dan saya tidak mengatur option fingerprint scanner untuk login ke dalam sistem.

<!-- PERHATIAN -->
<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
Saya tidak dapat menyediakan link untuk mendownload Cisco Packet Tracer versi terbaru. Karena netacad hanya diperuntukkan bagi yang memiliki akses ke dalam NetAcad. Silahkan melakukan download dengan account NetAcad masing-masing yaa. <a href="http://netacad.com/">NetAcad.com</a>
</div>

<!-- INFORMATION -->
<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
Kabar gembira! Bagi teman-teman yang belum mempunyai akun netacad untuk mendownload Cisco Packet Tracer, dapat terlebih dahulu membaca instruksi yang diberikan oleh mas <b>fathurhoho</b> pada tautan berikut ini >> <a href="https://ngonfig.net/akun-netacad.html"><b>Cara Mendaftar Akun Netacad</b></a>
</div>

<!-- PERTANYAAN -->
<div class="blockquote-yellow">
<div class="blockquote-yellow-title">Apakah ?</div>
Kabar gembira! Bagi teman-teman yang belum mempunyai akun netacad untuk mendownload Cisco Packet Tracer, dapat terlebih dahulu membaca instruksi yang diberikan oleh mas <b>fathurhoho</b> pada tautan berikut ini >> <a href="https://ngonfig.net/akun-netacad.html"><b>Cara Mendaftar Akun Netacad</b></a>
</div>

# SUPERSUP FOR REFERENSI
<!-- SUPERSUP -->
<sup>[2]({{ site.url }}/blog/custom-bios-logo-thinkpad#referensi)</sup>

# IMAGE CAPTION
<!-- IMAGE CAPTION -->
![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 1 - Settings > Details > Users</p>

# LIST CHECKBOX
<!-- LIST CHECKBOX -->
<ul class="chkbox">
<li class="chkbox-checked">Melihat layar <i>smartphone</i> langsung dari laptop dan dapat berinteraksi, seperti menggerak-gerakkan menu dan mengetik</li>
<li>Terhubung dengan WiFi tanpa perlu kabel data</li>
</ul>

# EMBED VIDEO YOUTUBE
<!-- EMBED CONTAINER: YOUTUBE -->
{% youtube ID_YOUTUBE %}

# FOOTNOTE REFERENCES
Adipisicing quia numquam id quisquam soluta. Repudiandae quae at amet a voluptatum, tempore, tempora Ut nemo quo laboriosam architecto commodi cum Sunt neque non consequatur magni distinctio! Animi impedit obcaecati.[^1]
[^1]: [suckless](https://suckless.org){:target="_blank"}

# MULTIPLE POST CONTROLER
<!-- NEXT PREV BUTTON -->
<div class="post-nav">
<a class="btn-blue-l disabled" href="#"><img style="width:20px;" src="/assets/img/logo/logo_ap.png"></a>
<a class="btn-blue-c" href="/arch/"><img style="width:20px;" src="/assets/img/logo/logo_menu.svg"></a>
<a class="btn-blue-r" href="/arch/step-1-connecting-to-the-internet"><img style="width:20px;" src="/assets/img/logo/logo_an.png"></a>
</div>

# KEYBOARD
<!-- KEYBOARD -->
<kbd>SPACE</kbd> + <kbd>ALT</kbd>

# CODE IN P
<!-- CODE in P -->
`single line code`

# CODE IN MULTILINE
<!-- CODE MULTILINE -->
```
multi line code
```

<!-- CODE MULTILINE -->
{% highlight python %}
x = ('a', 1, False)
{% endhighlight %}

# RAW CODE MULTILINE
<!-- LIQUID CODE MULTILINE -->
{% raw %}
```
{% if user %}
  Hello {{ user.name }}!
{% endif %}
```
{% endraw %}

# STABILO
Ini adalah contoh <span class="stabilo">kalimat yang di stabilo</span>.

atau <mark>ini juga bisa, lebih praktis</mark>.

# STRIKE
~~Ini adalah contoh artikel yang dicoret~~

<s>Ini juga contoh artikel yang dicoret menggunakan tag html5 s</s>

<del>Ini juga contoh artikel yang dicoret menggunakan tag html5 del</del>

# NO BREAK ELEMENT
<span class="nobr">Mas Bro !</span>

# DAFTAR ISI
<!-- REFERENCES -->
1. [https://wiki.archlinux.org/](https://wiki.archlinux.org/){:target="_blank"}
<br>Diakses tanggal: 2018/01/18
2. [https://bbs.archlinux.org/](https://bbs.archlinux.org/){:target="_blank"}
<br>Diakses tanggal: 2018/01/18


<link rel="icon" type="image/png" href="/assets/img/favicon/favicon.png">

# TABEL

| No | Header 1 | Header 2 | <center>Header 3</center> | Header 4 | <center>Header 5</center> |
| :--: | :--: | :--: | :-- | :--: | :-- |
| 1 | Data | Data | Data | Data | `data.service` |
| 2 | Data | Data | Data | Data | `data` |
| 3 | Data | Data | Data | Data | `data.service` |
| 4 | Data | Data | Data | Data | `data.service` |
| 5 | Data | Data | Data | Data | `data.service` |

<p class="img-caption" style="text-align:left;">Sumber: <a href="" target="_blank">Arch Wiki</a></p>

[Full arrow references](https://www.w3schools.com/charsets/ref_utf_arrows.asp){:target="_blank"}
<br>
[Full symbol references](https://www.w3schools.com/charsets/ref_utf_symbols.asp){:target="_blank"}
