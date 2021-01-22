---
layout: 'post'
title: "Ruby Installation Script dengan Auto Create Option for Selection"
date: 2020-09-27 12;53
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Ruby']
pin:
hot:
contributors: []
excerpt:
---

# Latar Belakang Masalah

Saya membuat sebuah Ruby script untuk shell wraper dalam memudahkan proses copy paste asset modifikasi dari user direktori ke root direktori.

Misal, saya memiliki sebuah asset **meta_01.svg** yang berada di home user
<br>**$HOME/theme/keymon/oblivion/meta_01.svg**

Ingin saya copy ke direktori asset dari keymon yang berada di
<br>**/usr/lib/python3.8/site-packages/keymon/themes/oblivion/meta.svg**

Jika menggunakan command **cp** akan seperti ini kira-kira.

<pre>
$ <b>sudo cp -vf $HOME/theme/keymon/oblivion/meta_01.svg \
              /usr/lib/python3.8/site-packages/keymon/themes/oblivion/meta.svg</b>
</pre>

Karena path yang dituju sangat dalam, maka timbul rasa malas apabila pekerjaan modifikasi ini dialkukan berulang kali untuk tujuan pengujian.

Maka dari itu, saya berinisiatif untuk membuatkan Ruby installation script agar dapat menangani masalah ini dengan memberikan instruksi secara interaktif.

Selain itu juga karena saya mengharapkan apabila saya menambahkan direktori theme lain, dan juga style yang lain, saya tidak perlu mengubah-ubah script untk memberikan option atau pilihan lagi. Karena pilihan-pilihan theme dan style sudah ditangani oleh script.

Mantaaaaaap memang!


# Pemecahan Masalah

Secara sederhana, algoritma dari script ini adalah:

1. **Membuat list semua direktori theme yang ada**
2. **Menampilkan semua direktori theme sebagai pilihan (option)**
3. **User: Memilih theme yang tersedia**<br>
   Nama theme diambil dari nama direktori dari masing-masing theme.
4. **Masuk ke dalam direktori theme**
5. **Membuat list semua style yang ada di dalam direktori theme**
6. **Menampilkan semua style sebagai pilihan (option)**
7. **User: Memilih style yang ada di dalam theme**
8. **User: Konfirmasi untuk melakukan proses instalasi**
9. **Melakukan proses $ sudo cp**

<br>
Selanjutnya, saya membuat sebuah file **install.rb**.

Kemudian mulai menulis prosedur dari algoritma di atas dengan bahasa Ruby.

Saya akan menjelaskan perbagian kecil, agar teman-teman yang teratarik dengan bahasa Ruby dapat lebih mudah memahami.

1. Mendefinisikan lokasi dari keymon installation direktori.<br>
    Setiap sistem kemungkinan akan berbeda berdasarkan distro yang digunakan dan versi Python yang digunakan.<br>
    Pada langkah ini, mau tidak mau saya harus meminta akses administrator dengan sudo.<br>
```ruby
python_lib_path = `sudo python -c "import sys; print(sys.path[4])"`
keymon_dir = python_lib_path.strip << '/keymon/themes'
puts "\nYour Key-Mon installation directory is on:
#{keymon_dir.sub('/themes', '')}"
```

2. Membuat daftar semua theme yang ada di dalam project.
```ruby
list_theme = `ls -1d */`.gsub("\/", '').split("\n")
```

3. Mengecualikan direktori tertentu dari daftar direktori theme.<br>
   Dalam kasus ini, direktori **sample**.
```ruby
['sample'].each do |exclude|
  list_theme.delete(exclude)
end
```

4. Menampilkan option (pilihan) berupa daftar theme yang ada.
```ruby
puts 'Select your Key-mon theme!'
list_theme.each_with_index do |theme, index|
  puts " (#{index + 1}) #{theme.capitalize}"
end
```
    Output:<br>
    ```
    Select your Key-mon theme!
    (1) Oblivion
    ```

5. Meminta inputan ke user dari pertanyaan di atas.
```ruby
puts "\nEnter theme number:"
print '=> '
selected_theme = gets.chomp
```
    Output:<br>
```
Enter theme number:
=> _
```

6. Mendefinisikan nama theme berdasarkan jawaban yang diberikan user.<br>
   Dari jawaban berupa string angka ke theme name dari list_theme.
```ruby
selected_theme_name = list_theme[selected_theme.to_i - 1]
```

7. Berpindah direktori ke dalam direktori theme yang dipilih user.
```ruby
Dir.chdir(selected_theme_name)
puts "\nYou are in #{selected_theme_name.capitalize} directory"
```
    Output:<br>
```
You are in ... directory
```

8. Membuat kondisi, apabila direktori terdapat style, maka masukkan ke dalam variable list_style array.<br>
   Apabila di dalam direktori kosong, maka exit program.
```ruby
unless `ls -p | grep -v /`.empty?
  list_style = `ls -p | grep -v /`.split("\n")
else
  puts "\nThere are no style in this directory"
  exit
end
```

9. Menampilkan option (pilihan) berupa style-style yang terdapat di dalam direktori theme.
```ruby
puts "\nSelect you modification style:"
list_style.each_with_index do |style, index|
  puts " (#{index + 1}) #{style}"
end
```
    Output:<br>
```
Select you modification style:
  (1) meta_01.svg
  (2) meta_02.svg
  (3) meta_03.svg
  (4) meta_04.svg
```

10. Meminta inputan berupa nomor style ke user.
```ruby
puts "\nEnter style number"
print '=> '
selected_style = gets.chomp
```
    Output:<br>
```
Enter style number
=> _
```

11. Mendefinisikan nama style berdasarkan jawaban yang diberikan user.<br>
    Dari jawaban berupa string angka ke nama style.
```ruby
selected_style_name = list_style[selected_style.to_i - 1]
```

12. Menampilkan pilihan style yang dipilih user.
```ruby
puts "\nYou choose: #{selected_style_name}"
```
    Output:<br>
```
You choose: ...
```

13. Menanyakan persetujuan kepada user, apakah ingin melakukan instalasi atau tidak.
```ruby
puts "\nAre you sure want to change the style? [y/n]"
print '=> '
agreement = gets.chomp
```
    Output:<rb>
```
Are you sure want to change the style? [y/n]
=> _
```

14. Mengolah jawaban user.
```ruby
if %w[y Y].include? agreement
  puts "\nLet's party!"
  puts
  system "sudo cp -vf #{selected_style_name} \
                      #{keymon_dir}/#{selected_theme_name}/meta.svg"
  puts "\nInstallation COMPLETED!"
elsif %w[n N].include? agreement
  puts "\nAh, Maybe later"
else
  puts "\nYou are not enter the correct answer"
end
```
    Output:<br>
    Apabila **y**<br>
    <pre>
Let's party!<br>
[sudo] password for user:<br>
'meta_01.svg' -> '/usr/lib/python3.8/site-packages/keymon/themes/oblivion/meta.svg'<br>
Installation COMPLETED!</pre>
    Apabila **n**
```
Ah, Maybe later
```
    Selain **y** & **n**
```
You are not enter the correct answer
```

15. Selesai

# Full Script

{% highlight_caption install.rb %}
{% highlight ruby linenos %}
#!/usr/bin/env ruby

# This is a Ruby wraper script for change the Meta/Super key logo of your
# Key-mon. You can choose your Meta modification style with this installation
# script install.rb.
# source  : https://github.com/bandithijo/key-mon-meta-mod
# author  : bandithijo@gmail.com
# created : 2020/09/27

# Please take a look a installation path of your keymon.
# It probably difference with my own system.
python_lib_path = `sudo python -c "import sys; print(sys.path[4])"`
keymon_dir = python_lib_path.strip << '/keymon/themes'

puts "\nYour Key-Mon installation directory is on:
#{keymon_dir.sub('/themes', '')}"

list_theme = `ls -1d */`.gsub("\/", '').split("\n")

['sample'].each do |exclude|
  list_theme.delete(exclude)
end

puts 'Select your Key-mon theme!'
list_theme.each_with_index do |theme, index|
  puts " (#{index + 1}) #{theme.capitalize}"
end
puts "\nEnter theme number:"
print '=> '
selected_theme = gets.chomp
selected_theme_name = list_theme[selected_theme.to_i - 1]

Dir.chdir(selected_theme_name)
puts "\nYou are in #{selected_theme_name.capitalize} directory"

unless `ls -p | grep -v /`.empty?
  list_style = `ls -p | grep -v /`.split("\n")
else
  puts "\nThere are no style in this directory"
  exit
end

puts "\nSelect you modification style:"
list_style.each_with_index do |style, index|
  puts " (#{index + 1}) #{style}"
end

puts "\nEnter style number"
print '=> '
selected_style = gets.chomp
selected_style_name = list_style[selected_style.to_i - 1]

puts "\nYou choose: #{selected_style_name}"

puts "\nAre you sure want to change the style? [y/n]"
print '=> '
agreement = gets.chomp
if %w[y Y].include? agreement
  puts "\nLet's party!"
  puts
  system "sudo cp -vf #{selected_style_name} \
                      #{keymon_dir}/#{selected_theme_name}/meta.svg"
  puts "\nInstallation COMPLETED!"
elsif %w[n N].include? agreement
  puts "\nAh, Maybe later"
else
  puts "\nYou are not enter the correct answer"
end
{% endhighlight %}


# Pesan Penulis

Untuk versi lebih update dapat dilihat pada repositori [di sini](https://github.com/bandithijo/key-mon-meta-mod/blob/master/install.rb){:target="_blank"}

Sepertinya, segini dulu yang dapat saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)
