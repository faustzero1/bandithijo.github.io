---
layout: 'post'
title: 'Memperbaiki Authentication is Required for Suspending the System XFCE'
date: 2018-05-04 21:56
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['XFCE', 'Tips']
pin:
hot:
contributors: []
description:
---

<!-- BANNER OF THE POST -->
<img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="https://s20.postimg.cc/j770ed1tp/banner_post_11.png" onerror="imgError(this);" alt="banner">

# Permasalahan

Saya baru saja berpindah *desktop environment* kembali menggunakan **XFCE4**. Permasalahan yang dulu pernah muncul salah satunya setiap kali sistem baru bangkit dari kondisi *sleep* terdapat sebuah *popup window* yang bertuliskan "*Authentication is required for suspending the system*".

# Solusi

Untuk hal-hal berbau *authentication* biasanya diatur oleh *polkit*.

## Cari lokasi target

Buka Terminal dan *copy paste command* di bawah untuk mencari lokasi dari file `org.freedesktop.login1.policy`.

{% shell_user %}
locate -b org.freedesktop.login1.policy
{% endshell_user %}

```
/usr/share/polkit-1/actions/org.freedesktop.login1.policy
```
Pada sistem saya, file tersebut berada pada lokasi seperti yang ditampilkan *output* di atas.

## Edit isi file target

Kemudian, kita akan membuka file tersebut menggunakan *text editor* favorit masing-masing.

{% shell_user %}
sudo vim /usr/share/polkit-1/actions/org.freedesktop.login1.policy
{% endshell_user %}

Kemudian cari baris dengan isi persis sama seperti di bawah.

```
<action id="org.freedesktop.login1.suspend">
```

Yang memiliki isi seperti di bawah ini.

{% highlight_caption /usr/share/polkit-1/actions/org.freedesktop.login1.policy %}
{% pre_caption %}
...
...
&lt;action id="org.freedesktop.login1.suspend">
  &lt;description gettext-domain="systemd">Suspend the system&lt;/description>
  &lt;message gettext-domain="systemd">Authentication is required for suspending the system.&lt;/message>
  &lt;defaults>
    &lt;allow_any>auth_admin_keep&lt;/allow_any>
    &lt;allow_inactive>auth_admin_keep&lt;/allow_inactive>
    &lt;allow_active>yes&lt;/allow_active>
  &lt;/defaults>
&lt;/action>
...
...
{% endpre_caption %}

Pada bagian tag **defaults**, kita akan merubah nilai dari **allow_any** dan **allow_inactive** menjadi bernilai **yes**.

**Sebelum**
<pre>
&lt;defaults&gt;
  &lt;allow_any&gt;<mark>auth_admin_keep</mark>&lt;/allow_any&gt;
  &lt;allow_inactive&gt;<mark>auth_admin_keep</mark>&lt;/allow_inactive&gt;
  &lt;allow_activey&gt;es&lt;/allow_active&gt;
&lt;/defaults&gt;
</pre>

**Sesudah**
<pre>
&lt;defaults&gt;
  &lt;allow_any&gt;<mark>yes</mark>&lt;/allow_any&gt;
  &lt;allow_inactive&gt;<mark>yes</mark>&lt;/allow_inactive&gt;
  &lt;allow_active&gt;yes&lt;/allow_active&gt;
&lt;/defaults&gt;
</pre>

## Hasil setelah diedit

Maka setelah kita rubah, keseluruhan kodenya kan tampak seperti ini.
{% highlight_caption /usr/share/polkit-1/actions/org.freedesktop.login1.policy %}
{% pre_caption %}
...
...
&lt;action id="org.freedesktop.login1.suspend">
  &lt;description gettext-domain="systemd">Suspend the system</description>
  &lt;message gettext-domain="systemd">Authentication is required for suspending the system.</message>
  &lt;defaults>
    &lt;allow_any>yes</allow_any>
    &lt;allow_inactive>yes</allow_inactive>
    &lt;allow_active>yes</allow_active>
  &lt;/defaults>
&lt;/action>
...
...
{% endpre_caption %}




# Referensi
1. [askubuntu.com/questions/543921/authentication-required-before-suspend](https://askubuntu.com/questions/543921/authentication-required-before-suspend)
<br>Diakses tanggal: 2018/04/28

2. [ubuntuforums.org/showthread.php?t=2276864](https://ubuntuforums.org/showthread.php?t=2276864<Paste>)
<br>Diakses tanggal: 2018/04/28
