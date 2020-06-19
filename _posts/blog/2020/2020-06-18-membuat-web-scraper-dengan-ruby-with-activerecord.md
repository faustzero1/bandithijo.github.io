---
layout: 'post'
title: "Membuat Web Scraper dengan Ruby (Output: POSTGRESQL: ACTIVERECORD)"
date: 2020-06-18 11:06
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

Hasil yang akan di dapatkan dari script yang akan kita buat adalah daftar nama-nama dosen beserta nidn dalam bentuk tabel di dalam database PostgreSQL. Kita akan memasukkan data menggunakan Active Record yang merupakan salah satu komponen dari Ruby on Rails yang digunakan untuk menghandle model.

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

gem 'httparty',              '~> 0.18.1'
gem 'nokogiri',              '~> 1.10', '>= 1.10.9'
gem 'byebug',                '~> 11.1', '>= 11.1.3'
gem 'activerecord',          '~> 6.0', '>= 6.0.3.2'
gem 'standalone_migrations', '~> 6.0'
gem 'pg',                    '~> 1.2', '>= 1.2.3'
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
     Active: active (running) since Thu 2020-06-18 11:06:53 WITA; 1m ago
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

Selanjutnya, untuk melihat database dan table, teman-tema dapat mengguakan **PostBird** (Database Management GUI) atau **pgcli**, saya akan menggunakan **pgcli**.

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
Pada tahap ini, kita **tidak perlu membuat database secara manual**, kita akan membuat database dengan bantuan **rake**.

Langkah pertama adalah membuat `Rakefile` di root direktori kita.

<pre>
ruby-web-scraper-dosen/
├── Gemfile
├── Gemfile.lock
└── <mark>Rakefile</mark>
</pre>

Isi `Rakefile` seperti di bawah ini.

{% highlight ruby linenos %}
require 'standalone_migrations'
StandaloneMigrations::Tasks.load_tasks
{% endhighlight %}

Selanjutnya kita perlu membuat database konfiguration `config.yml` pada direktori `db/`.

<pre>
ruby-web-scraper-dosen/
├── db/
│   └── <mark>config.yml</mark>
├── Gemfile
├── Gemfile.lock
└── Rakefile
</pre>

Lalu isikan `config.yml` seperti di bawah.

{% highlight yaml linenos %}
development:
  adapter: postgresql
  database: web_scraper_development
  pool: 5
  timeout: 5000
  host: localhost
  encoding: unicode
{% endhighlight %}

`web_scraper_development` adalah nama database yang akan kita gunakan.

Kalau sudah, sekarang kita akan membuat database dengan cara, buka Terminal dan jalankan perintah,

<pre>
$ <b>rake db:create</b>
</pre>

```
Created database 'web_scraper_development'
```

Perintah di atas akan menjalankan **rake** untuk membuat database dengan nama `web_scraper_development` seperti yang sudah kita definisikan pada file `config.yml`.

<!-- INFORMATION -->
<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>Untuk menghapus database, gunakan perintah:</p>
<pre>
$ <b>rake db:drop</b>
</pre>
<pre>
Dropped database 'web_scraper_development'
</pre>
</div>

Setelah database dibuat, kita perlu membuat tabel untuk menyimpan data-data yang sudah kita parsing dari wbesite target.

Untuk membuat tabel, kita akan menggunakan migration.

Buat migration dengan cara seperti di bawah, dan berikan nama, seperti:

1. `CreateDaftarDosens` (CamelCase), atau
2. `create_daftar_dosens` (snake_case)

<pre>
$ <b>rake db:new_migration name=CreateDaftarDosens</b>
</pre>

**atau**,

<pre>
$ <b>rake db:new_migration name=create_daftar_dosens</b>
</pre>

Perintah migrasi di atas akan membuat sebuah file migrasi.

<pre>
created db/migration/20200618031037_create_daftar_dosens.rb
</pre>

<pre>
ruby-web-scraper-dosen/
├── db/
│   ├── config.yml
│   └── migrate/
│       └── <mark>20200618031037_create_daftar_dosens.rb</mark>
│
├── Gemfile
├── Gemfile.lock
└── Rakefile
</pre>

Apabila kita membuat migrasi lagi, maka file-file migrasi akan terdapat pada direktori `db/migrate/`.

Migrasi yang kita buat di atas, dari namanya tentu sudah terbayang fungsinya adalah untuk membuat tabel dengan nama `daftar_dosens`. Penamanan tabel yang berbentuk jamak merupakan *convention* dari Ruby on Rails.

Pemberian awalan `Create` atau `create_` pada awal migrasi memiliki maksud tertentu, yaitu untuk membuat tabel/schema. Dengan menambahkan awalan tersebut maka, isi dari file migrasi akan otomatis berbentuk seperti di bawah ini.

{% highlight ruby linenos %}
class CreateDaftarDosens < ActiveRecord::Migration[6.0]
  def change
    create_table :daftar_dosens do |t|
    end
  end
end
{% endhighlight %}

Bari ke 3 & 4 adalah baris yang secara pintar dibuatkan apabila kita menambahkan awalan `Create` atau `create_` pada nama migrasi. Enak banget yaa (^_^)

Selanjutnya, kita perlu menyempurnakan file migrasi. Kita perlu menambahkan nama kolom yang kita perlukan, yaitu kolom **nama_dosen** dan **nidn_dosen**.

{% highlight ruby linenos %}
class CreateDaftarDosens < ActiveRecord::Migration[6.0]
  def change
    create_table :daftar_dosens do |t|
      t.string :nama_dosen, null: false
      t.string :nidn_dosen
    end
  end
end
{% endhighlight %}

Setelah kita memodifikasi file migrasi `..._create_daftar_dosens.rb`, selanjutnya adalah menjalankan migrasi tersebut.

<pre>
$ <b>rake db:migrate</b>
</pre>

```
== 20200618031037 CreateDaftarDosens: migrating ===============================
-- create_table(:daftar_dosens)
   -> 0.0103s
== 20200618031037 CreateDaftarDosens: migrated (0.0104s) ======================
```
Kalau migrasi berhasil, outputnya akan seperti di atas.

Untuk mengecek status migrasi, gunakan perintah di bawah.

<pre>
$ <b>rake db:migrate:status</b>
</pre>

```
database: web_scraper_development

 Status   Migration ID    Migration Name
--------------------------------------------------
   up     20200618031037  Create daftar dosens

```

Terlihat, bahwa status migrasi dari "Create daftar dosens" sudah **up**. Artinya, sekarang pada database `web_scraper_development` sudah terdapat tabel bernama `daftar_dosens`.

Untuk mengeceknya, buka **pgcli** dan jalankan perintah di bawah.

<pre>
web_scraper> <b>\dt</b>
</pre>

<pre>
+----------+----------------------+--------+------------+
| Schema   | Name                 | Type   | Owner      |
|----------+----------------------+--------+------------|
| public   | ar_internal_metadata | table  | bandithijo |
<mark>| public   | daftar_dosens        | table  | bandithijo |</mark>
| public   | schema_migrations    | table  | bandithijo |
+----------+----------------------+--------+------------+
SELECT 3
Time: 0.014s
</pre>

Untuk melihat detail dari tabel, gunakan perintah di bawah.

<pre>
web_scraper> <b>\d daftar_dosens;</b>
</pre>

<pre>
+------------+-------------------+-------------------------------------------------------------+
| Column     | Type              | Modifiers                                                   |
|------------+-------------------+-------------------------------------------------------------|
| id         | bigint            |  not null default nextval('daftar_dosens_id_seq'::regclass) |
| nama_dosen | character varying |  not null                                                   |
| nidn_dosen | character varying |                                                             |
+------------+-------------------+-------------------------------------------------------------+
Indexes:
    "daftar_dosens_pkey" PRIMARY KEY, btree (id)

Time: 0.026s
</pre>

Tentu saja tabel tersebut belum ada isinya.

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

# Demonstrasi Video

{% include youtube_embed.html id="2zYDrEaj9EQ" %}




# Referensi

1. [It's Time To HTTParty!](https://blog.teamtreehouse.com/its-time-to-httparty){:target="_blank"}
<br>Diakses tanggal: 2020/06/18

2. [nokogiri.org](https://nokogiri.org/){:target="_blank"}
<br>Diakses tanggal: 2020/06/18

3. [pg documentation](https://deveiate.org/code/pg/){:target="_blank"}
<br>Diakses tanggal: 2020/06/18

4. [pgcli](https://www.pgcli.com/){:target="_blank"}
<br>Diakses tanggal: 2020/06/18

5. [Cannot read from /tmp with PostgreSQL COPY, but able to read the same file from another directory with the exact same permissions](https://dba.stackexchange.com/questions/114568/cannot-read-from-tmp-with-postgresql-copy-but-able-to-read-the-same-file-from){:target="_blank"}
<br>Diakses tanggal: 2020/06/18
