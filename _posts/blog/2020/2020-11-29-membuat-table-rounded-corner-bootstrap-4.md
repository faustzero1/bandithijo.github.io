---
layout: 'post'
title: "Membuat Table dengan Rounded Corner pada Bootstrap 4"
date: 2020-11-29 10:38
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips']
pin:
hot:
contributors: []
---

# Latar Belakang

Kalau teman-teman menggunakan Bootstrap sebagai CSS Framework --terkhusus Bootstrap 4-- pasti akan mendapatkan table dengan bagian corner yang bersiku.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/c1TKPGPS/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}

```html
<table class="table table-bordered table-hover my-3">
  <thead>
    <tr>
      <th scope="col">Ticker</th>
      <th scope="col">Name</th>
      <th scope="col">Price</th>
      <th scope="col">Action</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td scope="row">...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
  </tbody>
</table>
```

# Masalah

Saya ingin memodifikasi agar tampilan dari masing-masing corner dari tabel memiliki tampilan yang rounded.

Namun, Bootstrap 4 tidak menyediakan class agar user dapat membuat table dengan corner yang rounded.


# Pemecahan Masalah

Kita akan mengoverride class table bawaan Bootstrap.

**SYARAT**

Tabel harus memiliki struktur seperti di bawah ini.

```
<table>

  <thead>
    <tr>
      <th></th>
      <th></th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td></td>
      <td></td>
    </tr>
  </tbody>

</table>
```

Oke, langsung ke penerapan.

Pada table, gunakan class `table-borderless` agar border bawaan bootstrap tidak mengoverride tabel border yang akan kita custom.

{% highlight html linenos %}
<table class="table table-borderless">
  <thead>
    <tr>
      <th>Ticker</th>
      <th>Name</th>
      <th>Price</th>
      <th>Action</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
  </tbody>
</table>
{% endhighlight %}

Selanjutnya, tambahkan custom CSS untuk mengoverride class table dari Bootstrap.

{% highlight css linenos %}
table {
  border-collapse: separate !important;
  border-spacing: 0 !important;
}
table tr th,
table tr td {
  border-right: 1px solid #dee2e6 !important;
  border-bottom: 1px solid #dee2e6 !important;
}
table tr th:first-child,
table tr td:first-child {
  border-left: 1px solid #dee2e6 !important;
}
table tr th {
  border-top: 1px solid #dee2e6 !important;
}

/* top-left border-radius */
table tr:first-child th:first-child {
  border-top-left-radius: 0.25rem !important;
}

/* top-right border-radius */
table tr:first-child th:last-child {
  border-top-right-radius: 0.25rem !important;
}

/* bottom-left border-radius */
table tr:last-child td:first-child {
  border-bottom-left-radius: 0.25rem !important;
}

/* bottom-right border-radius */
table tr:last-child td:last-child {
  border-bottom-right-radius: 0.25rem !important;
}
{% endhighlight %}

Besar dari radius `0.25rem` saya samakan dengan besar radius dari input box.

Warna border `#dee2e6` juga saya samakan dengan warna border dari input box.

Tujuannya agar terlihat menyatu dan seragam --tidak terlihat seperti custom abal-abal.

Dan beginilah hasilnya setelah modifikasi di atas kita lakukan.

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/NFWvZMcD/gambar-02.png" onerror="imgError(this);"}{:class="myImg"}




# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Sebenarnya, implementasi ini tidak spesifik untuk Bootstrap 4 saja, namun sangat general dan dapat digunakan dimana saja.

Bahkan saya pun menggunakannya di blog ini yang notabennya menggunakan CSS buatan sendiri.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)



# Referensi

1. [codepen.io/mlms13/pen/CGgLF](https://codepen.io/mlms13/pen/CGgLF){:target="_blank"}
<br>Diakses tanggal: 2020/11/29
