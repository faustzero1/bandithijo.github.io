---
layout: 'post'
title: "Visualisasi Data Wilayah dengan Datamaps pada Rails"
date: 2021-02-07 23:48
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Javascript', 'Rails']
pin:
hot:
contributors: []
description: "Mungkin teman-teman pernah melihat interaktif peta yang memvisualisasikan data tertentu, misal data jumlah penduduk setiap provinsi yang ditampilkan dalam bentuk peta. Catatan kali ini saya akan membahas bagaimana cara membuat hal tersebut dengan datamaps Javascript library pada Rails."
---

# Requirements

`ruby 2.7.2` `rails 6.1.1` `datamaps 0.5.9`

# Latar Belakang

Misalkan saya memiliki sebuah data peta sebaran kasus kumulativ COVID-19 seluruh provinsi di Indonesia.


| fetched_at | name        | total_cases | total_recovered | total_deaths | active_cases |
| :--        | :--         | --:         | --:             | --:          | --:          |
| 2021-02-07 | DKI Jakarta | 293825      | 265291          | 4573         | 23961        |
| 2021-02-07 | Jawa Barat  | 167707      | 134255          | 2039         | 31413        |
| 2021-02-07 | Jawa Tengah | 135552      | 86400           | 5646         | 43506        |
| 2021-02-07 | Jawa Timur  | 117851      | 103219          | 8152         | 6480         |
| 2021-02-07 | Jawa Timur  | 117851      | 103219          | 8152         | 6480         |
| ...        | ...         | ...         | ...             | ...          | ...          |

Saya ingin membuat sebuah visualisasi data peta Indonesia yang terbagi-bagi berdasarkan wilayah provinsi. Kemudian pada masing-masing provinsi tersebut menampilkan data total kasus (total_cases).

Kira-kira ilustrasinya seperti ini:


<div style="overflow:auto;">
<script src='https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.3/d3.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/topojson/1.6.9/topojson.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/datamaps/0.5.9/datamaps.idn.min.js'></script>

<div id="container1" style="position: relative; width: 890px; height: 400px; margin: 0 auto;"></div>

<script type="text/javascript">
//basic map config with custom fills, mercator projection
var map = new Datamap({
scope: 'idn',
element: document.getElementById('container1'),
setProjection: function (element) {
var projection = d3.geo.mercator()
.center([120, -5])
.rotate([0, 0])
.scale(4000 / 4)
var path = d3.geo.path()
.projection(projection);
return {path: path, projection: projection};
},
fills: {
defaultFill: '#dddddd',
'AAA': '#DB1836',
'BBB': '#F15A23',
'CCC': '#F89A1C',
'DDD': '#FFD500',
'EEE': '#C1D737',
'FFF': '#44B549',
'GGG': '#0EB049',
'HHH': '#016533',
},
data: {
'ID.AC': {fillKey: 'AAA', totalCases: '12.345'},
'ID.BA': {fillKey: 'AAA', totalCases: '12.345'},
'ID.BT': {fillKey: 'AAA', totalCases: '12.345'},
'ID.BE': {fillKey: 'BBB', totalCases: '12.345'},
'ID.JK': {fillKey: 'BBB', totalCases: '12.345'},
'ID.YO': {fillKey: 'BBB', totalCases: '12.345'},
'ID.GO': {fillKey: 'CCC', totalCases: '12.345'},
'ID.JA': {fillKey: 'CCC', totalCases: '12.345'},
'ID.JR': {fillKey: 'CCC', totalCases: '12.345'},
'ID.JT': {fillKey: 'DDD', totalCases: '12.345'},
'ID.JI': {fillKey: 'DDD', totalCases: '12.345'},
'ID.KB': {fillKey: 'DDD', totalCases: '12.345'},
'ID.KS': {fillKey: 'EEE', totalCases: '12.345'},
'ID.KT': {fillKey: 'EEE', totalCases: '12.345'},
'ID.KI': {fillKey: 'EEE', totalCases: '12.345'},
'ID.KU': {fillKey: 'CCC', totalCases: '12.345'},
'ID.BB': {fillKey: 'CCC', totalCases: '12.345'},
'ID.KR': {fillKey: 'CCC', totalCases: '12.345'},
'ID.LA': {fillKey: 'FFF', totalCases: '12.345'},
'ID.MU': {fillKey: 'FFF', totalCases: '12.345'},
'ID.MA': {fillKey: 'FFF', totalCases: '12.345'},
'ID.NB': {fillKey: 'GGG', totalCases: '12.345'},
'ID.NT': {fillKey: 'GGG', totalCases: '12.345'},
'ID.IB': {fillKey: 'GGG', totalCases: '12.345'},
'ID.PA': {fillKey: 'HHH', totalCases: '12.345'},
'ID.RI': {fillKey: 'HHH', totalCases: '12.345'},
'ID.SR': {fillKey: 'HHH', totalCases: '12.345'},
'ID.SE': {fillKey: 'FFF', totalCases: '12.345'},
'ID.ST': {fillKey: 'FFF', totalCases: '12.345'},
'ID.SG': {fillKey: 'FFF', totalCases: '12.345'},
'ID.SW': {fillKey: 'FFF', totalCases: '12.345'},
'ID.SB': {fillKey: 'GGG', totalCases: '12.345'},
'ID.SL': {fillKey: 'GGG', totalCases: '12.345'},
'ID.SU': {fillKey: 'GGG', totalCases: '12.345'}
},
geographyConfig: {
popupTemplate: function(geo, data) {
return ['<div class="hoverinfo"><strong>',
geo.properties.name + '</strong><br>Kasus (Kulumatif)',
': ' + data.totalCases,
'</div>'].join('');
}
}
});
</script>
</div>

Visualisasi peta di atas menggunakan bantuan **datamaps** yang menggunakan **D3.js** library.

> *Datamaps is intended to provide some data visualizations based on geographical data. It's **SVG-based**, can scale to any screen size, and includes everything inside of 1 script file. It heavily relies on the amazing **D3.js** library*.

# Permasalahan

Bagaimana caranya menghubungkan data yang ada di database Rails, dengan datamaps.

# Pemecahan Masalah

Kalau kita lihat pada bagian `data: {...}`,

{% highlight_caption app/views/data_peta/index.html.erb %}
{% highlight javascript linenos %}
// ...

    fills: {
      defaultFill: '#dddddd',
      'AAA': '#DB1836',
      'BBB': '#F15A23',
      'CCC': '#F89A1C',
      'DDD': '#FFD500',
      // ...
    },
    data: {
      'ID.AC': {fillKey: 'AAA', totalCases: '12.345'},
      'ID.BA': {fillKey: 'BBB', totalCases: '12.345'},
      'ID.BT': {fillKey: 'CCC', totalCases: '12.345'},
      'ID.BE': {fillKey: 'DDD', totalCases: '12.345'},
      // ...
    },
{% endhighlight %}

Data contohnya seperti di atas.

Kita akan mengganti data statis tersebut dengan data yang ada di database yang kita miliki.

## ActionController

Kalau melihat format data di atas pada baris 12-15, `data: {...}` tersebut memiliki format persatuan data, seperti ini:

```javascript
'ID.AC': {fillKey: 'AAA', totalCases: '12.345'},
```

Nah, artinya kita bisa membuat format seperti ini pada controller.

{% highlight_caption app/controllers/data_peta_controller.rb %}
{% highlight ruby linenos %}
@last_updated     = Province.last.fetched_at
@cumulative_cases = Province.select(:name, :total_cases)
  .where(fetched_at: @last_updated)
  .map { |n|
    "'#{n.name}': {fillKey: 'AAA', totalCases: 'n.total_cases'},\n"
  }.join
{% endhighlight %}

Pada baris 1, saya mengambil tanggal dari data terakhir.

Baris 2, saya memanggil Object Province dan melakukan SELECT terhadap field yang diperlukan saja, yaitu field `:nama` dan `:total_cases`.

Baris 3, saya hanya mengambil data pada tanggal paling baru di database yang saya simpan pada variable @last_updated.

Baris 4-5 saya melakukan mapping untuk agar value yang dikembalikan dalam bentuk array.

```ruby
=> ["'DKI Jakarta': {fillKey: 'AAA', totalCases: '293825'},\n", "'Jawa Barat': {fillKey: 'AAA', totalCases: '167707'},\n", "'Jawa Tengah': {fillKey: 'AAA', totalCas...
```

Baris 6, saya menggunakan method `.join` untuk membuat array mejadi string yang nantinya, pada view template, akan menggunakan method `raw()` untuk melakukan escaping string.

```ruby
=> "'DKI Jakarta': {fillKey: 'AAA', totalCases: '293825'},\n'Jawa Barat': {fillKey: 'AAA', totalCases: '167707'},\n'Jawa Tengah': {fillKey: 'AAA', totalCases: '1355...
```

<br>
### Mengkonversi Nama Provinsi ke Kode Provinsi

Kalau teman-teman perhatikan, bagian nama provinsi dan `fillKey:` masih belum sesuai dengan format yang diperlukan.

Karena nama provinsi harus berupa kode ISO format dari provinsi tersebut,

Misal untuk Aceh berarti kodenya adalah `ID.AC`.

Lantas, kita perlu melakukan konversi terhadap data `:name` terlebih dahulu.

Caranya mudah, saya tinggal buatkan sebuah method baru yang saya beri nama,

`convert_name_to_province_code(province_name)`.

Agar controller saya tetap bersih, saya akan menggunakan controller concern saja.

{% highlight_caption app/controllers/concerns/convert_name_to_province_code.rb %}
{% highlight ruby linenos %}
module ConvertProvNameToProvCode
  def convert_name_to_province_code(province_name)
    provinces = {
      'Aceh'                       => 'ID.AC',
      'Bali'                       => 'ID.BA',
      'Banten'                     => 'ID.BT',
      'Bengkulu'                   => 'ID.BE',
      'DKI Jakarta'                => 'ID.JK',
      'Daerah Istimewa Yogyakarta' => 'ID.YO',
      'Gorontalo'                  => 'ID.GO',
      'Jambi'                      => 'ID.JA',
      'Jawa Barat'                 => 'ID.JR',
      'Jawa Tengah'                => 'ID.JT',
      'Jawa Timur'                 => 'ID.JI',
      'Kalimantan Barat'           => 'ID.KB',
      'Kalimantan Selatan'         => 'ID.KS',
      'Kalimantan Tengah'          => 'ID.KT',
      'Kalimantan Timur'           => 'ID.KI',
      'Kalimantan Utara'           => 'ID.KU',
      'Kepulauan Bangka Belitung'  => 'ID.BB',
      'Kepulauan Riau'             => 'ID.KR',
      'Lampung'                    => 'ID.LA',
      'Maluku'                     => 'ID.MA',
      'Maluku Utara'               => 'ID.MU',
      'Nusa Tenggara Barat'        => 'ID.NB',
      'Nusa Tenggara Timur'        => 'ID.NT',
      'Papua'                      => 'ID.PA',
      'Papua Barat'                => 'ID.IB',
      'Riau'                       => 'ID.RI',
      'Sulawesi Barat'             => 'ID.SR',
      'Sulawesi Selatan'           => 'ID.SE',
      'Sulawesi Tengah'            => 'ID.ST',
      'Sulawesi Tenggara'          => 'ID.SG',
      'Sulawesi Utara'             => 'ID.SW',
      'Sumatera Barat'             => 'ID.SB',
      'Sumatera Selatan'           => 'ID.SL',
      'Sumatera Utara'             => 'ID.SU'
    }

    provinces[province_name] if provinces.include? province_name
  end
end
{% endhighlight %}

Oke, setelah jadi, tinggal di-include-kan ke data_peta_controller.rb.

{% highlight_caption app/controllers/data_peta_controller.rb %}
{% highlight ruby linenos %}
class DataPetaController < ApplicationController
  include ConvertProvNameToProvCode

  def index
    # ...
  end
end
{% endhighlight %}

<br>
### Mengklasifikasi total_cases Berdasaran Warna

Selanjutnya kita perlu mengklasifikasi jumlah dari `total_cases` ke dalam format warna yang tersedia.

{% pre_whiteboard %}
'AAA': '#DB1836'
'BBB': '#F15A23'
'CCC': '#F89A1C'
'DDD': '#FFD500'
'EEE': '#C1D737'
'FFF': '#44B549'
'GGG': '#0EB049'
'HHH': '#016533'
{% endpre_whiteboard %}

Anggaplah 'AAA' adalah yang paling banyak dan 'HHH' yang paling sedikit.

Saya akan menggunakan controller concern lagi yang saya beri nama,

`convert_total_cases_to_code(total_cases)`

{% highlight_caption app/controllers/concerns/convert_total_cases_to_code.rb %}
{% highlight ruby linenos %}
module ConvertTotalCasesToCode
  def convert_total_cases_to_code(total_cases)
    case total_cases
    when 200_000..300_000
      'AAA'
    when 150_000..200_000
      'BBB'
    when 90_000..150_000
      'CCC'
    when 70_000..90_000
      'DDD'
    when 50_000..70_000
      'EEE'
    when 30_000..50_000
      'FFF'
    when 10_000..30_000
      'GGG'
    when 100..10_000
      'HHH'
    end
  end
end
{% endhighlight %}

Oke, setelah jadi, tinggal di-include-kan ke data_peta_controller.rb.

{% highlight_caption app/controllers/data_peta_controller.rb %}
{% highlight ruby linenos %}
class DataPetaController < ApplicationController
  include ConvertProvNameToProvCode
  include ConvertTotalCasesToCode

  def index
    # ...
  end
end
{% endhighlight %}

<br>
### Memberikan Delimiter , untuk Ribuan

Data **total_cases** tidak memiliki format string berupa delimiter koma (,) untuk memberikan kemudahan dalam membaca satuan ribuan dalam nominal angka.

Rails sudah menyediakan helper method untuk menghandle ini namun adanya di view template yang disediakan oleh ActionView yang bernama `number_with_delimiter(number, options = {})`.

Apakah bisa digunakan di Controller?

Kalau tidak ada, apakah kita perlu membuat sendiri?

Apakah di ActionController ada juga method helper yang sama?

Mudahnya tinggal kita include saja `ActionView::Helpers::NumberHelper`.

{% highlight_caption app/controllers/data_peta_controller.rb %}
{% highlight ruby linenos %}
class DataPetaController < ApplicationController
  include ConvertProvNameToProvCode
  include ConvertTotalCasesToCode
  include ActionView::Helpers::NumberHelper

  def index
    # ...
  end
end
{% endhighlight %}

Selanjutnya tinggal kita gunakan pada object query yang sudah kita racik sebelumnya.

{% highlight_caption app/controllers/data_peta_controller.rb %}
{% highlight ruby linenos %}
class DataPetaController < ApplicationController
  include ConvertProvNameToProvCode
  include ConvertTotalCasesToCode
  include ActionView::Helpers::NumberHelper

  def index
    @last_updated     = Province.last.fetched_at
    @cumulative_cases = Province.select(:name, :total_cases)
      .where(fetched_at: @last_updated)
      .map { |n|
        "'#{convert_name_to_province_code(n.name)}': {fillKey: '#{convert_total_cases_to_code(n.total_cases)}', totalCases: '#{number_with_delimiter(n.total_cases, delimiter: ',')}'},\n"
      }.join
  end
end
{% endhighlight %}

Instance variable `@cumulative_cases` inilah yang akan kita gunakan pada view template.

## ActionView

Setelah selesai membuat object query di controller, selanjutnya tinggal kita gunakan di view template.

Tapi sebelumnya, kita perlu untuk menyiapkan beberapa Javascript library yang akan diperlukan oleh datamaps.

1. [**d3.min.js**](https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.3/d3.min.js){:target="_blank"}

2. [**topojson.min.js**](https://cdnjs.cloudflare.com/ajax/libs/topojson/1.6.9/topojson.min.js){:target="_blank"}

3. [**datamaps.idn.min.js**](https://cdnjs.cloudflare.com/ajax/libs/datamaps/0.5.9/datamaps.idn.min.js){:target="_blank"}, saya menggunakan datamaps wilayah Indonesia.

Kita akan letakkan pada direktori **vendor/assets/javascripts/** saja.

<pre>
.
├─ app/
├─ bin/
├─ config/
├─ db/
├─ lib/
├─ log/
├─ node_modules/
├─ public/
├─ spec/
├─ storage/
├─ tmp/
├─ vendor/
│   └─ assets/
│      └─ javascripts/
│         ├─ <mark>d3.min.js</mark>
│         ├─ <mark>topojson.min.js</mark>
│         └─ <mark>datamaps.idn.min.js</mark>
│
├─ Gemfile
...
</pre>

Buatkan struktur seperti di atas.

Kemudian, kita akan masukkan kepada daftar assets precompile, di **config/initializers/assets.rb**.

{% highlight_caption config/initializers/assets.rb %}
{% highlight ruby linenos %}
# Be sure to restart your server when you modify this file.

# ...

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w(
  d3.min.js topojson.min.js datamaps.idn.min.js
)
{% endhighlight %}

Tambahkan seperti pada baris 8, 9, 10.

Mantap!

Sekarang kita lanjut ke view template.

{% highlight_caption app/views/data_peta/index.html.erb %}
{% highlight eruby linenos %}
<div class="container px-0 pt-2 pb-5 mt-5" style="overflow-y: auto">
  <%= javascript_include_tag 'd3.min' %>
  <%= javascript_include_tag 'topojson.min' %>
  <%= javascript_include_tag 'datamaps.idn.min' %>

  <div id="container1" style="position: relative; width: 1100px; height: 400px; margin: 0 auto;"></div>

  <script type="text/javascript">
    //basic map config with custom fills, mercator projection
    var map = new Datamap({
      scope: 'idn',
      element: document.getElementById('container1'),
      setProjection: function (element) {
        var projection = d3.geo.mercator()
          .center([115, -5])
          .rotate([0, 0])
          .scale(3900 / 3)
        var path = d3.geo.path()
          .projection(projection);
        return {path: path, projection: projection};
      },
      fills: {
        defaultFill: '#dddddd',
        'AAA': '#DB1836',
        'BBB': '#F15A23',
        'CCC': '#F89A1C',
        'DDD': '#FFD500',
        'EEE': '#C1D737',
        'FFF': '#44B549',
        'GGG': '#0EB049',
        'HHH': '#016533',
      },
      data: {
        <%= raw @cumulative_cases %>
      },
      geographyConfig: {
        popupTemplate: function(geo, data) {
          return ['<div class="hoverinfo"><strong>',
            geo.properties.name + '</strong><br>Kasus (Kulumatif)',
            ': ' + data.totalCases,
            '</div>'].join('');
        }
      }
    });
  </script>
</div>
{% endhighlight %}

Baris 2, 3, 4, adalah cara memanggil Javascript library yang kita masukkan ke dalam direktori vendor sebelumnya.

Baris 34, adalah cara memanggil instance variable `@cumulative_cases` yang telah kita buat object querynya di **app/controllers/data_peta_controller.rb**.

Selesai!

Hanya seperti itu saja.

Apabila dirasa ada yan kurang pas, teman-teman bisa memodifikiasi dan memperbaiki sesuai keinginan.











# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)




# Referensi

1. [github.com/markmarkoh/datamaps](https://github.com/markmarkoh/datamaps){:target="_blank"}
<br>Diakses tanggal: 2021/02/07

2. [http://datamaps.github.io/](http://datamaps.github.io/){:target="_blank"}
<br>Diakses tanggal: 2021/02/07

3. [github.com/d3/d3](https://github.com/d3/d3){:target="_blank"}
<br>Diakses tanggal: 2021/02/07

4. [api.rubyonrails.org/classes/ActionView/Helpers/NumberHelper.html#method-i-number_with_delimiter](https://api.rubyonrails.org/classes/ActionView/Helpers/NumberHelper.html#method-i-number_with_delimiter){:target="_blank"}
<br>Diakses tanggal: 2021/02/07
