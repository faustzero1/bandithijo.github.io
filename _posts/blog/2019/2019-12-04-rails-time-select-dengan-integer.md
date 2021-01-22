---
layout: 'post'
title: "Rails time_select dengan Integer"
date: 2019-12-04 08:00
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
resume:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prerequisite

`Ruby 2.6.3` `Rails 5.2.3` `PostgreSQL 11.5`

# Prakata

Saya mendapatkan kasus dimana saya harus membuat "duration" field dengan tipe data integer. Yang mana sebelumnya duration field ini saya set dengan tipe data time.

Tujuan dari penggunaan tipe data integer pada duration field agar nantinya dapat dengan mudah diolah, seperti difilter berdasarkan jumlah menit tertentu, dan lain sebagainya.

# Target

Target yang ingin dicapai adalah, saya perlu **menyimpan data di dalam kolom duration dalam satuan menit**.

Contoh, untuk durasi selama **8 jam 30 menit**, berarti data akan disimpan sebesar **510 menit**.

Tampilannya kira-kira seperti ini, untuk pemilihan jam dan menit.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/j5s63RNM/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 1 - time_select untuk jam dan menit</p>

# Permasalahan

`time_select` adalah salah satu method yang dimiliki oleh `ActionView::Helpers::DateHelper`. Beberapa method lain diantaranya seperti, `date_select`, `datetime_select`, dll.[<sup>1</sup>](#referensi)

Secara normal, `time_select` ini akan bekerja dengan baik pada field dengan tipe data time. Namun, karena kebutuhan project, saya perlu memodifikasi agar `time_select` dapat menyimpan data ke dalam field dengan tipe data integer.

# Solusi

Sebagai catatan, cara yang saya lakukan ini mungkin bukan merupakan cara yang baik. Mengingat masih minimnya pengalaman dan jam terbang saya dalam membangun web aplikasi, terkhusus dengan Ruby on Rails.

Oke, kembali ke pokok perbincangan utama.

Untuk merubah kolom/field duration dari tipe data time menjadi integer, saya melakukan migration seperti ini.

{% shell_user %}
rails g migration alter_experiences_duration_to_integer
{% endshell_user %}

Kemudian menuliskan manual, masing-masing method up dan down-nya.

{% highlight_caption db/migrate/20191122060352_alter_experiences_duration_to_integer.rb %}
{% highlight ruby linenos %}
class AlterExperiencesDurationToInteger < ActiveRecord::Migration[5.2]
  def up
    remove_column :experiences, :duration, :time
    add_column :experiences, :duration, :integer
  end

  def down
    remove_column :experiences, :duration, :integer
    add_column :experiences, :duration, :time
  end
end
{% endhighlight %}

Perlu diketahui, saya melakukan perintah `remove_column` karena web aplikasi yang saya bangun, belum memiliki data sungguhan. Apabila sudah memiliki data sungguhan, sangat dihindari untuk melakukan penghapusan kolom/field. Lebih baik membuat kolom/field yang baru.

Berikut ini adalah contoh dari skema tabel experiences yang saya miliki.

{% highlight_caption db/schema.rb %}
{% highlight ruby linenos %}
create_table "experiences", force: :cascade do |t|
  # ...
  # ...
  t.integer "duration"
  # ...
  # ...
end
{% endhighlight %}

Karena saya menggunakan seed untuk membuat data-data dummy, saya perlu merubah formatnya dari format time menjadi total menit.

**Sebelum**,

```
duration: ['01:30', '03:00', '06:30', '08:00'].sample
```

**Sesudah**,

```
duration: [90, 180, 390, 480].sample
```

Karena data sudah disimpan dalam bentuk integer dan dalam satuan menit, maka saya perlu bantuan helper method untuk mengkonversi bentuk dari "hanya menit" menjadi "jam dan menit".

{% highlight_caption app/helpers/experiences_helper.rb %}
{% highlight ruby linenos %}
def formatted_duration(total_minute)
  hours = total_minute / 60
  minutes = total_minute % 60
  if minutes == 0
    pluralize("#{ hours }", "hour")
  else
    pluralize("#{ hours }", "hour") + " " + pluralize("#{ minutes }", "minute")
  end
end
{% endhighlight %}

Dengan begini, saya memiliki helper method bernama `formatted_duration()` yang dapat saya manfaatkan untuk mengkonversi tampilan data duration yang hanya dalam satuan menit, menjadi bentuk jam dan menit.

Kira-kira seperti ini contoh penggunaannya dalam view template.

{% highlight_caption app/views/experiences/index.html.erb %}
{% highlight eruby linenos %}
<div class="row no-gutters">
  <div class="col-sm-6">
    <span class="icon-time1 mr-1"></span>
    <span>Duration: <%= formatted_duration(experience.duration) %></span>
  </div>
</div>
{% endhighlight %}

Nah, sekarang bagian input field.

Pada bagian ini, harus saya akui, cukup merepotkan. Saya menghabiskan banyak sekali percobaan untuk membuat `time_select` dapat berfungsi seperti tujuan saya.

Pertama-tama pada view template dulu.

{% highlight_caption app/views/experiences/new.html.erb,app/views/experiences/edit.html.erb %}
{% highlight eruby linenos %}
<div class="form-group row no-gutters form-custom mb-3">
  <label class="col-md-3 col-form-label p-sm-0 d-flex align-items-center">Duration</label>
  <div class="col-md-9">
    <div class="row no-gutters">
      <% if controller_name == "experiences" && action_name == "edit" %>
        <% hours   = experience.duration / 60 %>
        <% minutes = experience.duration % 60 %>
        <%= hidden_field_tag 'duration-hours', hours %>
        <%= hidden_field_tag 'duration-minutes', minutes %>
        <%= f.time_select :duration,
            { start_hour: 1, end_hour: 12, minute_step: 10, time_separator: ' ',
            prompt: { hour: "Choose hour", minute: "Choose minute"}, ignore_date: true},
            class: "form-control col-md-2 px-2 mr-md-2 mb-md-0 mb-2" %>
      <% else %>
        <%= f.time_select :duration,
            { start_hour: 1, end_hour: 12, minute_step: 10, time_separator: ' ',
            prompt: { hour: "Choose hour", minute: "Choose minute"}, ignore_date: true},
            class: "form-control col-md-2 px-2 mr-md-2 mb-md-0 mb-2" %>
      <% end %>
    </div>
  </div>
</div>
{% endhighlight %}

Algoritma dari kode di atas adalah:

1. Jika data baru, maka masuk ke dalam blok else, yang akan digunakan oleh `experiences#new`.
2. Jika data edit, maka masuk de dalam blok if, yang artinya data duration yang berupa menit, akan dipecah menjadi dua variabel, `hours` dan `minutes`. Kemudian dimasukkan ke dalam `hidden_field_tag` masing-masing, dan akan dikrimkan ke `experiences#edit`.

Nah, berikut ini isi dari `experiences_controller.rb` yang akan menerima data dari kedua inputan pada view template di atas.

{% highlight_caption app/controllers/experiences_controller.rb %}
{% highlight ruby linenos %}
class ExperiencesController < ApplicationController

  def new
    @experience = Experience.new
  end

  def create
    @experience = Experience.new(experience_params)

    @hours   = (params[:experience]['duration(4i)']).to_i
    @minutes = (params[:experience]['duration(5i)']).to_i
    @experience.duration = @hours * 60 + @minutes

    if @experience.save
      redirect_to experience_path(@experience)
    else
      render :new
    end
  end

  def edit
    @experience = Experience.find(params[:id])
  end

  def update
    @experience = Experience.find(params[:id])

    @hours   = (params[:experience]['duration(4i)']).to_i
    @minutes = (params[:experience]['duration(5i)']).to_i
    @experience.duration = @hours * 60 + @minutes
    @duration = @experience.duration

    if @experience.update(experience_params)
      @experience.update(duration: @duration)
      redirect_to experience_path(@experience)
    else
      render :edit
    end
  end

  private

  def experience_params
    params.require(:experience).permit( ..., ...., :duration, ..., ...)
  end
end
{% endhighlight %}

Selesai!

# Pesan Penulis

Sekian, mudah-mudahan catatan saya yang masih banyak kurangnya ini dapat bermanfaat buat teman-teman.

Mungkin pada kesempatan yang lain, akan saya buatkan repo khusus agar teman-teman langsung merasakan fiturnya.

Terima kasih (^_^)v


# Referensi

1. [api.rubyonrails.org/v5.2.1/classes/ActionView/Helpers/DateHelper.html](https://api.rubyonrails.org/v5.2.1/classes/ActionView/Helpers/DateHelper.html){:target="_blank"}
<br>Diakses tanggal: 2019/12/04

2. [guides.rubyonrails.org/form_helpers.html#using-date-and-time-form-helpers](https://guides.rubyonrails.org/form_helpers.html#using-date-and-time-form-helpers){:target="_blank"}
<br>Diakses tanggal: 2019/12/04
