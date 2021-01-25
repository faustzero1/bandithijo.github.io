---
layout: 'post'
title: "Membuat Web Scraper dengan Ruby (Output: HTML) Level 2"
date: 2020-08-20 21:24
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Ruby']
pin:
hot:
contributors: []
resume:
---

{% box_perhatian %}
<p>Data yang penulis gunakan adalah data yang bersifat <b><i>free public data</i></b>. Sehingga, siapa saja dapat mengakses dan melihat tanpa perlu melalui layer authentikasi.</p>
<p>Penyalahgunaan data, bukan merupakan tanggung jawab dari penulis seutuhnya.</p>
{% endbox_perhatian %}

# Sekenario Masalah

Blog post ini adalah modifikasi dari post sebelumnya yang berjudul, ["Membuat Web Scraper dengan Ruby (Output: HTML)"](/blog/membuat-web-scraper-dengan-ruby-output-html){:target="_blank"}.

Permasalahan dengan script sebelumnya adalah tidak dapat mendapatkan hasil.

Laporan ini saya dapatkan dari seorang teman, yaitu mas **Rejka Permana** di Telegram.

Ternyata, setelah saya cek website dari target belajar, desain dari website sudah berubah.

Sekarang menjadi seperti ini.

{% image https://i.postimg.cc/yYZzBw7k/gambar-01.png | 1 %}

Tampilan yang sekarang, tentunya tidak dapat difetch menggunakan CSS selector yang sebelumnya. Karena markup dari HTML sudah berubah.

Lantas saya pun mencoba untuk memodifikasi script tersebut.

# Pemecahan Masalah

Tidak ada cara lain selain memodifikasi CSS selector.

Namun, kali ini, saya akan memanfaatkan Ruby Class sekaligus membuat script menjadi lebih Object Oriented.

Tujuannya agar apabila terjadi perubahan lagi, dapat lebih mudah untuk dimaintain.

Langkah pertama adalah, saya me-rename file `scraper.rb` menjadi `main.rb`.

Kemudian membuat 2 file baru yaitu `scaper.rb` dan `template.rb`.

<pre>
ruby-web-scraper-dosen/
├── daftar_dosen.html
├── Gemfile
├── Gemfile.lock
├── <mark>main.rb</mark>
├── <mark>scraper.rb</mark>
└── <mark>template.rb</mark>
</pre>

`main.rb` adalah aktor utama yang akan kita running.

`scraper.rb` adalah Scraper Class yang akan berisi logic dari proses scraping (backend).

`template.rb` adalah file yang akan menggenerate template (frontend).

Oke, selanjutnya adalah isi dari ketiga file tersebut.

# Ngoding Session

Meskipun sebelumnya sudah pernah dilakukan, saya akan coba menulis kembali dari awal. Agar teman-teman yang baru mengikuti dari blog post ini tidak begitu kebingungan.

## Initialisasi Gemfile

Buat file dengan nama `Gemfile`. dan kita akan memasang gem yang diperlukan di dalam file ini.

{% highlight_caption Gemfile %}
{% highlight ruby linenos %}
source 'https://rubygems.org'

gem 'httparty',     '~> 0.18.1'
gem 'nokogiri',     '~> 1.10', '>= 1.10.9'
gem 'byebug',       '~> 11.1', '>= 11.1.3'
{% endhighlight %}

Setelah memasang gem pada Gemfile, kita perlu melakukan instalasi gem-gem tersebut.

{% shell_user %}
bundle install
{% endshell_user %}

Proses bundle install di atas akan membuat sebuah file baru bernama `Gemfile.lock` yang berisi daftar dependensi dari gem yang kita butuhkan --daftar requirements--.

## main.rb

Selanjutnya adalah si tokoh utama.

{% highlight_caption main.rb %}
{% highlight ruby linenos %}
require 'httparty'
require 'nokogiri'
require 'byebug'
require_relative './scraper'
require_relative './template'

def main
  begin
    target_url = "http://baak.universitasmulia.ac.id/dosen/"
    unparsed_page = HTTParty.get(target_url)
  rescue SocketError
    puts "ERROR: Target URL tidak dikenal (salah alamat)"
    exit
  end

  parsed_page = Nokogiri::HTML(unparsed_page)

  # daftar semua dosen
  dosens = Scraper.new(parsed_page).fetch_all

  # daftar dosen pria
  dosens_pria = Scraper.new(parsed_page).fetch_by_gender('pria')

  # daftar dosen wanita
  dosens_wanita = Scraper.new(parsed_page).fetch_by_gender('wanita')

  # byebug

  # template
  Template.new(dosens, dosens_pria, dosens_wanita).create_html

  puts "TOTAL SELURUH DOSEN : #{dosens.count} orang"
  puts "TOTAL DOSEN PRIA    : #{dosens_pria.count} orang"
  puts "TOTAL DOSEN WANITA  : #{dosens_wanita.count} orang"
end

main

# Create index.html from daftar_dosen.html for rendering on netlify & vercel
%x(cp -f daftar_dosen.html index.html)
{% endhighlight %}

## scraper.rb

{% highlight_caption scrapper.rb %}
{% highlight ruby linenos %}
class Scraper

  attr_reader :parsed_page, :gender
  attr_writer :dosens

  def initialize(parsed_page)
    @parsed_page = parsed_page
  end

  def fetch_all
    dosens = Array.new
    dosen_listings = @parsed_page.css('div.elementor-widget-wrap p')
    dosen_listings[1..-2].each do |dosen_list|
      collect_dosen(dosen_list, dosens)
    end

    return dosens
  end

  def fetch_by_gender(gender)
    if gender == 'pria'
      index = 9
    elsif gender == 'wanita'
      index = 10
    else
      puts 'Gender Not Qualified!'
    end

    dosens = Array.new
    dosen_listings = @parsed_page.css('div.elementor-widget-wrap')[index].css('p')
    dosen_listings.each do |dosen_list|
      collect_dosen(dosen_list, dosens)
    end

    return dosens
  end

  def collect_dosen(dosen_list, dosens)
    nama_nidn_dosen = dosen_list&.text&.gsub(/(^\w.*?:)|(NIDN :\s)/, "").strip
    dosen = {
      nama_dosen: nama_nidn_dosen&.gsub(/[^A-Za-z., ]/i, ''),
      nidn_dosen: nama_nidn_dosen&.gsub(/[^0-9]/i, '')
    }

    if dosen[:nama_dosen] != nil
      dosens << dosen
    end
  end

end
{% endhighlight %}

## template.rb

{% highlight_caption template.rb %}
{% highlight ruby linenos %}
class Template

  require 'date'

  attr_accessor :dosens, :dosens_pria, :dosens_wanita

  def initialize(dosens, dosens_pria, dosens_wanita)
    @dosens        = dosens
    @dosens_pria   = dosens_pria
    @dosens_wanita = dosens_wanita
  end

  def create_html
    File.delete("daftar_dosen.html") if File.exist?("daftar_dosen.html")
    File.open("daftar_dosen.html", "w") do |f|
      f.puts '<!DOCTYPE html>'
      f.puts '<html lang="en">'
      f.puts '<head>'
      f.puts '<meta charset="UTF-8">'
      f.puts '<meta name="viewport" content="width=device-width, initial-scale=1">'
      f.puts "<title>Daftar Dosen Universitas Mulia Balikpapan(#{dosens.count} dosen)</title>"
      f.puts '</head>'
      f.puts '<body>'
      f.puts '<h1>Daftar Dosen UM BPPN</h1>'
      f.puts "<p>Data terakhir diparsing: #{Date.today}</p>"

      f.puts '''
      <p>Made with ❤ by <a href="https://bandithijo.github.io">Rizqi Nur Assyaufi</a> - 2020/07/12<br>
      Powered by <a href="http://ruby-lang.org">Ruby</a> |
      Source Code on <a href="https://github.com/bandithijo/ruby-web-scraper-dosen">GitHub</a></p>
      '''

      f.puts '<div class="tab">'
      ['Semua Dosen', 'Dosen Pria', 'Dosen Wanita'].each.with_index(1) do |dosen, index|
        f.puts "<button class='tablinks' onclick=\"openTab(event, 'tab#{index}')\">#{dosen}</button>"
      end
      f.puts '</div>'

      f.puts '<div id="tab1" class="tabcontent active">'
      f.puts '<h2>Daftar Semua Dosen</h2>'
      f.puts "<p style='margin-top:-12px;'>Jumlah Seluruh Dosen: #{dosens.size} orang</p>"
      f.puts '<input type="text" id="inputDosens" onkeyup="cariDosens()" placeholder="Cari nama dosen..">'
      f.puts '<table id="tableDosens">'
      dosens.each.with_index(1) do |dosen, index|
        f.puts '<tr>'
        f.puts "<td>#{dosen[:nama_dosen]}</td>"
        f.puts "<td>#{dosen[:nidn_dosen]}</td>"
        f.puts '</tr>'
      end
      f.puts '</table>'
      f.puts '</div>'

      f.puts '<div id="tab2" class="tabcontent">'
      f.puts '<h2>Daftar Dosen Pria</h2>'
      f.puts "<p style='margin-top:-12px;'>Jumlah Dosen Pria: #{dosens_pria.size} orang</p>"
      f.puts '<input type="text" id="inputDosensPria" onkeyup="cariDosens()" placeholder="Cari nama dosen pria..">'
      f.puts '<table id="tableDosensPria">'
      dosens_pria.each.with_index(1) do |dosen, index|
        f.puts '<tr>'
        f.puts "<td>#{dosen[:nama_dosen]}</td>"
        f.puts "<td>#{dosen[:nidn_dosen]}</td>"
        f.puts '</tr>'
      end
      f.puts '</table>'
      f.puts '</div>'

      f.puts '<div id="tab3" class="tabcontent">'
      f.puts '<h2>Daftar Dosen Wanita</h2>'
      f.puts "<p style='margin-top:-12px;'>Jumlah Dosen Wanita: #{dosens_wanita.size} orang</p>"
      f.puts '<input type="text" id="inputDosensWanita" onkeyup="cariDosens()" placeholder="Cari nama dosen wanita..">'
      f.puts '<table id="tableDosensWanita">'
      dosens_wanita.each.with_index(1) do |dosen, index|
        f.puts '<tr>'
        f.puts "<td>#{dosen[:nama_dosen]}</td>"
        f.puts "<td>#{dosen[:nidn_dosen]}</td>"
        f.puts '</tr>'
      end
      f.puts '</table>'
      f.puts '</div>'

      f.puts '''
      <style>
      :root {
        --fg-color: #000;
        --bg-color: #fff;
        --a-color: #0000ff;
      }
      ::placeholder {
        color: var(--fg-color);
        opacity: 0.5;
      }
      body {
        background-color: var(--bg-color);
        color: var(--fg-color);
        font-family: Arial;
        font-size: 12px;
      }
      a, a:visited {
        color: var(--a-color);
      }
      table,th,td {
        border: 1px solid var(--fg-color);
        border-collapse: collapse;
      }
      td {
        padding: 3px;
      }
      td:nth-child(2) {
        font-family: monospace;
        text-align: center;
      }
      .tab {
        overflow: hidden;
      }
      .tab button {
        background-color: inherit;
        float: left;
        border: none;
        outline: none;
        cursor: pointer;
        padding: 5px 5px 5px 0;
        transition: 0.3s;
        font-family: inherit;
        font-size: inherit;
        color: inherit;
        margin-right: 10px;
      }
      .tab button.active {
        text-decoration: underline;
      }
      .tabcontent {
        display: none;
      }
      input:focus, textarea:focus, select:focus{
        background-color: var(--bg-color);
        color: var(--fg-color);
        outline: none;
      }
      #inputDosens, #inputDosensPria, #inputDosensWanita {
        background-color: var(--bg-color);
        width: 30%;
        padding: 0;
        border: 1px solid var(--bg-color);
        margin: 0 0 12px 0;
        font-family: inherit;
        font-size: 12px;
      }
      @media screen and (width: 360px) {
        table, #inputDosens, #inputDosensPria, #inputDosensWanita {
          width: 100%;
        }
      }
      </style>
      '''

      f.puts '''
      <script>
      // Sumber: https://www.w3schools.com/howto/howto_js_tabs.asp
      function openTab(evt, tabNumber) {
        var i, tabcontent, tablinks;
        tabcontent = document.getElementsByClassName("tabcontent");
        for (i = 0; i < tabcontent.length; i++) {
          tabcontent[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
          tablinks[i].className = tablinks[i].className.replace(" active", "");
        }
        document.getElementById(tabNumber).style.display = "block";
        evt.currentTarget.className += " active";
      }

      // Sumber: https://www.w3schools.com/howto/howto_js_filter_table.asp
      function cariDosens() {
        var input, filter, table, tr,
            inputPria, filterPria, tablePria, trPria,
            inputWanita, filterWanita, tableWanita, trWanita,
            td, i, txtValue;
      '''

      ['', 'Pria', 'Wanita'].each do |dosen|
        f.puts """
        input#{dosen} = document.getElementById('inputDosens#{dosen}');
        filter#{dosen} = input#{dosen}.value.toUpperCase();
        table#{dosen} = document.getElementById('tableDosens#{dosen}');
        tr#{dosen} = table#{dosen}.getElementsByTagName('tr');
        for (i = 0; i < tr#{dosen}.length; i++) {
          td = tr#{dosen}[i].getElementsByTagName('td')[0];
          if (td) {
            txtValue = td.textContent || td.innerText;
            if (txtValue.toUpperCase().indexOf(filter#{dosen}) > -1) {
              tr#{dosen}[i].style.display = '';
            } else {
              tr#{dosen}[i].style.display = 'none';
            }
          }
        }
        """
      end

      f.puts '''
      }
      </script>
      '''

      f.puts '</body>'
      f.puts '</html>'
    end
  end

end
{% endhighlight %}

# Hasilnya

{% image https://i.postimg.cc/qR48MVf0/gambar-02.gif | 2 %}

# Demo

Untuk demonstrasi, teman-teman dapat mengunjungi alamat di bawah ini.

[https://daftar-dosen-umb.vercel.app](https://daftar-dosen-umb.vercel.app){:target="_blank"}

# Source

Bagi yang memerlukan source codenya, dapat mengunjungin alamat di bawah ini.

[https://github.com/bandithijo/ruby-web-scraper-dosen](https://github.com/bandithijo/ruby-web-scraper-dosen){:target="_blank"}

# Pesan Penulis

Sepertinya, segini dulu yang saya tuliskan.

Penjelasan dari masing-masing blok kode akan saya tuliskan pada kesempatan yang lain yaa.

Mudah-mudahan kalau teman-teman mampir ke post ini, sudah ada penjelasan per blok kodenya.

Terima kasih sudah mampir.

(^_^)



# Referensi

1. [It's Time To HTTParty!](https://blog.teamtreehouse.com/its-time-to-httparty){:target="_blank"}
<br>Diakses tanggal: 2020/08/20

2. [nokogiri.org](https://nokogiri.org/){:target="_blank"}
<br>Diakses tanggal: 2020/08/20
