---
layout: 'post'
title: "Memperbesar Gambar dengan Modal Menggunakan JavaScript (Tanpa JQuery)"
date: 2020-07-17 21:42
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Javascript']
pin:
hot:
contributors: []
---

# Sekenario Masalah

Baru seminggu ini saya menambahkan fitur memperbesar gambar dengan modal.

Fitur ini sebenarnya sudah saya ingin gunakan sejak awal membangun BanditHijo (R)-Chive, namun saat itu masih kurang pengalaman, jadi belum ngerti gimana cara mengimplementasikan dan memodifikasinya.

Seminggu yang lalu, saya berhasil mengimplementasikan fitur ini, meskipun, akhirnya saya menggunakan JQuery.

Bukan anti JQuery, hanya saja, saya merasa sayang kalau harus menggunakan JQuery untuk satu atau dua fitur. Rasanya *overkill*.

Nah, tepat hari ini, saya sudah berhasil memigrasikan fitur ini dari menggunakan JQuery menjadi hanya menggunakan vanilla JavaScript.

# Pemecahan Masalah

## Contoh Menggunakan JQuery

Saya akan mulai dengan contoh yang menggunakan JQuery.

Saya akan tuliskan dalam satu file html.

{% highlight_caption %}
{% highlight html linenos %}
<!-- Kumpulan beberapa gambar -->
<img class="myImg" src="http://bandithijo.github.io/assets/img/logo/logo_bandithijo.png"/>
<img class="myImg" src="http://bandithijo.github.io/assets/img/logo/logo_bandithijo.png"/>
<img class="myImg" src="http://bandithijo.github.io/assets/img/logo/logo_bandithijo.png"/>
{% endhighlight %}

{% highlight_caption %}
{% highlight html linenos %}
<!-- Modal yang akan digunakan bergantian oleh gambar-gambar di atas -->
<div id="myModal" class="modal">
  <img class="modal-content" id="modal-img">
</div>
{% endhighlight %}

{% highlight_caption %}
{% highlight html linenos %}
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script>
// Get the modal
var modal = document.getElementById('myModal');

// Get the image and insert it inside the modal - use its "alt" text as a caption
var img = $('.myImg');
var modalImg = $("#modal-img");
$('.myImg').click(function(){
    modal.style.display = "block";
    var newSrc = this.src;
    modalImg.attr('src', newSrc);
});

// Get the <span> element that closes the modal
var close = document.getElementsByClassName("modal")[0];

// When the user clicks image or modal, close the modal
close.onclick = function() {
  modal.style.display = "none";
}
</script>
{% endhighlight %}

Pada baris 9-13 di atas, adalah contoh baris kode dari JQuery.

{% highlight_caption %}
{% highlight html linenos %}
<style>
/* Style the Image Used to Trigger the Modal */
.myImg {
  cursor: zoom-in;
  transition: 0.3s;
}

.myImg:hover {opacity: 0.9;}

/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  z-index: 1; /* Sit on top */
  position: fixed; /* Stay in place */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.9); /* Black w/ opacity */
}

/* Modal Content (Image) */
img.modal-content {
  margin: auto;
  display: block;
  max-width: 100%;
  max-height: 100%;
  position: relative;
  top: 50%;
  transform: translateY(-50%);
}

/* 100% Image Width on Smaller Screens */
@media only screen and (max-width: 700px){
  .modal-content {
    width: 100%;
  }
}
</style>
{% endhighlight %}

## Contoh Menggunakan JavaScript

### Versi W3Schools

Kalau teman-teman mengikuti tutorial yang ada di W3Schools, akan seperti ini.

{% highlight_caption %}
{% highlight html linenos %}
<!-- Gambar -->
<img id="myImg" src="img_snow.jpg" alt="Snow" style="width:100%;max-width:300px">
{% endhighlight %}

{% highlight_caption %}
{% highlight html linenos %}
<!-- Modal yang akan digunakan oleh gambar di atas -->
<div id="myModal" class="modal">
  <span class="close">&times;</span>
  <img class="modal-content" id="img01">
  <div id="caption"></div>
</div>
{% endhighlight %}

{% highlight_caption %}
{% highlight html linenos %}
<script>
// Get the modal
var modal = document.getElementById("myModal");

// Get the image and insert it inside the modal - use its "alt" text as a caption
var img = document.getElementById("myImg");
var modalImg = document.getElementById("img01");
var captionText = document.getElementById("caption");
img.onclick = function(){
  modal.style.display = "block";
  modalImg.src = this.src;
  captionText.innerHTML = this.alt;
}

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
  modal.style.display = "none";
}
</script>
{% endhighlight %}

{% highlight_caption %}
{% highlight html linenos %}
<style>
body {font-family: Arial, Helvetica, sans-serif;}

#myImg {
  border-radius: 5px;
  cursor: pointer;
  transition: 0.3s;
}

#myImg:hover {opacity: 0.7;}

/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.9); /* Black w/ opacity */
}

/* Modal Content (image) */
.modal-content {
  margin: auto;
  display: block;
  width: 80%;
  max-width: 700px;
}

/* Caption of Modal Image */
#caption {
  margin: auto;
  display: block;
  width: 80%;
  max-width: 700px;
  text-align: center;
  color: #ccc;
  padding: 10px 0;
  height: 150px;
}

/* Add Animation */
.modal-content, #caption {
  -webkit-animation-name: zoom;
  -webkit-animation-duration: 0.6s;
  animation-name: zoom;
  animation-duration: 0.6s;
}

@-webkit-keyframes zoom {
  from {-webkit-transform:scale(0)}
  to {-webkit-transform:scale(1)}
}

@keyframes zoom {
  from {transform:scale(0)}
  to {transform:scale(1)}
}

/* The Close Button */
.close {
  position: absolute;
  top: 15px;
  right: 35px;
  color: #f1f1f1;
  font-size: 40px;
  font-weight: bold;
  transition: 0.3s;
}

.close:hover,
.close:focus {
  color: #bbb;
  text-decoration: none;
  cursor: pointer;
}

/* 100% Image Width on Smaller Screens */
@media only screen and (max-width: 700px){
  .modal-content {
    width: 100%;
  }
}
</style>
{% endhighlight %}

Memang benar, script di atas dapat menampilkan gambar pada Modal, namun...**tidak bisa berfungsi apabila lebih dari satu gambar**.


### Versi TutorialsPoint

Solusinya, kita perlu memodifikasi tag image yang menggunakan id menjadi class.

{% highlight_caption %}
{% highlight html linenos %}
<!-- Gambar-gambar -->
<img class="myImg" src="http://bandithijo.github.io/assets/img/logo/logo_bandithijo.png"/>
<img class="myImg" src="http://bandithijo.github.io/assets/img/logo/logo_bandithijo.png"/>
<img class="myImg" src="http://bandithijo.github.io/assets/img/logo/logo_bandithijo.png"/>
{% endhighlight %}

Menyederhanakan modal, hanya menggunakan class.

{% highlight_caption %}
{% highlight html linenos %}
<!-- Modal yang akan digunakan oleh gambar di atas -->
<div class="modal">
  <img class="modal-content">
</div>
{% endhighlight %}

{% highlight_caption %}
{% highlight html linenos %}
<script>
// Get the modal
var modal = document.querySelector(".modal");
var modalImg = document.querySelector(".modal-content");
Array.from(document.querySelectorAll(".myImg")).forEach(item => {
  item.addEventListener("click", event => {
    modal.style.display = "block";
    modalImg.src = event.target.src;
  });
});

// When the user clicks image or modal, close the modal
document.querySelector(".modal").addEventListener("click", () => {
  modal.style.display = "none";
});
</script>
{% endhighlight %}

Baris 5-10 di atas, adalah blok kode JavaScript yang melakukan looping terhadap semua class `myImg`.

Inilah yang membuat setiap gambar yang ada pada blog post kita, dapat menjalankan fungsi image di dalam Modal.

Saya juga memodifikasi style di bawah, agar membuat gambar berada persis di tengah dari screen.

{% highlight_caption %}
{% highlight html linenos %}
<style>
/* Style the Image Used to Trigger the Modal */
.myImg {
  cursor: zoom-in;
  transition: 0.3s;
}

.myImg:hover {opacity: 0.9;}

/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  z-index: 1; /* Sit on top */
  position: fixed; /* Stay in place */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.9); /* Black w/ opacity */
}

/* Modal Content (Image) */
img.modal-content {
  margin: auto;
  display: block;
  max-width: 100%;
  max-height: 100%;
  position: relative;
  top: 50%;
  transform: translateY(-50%);
}

/* 100% Image Width on Smaller Screens */
@media only screen and (max-width: 700px){
  .modal-content {
    width: 100%;
  }
}
</style>
{% endhighlight %}

Selesai!!!

Saya rasa hanya ini yang dapat saya tuliskan saat ini.

Mudah-mudahan dapat bermanfaat untuk teman-teman.

Terima kasih.

(^_^)








# Referensi


1. [How to create a modal image gallery with CSS and JavaScript?](https://www.tutorialspoint.com/how-to-create-a-modal-image-gallery-with-css-and-javascript){:target="_blank"}
<br>Diakses tanggal: 2020/07/17

2. [w3schools - How TO - Modal Images](https://www.w3schools.com/howto/howto_css_modal_images.asp){:target="_blank"}
<br>Diakses tanggal: 2020/07/17
