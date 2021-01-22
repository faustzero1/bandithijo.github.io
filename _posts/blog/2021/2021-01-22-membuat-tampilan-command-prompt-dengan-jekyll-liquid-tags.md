---
layout: 'post'
title: "Membuat Tampilan Command Prompt untuk Blog dengan Jekyll Liquid Tags"
date: 2021-01-22 09:53
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Jekyll']
pin:
hot:
contributors: []
resume: "Menulis teknikal blog cukup merepotkan apabila kita tidak menghandle dengan baik cara untuk memasukkan command prompt, karena akan banyak sekali command prompt yang akan digunakan pada teknikal blog. Catatan ini akan membahas bagaimana BanditHijo dalam menghandle command prompt di blog."
---

# Latar Belakang Masalah

Seiring berjalannya waktu, jumlah post di BanditHijo Blog ini semakin banyak.

Saya pun sudah beberapa kali merubah beberapa style untuk beberapa komponen terutama komponen seperti tampilan terminal prompt atau code block. Masih mencari-cari style seperti apa yang pas dan mudah untuk dipahami.

Ketika style baru ditemukan, maka style yang lama juga mau tidak mau harus ikut diubah.

Sangat ribet sekali bukan?

Belum lagi, bentuk dari stylenya adalah HTML yang bercampur dengan Markdown di dalam post.

Misal seperti ini,

{% highlight_caption _posts/blog/2021/2021-01-01-contoh-artikel.md %}
{% highlight markdown linenos %}
Lorem ipsum dolor sit amet consectetur adipisicing elit. Totam neque quod, debitis maxime nostrum quibusdam.
Harum ullam repudiandae beatae nesciunt ea ipsam nisi? Quasi quae aliquid ratione vel blanditiis vitae.

<pre>
$ <b>sudo pacman -Syu</b>
$ <b>sudo pacman -S ruby</b>
</pre>

Lorem ipsum dolor sit amet consectetur adipisicing elit. Nulla doloribus, labore dicta dolore magnam maiores.
Inventore expedita minus accusantium deserunt ipsum pariatur magni, cum reiciendis maxime.
Aperiam incidunt tempora natus?

<!-- INFORMATION -->
<div class="blockquote-blue">
<div class="blockquote-blue-title"><img src="/assets/img/logo/logo_note.svg">Informasi</div>
<p markdown=1>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Ex sapiente dicta,<br>
consequuntur veritatis, ipsum quos, hic dolores alias possimus reiciendis doloremque cupiditate nisi.<br>
Quaerat adipisci blanditiis sit quos, soluta iste.<p>
</div>
{% endhighlight %}

Baris ke 4-6, adalah prompt terminal.

baris ke 12-18, adalah contoh dari quote informasi yang berwarna biru.

<br>
Nah, yang menjadi masalah adalah,

Bayangkan apabila terdapat ratusan artikel dan kita ingin merubah stylenya.

Mungkin gak? Masih mungkin, tapi cukup bikin mumet kepala. 😅

## Apa yang saya inginkan?

Saya ingin menggunakan sesuatu semacam **wadah**, yang apabila ingin merubah stylenya, kita cukup merubah si wadah saja, dan semua yang menggunakan wadah tersebut otomatis ikut berubah juga.

Dan wadah tersebut harus sederhana. Cukup sederhana untuk ditulis dan dibaca.

Seperti ini,

{% highlight_caption _posts/blog/2021/2021-01-01-contoh-artikel.md %}
{% highlight liquid linenos %}
Lorem ipsum dolor sit amet consectetur adipisicing elit. Totam neque quod, debitis maxime nostrum quibusdam.
Harum ullam repudiandae beatae nesciunt ea ipsam nisi? Quasi quae aliquid ratione vel blanditiis vitae.

{% raw %}{% shell_user %}
sudo pacman -Syu
sudo pacman -S ruby
{% endshell_user %}{% endraw %}

Lorem ipsum dolor sit amet consectetur adipisicing elit. Nulla doloribus, labore dicta dolore magnam maiores.
Inventore expedita minus accusantium deserunt ipsum pariatur magni, cum reiciendis maxime.
Aperiam incidunt tempora natus?

{% raw %}{% box_info %}
<p markdown=1>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Ex sapiente dicta,<br>
consequuntur veritatis, ipsum quos, hic dolores alias possimus reiciendis doloremque cupiditate nisi.<br>
Quaerat adipisci blanditiis sit quos, soluta iste.<p>
{% endbox_info %}{% endraw %}
{% endhighlight %}

Pada contoh di atas, saya menggunakan module **Liquid::Block** untuk membungkus konten yang ingin saya tampilkan.

{% pre_whiteboard %}
{% raw %}{% nama_tag %}
# konten
# yang ingin ditampilkan
# bisa dalam bentuk multiline
{% endnama_tag %}{% endraw %}
{% endpre_whiteboard %}

Fitur ini, disebut dengan Liquid Tags. Fitur ini disediakan oleh Jekyll karena Jekyll menggunakan Liquid sebagai bahasa template.

<br>
Oke, karena keterbatasan ilmu saya saat ini, yang ingin saya catat hanya hal yang dasar saja dalam membuat Liquid tags yang juga digunakan di blog ini.

Mungkin artikel ini akan berkesinambungan seiring bertambahnya teknik yang saya dapatkan.

# Praktik Membuat Liquid Tags

Sebenarnya ada banyak Liquid module yang dapat kita gunakan untuk membangun tags, namun pada catatan kali ini, saya hanya akan mencontohkan untuk **Liquid::Block** module saja.

## Liquid::Block Tanpa Parameter

Untuk membuat Liquid::Block Tanpa Parameter, cukup mudah.

Pertama-tama, karena kita menggunakan Jekyll, kita akan menganggap fitur yang kita buat ini sebagai plugin.

Maka kita akan menempatkannya pada direktori **_plugins/**.

<pre>
.
├── _plugins/
│   ├── boxes.rb
│   ├── highlight_caption.rb
│   ├── jekyll_git_data.rb
│   ├── pre_class.rb
│   ├── shells.rb
│   └── youtube.rb
...
</pre>

Dapat dilihat, kalau saya memiliki beberapa custom plugin yang saya buat untuk memudahkan proses menulis di blog ini.

### Command Prompt

Saya akan contohkan untuk **shells.rb**, yang saya gunakan untuk menyimpan beberapa prompt shell untuk user dan root.

Kalau teman-teman lihat tampilan prompt seperti di bawah ini:

{% shell_user %}
sudo pacman -Syy
{% endshell_user %}

{% shell_root %}
systemctl start NetworkManager.service
{% endshell_root %}

Kedua tampilan prompt di atas, digenerate dari Liquid tags yang berasal dari file plugin **shells.rb** tersebut.

Pada tampilan markdownya akan seperti ini:

{% highlight_caption _posts/blog/2021/2021-01-01-contoh-artikel.md %}
{% highlight liquid %}
{% raw %}{% shell_user %}
sudo pacman -Syy
{% endshell_user %}{% endraw %}
{% endhighlight %}

{% highlight_caption _posts/blog/2021/2021-01-01-contoh-artikel.md %}
{% highlight liquid %}
{% raw %}{% shell_root %}
systemctl start NetworkManager.service
{% endshell_root %}{% endraw %}
{% endhighlight %}

<br>
Nah! Sekarang saya akan perlihatkan isi dari plugin **shells.rb**.

{% highlight_caption _plugins/shells.rb %}
{% highlight ruby linenos %}
module Jekyll
  class ShellRoot < Liquid::Block
    def render(context)
      commands = super.split("\n")
      text  = '<pre>'
      text += commands[1..].map do |i|
        "<span class='cmd'># </span><b>#{i}</b><br>"
      end.join.to_s
      text += '</pre>'
      text
    end
  end

  class ShellUser < Liquid::Block
    def render(context)
      commands = super.split("\n")
      text  = '<pre>'
      text += commands[1..].map do |i|
        "<span class='cmd'>$ </span><b>#{i}</b><br>"
      end.join.to_s
      text += '</pre>'
      text
    end
  end
end

Liquid::Template.register_tag('shell_root',  Jekyll::ShellRoot)
Liquid::Template.register_tag('shell_user',  Jekyll::ShellUser)
{% endhighlight %}

Dapat dilihat bahwa saya membangun sebuah prompt dengan menggunakan pre tag.

{% pre_whiteboard %}
&lt;pre>
&lt;span class="cmd">$ </span>&lt;b>command terminal</b>
&lt;/pre>
{% endpre_whiteboard %}

Style dari prompt ini adalah:

{% highlight_caption assets/css/main.css %}
{% highlight css %}
/* Untuk box dari command */
pre {
    background: #002b36;
    border-radius: 5px;
    font-size: 14px;
    font-family: 'FiraCodeNerdFontComplete-Medium','Roboto Mono', monospace;
    line-height: 1.45;
    overflow: auto;
    padding: 10px;
}

/* Untuk mewarnai command terminal menjadi kuning */
pre b {
    color: #FFCC00;
}

/* Untuk mendisable selection dari simbol prompt */
pre span.cmd {
    user-select: none;
    -webkit-user-select: none;
    -ms-user-select: none;
    -webkit-touch-callout: none;
    -o-user-select: none;
    -moz-user-select: none;
}
{% endhighlight %}


Fitur dari Liquid tags ini adalah,

1. Setiap baris baru (newline), akan diconvert menjadi 1 baris command (perintah).

Seperti ini contohnya:

{% highlight_caption _posts/blog/2021/2021-01-01-contoh-artikel.md %}
{% highlight liquid %}
{% raw %}{% shell_user %}
mkdir project
cd project
git clone https://github.com/bandithijo/new_project
cd new_project
bundle exec jekyll server
{% endshell_user %}{% endraw %}
{% endhighlight %}

Hasilnya:

{% shell_user %}
mkdir project
cd project
git clone https://github.com/bandithijo/new_project
cd new_project
bundle exec jekyll server
{% endshell_user %}

Nah, sederhana kan?













# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)




# Referensi

1. [jekyllrb.com/docs/liquid/tags/](https://jekyllrb.com/docs/liquid/tags/){:target="_blank"}
<br>Diakses tanggal: 2021/01/22

2. [jekyllrb.com/docs/plugins/your-first-plugin/](https://jekyllrb.com/docs/plugins/your-first-plugin/){:target="_blank"}
<br>Diakses tanggal: 2021/01/22
