---
layout: 'post'
title: 'Generate Private dan Public GPG Key Sendiri'
date: 2018-12-09 07:43
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Security', 'Tips']
pin:
hot:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="" alt="banner"> -->

# Prakata

Pada tulisan sebelumnya, saya pernah mendokumentasikan tentang ["Memperbaiki GPG: Warning: Unsafe Permissions on Homedir"](https://bandithijo.com/blog/memperbaiki-gpg-permissions-on-homedir){:target="_blank"}. Kali ini, saya akan mendokumentasikan bagaimana cara membuat atau mengenerate GPG key milik kita sendiri.

**Gunanya buat apa sih GPG key?**

Pemanfaatannya sangat beragam, misal ingin mengunci sebuah file atau direktori, menandatangai sebuah berkas, dapat juga digunakan untuk authentikasi login, seperti login saat akan melakukan commit ke git repository (GitHub atau GitLab). Hal-hal tersebut adalah contoh yang biasa saya manfaatkan. Entah, mungkin masih banyak kegunaan lain yang saya belum memahaminya, mungkin teman-teman lebih paham dan dapat mencari sendiri.

Nah, jika kamu belum memiliki GPG key sendiri, mungkin catatan ini dapat membantu kamu membuatnya.

# Mengenerate GPG Key

1. Instal `gnupg` - sesuaikan dengan distribusi GNU/Linux kalian.
    ```
    $ sudo pacman -S gnupg
    ```
2. Selanjutnya , generate private/public key pair dengan perintah berikut.
    ```
    $ gpg --full-gen-key
    ```
Kita akan disuguhkan bebreapa pertanyaan.
3. Pertanyaan pertama mengenai algroitma apa yang akan digunakan (_default_ RSA and RSA).
    ```
    Please select what kind of key you want:
        (1) RSA and RSA (default)
        (2) DSA and Elgamal
        (3) DSA (sign only)
        (4) RSA (sign only)
    Your selection? 1
    ```
4. Pertanyaan selanjutnya mengenai panjang dari kunci. Saya merekomendasikan untuk mengisikan dengan value tertinggi, yaitu `4096`.
    ```
    RSA keys may be between 1024 and 4096 bits long.
    What keysize do you want? (2048) 4096
    Requested keysize is 4096 bits
    ```
5. Pertanyaan selanjutnya mengenai sampai kapan private/public key pair ini bertahan. Pertanyaan ini bersifat subjektif. Apabila kamu orang yang rajin, silahkan menentukan kapan kunci gpg anda akan _expired_, namun buat kalian yang malas seperti saya, kita gunakan saja default, yaiut `0`.
    ```
    Please specify how long the key should be valid.
        0 = key does not expire
        <n>  = key expires in n days
        <n>w = key expires in n weeks
        <n>m = key expires in n months
        <n>y = key expires in n years
    Key is valid for? (0) 0
    Key does not expire at all
    ```
6. Pertanyaan selanjutnya mengenai mengkonfirmasi apakah semua informasi yang kita masukkan sebelumnya sudah sesuai atau belum. Jawab `y`.
    ```
    Is this correct? (y/N) y
    ```
7. Pertanyaan selanjutnya, gnupg akan membangun user ID dan identitas dari kunci kalian.
    ```
    GnuPG needs to construct a user ID to identify your key.

    Real name: Baba Asyong

    Email address: basyong@kontrakan.com
    Comment:

    You selected this USER-ID:
        "Baba Asyong <basyong@kontrakan.com>"

    Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O
    ```
8. Selanjutnya, kita diminta memasukkan **STRONG PASSWORD**.
    ```
    We need to generate a lot of random bytes. It is a good idea to perform
    some other action (type on the keyboard, move the mouse, utilize the
    disks) during the prime generation; this gives the random number
    generator a better chance to gain enough entropy.
    ```
9. Setelah memasukkan passwod dan konfirmasi password akan keluar *output* berikut ini.
    ```
    gpg: key 1F3C927C841F10DD marked as ultimately trusted
    gpg: revocation certificate stored as '/home/bandithijo/.gnupg/openpgp-revocs.d/46AA8ADA995B2ABD2C3CE4641F3C927C841F10DD.rev'
    public and secret key created and signed.

    pub   rsa4096 2018-12-09 [SC]
          46AA8ADA995B2ABD2C3CE4641F3C927C841F10DD
    uid                      Baba Hasyong <basyong@kontrakan.com>
    sub   rsa4096 2018-12-09 [E]
    ```
Selesai.

Dikemudian hari, apabila ingin melihat GPG Key ID yang sudah kita buat, dapat menggunakan perintah di bawah.
```
$ gpg --list-secret-keys --keyid-format LONG basyong@kontrakan.com
```
```
sec   rsa4096/1F3C927C841F10DD 2018-12-09 [SC]
      46AA8ADA995B2ABD2C3CE4641F3C927C841F10DD
uid                 [ultimate] Baba Hasyong <basyong@kontrakan.com>
ssb   rsa4096/0A35BAC39862C23B 2018-12-09 [E]
```
Ganti `basyong@kontrakan.com` dengan email yang kalian isikan untuk identitas dari gpg key.

# Mengeksport Public Key

Salah satu kegunannya seperti, apabila terdapat aplikasi seperti GitLab atau GitHub, dan lain sebagainya yang membutuhkan gpg public key kita, maka kita perlu melakukan export dari gpg public key yang kita miliki.

Caranya sangat mudah.

1. Untuk melihat gpg public key yang kita miliki.
    ```
    $ gpg --list-secret-keys --keyid-format LONG basyong@kontrakan.com
    ```
    ```
    sec   rsa4096/1F3C927C841F10DD 2018-12-09 [SC]
          46AA8ADA995B2ABD2C3CE4641F3C927C841F10DD
    uid                 [ultimate] Baba Hasyong <basyong@kontrakan.com>
    ssb   rsa4096/0A35BAC39862C23B 2018-12-09 [E]
    ```
2. Kemudian, pada bagian `sec`, ambil ID dari key kita. `1F3C927C841F10DD` dan masukkan ke dalam perintah berikut ini.
    ```
    $ gpg --armor --export 1F3C927C841F10DD
    ```
    ```
    -----BEGIN PGP PUBLIC KEY BLOCK-----

    mQINBFwM9hQBEACrZsDcTkCavQFKwqdSfv9rcCRU9ql5cnIEW2HY2dwYRfBDPy9y
    9d9n/5TP3wpmlGaeVU9ljhGPh6exYK1Yz8zrPmOcJVE0h9ZWYY4rTS46OrlXF5Wn
    8/tJRctrm3OPuwMN2FQuVAfDYRzfQgbNr9+Pz6U9NOMpMTs70w65gDrYpMfxGQYi
    8Bnwsc8BuDAsY9m4wMzl9KhJHsZ/CMvdX3oFG4GEX5SPuBrNc1PZa9AOKGrzt2NP
    0mrLWNQYnnxYYH8BjgoTqxZ3WQpffnFTLcihQnX3BfL5GrA2RrrU6f7h2YPuMz5W

    ========================= dipotong =============================

    qlpL20bND258qGW6htQ0aHKLUIBpaL7fXU5RdMJmD1/W4/EkYPgvdqwhEE16Axmu
    BcbDWOnX9NGg9Y6pJbG/oWZ9DkJ8f2Oi8bj7p6tPLlsh1AOcqpbnGohA9CQKOZkW
    QiJY/xPeHS5qo433FBu5NaAUZ6IYcC6FFqpKGXZhKYRlYa9Z/pQl4Ic2tQxP94r/
    CVfyDFSzVyBVpfodkPgVyzJk9tnTTSGbeFMIVf6PJaLm8trDQWSDiMPsUijvCtRi
    X8t4Cny/6WeCKxruPNTDsjo0Z+rRLugQu5ch4Y0Rod4y57/3/kVJc5eMNWxtsZl3
    =m0Zl
    -----END PGP PUBLIC KEY BLOCK-----
    ```
Selesai.

# Pesan Penulis

Catatan ini masih sangat jauh dari sempurna. Apabila mengalami kesulitan dan kegagalan, sangat saya rekomendasikan untuk melihat referensi yang saya sertakan pada akhir tulisan ini.



# Referensi

1. [wiki.archlinux.org/index.php/GnuPG](https://wiki.archlinux.org/index.php/GnuPG){:target="_blank"}
<br>Diakses tanggal: 2018/12/09

2. [docs.gitlab.com/ee/user/project/repository/gpg_signed_commits/](https://docs.gitlab.com/ee/user/project/repository/gpg_signed_commits/){:target="_blank"}
<br>Diakses tanggal: 2018/12/09

3. [help.github.com/articles/generating-a-new-gpg-key/](https://help.github.com/articles/generating-a-new-gpg-key/){:target="_blank"}
<br>Diakses tanggal: 2018/12/09
