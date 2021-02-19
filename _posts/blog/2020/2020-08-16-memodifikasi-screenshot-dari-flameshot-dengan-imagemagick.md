---
layout: 'post'
title: "Memodifikasi Hasil ScreenShot dari Flameshot dengan ImageMagick"
date: 2020-08-16 10:13
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Ruby']
pin:
hot: true
contributors: []
resume: "Ide untuk mempercantik hasil screenshot dari Flameshot ini terinspirasi dari gambar-gambar hasil screenshot yang diproduksi oleh sistem operasi OSX. Jangan khawatir, di GNU/Linux, kita juga dapat membuat hal serupa, malah bisa lebih keren karena kita dapat dengan bebas memodifikasinya. Dengan begini, hasil screenshot setiap orang, akan jadi unik dan khas, sesuai dengan karakter masing-masing."
---

# Requirements

`imagemagick 7.x` `flameshot 0.8.x` `xclip 0.13` `ruby 2.7.x`

# Sekenario Masalah

Beberapa waktu yang lalu, saya menulis tentang ["Membuat Hasil ScreenShot pada GNU/Linux seperti Milik macOS"](/blog/membuat-hasil-screenshot-linux-seperti-pada-macos){:target="_blank"}.

Pada artikel tersebut, script dijalankan setelah gambar hasil screenshot jadi.

**Namun, bagaimana apabila screenshot yang dihasilkan berasal dari flameshot?**

Kalau membuat sequence command seperti ini,

{% shell_user %}
flameshot gui; imagemagick-script
{% endshell_user %}

Permasalahannya adalah, apabila kita tidak jadi melakukan screenshot dengan flameshot, maka script `imagemagick-script` akan tetap dijalankan, dan akan memodifikasi gambar terakhir pada direktori screenshot.

# Pemecahan Masalah

Kita perlu memasukkan perintah flameshot ke dalam script.

Nantinya, yang kita panggil bukan lagi flameshot, melainkan script kita --untuk menjalankan flameshot dengan hasil yang telah dimodifikasi dengan imagemagick.

Saya beri nama `flameshot-imgck`.

{% highlight_caption $HOME/.local/bin/flameshot-imgck %}
{% highlight ruby linenos %}
#!/usr/bin/env ruby

require 'date'

# Please wite your dir with ~/ first
screenshot_dir    = '~/pic/ScreenShots'
Dir.chdir(File.expand_path(screenshot_dir))
original_file     = Time.now.strftime('Screenshot_%Y-%m-%d_%H-%M-%S.png')
target_file       = original_file.split('').insert(-5, 'X').join
color_profile     = '/usr/share/color/icc/colord/sRGB.icc'
border_size       = '1'
background_color  = '"#FFFFFF"' # 'none' for transparent; Hex color use '"#000000"'
background_size   = '10'
shadow_size       = '50x10+0+10'
font              = 'JetBrains-Mono-Regular-Nerd-Font-Complete'
font_size         = '11'
color_fg          = '#ffffff'
color_bg          = '#666666'
author_position   = ['SouthWest', '+30+26']
author            = 'Shooter: @' + `echo $USER`.strip

%x(
flameshot gui --raw > #{original_file}

magick convert #{original_file} -bordercolor '#{color_bg}' -border #{border_size} \
#{target_file}

magick convert #{target_file} \\( +clone -background black \
-shadow #{shadow_size} \\) +swap -background none \
-layers merge +repage #{target_file}

magick convert #{target_file} -bordercolor #{background_color} \
-border #{background_size} #{target_file}

echo -n " #{author} " | magick convert #{target_file} \
-gravity #{author_position[0]} -pointsize #{font_size} -fill '#{color_fg}' \
-undercolor '#{color_bg}' -font #{font} \
-annotate #{author_position[1]} @- #{target_file}

magick convert #{target_file} -gravity South -chop 0x#{background_size.to_i / 2} \
#{target_file}

magick convert #{target_file} -gravity North -background #{background_color} \
-splice 0x#{background_size.to_i / 2} #{target_file}

magick convert #{target_file} -profile #{color_profile} #{target_file}
)

list_file = `ls -p | grep -v /`
last_file = list_file.split(' ').last
if last_file.include? 'X'
  `notify-send "ImageMagick" "Improving success!" -t 3000`
  `xclip -selection clipboard -i #{target_file} -t image/png`
end

size = `find #{last_file} -printf %s`
if size == '0' || size <= '20'
  `rm -rf #{last_file}`
  `notify-send "Flameshot" "Process Aborted!" -t 1000`
end
{% endhighlight %}

Kalau kita menjalankan script di atas, akan menghasilkan dua buah file.

<pre>
Screenshot_2020-08-16_11-32-45.png    <- Original
Screenshot_2020-08-16_11-32-45X.png   <- Modifikasi
</pre>

{% box_perhatian %}
<p markdown="1">Alamat `screenshot_dir` dengan alamat yang ada di Flameshot, **harus sama**.</p>
<p markdown="1">Kalau tidak, maka script tidak berjalan sebagaimana mestinya.</p>
{% endbox_perhatian %}

File Original tidak dimodifikasi, tujuannya sebagai backup. Karena saya menyadari bahwa pengambilan screenshot adalah hal yang sangat *crucial* dan terkadang tidak dapat diulang dua kali.

File Modifikasi adalah hasil pengolahan dengan imagemagick, kalau dibuka akan seperti ini hasilnya.

{% image https://i.postimg.cc/C1jrwMbJ/gambar-01.png | 1 %}

Nah, dengan seperti ini, kita tetap dapat memanfaatkan fitur annotate milik flameshot.

Mulai dari sekarang, hasil flameshot kita akan berbeda dari screenshot-screenshot sebelumnya.

# Modifikasi Script

Beberapa modifikasi yang sering saya lakukan adalah:

## Menghilangkan Border

Baris ke-11, adalah variabel untuk mendefinisikan border dari hasil screenshot.

Ubah nilainya ke `0` apabila tidak ingin menggunakan border.

{% highlight_caption $HOME/.local/bin/flameshot-imgck %}
{% highlight ruby %}
border_size = '0'
{% endhighlight %}

## Mengganti Author (ScreenShoter)

Baris ke-20, adalah variabel untuk mendifinisikan author dari pengambil screenshot.

Ubah nilainya sesuai dengan preferensi teman-teman.

{% highlight_caption $HOME/.local/bin/flameshot-imgck %}
{% highlight ruby %}
author = 'Shooter: @' + `echo $USER`.strip
{% endhighlight %}

## Disable Author

Baris ke 35-38, adalah proses pemberian author.

Kalau ingin dihilangkan, cukup dengan memberikan tanda `#` di setiap awal baris ke-34 sampai baris ke-37.

{% highlight_caption $HOME/.local/bin/flameshot-imgck %}
{% highlight ruby %}
%x(
flameshot gui --raw > #{original_file}

...
...

#echo -n " #{author} " | convert #{target_file} \
#-gravity #{author_position[0]} -pointsize #{font_size} -fill '#{color_fg}' \
#-undercolor '#{color_bg}' -font #{font} \
#-annotate #{author_position[1]} @- #{target_file}

...
...
)
{% endhighlight %}

## Mengganti Author Font

Baris ke-15, adalah variable untuk mendifinisikan font.

Ganti nilainya sesuai dengan preferensi teman-teman.

{% highlight_caption $HOME/.local/bin/flameshot-imgck %}
{% highlight ruby %}
font = 'JetBrains-Mono-Regular-Nerd-Font-Complete'
{% endhighlight %}

{% box_info %}
<p>Cara untuk mendapatkan nama font, gunakan perintah di bawah.</p>
{% shell_user %}
convert -list font
{% endshell_user %}
<p>Untuk mendapatkan hasil yang lebih spesifik, gunakan grep dengan mengambil awal kata dari nama font.</p>
{% shell_user %}
convert -list font | grep -i 'fura'
{% endshell_user %}
Hasilnya akan seperti ini.
<pre>
...
...
Font: Fura-Code-Regular-Nerd-Font-Complete
  family: FuraCode Nerd Font
  glyphs: /usr/share/fonts/TTF/Fura Code Regular Nerd Font Complete.ttf
Font: Fura-Code-Regular-Nerd-Font-Complete-Mono
  family: FuraCode Nerd Font Mono
  glyphs: /usr/share/fonts/TTF/Fura Code Regular Nerd Font Complete Mono.ttf
...
...
</pre>
<p>Tinggal pilih font yang sesuai dengan preferensi teman-teman.</p>
<p>Ambil value yang ada di dalam <code>Font:</code></p>
{% endbox_info %}

## Mengganti Author Font Size

Baris ke-16, adalah variable yang mendifinisikan ukuran font.

Ganti sesuai preferensi teman-teman dalan satuan ukuran **pt** (point).

{% highlight_caption $HOME/.local/bin/flameshot-imgck %}
{% highlight ruby %}
font_size = '11'
{% endhighlight %}

## Mengganti Author Position

Baris ke-19, adalah variabel untuk mendifinisikan nilai posisi dari author.

Index ke-0 berisi, 8 arah mata angin + 1 Center.

```
NorthWest, North, NorthEast, West, Center, East, SouthWest, South, SouthEast
```

Sebagai acuan untuk memposisikan object dengan singkat.

{% highlight_caption $HOME/.local/bin/flameshot-imgck %}
{% highlight ruby %}
author_position = ['South', '...']
{% endhighlight %}

Index ke-1 berisi, jarak +X+Y

{% highlight_caption $HOME/.local/bin/flameshot-imgck %}
{% highlight ruby %}
author_position = ['...', '+10+10']
{% endhighlight %}

Hasilnya,

{% highlight_caption $HOME/.local/bin/flameshot-imgck %}
{% highlight ruby %}
author_position = ['South', '+10+10']
{% endhighlight %}

## Background Transparent

Baris ke-12, adalah variable untuk mendifinisikan border color yang digunakan untuk memberikan background pada hasil screenshot.

Ubah nilainya menjadi `none` untuk transparent.

{% highlight_caption $HOME/.local/bin/flameshot-imgck %}
{% highlight ruby %}
background_color  = "none"
{% endhighlight %}

Kalau ingin menggunakan warna,

{% highlight_caption $HOME/.local/bin/flameshot-imgck %}
{% highlight ruby %}
background_color  = "'#002b36'"
{% endhighlight %}


## Background Padding

Baris ke-13, adalah variable untuk mendifinisikan padding dari background dengan screenshot.

Ganti sesuai preferensi teman-teman.

Sesuaikan dengan besar dari shadow yang digunakan, agar shadow tidak terpotong.

{% highlight_caption $HOME/.local/bin/flameshot-imgck %}
{% highlight ruby %}
background_size   = "20"
{% endhighlight %}

## Shadow

Baris ke-14, adalah variable untuk mendifinisikan shadow yang ada di bawah screenshot.

Ganti sesuai preferensi teman-teman.

{% highlight_caption $HOME/.local/bin/flameshot-imgck %}
{% highlight ruby %}
shadow_size = '50x10+0+10'
{% endhighlight %}

## Color Profile

Menambahkan color profile ini penting untuk Telegram. Kalau tidak menambahkan color profile, gambar kita akan terlihat "over bright" di Telegram Android meskipun tidak terlihat di Telegram Desktop.

{% highlight_caption $HOME/.local/bin/flameshot-imgck %}
{% highlight ruby %}
# ...
# ...
color_profile = '/usr/share/color/icc/colord/sRGB.icc'
# ...
# ...

%x(
flameshot gui --raw > #{original_file}

...
...

convert #{target_file} -profile #{color_profile} #{target_file}

...
...
)
{% endhighlight %}

## Save to Clipboard!

Apabila telah selesai melakukan screenshot, kita dapat menyimpan dengan menekan tombol <kbd>ENTER</kbd>.

Maka, hasil screenshot kita akan disimpan ke clipboard.

{% highlight_caption $HOME/.local/bin/flameshot-imgck %}
{% highlight ruby %}
list_file = `ls -p | grep -v /`
last_file = list_file.split(' ').last
if last_file.include? 'X'
  `notify-send "ImageMagick" "Improving success!" -t 3000`
  `xclip -selection clipboard -i #{target_file} -t image/png`
end
{% endhighlight %}

Tinggal kita paste di Telegram.

Namun, dengan Ruby script ini, hasil screenshot tetap berada pada direktori screenshot yang sudah kita set.

Jangan lupa untuk mendisable tombol save pada configurasi interface di Flameshot.

{% shell_cmd $ %}
flameshot config
{% endshell_cmd %}

{% image https://i.postimg.cc/7LTNWWGB/gambar-02.png | 2 %}

Tujuannya agar kita tidak latah lalu menekan tombol save. Agar hanya ada satu pilihan untuk menyimpan, yaitu menekan tombol <kbd>ENTER</kbd>.

## Menghandle Escape

Apabila kita tidak jadi melakukan screenshot dan menekan tombol <kbd>ESC</kbd>, proses screenshot dengan script ini akan meninggalkan file kosong (sebesar 0 B - 10 B).

Untuk menghandle hal tersebut, saya memilih mendeteksi size dari file tersebut dan menghapusnya.

{% highlight_caption $HOME/.local/bin/flameshot-imgck %}
{% highlight ruby %}
size = `find #{last_file} -printf %s`
if size == '0' || size <= '20'
  `rm -rf #{last_file}`
  `notify-send "Flameshot" "Process Aborted!" -t 1000`
end
{% endhighlight %}




# Pesan Penulis

Mantap!!!

Saya rasa hanya ini yang dapat saya tuliskan saat ini.

Mudah-mudahan dapat bermanfaat untuk teman-teman.

Terima kasih.

(^_^)



# BONUS

## Alternatif Project

### 1. Awesome Flameshot (Bash Version oleh Berrabe)

Tidak semua temann-teman memiliki Ruby, namun, biasanya sudah memiliki Bash secara default.

Versi Bash ini dapat menjadi alternatif yang sangat praktis untuk teman-teman.

Terima kasih kepada bro Berrabe telah mem-porting ke Bash.

Teman-teman dapat menikmati source nya di sini yaa, [**Bash version oleh Berrabe**](https://github.com/berrabe/awesome-flameshot){:target="_blank"}.

{% image https://github.com/berrabe/awesome-flameshot/raw/master/docs/logo.png | 3 %}

{% image https://github.com/berrabe/awesome-flameshot/raw/master/docs/output.png | 4 %}


## Versi Python

{% box_perhatian %}
<p>Versi Python sudah tidak saya maintain lagi.</p>
{% endbox_perhatian %}

Saya beri nama `flameshot-imgck-python`.

{% highlight_caption $HOME/.local/bin/flameshot-imgck-pyhton %}
{% highlight python linenos %}
#!/usr/bin/env python

import os
from datetime import datetime

# Please write your screenshot dir with full path. Later, I'll improve this.
screenshot_dir    = "/home/bandithijo/pic/ScreenShots"
os.chdir(screenshot_dir)
original_file     = datetime.now().strftime("Screenshot_%Y-%m-%d_%H-%M-%S.png")
target            = list(original_file)
target.insert(-4, 'X')
target_file       = ''.join(target)
color_profile     = "/usr/share/color/icc/colord/sRGB.icc"
border_size       = "1"
background_color  = "white" # "none" for transparent; Hex color use "'#ffffff'"
background_size   = "10"
shadow_size       = "50x10+0+10"
font              = "JetBrains-Mono-Regular-Nerd-Font-Complete"
font_size         = "11"
color_fg          = "#ffffff"
color_bg          = "#666666"
author_position   = ["SouthWest", "+30+26"]
author            = "Shooter: @" + \
                    os.popen("echo $USER").read().rstrip("\n")

os.system(f"""
flameshot gui --raw > {original_file}

magick convert {original_file} -bordercolor '{color_bg}' -border {border_size} \
{target_file} \

magick convert {target_file} \\( +clone -background black \
-shadow {shadow_size} \\) +swap -background none \
-layers merge +repage {target_file} \

magick convert {target_file} -bordercolor {background_color} \
-border {background_size} {target_file} \

echo -n " {author} " | magick convert {target_file} \
-gravity {author_position[0]} -pointsize {font_size} -fill '{color_fg}' \
-undercolor '{color_bg}' -font {font} \
-annotate {author_position[1]} @- {target_file} \

magick convert {target_file} -gravity South -chop 0x{int(background_size)/2} \
{target_file} \

magick convert {target_file} -gravity North -background {background_color} \
-splice 0x{int(background_size)/2} {target_file} \

magick convert {target_file} -profile {color_profile} {target_file} \
""")

list_file = os.popen("ls -p | grep -v /").read().split("\n")[:-1]
last_file = list_file[-1]
if 'X' in last_file:
    os.system("notify-send 'ImageMagick' 'Improving success!' -t 3000")
    os.system(f"xclip -selection clipboard -i {target_file} -t image/png")

size = os.popen(f"find {last_file} -printf %s").read()
if size == '0' or size <= '20':
    os.system(f"rm -rf {last_file}")
    os.system("notify-send 'Flameshot' 'Process Aborted!' -t 1000")
{% endhighlight %}






# Referensi

1. [Membuat Hasil ScreenShot pada GNU/Linux seperti Milik macOS](/blog/membuat-hasil-screenshot-linux-seperti-pada-macos){:target="_blank"}
<br>Diakses tanggal: 2020/08/16
