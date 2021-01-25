---
layout: 'post'
title: "Translate-shell, Translator CLI Online yang Praktis"
date: 2020-10-16 22:05
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Ulasan', 'Tips']
pin:
hot:
contributors: []
resume: "Tools ini dapat kita operasikan dari dalam Terminal. Sangat praktis untuk menerjemahkan kata maupun kalimat. Untuk yang sehari-harinya bekerja dengan di dalam Terminal, mungkin aplikasi ini sangat cocok untuk digunakan. Tidak perlu lagi harus membuka Browser untuk mencari translasi dari kata/kalimat."
---

# Latar Belakang

Kamus atau *dictionary*, bagi yang beraktifitas dalam dua bahasa, pasti memerlukannya.

Meskipun tidak setiap waktu, namun cukup merepotkan apabila akses untuk mencari kamus cukup ribet.

Misal,

**Orang A**
1. Membuka browser dan mengakses halaman Google Translate
2. Mengetikkan kata/kalimat yang akan ditranslate
3. Menunggu hasil

**Orang B**
1. Membuka terminal dan masuk ke dalam translate-shell
2. Mengetikkan kata/kalimat yang akan ditranslate
3. Menunggu hasil

Sekilas, tidak ada yang terlalu berbeda dari perilaku antara **Orang A** atau **B**.

Namun, pada kenyataannya, proses nomor **1.** bisa jadi cukup panjang bagi **Orang A**, karena perlu untuk menggerakkan mouse ke sana dan kemari.

Belum lagi apabila resource RAM yang tidak memadai sehingga membuka browser saja menjadi pekerjaan yang cukup menyita waktu.

Saya adalah gambaran dari **Orang A** sebelum akhirnya mengenal **translate-shell** dan menjadi **Orang B** saat ini.

# Tentang translate-shell

**Translate Shell** adalah *command-line translator* yang dapat menggunakan Google Translate, Bing Translator, Yandex Translate, Apertium, dll. sebagai engine translator untuk menerjemahkan kata/frase/kalimat. Sebelumnya, dikenal dengan nama Google Tranaslate CLI.

## Kebutuhan Sistem

Translate Shell dapat bekerja pada banyak sistem yang sesuai dengan POSIX seperti:

1. GNU/Linux
2. macOS
3. *BSD
4. Android (menggunakan Termux)
5. Windows (menggunakan WSL, Cygwin, atau MSYS2)

## Dependensi

Dependensi yang diperlukan:

1. GNU Awk (Gawk)
2. GNU Bash atau Zsh, namun dapat pula menggunakan unix shell apapun seperti ksh, tcsh, fish, dan lain-lain.

## Dependensi yang Direkomendasikan

Beberapa daftar dependensi di bawah ini bersifat *optional* namun sangat direkomendasikan untuk dipasang.

1. curl
2. GNU FriBidi
3. mplayer, mpv, mpg123, eSpeak
4. less, more, most
5. rlwrap
6. aspell, hunspell

## Instalasi

Translate Shell pada halaman "GitHub readme" mereka, menjelaskan berbagai macam cara untuk memasang Translate Shell, tautannnya dapat teman-teman lihat [di sini](https://github.com/soimort/translate-shell#installation){:target="_blank"}.

### Nyicip dulu (tanpa install)

Kita dapat sekedar "nyicipin" dahulu tanpa perlu melakukan instalasi.

Buka Terminal, (khusus **bash** & **zsh**)

{% shell_user %}
gawk -f <(curl -Ls git.io/translate) -- -shell
{% endshell_user %}

Apabila berhasil outputnya akan seperti ini.

```
Translate Shell
(:q to quit)
> _
```

Tinggal mengetikkan kata yang akan kita translate, maka translate-shell akan secara otomatis mendeteksi kata/kalimat yang diinputkan dan secara default akan ditranslate ke bahasa inggris.

Untuk proses instalasi, teman-teman dapat menggunakan package manager dari distro masing-masing.

Misal, seperti saya yang menggunakan Arch Linux.

{% shell_user %}
sudo pacman -S translate-shell
{% endshell_user %}

Untuk distirbusi yang lain, dapat dilihat [di sini](https://github.com/soimort/translate-shell/wiki/Distros){:target="_blank"}.

Untuk cara instalasi yang lain, dapat dilihat [di sini](https://github.com/soimort/translate-shell#installation){:target="_blank"}.

# Konfigurasi

File konfigurasi dapat kalian letakkan pada lokasi-lokasi beirikut ini:

1. `.trans` di *current working directory* -- direktori kerja saat ini

2. `~/.translate-shell/init.trans` di HOME direktori

3. `$XDG_CONFIG_HOME/translate-shell/init.trans`<br>(defaultnya ada di `~/.config/translate-shell/init.trans`)

4. `/etc/translate-shell` untuk *system wide*

Saya memilih lokasi nomor 3, untuk menyimpan file `init.trans`.

Dan ini adalah contoh dari file `init.trans` yang saya gunakan.

{% highlight_caption $HOME/.config/translate-shell/init.trans %}
{% highlight trans linenos %}
{
 :translate-shell "0.9.6"
 :verbose         true
 :hl              "id"
 :tl              "en"
 :show-original   false
 :view            true
 :engine          "google"
 :user-agent      "Mozilla/5.0 (X11; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0"
}
{% endhighlight %}

Parameter-parameter tersebut dapat kalian lihat pada option `-h` atau `$ manual trans`.

Silahkan modifikasi sendiri sesaui dengan kebutuhan kalian.

# Cara Penggunaan

Saya hanya akan menunjukkan beberapa contoh saja, karena pada halaman GitHub readme dari Translate Shell sudah mendemonstrasikan dengan sangat lengkap.

## Menerjemahkan kata

### Mendefinisikan bahasa target

**Dari bahasa apapun, ke bahasa kita**

Target bahasa yang digunakan adalah bahasa yang kita definisikan pada `locale` sistem kita.

{% shell_user %}
trans impersonate
{% endshell_user %}

**Dari bahasa apapun, ke bahasa yang kita definisikan**

{% shell_user %}
trans :id impersonate
{% endshell_user %}

**Dari bahasa apapun, ke 2 bahasa yang kita definisikan**

{% shell_user %}
trans :id+ja impersonate
{% endshell_user %}

Selain mendefinisikan bahasa target setelah tanda `:`, kita juga dapat menggunakan option `-t`.

{% shell_user %}
trans -t id impersonate
{% endshell_user %}

{% shell_user %}
trans -t id+ja impersonate
{% endshell_user %}

Keuntungan menggunakan option `-t`, kita dapat menuliskan bahasa target dengan nama bahasanya.

{% shell_user %}
trans -t japanese impersonate
trans -t 日本語 impersonate
{% endshell_user %}

### Mendefinisikan bahasa sumber

Sekarang sebaliknya, untuk mendefinisikan bahasa sumber.

{% shell_user %}
trans id: menirukan
{% endshell_user %}

Karena kita tidak mendefinisikan bahasa target (hanya bahasa sumber), maka kata 'meniru' akan diterjemahkan ke bahasa yang didefinisikan di `locale`.

Untuk option bahasa sumber, kita gunakan `-s`.

{% shell_user %}
trans -s id menirukan
{% endshell_user %}

### Menerjemahkan banyak kata atau sebuah frase

Kalau kalian menulis seperti ini.

{% shell_user %}
trans :id impersonate character
{% endshell_user %}

Maka, akan diterjemakan masing-masing kata.

Apabila, ingin diterjemahkan sebagai satu frase, harus diapit dengan tanda petik satu `'...'` atau dua `"..."`.

<pre>
</pre>
{% shell_user %}
trans :id 'impersonate character'
trans :id "impersonate character"
{% endshell_user %}

### Menerjemahkan sebuah kalimat

Kurang lebih formnya sama dengan frase, yaitu menggunakan tanda petik satu `'...'` atau dua `"..."`.

{% shell_user %}
trans :id 'Impersonator is someone who imitates the behavior or actions of another.'
trans :id "Impersonator is someone who imitates the behavior or actions of another."
{% endshell_user %}

Dapat pula untuk multiline (banyak baris).

<pre>
<span class="cmd">$ </span><b>trans :zh "Creeps in this petty pace from day to day,
> To the last syllable of recorded time;
> And all our yesterdays have lighted fools
> The way to dusty death."</b>
</pre>

Untuk menghindari karakter tertentu seperti tanda `!` diintrepertasikan oleh shell sebagai "special characters", gunakan petik satu.

{% shell_user %}
trans :id 'Out, out, brief candle!'
{% endshell_user %}

Atau, kalau ingin teteap menggunakan petik dua, dapat menggunakan backslash tepat sebelum spesial karakter tersebut `\` (*escaping character*).

{% shell_user %}
trans :id "Out, out, brief candle\!"
{% endshell_user %}

Apabila terdapat kata yang menggunakan tanda petik satu, seperti `jum'at`, maka kalimat sebaiknya diapit oleh tanda petik dua `"..."`.

{% shell_user %}
trans :id "Life's but a walking shadow, a poor player."
{% endshell_user %}

Alternatif lain, selain menggunakan tanda petik, kita dapat menggunakan option `-j` (`-join-sentence`).

{% shell_user %}
trans :id -j Impersonator is someone who imitates the behavior of another.
{% endshell_user %}

Atau, apabila terdapat kata yang mengandung tanda petik sati, gunakan backslash tepat sebelum tanda petik.

{% shell_user %}
trans :id -j  Life\'s but a walking shadow, a poor player.
{% endshell_user %}

## Brief Mode

Secara default, Translate Shell akan menunjukkan hasil terjemahan yang banyak sekali.

Apabila kita lebih suka untuk melihat terjemahan yang paling relevan saja, terdapat mode yang disebut "brief mode".

Untuk dapat menggunakannya, tambahkan option `-b` (`-brief`).

{% shell_user %}
trans -b :ja 'Hello, World'
{% endshell_user %}

Hasilnya

```
こんにちは世界
```

Contoh di atas, secara default akan ditampilkan dalam tulisah jepang. Untuk hasil yang menampilkan "phonetic notation" (notasi penyebutan), kita dapat menambahkan tanda `@` tepat sebelum bahasa target.

{% shell_user %}
trans -b :@ja 'Hello, World'
{% endshell_user %}

Hasilnya,

```
Kon'nichiwa sekai
```

<br>

Dan masih banyak, contoh-contoh penggunaan dari options yang disediakan oleh Translate Shell.

Teman-teman dapat mengunjungi halaman GitHub readme dari Tranaslate Shell, [di sini](https://github.com/soimort/translate-shell#getting-started-by-examples){:target="_blank"}.

Salah satu fitur yang saya suka adalah REPL (Interactive Translate Shell).

Kita dapat masuk ke dalam REPL shell dengan menggunakan options `-I`, `-interactive`, atau `-shell`.

{% shell_user %}
trans -shell
{% endshell_user %}

Hasilnya,

```
Translate Shell
(:q to quit)
> _
```

REPL mode ini mengikuti konfigurasi file `init.trans` yang sudah kita definisikan.

# Tambahan

## Membuat Interaktif Menu Translate dengan Dmenu

{% highlight_caption $HOME/.local/bin/dmenu-trans %}
{% highlight bash linenos %}
#!/bin/sh

DMENU="/usr/local/bin/dmenu"

en_id() {
    st -t 'st+:Translate Shell [EN:ID]' \
    -g 60x8-0-0 \
    -e trans -no-view -no-pager -indent 0 -j \
    -hl en \
    -shell \
    -show-original-phonetics n \
    -show-translation y \
    -show-translation-phonetics n \
    -show-prompt-message n \
    -show-languages n \
    -show-original-dictionary n \
    -show-dictionary n \
    -show-alternatives n \
    en:id
}

id_en() {
    st -t 'st+:Translate Shell [ID:EN]' \
    -g 60x8-0-0 \
    -e trans -no-view -no-pager -indent 0 -j \
    -hl en \
    -shell \
    -show-original-phonetics n \
    -show-translation y \
    -show-translation-phonetics n \
    -show-prompt-message n \
    -show-languages n \
    -show-original-dictionary n \
    -show-dictionary n \
    -show-alternatives n \
    id:en
}

vim_translate() {
    st -t 'st+:Translate Playground' -g 85x20-0-0 -e vim ~/.translate
}

OPTIONS=$(echo -e "EN-ID\nID-EN\nPlayground" | $DMENU -i -p " Translate:")

case "$OPTIONS" in
    "EN-ID") en_id;;
    "ID-EN") id_en;;
    "Playground") vim_translate;;
esac
{% endhighlight %}

Hasilnya akan seperti ini,

{% image https://i.postimg.cc/jjtp9bdv/gambar-01.gif | 1 %}

Saya biasa gunakan untuk mentranslate beberapa kata/frase/atau kalimat yang saya tidak paham maksudnya.

## Mengintegrasikan Translate Shell dengan Vim/Neovim

Ada beberapa plugin yang dapat kita gunakan untuk mengintegrasikan Translate Shell dengan Vim.

1. [**VincentCordobes/vim-translate**](https://github.com/VincentCordobes/vim-translate){:target="_blank"}, a tiny translate-shell wrapper for Vim.

2. [**echuraev/translate-shell.vim**](https://github.com/echuraev/translate-shell.vim){:target="_blank"}, a power and flexible plugin for translating text without leaving Vim. It provides a window that displays the translate of word under cursor, selected text or you can use "on fly" translation and translate inserted text.

3. [**voldikss/vim-translator**](https://github.com/voldikss/vim-translator){:target="_blank"}, an asynchronous translating plugin for Vim/Neovim, it allows users to use multiple engines including trans.

<br>
Saat tulisan ini dibuat, saya baru mencoba **VincentCordobes/vim-translate**.

{% image https://i.postimg.cc/ncMB4j4G/gambar-02.gif | 2 | Mencoba `:translate` dan `:TranslateReplave` %}

{% image https://i.postimg.cc/v805xLVm/gambar-03.gif | 3 | Perbandingan kecepatan Translate Shell dengan vim-translate %}


# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)

# Referensi

1. [github.com/soimort/translate-shell](https://github.com/soimort/translate-shell){:target="_blank"}
<br>Diakses tanggal: 2020/10/16

2. [github.com/soimort/translate-shell/wiki/Configuration](https://github.com/soimort/translate-shell/wiki/Configuration){:target="_blank"}
<br>Diakses tanggal: 2020/10/16

3. [github.com/soimort/translate-shell/wiki/REPL](https://github.com/soimort/translate-shell/wiki/REPL){:target="_blank"}
<br>Diakses tanggal: 2020/10/16

4. [github.com/VincentCordobes/vim-translate](https://github.com/VincentCordobes/vim-translate){:target="_blank"}
<br>Diakses tanggal: 2020/10/16
