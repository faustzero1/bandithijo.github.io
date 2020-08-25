---
layout: 'post'
title: "Memasang Rubocop (Ruby linter) pada Vim"
date: 2020-08-25 05:17
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Vim']
pin:
hot:
contributors: []
---

# Latar Belakang Masalah

Sejak 2019 saya memulai memprogram menggunakan bahasa Ruby, baru sekarang saya merasa perlu untuk menerapkan *code formater*. Tujuannya agar code yang kita tulis minim dari kesalahan akibat dari kesalahan penulisan stuktur dari sintaks sekaligus untuk menyeragamkan format code yang ditulis oleh tim member yang lain yang juga menggunakan *code formater*.

*Code formater* biasanya dalam text editor akan di-*bundle* bersama *code analyzer* yang biasa disebut dengan **linter**. Pengalaman saya berinteraksi dengan linter adalah saat belajar menggunakan bahasa Python dengan vim plugin **python-mode**. Saat itu, saya mendapat pengalaman dan kesan yang sangat bagus. Karena saya dipaksa untuk menulis sintaks kode berdasarkan format yang sudah disepakati. Kalau tidak, maka akan terdapat beberapa *warning* yang menandakan bahwa baris kode yang kita tulis tidak mengikuti kaidah atau format yang sesuai.

Dalam bahasa Python, saya mengenal beberapa linter diantaranya: pylint, pylama, pycodestyle, pyflake, flake8, pep8, dll. Dalam bahasa Ruby, saya mengenal beberapa linter diantaranya: Rubocop --mungkin masih banyak lagi, namun hanya satu itu saja yang sering saya dengar.

Maka, pada kesempatan kali ini, saya merasa sudah waktunya untuk menulis kode Ruby menggunakan *code formater* agar format penulisan kode lebih rapi. *Code formater* yang akan saya pergunakan adalah **Rubocop**.

# Apa itu Rubocop?

Secara sederhana, Rubocop adalah *static code analyzer* (linter) dan juga *code formater* untuk bahasa pemrograman Ruby. Apabila kita menggunakan Rubocop, secara otomatis, Rubocop akan memaksa kita untuk menulis sintaks Ruby dengan mengikuti kaidah-kaidah penulisan Ruby code yang ada di dalam [Ruby Style Guide](https://rubystyle.guide/){:target="_blank"}.

# Instalasi

Tanpa berlama-lama, saya akan langsung saya *to the point* pada hal-hal teknik yang perlu dilakukan.

## Pasang Rubocop Gem

Sebelum memasang Rubocop pada Vim, kita perlu memasang Rubocop pada Ruby environment kita. Kenapa saya katakan Ruby environment? Karena biasanya sebagai programmer Ruby, kita sangat direkomendasikan untuk menggunakan Ruby environment seperti RVM atau Rbenv. Saya sendiri menggunakan Rbenv.

Terlebih dahulu saya melakukan pengecekan versi Ruby yang saat ini sedang saya pergunakan. Tujuannya agar saya mengetahui bahwa saya pernah memasang Rubocop pada Ruby versi tertentu.

<pre>
$ <b>ruby -v</b>
</pre>

```
ruby 2.7.1p83 (2020-03-31 revision a0c7c23c9c) [x86_64-linux]
```

Setelah itu pasang Rubocop gem terbaru.

<pre>
$ <b>gem install rubocop</b>
</pre>

Tunggu proses instalasinya hingga selesai.

Apabila telah selesai, artinya kita telah berhasil memasang Rubocop pada versi Ruby 2.7.1. Jika kita memiliki project dengan versi Ruby yang berbeda, kita perlu memasang Rubocop kembali pada versi Ruby tersebut.

## ALE

Saya juga menggunakan [**ALE**](https://github.com/dense-analysis/ale){:target="_blank"} (Asynchronous Lint Engine) adalah Vim plugin yang menyediakan linting (syntax checking dan semantic errors) untuk NeoVim 0.2.0+ dan Vim 8 saat kita mengedit text dan berperilaku seperti Vim Language Server Protocol client.

ALE mendukung cukup banyak language dan linter. Nantinya, kita akan mengkonfigurasi ALE agar menggunakan Rubocop sebagai linter saat kita mengerjakan file Ruby.

## Pasang vim-rubocop & ALE

Saya menggunakan **vim-plug** sebagai plugin manager.

Untuk memasang Rubocop, kita akan menggunakan bantuan plugin yang bernama [**ngmy/vim-rubocop**](https://github.com/ngmy/vim-rubocop){:target="_blank"}.

Tambahkan pada `.vimrc`.

```viml
" A The Vim RuboCop plugin runs RuboCop and displays the results in Vim
Plug 'ngmy/vim-rubocop'

" A Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
Plug 'dense-analysis/ale'
```

Kemudian refresh dulu vimrc dengan melakukan source ke vimrc agar plugin yang baru saja kita tambahkan dapat dikenali.

```
:source $MYVIMRC
```

Lalu instal vim-rubocop yang baru saja kita tambahkan, dengan menggunakan perintah.

```
:PlugInstall
```

Tunggu proses instalasinya sampai selesai.

## Konfigurasi vim-rubocop

Untuk mengkonfigurasi vim-rubocop, yang paling penting adalah kita perlu mendefinisikan dimana letak file `rubocop.yml` berada.

File **rubocop.yml** ini berisi aturan-aturan yang akan digunkan oleh Rubocop untuk menilai kode yang kita tulis.

Kita dapat meng-enable atau men-disable sesuai dengan keperluan kita.

Letak dari file **rubocop.yml** ini dapat kita letakkan secara global atau project root direktori (local).

Secara urutan, proses pembacaan file rubocop.yml akan seperti di bawah ini.

```
[1] /path/to/project/lib/utils/.rubocop.yml

[2] /path/to/project/lib/.rubocop.yml

[3] /path/to/project/.rubocop.yml

[4] /.rubocop.yml

[5] ~/.rubocop.yml

[6] ~/.config/rubocop/config.yml

[7] RuboCop’s default configuration
```
Pada konfigurasi kali ini saya akan menggunakan yang global karena saya tidak selalu mendifinisikan file rubocop.yml untuk project yang sedang saya kerjakan.

Saya menggunakan nomor 6 dan akan membuat symbolic link untuk nomor 5. 😁

### Pembuatan File rubocop.yml

Pertama buat dahulu direktori config untuk Rubocop dan masuk ke dalam direktori tersebut.

<pre>
$ <b>mkdir -p $HOME/.config/rubocop</b>
$ <b>cd $HOME/.config/rubocop</b>
</pre>

Kemudian download dulu aturan-aturan Rubocop yang default dari alamat di bawah ini.

[**RuboCop’s default configuration**](https://raw.githubusercontent.com/rubocop-hq/rubocop/master/config/default.yml){:target="_blank"}

Ganti nama filenya menjadi `rubocop.yml.example`.

<pre>
$ <b>mv default.yml rubocop.yml.example</b>
</pre>

Selanjutnya, saya akan membuat file **config.yml** yang berisi aturan-aturan yang akan meng-override aturan default untuk saya disable.

Jadi fungsi dari file **config.yml** ini saya pergunakan hanya untuk men-disable aturan yang saya tidak inginkan.

<pre>
$ <b>touch $HOME/.config/rubocop/config.yml</b>
</pre>

Apabila saya melakukan list direktori akan seperti ini hasilnya

<pre>
$ <b>ls</b>
config.yml  rubocop.yml.example
</pre>

Buka file **config.yml** dengan text editor dan tambahkan beberapa aturan yang ingin di-disable.

Contoh beberapa aturan yang saya disable.

{% highlight yml %}
# $HOME/.config/rubocop/config.yml

Style/Documentation:
  Description: 'Document classes and non-namespace modules.'
  Enabled: false

Metrics/MethodLength:
  Description: 'Avoid methods longer than 10 lines of code.'
  StyleGuide: '#short-methods'
  Enabled: false
  CountComments: false  # count full line comments?
  Max: 10
  CountAsOne: []
  ExcludedMethods: []

Style/GlobalVars:
  Description: 'Do not introduce global variables.'
  StyleGuide: '#instance-vars'
  Reference: 'https://www.zenspider.com/ruby/quickref.html'
  Enabled: false
  # Built-in global variables are allowed by default.
  AllowedVariables: []

Style/FrozenStringLiteralComment:
  Description: >-
                 Add the frozen_string_literal comment to the top of files
                 to help transition to frozen string literals by default.
  Enabled: false
  EnforcedStyle: always
  SupportedStyles:
    # `always` will always add the frozen string literal comment to a file
    # regardless of the Ruby version or if `freeze` or `<<` are called on a
    # string literal. It is possible that this will create errors.
    - always
    # `always_true` will add the frozen string literal comment to a file,
    # similarly to the `always` style, but will also change any disabled
    # comments (e.g. `# frozen_string_literal: false`) to be enabled.
    - always_true
    # `never` will enforce that the frozen string literal comment does not
    # exist in a file.
    - never
  SafeAutoCorrect: false

Metrics/PerceivedComplexity:
  Description: >-
                 A complexity metric geared towards measuring complexity for a
                 human reader.
  Enabled: true
  IgnoredMethods: []
  Max: 10 # default: 8

# Avoid complex methods.
Metrics/CyclomaticComplexity:
  Description: >-
                 A complexity metric that is strongly correlated to the number
                 of test cases needed to validate a method.
  Enabled: true
  IgnoredMethods: []
  Max: 10 # default: 7
{% endhighlight %}

Saya mendisable:

1. **Style/Documentation**, untuk Class documentation yang biasanya ada di bagian atas dari Class.
2. **Metrics/MethodLength**, untuk membatasi jumlah baris pada method yang tidak lebih dari 10 baris.
3. **Style/GlobalVars**, untuk menghindari menggunakan global variabel.
4. **Style/FrozenStringLiteralComment**, untuk mewajibkan menulis magic string.
5. **Metrics/PerceivedComplexity** & **Metrics/CyclomaticComplexity**, untuk mengatur penulisan method yang mudah dipahami, dan tidak berbelit-belit.

Kemudian, saya akan membuat symbolic link file **config.yml** untuk saya letakkan di $HOME direktori secara hidden.

<pre>
$ <b>ln -sf $HOME/.config/rubocop/config.yml $HOME/.rubocop.yml</b>
</pre>

Dengan begini, saya memiliki file `~/.rubocop.yml` yang isinya akan sama dengan file `~/.config/rubocop/config.yml`.

**Kenapa saya buat menjadi symbolic seperti ini?**

Agar path yang digunakan lebih pendek. 😁

### Definisikan File rubocop.yml yang Digunakan

Setelah kita mendifinikan aturan-aturan apa saja, kita perlu mendifinisikan file aturan mana yang akan kita pergunakan.

Tambahkan pada `.vimrc`.

```viml
let g:vimrubocop_config = '~/.rubocop.yml'
```

Saya mendefinisikan file `~/.rubocop.yml` yang merupakan symbolic link dari file `~/.config/rubocop/config.yml`.

## Konfigurasi ALE

Setelah kita mengkonfigurasi vim-rubocop, kita juga perlu mengkonfigurasi ALE untuk mendifinisikan linter apa yang akan kita gunakan.

```viml
let g:ale_linters = {
\   'ruby': ['rubocop'],
\}

let g:ale_fix_on_save = 0
```

Kemudian, definisikan juga fixer yang akan digunakan.

```viml
let g:ale_fixers = {
\   'ruby': ['rubocop'],
\}
```

Untuk mengaktifkan ALE fixer kita dapat menggunakan perintah.

```
:ALEFix
```

Selain menggunakan Rubocop sebagai fixer, kita dapat mengecek saran penggunaan fixer yang lain dengan menggunakan perintah.

```
:ALEFixSuggest
```

```
Try the following fixers appropriate for the filetype:

'rubocop' - Fix ruby files with rubocop --auto-correct.
'rufo' - Fix ruby files with rufo
'sorbet' - Fix ruby files with srb tc --autocorrect.
'standardrb' - Fix ruby files with standardrb --fix

Try the following generic fixers:

'remove_trailing_lines' - Remove all blank lines at the end of a file.
'trim_whitespace' - Remove all trailing whitespace characters at the end of every line.

See :help ale-fix-configuration

Press q to close this window
```

<!-- INFORMATION -->
<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>Pada saat ini, saya hanya mendifinisikan untuk bahasa Ruby, namun sebenarnya, saya juga mendifinisikan untuk bahasa yang lain seperi JavaScript dan Python.</p>
</div>

Meskipun saat ini, saya hanya berhasil menjalankan fixer untuk `remove_trailing_lines`.

Saya masih akan terus mencoba-coba agar fungsi fixer secara otomatis benar-benar dapat digunakan.


# Pesan Penulis

Sepertinya, segini dulu yang saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)



# Referensi

1. [github.com/rubocop-hq/rubocop](https://github.com/rubocop-hq/rubocop){:target="_blank"}
<br>Diakses tanggal: 2020/08/25

2. [github.com/ngmy/vim-rubocop](https://github.com/ngmy/vim-rubocop){:target="_blank"}
<br>Diakses tanggal: 2020/08/25

3. [Vim for Ruby and Rails in 2019](https://www.vimfromscratch.com/articles/vim-for-ruby-and-rails-in-2019/){:target="_blank"}
<br>Diakses tanggal: 2020/08/25
