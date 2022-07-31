---
layout: 'post'
title: "Membuat Presentation Mode tanpa XFCE4 Power Manager di GNU/Linux (Bonus! dmenu-presentationmode)"
date: 2022-07-31 08:38
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
description: "Presentation Mode. Beberapa teman-teman yang menggunakan XFCE pasti pernah menggunakan fitur ini. Fitur yang membuat system kita tidak bisa melakukan sleep/standby. Biasanya kita gunakan ditengah presentasi atau sedang menonton film. Pada catatan kali ini, kita akan meniru Presentation Mode tersebut tanpa menggunakan xfce4-power-manager, melainkan menggunakan DPMS (Display Power Management Signal) yang dapat kita on dan off kan melalui xset."
---

# Pendahuluan

Presentation Mode. Beberapa teman-teman yang menggunakan XFCE pasti pernah menggunakan fitur ini. Fitur yang membuat system kita tidak bisa melakukan sleep/standby. Biasanya kita gunakan ditengah presentasi atau sedang menonton film.

Pada catatan kali ini, kita akan meniru Presentation Mode tersebut tanpa menggunakan `xfce4-power-manager`, melainkan menggunakan **DPMS** (*Display Power Management Signal*) yang dapat kita on dan off kan melalui `xset`.

> *DPMS (Display Power Management Signaling) enables power saving behaviour of monitors when the computer is not in use.*
>
> [Arch Wiki - Display Power Management Signal](https://wiki.archlinux.org/title/Display_Power_Management_Signaling){:target="_blank"}

# Paket yang Diperlukan

Pastikan paket **xorg-xset** sudah terpasang.

```
extra/xorg-xset 1.2.4-3 (19.0 KiB 39.8 KiB) [xorg-apps xorg]
  User preference utility for X
```

# Cara Penggunaan

## Melihat value dari DPMS

Secara *default*, DPMS sudah dalam keadaan aktif. Kita dapat melihat query parameter apa saja yang tersedia dengan perintah:

{% shell_user %}
xset q
{% endshell_user %}

<pre>
...
...

DPMS (Energy Star):
  Standby: 300    Suspend: 0    Off: 600
  <mark>DPMS is Enabled</mark>
  Monitor is On
</pre>

## Presentation Mode ON atau OFF

**Presentation Mode ON**

{% shell_user %}
xset -dpms
{% endshell_user %}

<br>
**Presentation Mode OFF**

{% shell_user %}
xset +dpms
{% endshell_user %}

# Bonus!

## dmenu-presentationmode

{% highlight_caption ~/.local/bin/dmenu-presentationmode %}
{% highlight sh linenos %}
#!/bin/bash

# Deps:
# - xorg-xset
# - dmenu
# - dunst
# - jq

presentation_on() {
    xset -dpms
    dunstify "Presentation Mode: ON" "(DPMS Disabled)" -t 3000 -r 1
}

presentation_off() {
    xset +dpms
    dunstify "Presentation Mode: OFF" "(DPMS Enabled)" -t 3000 -r 1
}

presentation_status() {
    dpms_status=$(xset q | grep 'DPMS is' | awk 'NF>1{print $NF}')
    if [[ $dpms_status = "Enabled" ]]; then
        status="OFF"
    else
        status="ON"
    fi
    dunstify "Presentation Mode: $status"
}

main() {
    OPTIONS='''
    [
    ["On",     "presentation_on"],
    ["Off",    "presentation_off"],
    ["Status", "presentation_status"]
    ]
    '''

    OBJ_MENU=$(echo $OPTIONS | jq -r '.[][0]' | dmenu -i -p ' Presentation Mode')
    OBJ_SELECTED=$(echo $OPTIONS | jq -r ".[] | select(.[0] == \"$OBJ_MENU\") | .[1]")

    $OBJ_SELECTED
}

main
{% endhighlight %}

# Pesan Penulis

Penggunaan lebih lanjut saya serahkan pada imajinasi dan kreatifitas teman-teman.

Terima kasih sudah mampir yaa.

# Referensi

1. [https://wiki.archlinux.org/title/Display_Power_Management_Signaling](https://wiki.archlinux.org/title/Display_Power_Management_Signaling){:target="_blank"}
<br>Diakses tanggal: 2022/07/31
