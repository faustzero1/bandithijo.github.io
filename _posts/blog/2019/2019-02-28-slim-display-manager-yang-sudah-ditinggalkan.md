---
layout: 'post'
title: 'SLiM, Display Manager yang Sudah Lama Ditinggalkan'
date: 2019-02-28 17:47
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Ulasan', 'Tips', 'Arch Linux']
pin:
hot:
contributors: []
resume: "SLiM Display Manager termasuk display manager favorit yang banyak digunkan oleh para ricer. Karena sangat mudah untuk dimofifikasi. Catatan kali ini, saya ingin berbagi bagaimana cara saya dalam mengkonfigurasi SLiM."
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Mungkin sebagian dari teman-teman ada yang sudah pernah mencicipi distribusi sistem operasi GNU/Linux yang menggunakan SLiM display manager.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/JzS4m67p/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 1 - SLiM display manager dengan default theme</p>

Dari informasi yang saya baca pada halaman [Arch Wiki/SLiM](https://wiki.archlinux.org/index.php/SLiM#Match_SLiM_and_Desktop_Wallpaper){:target="_blank"}. Proyek ini sudah ditinggalkan. Rilis paling akhir pada tahun 2013. Website dari proyek inipun sudah tidak ada lagi.

Pada halaman Arch Wiki tersebut juga kita disarankan untuk mempertimbangkan menggunakan Display Manager yang lain. Karena SLiM tidak secara penuh *support* dengan systemd, termasuk logind sessions.

# Mengapa Tertarik dengan SLiM?

Sebenarnya sudah lama mencari-cari pengganti dari LightDM display manager. Saya merasa kurang fleksibel dalam mengkostumisasi sesuai preferensi sendiri. Belum lagi transisi antara verbose mode dari journalctl ke tampilan LightDM tidak begitu *smooth*.

Sampai beberapa waktu lalu, menemukan halaman pada Slant.co yang membahas [What is the best Linux Display Manager?](https://www.slant.co/topics/2053/~best-linux-display-manager){:target="_blank"}.

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/SRfqskGy/gambar-02.png" onerror="imgError(this);"}{:class="myImg"}

Saya agak heran, karena bukan LightDM yang menduduki peringkat no. 1 saat ini (2019/02/28), melainkan SLiM dengan perolehan point sebanyak 92, disusul LightDM sebesar 84.

Dengan selisih yang tidak terlampau jauh, tidak menutup kemungkinan LightDM akan segera menyusul ke peringkat pertama.

Namun, saya tetap ingin mencoba SLiM. Karena rasa penasaran saya atas apa yang membuat SLiM masih menduduki peringkat pertama, padahal telah 5 tahun ditinggalkan.

## Kelebihan dan Kekurangan SLiM

![gambar_8]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/C1N5Z5SM/gambar-08.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Sumber: <a href="https://www.slant.co/topics/2053/~best-linux-display-manager" target="_blank">Slant.co - SLiM Pros and Cons</a></p>

# Pengecekan Paket

Karena paket SLiM display manager ini termasuk paket yang sudah tidak lagi dimaintain oleh upstream developer, tentunya akan sangat penting untuk mengetahui apakah paket yang akan kita gunakan memiliki *bug reports*, *security reposts*, dll.

Pada distribusi Arch Linux, untuk menelusuri sebuah paket sangatlah mudah. Kita hanya perlu mengunjungi [archlinux.org/packages](https://www.archlinux.org/packages/){:target="_blank"}. Kemudian, mencari paket bernama `slim`.

Beberapa hal yang saya perhatikan adalah:

1. **Last Updated**
2. **View Changes**
3. **Bug Reports**

Berikut ini tampilan dari ketiga hal di atas.

![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/T2NPtdTS/gambar-03.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 3 - <a href="https://www.archlinux.org/packages/extra/x86_64/slim/" target="_blank">last Updated</a></p>

![gambar_4]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/fT3RFGLb/gambar-04.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 4 - <a href="https://git.archlinux.org/svntogit/packages.git/log/trunk?h=packages/slim" target="_blank">View Changes</a></p>

![gambar_5]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/5NZ2MsYS/gambar-05.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 5 - <a href="https://bugs.archlinux.org/?project=1&string=slim" target="_blank">Bug Reports</a></p>

Nah, dengan begini, kita dapat memantau, apakah paket SLiM ini **tidak lagi dimaintain** di Arch Linux atau **memiliki bug**.

Kita juga dapat sekalian mengecek apakah paket `slim` ini memiliki *security issue* atau tidak, pada halaman [security.archlinux.org](https://security.archlinux.org/){:target="_blank"}.

Untuk teman-teman yang menggunakan distribusi selain Arch atau turunan Arch, silahkan menyesuaikan saja yaa.

# Instalasi

{% box_perhatian %}
<p><b>Saya tidak merekomendasikan untuk menggunakan SLiM Display Manager</b>.</p>
<p>Apabila terjadi sesuatu yang merugikan teman-teman di kemudian hari, bukan merupakan tanggung jawab saya sebagai penulis.</p>
<p>Tanggung jawab sepenuhnya ada di tangan teman-teman.</p>
<p>Kalau setuju, yuk kita kemon!</p>
{% endbox_perhatian %}

Untuk distribusi Arch Linux, sangat saya sarankan memasang paket SLiM menggunakan *package manager*, dikarenakan alasan di atas. Agar paket yang kita gunakan, adalah paket yang sudah jelas ter-*maintained* dengan baik.

{% shell_user %}
sudo pacman -S slim
{% endshell_user %}

Untuk distribusi yang lain, silahkan menyesuaikan.

# Konfigurasi

## Jalankan Service SLiM

Setelah memasang paket SLiM, kita perlu menjalankan `slim.service`.

Dikarenakan kita harus memilih salah satu Display Manager yang digunakan, karena sebelumnya saya menggunakan LightDM Display Manager, saya akan men-*disable* service dari LightDM terlebih dahulu.

{% shell_user %}
sudo systemctl disable lightdm.service
{% endshell_user %}

Selanjutnya, baru meng-*enable*-kan service dari SLiM.

{% shell_user %}
sudo systemctl enable slim.service
{% endshell_user %}

## Sessions

SLiM dapat secara otomatis mendeteksi daftar sessions yang terdapat pada direktori `/usr/share/xsessions/`.

Contohnya seperti milik saya. Saya memiliki 3 sessions.

1. i3
2. dwm
3. qtile

```
/usr/share/xsessions/
.
├── dwm.desktop
├── i3.desktop
└── qtile.desktop
```

Sejak versi 1.3.6-2, SLiM sudah menyediakan fitur ini.

Untuk konfigurasi "pemilihan session", saya akan menuliskan dua cara.

1. Dapat memilih session pada saat login
2. Tidak dapat memilih session pada saat login

Kedua cara di atas, pada dasarnya, kita akan berurusan dengan 2 file.

1. `/etc/slim.conf`
2. `~/.xinitrc`

Saya mulai dari cara pertama.

### Menampilkan Pilihan Session pada saat Login

Edit file `/etc/slim.conf` dengan *text editor* favorit kalian.

{% shell_user %}
sudo vim /etc/slim.conf
{% endshell_user %}

{% highlight_caption /etc/slim.conf %}
{% highlight sh linenos %}
# ...
# ...

# Set directory that contains the xsessions.
# slim reads xsesion from this directory, and be able to select.
sessiondir            /usr/share/xsessions/

# ...
# ...
{% endhighlight %}

Perhatikan baris ke-6, pastikan sudah *enable* (tidak ada tanda # dibagian paling depan).

Bagian inilah yang akan mengaktifkan pilihan session pada saat login.

(Perbaikan dari: **Harry Kurn**)

**Penting!** untuk menambahkan baris di bawah ini pada file `~/.xinitrc`.

{% highlight_caption $HOME/.xinitrc %}
{% highlight sh linenos %}
# ...
# ...

exec $1
{% endhighlight %}

Tujuannya agar inputan yang dipilih menggunakan <kbd>F1</kbd> akan dieksekusi.

![gambar_6]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/d35FFTvd/gambar-06.gif" onerror="imgError(this);"}{:class="myImg"}

Kita dapat memilih session dengan menekan tombol <kbd>F1</kbd>.

### Tidak Dapat Memilih Session pada saat Login

Untuk Cara kedua ini, dapat pula kita sebut sebagai *automatic session*, karena kita tidak memilih session sendiri dengan menekan tombol <kbd>F1</kbd> seperti di atas. Melainkan, kita sudah terlebih dahulu mendefinisikan *default session* yang akan kita pergunakan.

Edit file `/etc/slim.conf` dengan *text editor* favorit teman-teman.

{% shell_user %}
sudo vim /etc/slim.conf
{% endshell_user %}

{% highlight_caption /etc/slim.conf %}
{% highlight sh linenos %}
# ...
# ...

# Set directory that contains the xsessions.
# slim reads xsesion from this directory, and be able to select.
#sessiondir            /usr/share/xsessions/

# ...
# ...
{% endhighlight %}

**Perhatikan!** pada baris ke-6. Tambahkan tanda pagar `#`, untuk mendisable konfigurasi pada baris ini.

Selanjutnya, definisikan *default session* yang akan kita pergunakan.

Edit file `~/.xinitrc` dengan *text editor* favorit kalian.

{% shell_user %}
vim ~/.xinitrc
{% endshell_user %}

Ada dua cara yang saya tawarkan.

#### Cara Sederhana

{% highlight_caption $HOME/.xinitrc %}
{% highlight sh linenos %}
# ...
# ...
exec i3
#exec dwm
#exec qtile
# ...
# ...
{% endhighlight %}

Karena saya menggunakan i3wm sebagai *default session* saya, maka saya meng-*enable*-kan dengan menghapus tanda pagar `#`, seperti contoh di atas.

#### Cara Keren

{% box_perhatian %}
<p markdown=1>(Perbaikan dari: **Harry Kurn**)</p>
<p markdown=1>Cara keren ini sudah **tidak direkomendasikan** lagi.</p>
{% endbox_perhatian %}

<s>
{% highlight_caption $HOME/.xinitrc %}
{% highlight sh linenos %}
# ...
# ...

# Untuk SLiM Session
DEFAULTSESSION=i3
case "$1" in
    i3) exec i3 ;;
    sway) exec sway ;;
    dwm) exec dwm ;;
    qtile) exec qtile ;;
    bspwm) exec bspwm ;;
    *) exec $DEFAULTSESSION ;;
esac

# ...
# ...
{% endhighlight %}

Untuk mengganti <i>default session</i> yang ingin digunakan, ubah nilai dari <i>variabel</i> <code>DEFAULTSESSION=</code>.
</s>

![gambar_7]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/yxs6sHRq/gambar-07.png" onerror="imgError(this);"}{:class="myImg"}

# System Sessions

SLiM juga dapat mengakses *system sessions* seperti: reboot, shutdown, suspend, exit dan console.

| <center>System Sessions</center> | <center>Username</center> | <center>Password</center> |
| :--: | :-- | :-- |
| **REBOOT** | `reboot` | `<root_password>` |
| **SHUTDOWN** | `halt` | `<root_password>` |
| **SUSPEND** | `suspend` | `<root_password>` |
| **EXIT** | `exit` | `<root_password>` |
| **CONSOLE** | `consle` | `<root_password>` |

Untuk mengaktifkan dan menonaktifkan fitur ini, teman-teman dapat melihat pada file `/etc/slim.conf`.

{% highlight_caption /etc/slim.conf %}
{% highlight sh linenos %}
# Commands for halt, login, etc.
halt_cmd            /sbin/shutdown -h now
reboot_cmd          /sbin/shutdown -r now
console_cmd         /usr/bin/xterm -C -fg white -bg black +sb -T "Console login" -e /bin/sh -c "/bin/cat /etc/issue; exec /bin/login"
#suspend_cmd        /usr/sbin/suspend
{% endhighlight %}

**suspend**, secara default dalam keadaan tidak aktif.

## Instalasi Themes

Instalasi themes pada SLiM display manager termasuk sangat mudah.

Hanya perlu memindahkan atau mengcopy paste direktori themes ke direktori `/usr/share/slim/themes`.

Salah satu contoh direktori SLiM themes, biasanya mengandung sedikitnya 3 file.

```
darky_solarized_dark_yellow
.
├── background.png
├── panel.png
└── slim.theme
```

{% box_info %}
<p>Saya menggunakan theme <b>darky_solarized_dark_yellow</b> yang merupakan hasil modifikasi dari <b>darky_pink</b> milik <a href="https://github.com/adi1090x/slim_themes" target="_blank">GitHub/adi1090x/slim_themes</a></p>
{% endbox_info %}



![gambar_9]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/4x6g4MJs/gambar-09.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Themes: darky_pink</p>

![gambar_10]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/MGz8nDTR/gambar-10.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Themes: darky_solarized_dark_yellow</p>

Cara instalasi themes sangat mudah.

Secara garis besar proses instalasi dibagi dalam 2 tahap.

1. Copy direktori themes ke dalam direktori `/usr/share/slim/themes/`
2. Merubah nilai dari variabel `current_theme` pada file `/etc/slim.conf`

### Copy Direktori Themes

{% shell_user %}
sudo cp -rvf &lt;dir_themes> /usr/share/slim/themes
{% endshell_user %}

Sebagai contoh, saya memiliki themes bernama `darky_solarized_dark_yellow`.

{% shell_user %}
sudo cp -rvf darky_solarized_dark_yellow /usr/share/slim/themes
{% endshell_user %}

Kemudian lakukan pengecekan pada direktori `/usr/share/slim/themes/` apakah sudah berhasil dicopy.

{% shell_user %}
ll /usr/share/slim/themes
{% endshell_user %}

<pre>
<mark>drwxr-xr-x root root darky_solarized_dark_yellow</mark>
drwxr-xr-x root root default
</pre>

Nah, kalau sudah ada, berarti sudah terinstall.

### Menginisialisasi Nama Themes

Apabila langkah copy direktori themes sudah dilakukan, selanjutnya tinggal mengganti nilai dari variabel `current_theme` pada file `/etc/slim.conf` yang tadinya bernilai `default` menjadi `<nama_theme>`.

{% shell_user %}
sudo vim /etc/slim.conf
{% endshell_user %}

{% highlight_caption /etc/slim.conf %}
{% highlight sh linenos %}
# ...
# ...

# current theme, use comma separated list to specify a set to
# randomly choose from
current_theme        darky_solarized_dark_yellow

# ...
# ...
{% endhighlight %}


# Pesan Penulis

Untuk diperhatikan, SLiM display manager tidak menggunakan `~/.profile` untuk mengambil data-data aplikasi atau PATH apa saja yang harus dijalankan saat sistem startup, melainkan menggunakan `~/.xinitrc`.

Hal tersebut di atas sangat berbeda dengan Display Manager seperti GDM dan LightDM yang mengambil data-data startup applications dan PATH pada `~/.profile`.

Apabila hal ini tidak dikonfigurasi dengan benar, maka akan ada beberapa hal yang tidak berjalan sebagaimana mestinya.

Silahkan merujuk pada [.xinitrc](https://github.com/bandithijo/dotfiles/blob/master/.xinitrc){:target="_blank"} milik saya yang berada di GitHub/dotfiles, apabila memang diperlukan.

Sepertinya seperti ini dulu.

Mudah-mudahan dapat bermanfaat buat teman-teman.

Terima kasih.

# Terima Kasih

Terima kasih, Bro **Harry Kurn**.

![gambar_11]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/xdSvWxK2/gambar-11.png" onerror="imgError(this);"}{:class="myImg"}




# Referensi

1. [wiki.archlinux.org/index.php/SLiM](https://wiki.archlinux.org/index.php/SLiM){:target="_blank"}
<br>Diakses tanggal: 2019/02/28

2. [github.com/data-modul/slim](https://github.com/data-modul/slim){:target="_blank"}
<br>Diakses tanggal: 2019/02/28

3. [www.slant.co/topics/2053/~best-linux-display-manager](https://www.slant.co/topics/2053/~best-linux-display-manager){:target="_blank"}
<br>Diakses tanggal: 2019/02/28

4. [wiki.archlinux.org/index.php/GNOME/Keyring#Using_the_keyring_outside_GNOME](https://wiki.archlinux.org/index.php/GNOME/Keyring#Using_the_keyring_outside_GNOME){:target="_blank"}
<br>Diakses tanggal: 2019/02/28
