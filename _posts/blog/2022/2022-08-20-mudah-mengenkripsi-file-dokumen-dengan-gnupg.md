---
layout: 'post'
title: "Mudah Mengenkripsi File dan Dokumen dengan GnuPG (GPG)"
date: 2022-08-20 06:46
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Security']
pin:
hot:
contributors: []
description: "GnuPG adalah implementasi dari OpenPGP Standard (PGP) yang juga dikenal dengan nama GPG, yang dapat kita gunakan untuk melakukan enkripsi dan menandatangani data. Kita akan menggunakan GnuPG untuk mengenkripsi file atau dokumen."
---

# Pendahuluan

{{ page.description }}

# Tujuan

Kenapa kita perlu mengenkripsi file atau dokumen?

1. Memberikan pengamanan ganda terhadap file atau dokumen yang kita simpan di laptop atau komputer kita. Misal: file-file kantor yang bersifat rahasia
1. Mengamankan file atau dokumen yang akan didistribusikan ke orang lain. Misal: via email, flashdrive atu WA/Telegram
1. dst.

# Penggunaan

Penggunaan dari GPG sangat kompleks sekali. Di catatan kali ini, saya hanya akan menunjukkan beberapa perintah-perintah yang sering saya pergunakan.

## Tentukan target file yang akan dienkripsi

Target file bisa apa saja, misal: gambar, video, file dari Miscrosoft Word, archive (zip, tar, dst.), dll.

Sebagai contoh file atau dokumen yang akan saya enkripsi adalah sebuah file bertipe plain text dengan ekstension Markdown.

{% highlight_caption tabel_users.md %}
{% highlight markdown linenos %}
| id  | email                                | password                           |
|-----|--------------------------------------|------------------------------------|
| 1   | kyle_kunde@predovic-gorczany.com     | mjvfPFh9E1WCUMPY2H5uLNRxvw42MdJRSH |
| 2   | dorene_berge@bogisich.info           | mhRudkNp1QyM3bpqxCq3tJzKVuQJHcsLZT |
| 3   | kimberlie@mueller.info               | mxiHi8kUAvrt2c4HsCcR5diZnBy26wHnzg |
| 4   | royce.marks@bauch.com                | msk7nRPFfckdpxePKurzXNCPNUtkej5pnn |
| 5   | billie@armstrong.net                 | msGDzgvmyqY1UqybAB4ujv595qRNEWi16D |
| 6   | gina@reynolds-klein.org              | mmGKEBk99QwgcdCwuUjtHzJYXESF96uRNP |
| 7   | shon.batz@kiehn.name                 | mut88wKf8GhKoijTLAXkoVNgUTscark4Uu |
| 8   | minh@lubowitz-walsh.io               | mx8Qort7MR4RrjNfCsY4dnu9meQrSB6ChF |
| 9   | jonah@reinger.io                     | mjoFeZ7BUrhiwF4PkcrqfUT1CUBJbSonBw |
| 10  | trey_zemlak@wisozk.info              | mg99BBN2Y6S7YCsVa8wDK6yqZNEKvjwTUq |
{% endhighlight %}

Setelah menentukan target file, kita lanjut ke tahap enkripsi.

## Enkripsi

Ada banyak sekali cara metode enkripsi yang dapat kita lakukan dengan gpg.

Di catatan ini saya membatasi hanya menulis cara yang sering saya gunakan saja.

Untuk metode-metode lain, teman-teman dapat membaca sendiri di `man gpg`.

### Enkripsi dengan default secret GPG key

Syarat: Kita sudah memiliki default secret gpg key.

Artinya bentuk enkripsi ini hanya dapat dibuka oleh orang yang memiliki signature dari gpg key tersebut. Yang berarti saya sendiri.

Cara mengetahuinya.

{% shell_user %}
gpg --list-secret-keys
{% endshell_user %}

```
sec   rsa4096 2022-08-20 [SC]
      AE706A616B252A6822635041560691E942A02F91
uid           [ultimate] Rizqi Nur Assyaufi <bandithijo@gmail.com>
uid           [ultimate] Rizqi Nur Assyaufi <rizqiassyaufi@gmail.com>
uid           [ultimate] Rizqi Nur Assyaufi <rizqinurassyaufi@gmail.com>
ssb   rsa4096 2022-08-20 [E]
```

Saya memiliki 1 buah gpg key.

Nah, kita bisa langsung mengenkripsi file dengan menandatanganinya (*sign*) dengan gpg secret key yang kita miliki.

{% shell_user %}
gpg --sign tabel_users.md
{% endshell_user %}

Outputnya akan berupa file `tabel_users.md.gpg`.

<pre>
tabel_users.md <mark>tabel_users.md.gpg</mark>
</pre>

### Enkripsi dengan symmetric key

Ketika membuat gpg key, kita akan membuat 2 kunci, public key & secret key. Inilah yang disebut assymmetric key, karena key yang digunakan untuk menguncinya tidak sama dengan kunci yang digunakan untuk membuka.

Namun, kita tetap bisa mengunci file secara symmetric dengan gpg.

{% shell_user %}
gpg --symmetric tabel_users.md
{% endshell_user %}

Setelah itu, kita akan diminta memasukkan password sebanyak 2x.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/0jhyjs0t/gambar-01.png" onerror="imgerror(this);"}{:class="myImg"}

Outputnya akan berupa file `tabel_users.md.gpg`.

<pre>
tabel_users.md <mark>tabel_users.md.gpg</mark>
</pre>

### Enkripsi dengan gpg public key si penerima

Metode enkripsi ini saya gunakan untuk berkirim file kepada orang yang gpg public key nya saya simpan.

Misal, saya ingin berkirim file yang terenkripsi kepada om Linus Torvalds. Kebetulan saya punya gpg public key om Linus.

{% shell_user %}
gpg --list-key torvalds@linux-foundation.org
{% endshell_user %}

```
pub   rsa2048 2011-09-20 [SC]
      ABAF11C65A2970B130ABE3C479BE3E4300411886
uid           [ unknown] Linus Torvalds <torvalds@kernel.org>
uid           [ unknown] Linus Torvalds <torvalds@linux-foundation.org>
sub   rsa2048 2011-09-20 [E]
```

Oke, tinggal kita enkripsi file nya dengan gpg public key punya om Linus.

{% shell_user %}
gpg --encrypt --recipient torvalds@linux-foundation.org tabel_users.md
{% endshell_user %}

```
gpg: 88BCE80F012F54CA: There is no assurance this key belongs to the named user

sub  rsa2048/88BCE80F012F54CA 2011-09-20 Linus Torvalds <torvalds@linux-foundation.org>
 Primary key fingerprint: ABAF 11C6 5A29 70B1 30AB  E3C4 79BE 3E43 0041 1886
      Subkey fingerprint: AEE4 16F7 DCCB 753B B3D5  609D 88BC E80F 012F 54CA

It is NOT certain that the key belongs to the person named
in the user ID.  If you *really* know what you are doing,
you may answer the next question with yes.

Use this key anyway? (y/N) y
```

Outputnya akan menjadi file `tabel_users.md.gpg`.

<pre>
tabel_users.md  <mark>tabel_users.md.gpg</mark>
</pre>

Nah, sudah jadi. Tinggal dikirim ke om Linus.

Hanya om Linus yang dapat membuka file terenkripsi tersebut dengan gpg secret key milik om Linus, karena file tersebut dienkripsi dengan gpg public key miliknya.


## Dekripsi

Cara untuk mendekrip file atau dokumen yang dienkripsi dengan gpg, biasanya, saya menggunakan 2 flow.

### Mengintip isi file yang terenkripsi dengan less

{% shell_user %}
gpg --decrypt tabel_users.md.gpg | less
{% endshell_user %}

### Membuka file yang terenkripsi dalam bentuk file

{% shell_user %}
gpg --output tabel_users.md --decrypt tabel_users.md.gpg
{% endshell_user %}

# Tips & Trick

## Mudah mengintip file terenkripsi dari Ranger

Tambahkan baris di bawah ini pada salah satu file configurasi ranger `~/.config/ranger/rifle.conf`.

{% highlight_caption ~/.config/ranger/rifle.conf %}
{% highlight conf linenos %}
# gnupg
ext gpg, has gpg = gpg --decrypt "$1" | less
{% endhighlight %}

Arti dari baris di atas:

1. Untuk file dengan extension `.gpg`
1. Apabila sudah terpasang GnuPG dengan command `gpg`
1. Execute file terpilih dengan command `gpg --decrypt "$1" | less`
1. Dimana `$1` adalah file yang terseleksi

<br>
Saya menggunakan `less` untuk mengintip file terenkripsi tersebut.


# Pesan Penulis

Penggunaan lebih lanjut saya serahkan pada imajinasi dan kreatifitas teman-teman.

Terima kasih sudah mampir yaa.

<br>
Saya juga pernah menulis terkait GnuPG di catatan sebelumnya.

1. [Memperbaiki GPG: Warning: Unsafe Permissions on Homedir](/blog/memperbaiki-gpg-permissions-on-homedir){:target="_blank"}
1. [Generate Private dan Public GPG Key Sendiri](/blog/generate-gpg-key){:target="_blank"}
1. [Menambahkan Email Kedua ke dalam GPG Key](/blog/menambahkan-email-lain-kedalam-gpgkey){:target="_blank"}

# Referensi

1. [https://www.gnupg.org/](https://www.gnupg.org/){:target="_blank"}
<br>Diakses tanggal: 2022/08/20

1. [https://www.gnupg.org/gph/en/manual/x110.html](https://www.gnupg.org/gph/en/manual/x110.html){:target="_blank"}
<br>Diakses tanggal: 2022/08/20
