---
layout: 'post'
title: "Membuat Footer Stay on Bottom but Not Fixed pada Bootstrap"
date: 2020-12-05 14:41
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

Kalian pasti pernah melihat Footer yang manja di sebuah website.

Kira-kira seperti ini contohnya.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/RFGxYSgJ/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}

Perhatikan kotak berwarna merah.

Footer ini sangat manja karena menempel pada post body.

<br>
Saya ingin membuat Footer yang mandiri. Yang akan selalu berada di bagian bawah layar, meskipun body post tidak sebanyak tinggi layar.

Namun, saya juga tidak ingin membuat Footer ini terlalu keras kepala (Fixed), sehingga tetap berada di bawah layar meskipun post content sudah banyak.

Idealnya, Footer yang saya inginkan seperti ini.

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/pdHNXh7n/gambar-02.png" onerror="imgError(this);"}{:class="myImg"}

Meskipun post content hanya sedikit, Footer tetap berada di bagian bawah layar. Dan apabila post content sudah banyak, Footer akan terdorong menghilang bersama post content yang paling bawah.

# Implementasi

Markup HTML nya seperti ini polanya.

{% highlight html linenos %}
<!DOCTYPE html>
<html>
  <head>
    <title>Footer Anti Manja</title>
  </head>

  <body class="d-flex flex-column">

    <div id="content">
      ...
      ...
    </div>

    <footer id="footer">
      ...
      ...
    </footer>

  </body>
</html>
{% endhighlight %}

<br>
Style nya seperti ini.

{% highlight css linenos %}
html,
body {
  height: 100%;
}

#content {
  flex: 1 0 auto;
}

#footer {
  flex-shrink: none;
}
{% endhighlight %}





# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)
