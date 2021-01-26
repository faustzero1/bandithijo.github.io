---
layout: 'post'
title: "Membuat Jekyll Custom Tags dengan Liquid Tags"
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

Di Jekyll, saya melihat pada module Tags menggunakan setidaknya **Liquid::Block** dan juga **Liquid::Tags**.

Liquid tags yang disediakan oleh Jekyll, pasti teman-teman pernah menggunakannya.

1. **highlight**, menggunakan **Liquid::Block** (lib/jekyll/tags/highlight.rb)
2. **include**, menggunakan **Liquid::Tags** (lib/jekyll/tags/include.rb)
3. **link**, menggunakan **Liquid::Tags** (lib/jekyll/tags/link.rb)

<br>
Nah, kita akan mamanfaatkan kedua module ini untuk membuat Liquid tags yang kita perlukan.

Misal, kalau di BanditHijo, saya lebih banyak memerlukan untuk menampilkan **command prompt**, **highlight code**, dan **image**.

Pertama-tama, karena kita menggunakan Jekyll, kita akan menganggap fitur yang kita buat ini sebagai plugin.

Maka kita akan menempatkannya pada direktori **_plugins/**.

<pre>
.
├── _plugins/
│   ├── images.rb
│   └── shells.rb
...
</pre>

Dapat dilihat, kalau saya memiliki beberapa custom plugin yang saya buat untuk memudahkan proses menulis di blog ini.

Ayo kita lihat!

## Liquid::Tags dengan Parameter

Rasanya, penggunaan module **Liquid::Tags** memang hampir semuanya menggunakan parameter.

### Image Tag

Saya menggunakannya untuk menghandle image.

Sebelum mengenal Liquid tags, saya menggunakan cara ini untuk memasukkan gambar.

{% highlight_caption _posts/blog/2021/2021-01-01-contoh-artikel.md %}
{% highlight liquid %}
{% raw %}![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/wT7rfFFX/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}{% endraw %}
{% endhighlight %}

Ribet banget yaa.

Saya membuat snippets agar tidak ribet saat akan menggunakannya, namun, tetap saja hal ini membuat markdown file yang kita tulis menjadi kotor.

Saya ingin terlihat lebih rapi tanpa terlalu banyak HTML tag.

Kira-kira seperti ini,

{% highlight_caption _posts/blog/2021/2021-01-01-contoh-artikel.md %}
{% highlight liquid %}
{% raw %}{% image https://i.postimg.cc/wT7rfFFX/gambar-01.png" | 1 | Ini adalah caption }{% endraw %}
{% endhighlight %}

Nah! Lebih sederhana kan?

Berikut ini adalah codenya,

{% highlight_caption _plugins/shells.rb %}
{% highlight ruby linenos %}
module Jekyll
  class Image < Liquid::Tag
    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      params = split_params(@input)
      url = params[0].strip
      num = params[1].strip if params.length > 1
      cap = params[2].strip if params.length > 2

      output  = "![gambar_#{num}](/assets/img/logo/logo_blank.svg){:data-echo='#{url}' onerror='imgError(this);'}{:class='myImg'}"
      output += "\n<p class='img-caption' markdown='1'>Gambar #{num} - #{cap}</p>" if params.length == 3
      output
    end

    def split_params(params)
      params.split(' | ')
    end
  end
end

Liquid::Template.register_tag('image', Jekyll::Image)
{% endhighlight %}

Blok kode di atas adalah untuk kebutuhan saya.

Tentunya, teman-teman perlu memodifikasi sesuai dengan yang teman-teman butuhkan.


## Liquid::Block Tanpa Parameter

Untuk membuat Liquid::Block Tanpa Parameter, cukup mudah.

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


## Liquid::Block dengan Parameter

Untuk membuat Liquid::Block dengan Parameter, cukup tricky tapi mungkin.

### Command Prompt

Saya akan contohkan lagi untuk Command Prompt tapi dapat kita definisikan sendiri bentuk dari prompt dan warnanya.

Seperti ini misalnya,

{% highlight_caption _posts/blog/2021/2021-01-01-contoh-artikel.md %}
{% highlight liquid %}
{% raw %}{% shell_cmd $ %}
sudo pacman -Syu
sudo pacman -Scc
{% endshell_cmd %}{% endraw %}
{% endhighlight %}

{% shell_cmd $ %}
sudo pacman -Syu
sudo pacman -Scc
{% endshell_cmd %}

Atau,

{% highlight_caption _posts/blog/2021/2021-01-01-contoh-artikel.md %}
{% highlight liquid %}
{% raw %}{% shell_cmd # %}
pacman -Syu
pacman -Scc
{% endshell_cmd %}{% endraw %}
{% endhighlight %}

{% shell_cmd # %}
pacman -Syu
pacman -Scc
{% endshell_cmd %}

Saya menggunakan parameter `$` untuk mengindikasikan user biasa dan `#` untuk mengindikasikan root.

Atau, dengan parameter warna

{% highlight_caption _posts/blog/2021/2021-01-01-contoh-artikel.md %}
{% highlight liquid %}
{% raw %}{% shell_cmd [arch@iso ~]# | #DC322F %}
mkdir project
cd project
git clone https://github.com/bandithijo/new_project
cd new_project
bundle exec jekyll server
{% endshell_cmd %}{% endraw %}
{% endhighlight %}

{% shell_cmd [arch@iso ~]# | #DC322F %}
mkdir project
cd project
git clone https://github.com/bandithijo/new_project
cd new_project
bundle exec jekyll server
{% endshell_cmd %}

Jadi lebih fleksible.

Nah! Codenya seperti ini.

{% highlight_caption _plugins/shells.rb %}
{% highlight ruby linenos %}
module Jekyll
  class ShellCommand < Liquid::Block
    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      params        = split_params(@input)
      prompt_symbol = params[0]&.strip
      prompt_color  = params[1]&.strip if params.length > 1

      commands = super.split("\n")
      output  = '<pre>'
      output += commands[1..].map do |i|
        "<span class='cmd' #{"style='color:#{prompt_color};'" unless prompt_color.nil?}>" \
        "#{prompt_symbol.nil? ? '$' : prompt_symbol} </span><b>#{i}</b><br>"
      end.join.to_s
      output += '</pre>'
      output
    end

    def split_params(params)
      params.split(' | ')
    end
  end
end

Liquid::Template.register_tag('shell_cmd',  Jekyll::ShellCommand)
{% endhighlight %}








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

3. [blog.sverrirs.com/2016/04/custom-jekyll-tags.html](https://blog.sverrirs.com/2016/04/custom-jekyll-tags.html){:target="_blank"}
<br>Diakses tanggal: 2021/01/25
