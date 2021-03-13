---
layout: 'post'
title: "Export Data ke CSV pada Rails"
date: 2020-07-09 10:07
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Rails']
pin:
hot:
contributors: []
description:
---

# Prerequisite

`Ruby 2.6.6` `Rails 5.2.4` `PostgreSQL 12.3`

# Sekenario Masalah

Saya punya data yang ingin di-*eksport* ke dalam bentuk CSV (*Comma-Separated Value*).

# Pemecahan Masalah

Ruby menyediakan class CSV yang dapat kita gunakan untuk melakukan baca & tulis.dari Strings atau IO objects.

# Implementasi

Kita akan membuat tombol untuk men-download file CSV pada view template dan akan di-respon oleh controller.

## Controller

Saya akan mengawali dengan membuat response ke controller apabila tombol pada view template di tekan.

{% highlight_caption app/controllers/cases_controller.rb %}
{% highlight ruby linenos %}
class CasesController < ApplicationController

  def index
    @cases = Case.all

    respond_to do |format|
      format.html
      format.csv {
        send_data @cases.to_csv,
        filename: "COVID-19_INDO_PERHARI_#{@cases.last.fetched_at}.csv"
      }
    end
  end
end
{% endhighlight %}

Perhatikan bari ke-11, nantinya, kita akan membuat method `.to_csv()` pada model.

Apabila ingin merubah nama file, dapat merubah pada bagian `filename:...` di baris ke-12 tersebut.

## Model

Pada model, kita akan menggunakan CSV class yang sudah disediakan oleh Ruby untuk membuat atau menulis file CSV. Kita akan menggunakan method `.generate()`.

Buka model dari object yang akan kita tulis ke CSV.

{% highlight_caption app/models/case.rb %}
{% highlight ruby linenos %}
class Case < ApplicationRecord
  ...
  ...

  def self.to_csv
    attributes = %w(id fetched_at positif_covid meninggal_covid
                    sembuh_covid jumlah_odp jumlah_pdp)

    CSV.generate(headers: true, col_sep: ";") do |csv|
      csv << attributes

      all.find_each do |kasus|
        csv << attributes.map{ |attr| kasus.send(attr) }
      end
    end
  end
end
{% endhighlight %}

Perhatikan pada baris ke-8 `attributes = ...`, ini bernilai Array yang mewakili masing-masing field. Ini juga akan dijadikan sebagai header dari file CSV.

Baris ke-24 `col_sep: ";'`, adalah pendifinisian untuk *delimiter* atau batas yang digunakan untuk memisahkan antara data. Defaultnya menggunakan ",".

## View Template

Selanjutnya, kita buat link atau button yang akan di respon oleh controller.

{% highlight_caption app/views/cases/index.html.erb %}
{% highlight erb linenos %}
<%= link_to cases_path(format: "csv"), class: "button is-fullwidth-mobile" do %>
  <span class="icon">
    <%= image_tag 'file-download-solid.svg', width: '12' %>
  </span>
  <span class="has-text-weight-normal">Export as SpreadSheet</span>
<% end %>
{% endhighlight %}

Bagian yang harus diperhatikan adalah baris ke-3, `..._path(format: "csv")`.

Selesai!

# Pesan Penulis

Catatan ini bukan merupakan tutorial, saya hanya ingin memberikan gambaran betapa mudahnya mengeksport data ke dalam format **.csv** dari Rails menggunakan **CSV** class yang sudah disediakan oleh Ruby.

Maka dari itu, apabila teman-teman ingin mendapatkan penjelasan yang lebih baik, silahkan mengunjungin dokumentasi dari CSV class yang ada di ruby-doc.org. Tentunya akan lebih *up to date* dari yang saya tulis di sini.

Saya juga memanfaatkan gem ini untuk mengeksport data ke csv seperti yang saya lakukan di [bandithijo.github.io/covid19](https://bandithijo.github.io/covid19){:target="_blank"}

Saya rasa hanya ini yang dapat saya tuliskan saat ini.

Mudah-mudahan dapat bermanfaat untuk teman-teman.

Terima kasih.

(^_^)








# Referensi

1. [dev.to/victorhazbun/export-records-to-csv-files-with-rails-2778](https://dev.to/victorhazbun/export-records-to-csv-files-with-rails-2778){:target="_blank"}
<br>Diakses tanggal: 2020/07/09

2. [ruby-doc.org/stdlib-2.6.1/libdoc/csv/rdoc/CSV.html](https://ruby-doc.org/stdlib-2.6.1/libdoc/csv/rdoc/CSV.html){:target="_blank"}
<br>Diakses tanggal: 2020/07/09

3. [github.com/ruby/csv](https://github.com/ruby/csv){:target="_blank"}
<br>Diakses tanggal: 2020/07/09
