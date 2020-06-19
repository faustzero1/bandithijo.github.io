---
layout: 'post'
title: "Membuat Web Scraper dengan Ruby (Output: POSTGRESQL: COPY FROM CSV)"
date: 2020-06-16 18:49
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Ruby']
pin:
hot:
---

<!-- INFORMATION -->
<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Disclaimer</div>
<p>Data yang penulis gunakan adalah data yang bersifat <b><i>free public data</i></b>. Sehingga, siapa saja dapat mengakses dan melihat tanpa perlu melalui layer authentikasi.</p>
<p>Penyalahgunaan data, bukan merupakan tanggung jawab dari penulis seutuhnya.</p>
</div>

# Pendahuluan

*Web scraping* adalah teknik mengambil atau mengekstrak sebagian data dari suatu website secara spesifik, spesifik dalam arti hanya data tertentu saja yang diambil. Script atau program untuk melakukan hal tersebut, disebut dengan *web scraper*.

# Objektif

Catatan kali ini saya akan mendokumentasikan proses dalam membuat *web scraper* dengan tujuan untuk mengambil data nama-nama dosen yang ada pada website resmi Biro Akademik Universitas Mulia Balikpapan yang ada pada halaman [ini](http://baak.universitasmulia.ac.id/dosen/){:target="_blank"}.

Hasil yang akan di dapatkan dari script yang akan kita buat adalah daftar nama-nama dosen beserta nidn dalam bentuk tabel di dalam database PostgreSQL.

# Penerapan

Langkah awal adalah persiapkan direktori untuk proyek.

Saya akan beri nama `ruby-web-scraper-dosen`.

Biasakan untuk memberi nama proyek tidak menggunakan karakter **spasi**.

<pre>
$ <b>mkdir ruby-web-scraper-dosen</b>
</pre>

Kemudian masuk ke dalam direktori proyek.

<pre>
$ <b>cd ruby-web-scraper-dosen</b>
</pre>

Buat file dengan nama `Gemfile`. dan kita akan memasang gem yang diperlukan di dalam file ini.

{% highlight ruby linenos %}
source 'https://rubygems.org'

gem 'httparty',     '~> 0.18.1'
gem 'nokogiri',     '~> 1.10', '>= 1.10.9'
gem 'byebug',       '~> 11.1', '>= 11.1.3'
gem 'pg',           '~> 1.2', '>= 1.2.3'
{% endhighlight %}

Setelah memasang gem pada Gemfile, kita perlu melakukan instalasi gem-gem tersebut.

<pre>
$ <b>bundle install</b>
</pre>

Proses bundle install di atas akan membuat sebuah file baru bernama `Gemfile.lock` yang berisi daftar dependensi dari gem yang kita butuhkan --daftar requirements--.

Pastikan kalau service dari PostgreSQL sudah berjalan.

<pre>
$ <b>sudo systemctl status postgresql.service</b>
</pre>

```
● postgresql.service - PostgreSQL database server
     Loaded: loaded (/usr/lib/systemd/system/postgresql.service; disabled; vendor preset: disabled)
     Active: active (running) since Thu 2020-06-18 11:06:53 WITA; 8h ago
   Main PID: 36698 (postgres)
      Tasks: 8 (limit: 4610)
     Memory: 28.9M
     CGroup: /system.slice/postgresql.service
             ├─ 36698 /usr/bin/postgres -D /var/lib/postgres/data
             ├─ 36700 postgres: checkpointer
             ├─ 36701 postgres: background writer
             ├─ 36702 postgres: walwriter
             ├─ 36703 postgres: autovacuum launcher
             ├─ 36704 postgres: stats collector
             ├─ 36705 postgres: logical replication launcher
             └─397565 postgres: bandithijo web_scraper [local] idle
```

Selanjutnya, kita harus membuat database. Teman-tema dapat mengguakan **PostBird** (Database Management GUI) atau **pgcli**, saya akan menggunakan **pgcli**.

Jalankan **pgcli**,

<pre>
$ <b>pgcli</b>
</pre>

```
Server: PostgreSQL 12.3
Version: 3.0.0
Chat: https://gitter.im/dbcli/pgcli
Home: http://pgcli.com
bandithijo>
```
Dan buat database dengan nama `web_scraper`.

<pre>
bandithijo> <b>CREATE DATABASE web_scraper;</b>
</pre>

```
CREATE DATABASE
Time: 0.271s
```

Setelah database sudah dibuat, sekarang kita akan membuat aktor utamanya.

Beri nama `scraper.rb`.

{% highlight ruby linenos %}
# daftar gem yang diperlukan
require 'httparty'
require 'nokogiri'
require 'byebug'

def scraper
  # blok ini bertugas untuk mengambil data dengan output berupa variabel array
  target_url = "http://baak.universitasmulia.ac.id/dosen/"
  unparsed_page = HTTParty.get(target_url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  dosens = Array.new
  dosen_listings = parsed_page.css('div.elementor-widget-wrap')
  dosen_listings.each do |dosen_list|
    dosen = {
      # perlu mengganti ' dengan ` agar tidak mengacaukan proses input data nama
      nama_dosen: dosen_list.css("h2")[0]&.text&.gsub("\n", "")&.gsub(/'/, "`")&.squeeze,
      nidn_dosen: dosen_list.css("h2")[1]&.text&.gsub("\n", "")
    }
    if dosen[:nama_dosen] != nil
      dosens << dosen   # dosens, variable array yang menampung data para dosen
    end
  end
  # aktifkan byebug apabila diperlukan
  #byebug

  # blok ini bertugas untuk membuat file csv yang berisi daftar dosen
  File.open("/data/daftar_dosen.csv", "w") do |f|
    f.puts "id;nama_dosen;nidn_dosen"
    dosens.each.with_index(1) do |dosen, index|
      f.puts "#{index};#{dosen[:nama_dosen]};#{dosen[:nidn_dosen]}"
    end
  end

  begin
    # blok ini bertugas untuk membuat koneksi ke database engine
    conn = PG::Connection.open(dbname: 'web_scraper')

    # blok ini bertugas untuk membuat tabel dan menghapus apabila sudah ada
    conn.exec("DROP TABLE IF EXISTS daftar_dosens")
    conn.exec("CREATE TABLE daftar_dosens(
              id BIGSERIAL NOT NULL PRIMARY KEY,
              nama_dosen VARCHAR(100) NOT NULL,
              nidn_dosen VARCHAR(10))")

    # blok ini bertugas untuk memasukkan data ke dalam tabel database
    conn.exec("COPY daftar_dosens(id, nama_dosen, nidn_dosen) FROM '/data/daftar_dosen.csv' DELIMITER ';' CSV HEADER")
  rescue PG::Error => e
    puts e.message
  ensure
    conn.close if conn
  end

  puts "TOTAL DOSEN: #{dosens.count} orang"
end

scraper
{% endhighlight %}

Sebelum kita menjalankan perintah untuk memanggil sang aktor utama, kita perlu menyipakan tempat untuk file .csv yang akan kita simpan pada direktori `/data/`. Alasan kenapa kita perlu menyiapkan tempat khusus karena permasalahan dengan permission user postgres. Jadi untuk kemudahan, kita siapkan tempat khusus yang dapat digunakan oleh keduabelah pihak baik user kita dan user postgres.

Saya sudah coba mengekspor file .csv ke direktori `/tmp/` dan mengimportnya, namun gagal dan mendapatkan pesan error seperti ini.

```
ERROR:  could not open file "/tmp/daftar_dosen.csv" for reading: No such file or directory
```

Terkadang juga pesan error nya adalah *permission denied*.

```
ERROR:  could not open file "/tmp/daftar_dosen.csv" for reading: Permission Denied
```

Berdasarkan rekomendasi dari jawaban yang diberikan pada [dba.stackexchange: Cannot read from /tmp with PostgreSQL COPY](https://dba.stackexchange.com/questions/114568/cannot-read-from-tmp-with-postgresql-copy-but-able-to-read-the-same-file-from){:target="_blank"} --saya mendemonstrasikan pada dokumentasi video di bawah--.

Maka dari itu saya mengakali dengan membuat sebuah temp direktori yang dapat diakses oleh keduabelah pihak.

Kita perlu membuat direktori `/data/` terlebih dahulu.

<pre>
$ <b>sudo mkdir /data</b>
</pre>

Kemudian, mount dengan tipe **tmpfs**.

<pre>
$ <b>sudo mount -t tmpfs -o rw tmpfs /data</b>
</pre>

Setelah itu, jalankan dengan perintah,

<pre>
$ <b>ruby scraper.rb</b>
</pre>

Apabila berhasil, akan keluar output di terminal seperti ini. Tidak ada error apapun kecuali output jumlah dosen.

```
TOTAL DOSEN: 138 orang
```

Sekarang, kita akan punya file .csv yang berada pada direktori `/data/daftar_dosen.csv`.

```
id;nama_dosen;nidn_dosen
1;Abdul Fatah;1114107001
2;Abdul Hamid Kurniawan, S.kom., M.TI;1114107001
3;Abi Habibi;1114107001
...
...
136;Teguh Pribadi, S.H., M.H;-
137;Sampara, S.H., M.H.;-
138;Candra Bagus Agung P, S.E., M.M.;-
```

File .csv ini lah yang akan di import ke dalam database menggunakan SQL Query `COPY FROM`.

Sekarang coba cek ke database.

Masuk terlebih dahulu ke databse `web_scraper`.

<pre>
bandithijo> <b>\c web_scraper;</b>
</pre>

```
You are now connected to database "web_scraper" as user "bandithijo"
Time: 0.012s
web_scraper>
```

Setelah kita berada di dalam database `web_scraper` kita dapat melihat hasil dari data-data yang sudah diinputkan dengan cara.

<pre>
web_scraper> <b>SELECT * FROM daftar_dosens</b>
</pre>

```
+------+------------------------------------------------+--------------+
| id   | nama_dosen                                     | nidn_dosen   |
|------+------------------------------------------------+--------------|
| 1    | Abdul Fatah                                    | 1114107001   |
| 2    | Abdul Hamid Kurniawan, S.kom., M.TI            | 1114107001   |
| 3    | Abi Habibi                                     | 1114107001   |
| 4    | Abiratno, S.T., M.Sc.                          | 1107017201   |
| 5    | Dr. Agung Sakti Pribadi, S.H., M.H.            | 1131036301   |
| 6    | Alfa                                           | 9911002592   |
...
...
| 133  | Zara Zerina Azizah, S.Pd.I, S.E., M.M          | 1103039301   |
| 134  | Heru Zulkifli, S.Kom., M.Kom                   | 1115027501   |
| 135  | M.Andhi Rohmat Basuki, S.Kom., M.Kom           | -            |
| 136  | Teguh Pribadi, S.H., M.H                       | -            |
| 137  | Sampara, S.H., M.H.                            | -            |
| 138  | Candra Bagus Agung P, S.E., M.M.               | -            |
+------+------------------------------------------------+--------------+
SELECT 138
(END)
```

Selesai!

<!-- INFORMATION -->
<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>Apabila direktori <code>/data/</code> yang berlaku sebagai temp direktori sudah tidak digunakan, kita dapat meng-<i>unmount</i> dengan cara,</p>
<pre>
$ <b>sudo fusermount -u /data</b>
</pre>
</div>


# Demonstrasi Video

{% include youtube_embed.html id="qdFkae_mYbE" %}




# Referensi

1. [It's Time To HTTParty!](https://blog.teamtreehouse.com/its-time-to-httparty){:target="_blank"}
<br>Diakses tanggal: 2020/06/16

2. [nokogiri.org](https://nokogiri.org/){:target="_blank"}
<br>Diakses tanggal: 2020/06/16

3. [pg documentation](https://deveiate.org/code/pg/){:target="_blank"}
<br>Diakses tanggal: 2020/06/16

4. [pgcli](https://www.pgcli.com/){:target="_blank"}
<br>Diakses tanggal: 2020/06/16

5. [Cannot read from /tmp with PostgreSQL COPY, but able to read the same file from another directory with the exact same permissions](https://dba.stackexchange.com/questions/114568/cannot-read-from-tmp-with-postgresql-copy-but-able-to-read-the-same-file-from){:target="_blank"}
<br>Diakses tanggal: 2020/06/16
