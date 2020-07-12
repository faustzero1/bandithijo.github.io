---
layout: 'post'
title: "Membuat Collection of Checkbox yang Berbasis Rentang pada Rails"
date: 2020-02-05 06:09
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Rails', 'jQuery']
pin:
hot:
contributors: []
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prerequisite

`Ruby 2.6.3` `Rails 5.2.3` `PostgreSQL 11.5`

# Prakata

Catatan kali ini, saya akan kembali mendokumentasikan tentang search filter yang menggunakan Ransack sebagai backend dengan tampilan frontend berupa checkbox.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/gjrXFksr/gambar-01.gif" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 1 - Rails view helper collection_check_boxes</p>

Seperti ilustrasi di atas, dapat teman-teman lihat, bahwa collection checkbox pada search filter panel tersebut memiliki rentang tertentu pada setiap listnya.

Hampir sama dengan tulisan saya sebelumnya, mengenai ["Membuat Input Select yang Berbasis Rentang pada Rails"](/blog/rails-input-select-based-on-range){:target="_blank"}, yang mana pada tulisan tersebut, saya menggunakan view helper berupa `select`, kali ini saya akan menggunakan view helper berupa `collection_check_boxes`.

Secara default, `collection_check_boxes` ini dapat menampung multiple value yang akan disimpan dalam bentuk array. Namun, untuk menyederhanakan proses pencarian, saya membuat `collection_check_boxes` hanya dapat dipilih satu saja dengan bantuan jQuery.

# Pemecahan Masalah

Masih sama seperti post sebelum ini.

Saya memanfaatkan **Ransack** sebagai search filter.

Ransack memiliki option pencarian untuk menghandle rentang, yaitu `_in`.

`_in`, *match any values in array*.

Selain array, dapat juga berupa tipe data range `x..y`.

Misal, seperti ilustrasi di atas.

Saya memiliki field bernama `price` (budget) dan `duration_id`.

Nah, sekarang saya akan mencoba bermain dengan Active Record.

```
irb(main):001:0> Experience.ransack(price_in: 100..300).result.pluck(:price).uniq
```
```
   (5.5ms)  SELECT "experiences"."price" FROM "experiences" LEFT OUTER JOIN "ratings" ON "ratings"."experience_id" = "experiences"."id" WHERE "experiences"."deleted_at" IS NULL AND "experiences"."price" IN ('100', '101', '102', '103', '104', '105', '106', '107', '108', '109', '110', '111', '112', '113', '114', '115', '116', '117', '118', '119', '120', '121', '122', '123', '124', '125', '126', '127', '128', '129', '130', '131', '132', '133', '134', '135', '136', '137', '138', '139', '140', '141', '142', '143', '144', '145', '146', '147', '148', '149', '150', '151', '152', '153', '154', '155', '156', '157', '158', '159', '160', '161', '162', '163', '164', '165', '166', '167', '168', '169', '170', '171', '172', '173', '174', '175', '176', '177', '178', '179', '180', '181', '182', '183', '184', '185', '186', '187', '188', '189', '190', '191', '192', '193', '194', '195', '196', '197', '198', '199', '200', '201', '202', '203', '204', '205', '206', '207', '208', '209', '210', '211', '212', '213', '214', '215', '216', '217', '218', '219', '220', '221', '222', '223', '224', '225', '226', '227', '228', '229', '230', '231', '232', '233', '234', '235', '236', '237', '238', '239', '240', '241', '242', '243', '244', '245', '246', '247', '248', '249', '250', '251', '252', '253', '254', '255', '256', '257', '258', '259', '260', '261', '262', '263', '264', '265', '266', '267', '268', '269', '270', '271', '272', '273', '274', '275', '276', '277', '278', '279', '280', '281', '282', '283', '284', '285', '286', '287', '288', '289', '290', '291', '292', '293', '294', '295', '296', '297', '298', '299', '300')

=> ["250", "150"]
```

```
irb(main):002:0> Experience.ransack(duration_id_in: 1..8).result.pluck(:duration_id).uniq
```
```
   (2.1ms)  SELECT "experiences"."duration_id" FROM "experiences" LEFT OUTER JOIN "ratings" ON "ratings"."experience_id" = "experiences"."id" WHERE "experiences"."deleted_at" IS NULL AND "experiences"."duration_id" IN (1, 2, 3, 4, 5, 6, 7, 8)

=> [8, 6, 4, 5, 7, 3, 2]
```

Kira-kira seperti itu.

Tinggal dibuatkan frontend nya.


## Controller

Search filter ini akan tampil pada halaman Experience index.

```ruby
# app/controllers/experiences_controller.rb

class ExperiencesController < ApplicationController
  def index
    @search = Experience.ransack(params[:q])
    @experiences = @search.result(distinct: true).order(:id)
  end

  ...
  ...
end
```

## Routes

Seperti biasa, saya memberikan route untuk action index.

```ruby
# config/routes.rb

Rails.application.routes.draw do
  resources :experiences, only: %w[index ... ...] do
  ...
  ...
end
```

## View Template

Contoh blok html di bawha ini hanya sebagai dummy.

Hanya blok kode ERB saja yang perlu diperhatikan.


```erb
<!-- app/views/experiences/index.html -->

<%= search_form_for @search, url: experiences_path do |f| %>
  <div class="position-relative">
    <div class="row column-search">
      ...
      ...
      ...

      <!-- Budget Range Collection Check Boxes -->
      <div class="border-bottom" id="filter-tour-budget">
        <div class="d-flex justify-content-between ">
          <span>Tour Budget</span>
          <a class="font-size-12 clear-all" data-clear="filter-tour-budget">
            <div id="clearAllBudget">clear all</div>
          </a>
        </div>
        <div class="checkbox-box" id="budget-checkbox">
          <%= f.collection_check_boxes :price_in,
                                       [['Below RM100',     1..100],
                                        ['RM101 - RM300',   101..300],
                                        ['RM301 - RM500',   301..500],
                                        ['RM501 and above', 501..1000]],
                                        :second, :first,
                                        checked: "#{(params[:q][:price_in] rescue nil)}" do |b| %>
            <div class="form-check d-flex">
              <%= b.check_box class: 'custom-control-input budget', name: 'q[price_in]' %>
              <%= b.label class: 'custom-control-label' %>
            </div>
          <% end %>
        </div>
      </div>
      <!-- END Budget Range Collection Check Boxes -->

      <!-- Duration Collection Check Boxes -->
      <div class="border-bottom" id="filter-tour-duration">
        <div class="d-flex justify-content-between ">
          <span>Tour Duration</span>
          <a class="font-size-12 clear-all" data-clear="filter-tour-duration">
            <div id="clearAllDuration">clear all</div>
          </a>
        </div>
        <div class="checkbox-box" id="duration-checkbox">
          <%= f.collection_check_boxes :duration_id_in,
                                       [['< 4 hours',   1..8],
                                        ['4 - 6 hours', 8..12],
                                        ['> 6 hours',   12..24]],
                                        :second, :first,
                                        checked: "#{(params[:q][:duration_id_in] rescue nil)}" do |b| %>
            <div class="form-check d-flex">
              <%= b.check_box class: 'custom-control-input duration', name: 'q[duration_id_in]' %>
              <%= b.label class: 'custom-control-label' %>
            </div>
          <% end %>
        </div>
      </div>
      <!-- END Duration Collection Check Boxes -->

    </div>
  </div>

  <div>
    <%= f.submit "Check Availability", class: "btn btn-primary" %>
  </div>
<% end %>
```

Perhatikan pada masing-masing check box, saya memberikan nama,

```erb
name: 'q[price_in]'
```
```erb
name: 'q[duration_id_in]'
````

Agar output dari params tersebut menghasilkan string.

Karena, apabila saya tidak saya memberikan nama, check box ini secara default akan memiliki nama,

```erb
name: 'q[price_in][]'
````
```erb
name: 'q[duration_id_in][]'
```

Yang akan menghasilkan params dengan value berupa array.

Maka dari itu, pada controller, saya perlu membuat sebuah method yang akan mengkonversi dari string menjadi range.

Karena nanti hasil output dari `params[:q][:price_in]` dan `params[:q][:duration_id_in]` dari view helper `collection_check_boxes` berupa string, maka saya perlu merubah tipe datanya menjadi range pada experiences_controller.

Tambahkan kode di bawah ini pada **experiences_controller.rb**.

```ruby
# app/controllers/experiences_controller.rb

class ExperiencesController < ApplicationController
  before_action :convert_string_into_range, only: [:index]

  def index
    ...
  end

  ...
  ...

  private

  # For converting string of value params into range
  def string_to_range(rangestr)
    rangestr&.split('..')&.inject { |s,e| s.to_i..e.to_i }
  end

  def convert_string_into_range
    # For Experiences, search filter by budget range. Convert string into range
    unless (params[:q][:price_in] rescue nil).blank?
      params[:q][:price_in] = string_to_range(params.dig(:q, :price_in))
    end

    # For Experiences, search filter by duration range. Convert string into range
    unless (params[:q][:duration_id_in] rescue nil).blank?
      params[:q][:duration_id_in] = string_to_range(params.dig(:q, :duration_id_in))
    end
  end
end
```

### jQuery disable multiple check

Secara default, view helper `collection_check_boxes` ini dapat menampung multiple value yang disimpan dalam array, sehingga frontend, kita dapat memilih banyak pilihan pada check box. Namun, karena alasan tertentu, saya memilih untuk menyederhanakan dan membuat `collection_check_boxes` ini hanya dapat menampung nilai string dan hanya dapat memilih satu saja.

Saya menggunakan bantuan jQuery untuk dapat melakukan hal tersebut di atas.

```erb
<!-- app/views/experiences/index.html -->

...
...

<script>
  ...
  ...

  // For clear all checkboxes on Duration
  $('#clearAllDuration').on("click", function(){
    var clearCheckBox = $('input[class="custom-control-input duration"]');
    clearCheckBox.prop("checked",false);
  });

  // For clear all checkboxes on Budget
  $('#clearAllBudget').on("click", function(){
    var clearCheckBox = $('input[class="custom-control-input budget"]');
    clearCheckBox.prop("checked",false);
  });

  // For Duration only able to select on checkbox and uncheck other
  $('input.custom-control-input.duration').on('change', function() {
    $('input.custom-control-input.duration').not(this).prop('checked', false);
  });

  // For Budget only able to select on checkbox and uncheck other
  $('input.custom-control-input.budget').on('change', function() {
    $('input.custom-control-input.budget').not(this).prop('checked', false);
  });

  ...
  ...
</script>
```

Nah, dengan begini tahapan demi tahapan sudah selesai.

Mudah-mudahan dapat bermanfaat buat teman-teman.

Terima kasih.

(^_^)



# Referensi

1. [apidock.com/rails/v4.0.2/ActionView/Helpers/FormOptionsHelper/collection_check_boxes](https://apidock.com/rails/v4.0.2/ActionView/Helpers/FormOptionsHelper/collection_check_boxes){:target="_blank"}
<br>Diakses tanggal: 2020/02/05

2. [github.com/activerecord-hackery/ransack/wiki/Basic-Searching#in](https://github.com/activerecord-hackery/ransack/wiki/Basic-Searching#in){:target="_blank"}
<br>Diakses tanggal: 2020/02/05
