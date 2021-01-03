---
layout: 'post'
title: "Select Menu dengan Short Description Menggunakan jQuery pada Rails"
date: 2019-12-14 01:44
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Rails', 'Javascript']
pin:
hot:
contributors: []
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prerequisite

`Ruby 2.6.3` `Rails 5.2.3` `PostgreSQL 11.5`

# Prakata

Pernah membuat menu select atau dropdown menu, namun merasa keterngan nama yang tertulis di menu tersebut tidak dapat menjelaskan secara detail karena keterbatasan tempat.

Misalnya, seperti pada project yang sedang saya kerjakan. Terdapat menu select untuk memilih salah satu Cancellation Policy melalui menu select. Seperti di bawah ini.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/4NKCw592/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 1 - Cancellation Policy Menu Select</p>

Lihat, tidak ada informasi yang lebih detail mengenail masing-masing menu.

Kalau seperti ini, tentunya kita akan bingung, mana menu yang pas untuk kita pilih.

# Permasalahan

Pada umumnya, memang menu select tidak terdapat penjelasan singkat. Hanya tertulis nama dari value yang dijadikan menu selection.

# Sekenario

Untuk mengatasi hal ini, saya menggunakan bantuan jQuery untuk menampilkan dan menyembunyikan element pada template.

Saya ingin memilih Cancellation Policy pada form untuk membuat dan mengedit Experience.

Data text diambil dari tabel yang menampung data-data Cancellation Policy.

Data yang ditampilkan akan mengikuti menu select yang sedang dipilih (*selected*).

# Pemecahan Masalah

Pada view template, pada bagian form, seperti ini yang saya lakukan.

{% highlight_caption app/view/experiences/_form.html.erb %}
{% highlight eruby linenos %}
<style>
/* For Cancellation Policy Short Description */
.description {
  margin: 0 auto;
}
.short-description {
  display: none;
}
</style>

<!-- Menu Select -->
<div class="form-group row">
  <label class="col-md-3">Cancellation Policy</label>
  <div class="col-md-9">
    <%= f.collection_select :cancellation_policy_id,
                            CancellationPolicy.all, :id, :name,
                            { include_blank: '-Select Category-' },
                            { class: 'form-control' } %>
  </div>
</div>

<!-- Short Description for Menu Select -->
<div class="form-group row">
  <div class="col-md-3"></div>
  <div class="col-md-9">
    <div class="description">
      <% CancellationPolicy.all.each do |policy| %>
        <div id="<%= policy.id %>" class="short-description">
          <h5 class="font-family-medium text-black mb-0"><%= policy.name %></h5>
          <p class=""><%= policy.short_description %>.</p>
        </div>
      <% end %>
    </div>
  </div>
</div>
{% endhighlight %}

Jangan mentah-mentah mengikuti struktur kode di atas yaa, seperti Stylesheet dan Javascript.

Semua yang ada pada catatan ini hanya sebagai contoh untuk mempermudah penjelasan.

Dapat dilihat pada struktur HTML di atas, ada beberapa bagian yang saya persiapkan untuk digunakan pada jQuery.

Pada bagian `class="description"` berisi tag DIV yang nantinya akan dijadikan sebagai tempat untuk menampilkan short description dari Cancellation Policy.

`id="<%= policy.id %>` berisi tag DIV yang akan berganti-ganti nilainya mengikuti id dari menu select yang terpilih.

`class="short-description"` berisi tag DIV yang mulanya tidak ditampilkan `display:none`, lalu akan tampil bersamaan dengan menu selection yang mulai dipilih.

Selanjutnya, tinggal meracik jQuery saja.

{% highlight_caption app/view/experiences/_form.html.erb %}
{% highlight eruby linenos %}
...
...
...

<script>
// For Cancellation Policy Short Description
$(function() {
  $('#experience_cancellation_policy_id').change(function(){
    $('.short-description').hide();
    $('#' + $(this).val()).show();
  });
});
</script>
{% endhighlight %}

`#experience_cancellation_policy_id` adalah pola penamaan id dari menu selection `collection_select :cancellation_policy_id` yang berada pada form Experience. Sudah dapat dipastikan kalau pola penamaannya akan seperti itu.

Atau dapat juga menggunakan inspect element pada Browser untuk mengetahui id dari menu select.

Nah, kalau sudah semua, hasilnya akan seperti ini.

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/bN475t0y/gambar-02.gif" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 2 - Cancellation Policy Menu Select dengan Short Description</p>

Selesai!

Mudah-mudahan catatan singkat ini dapat bermanfaat buat teman-teman.

Terima kasih.

(^_^)







# Referensi

1. [www.w3schools.com/jquery/jquery_hide_show.asp](https://www.w3schools.com/jquery/jquery_hide_show.asp){:target="_blank"}
<br>Diakses tanggal: 2019/12/14
