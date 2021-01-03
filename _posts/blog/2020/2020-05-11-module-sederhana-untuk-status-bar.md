---
layout: 'post'
title: "Membuat Module Sederhana untuk Status Bar GNU/Linux dan FreeBSD"
date: 2020-05-11 23:47
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Script']
pin:
hot:
contributors: []
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Pendahuluan

Bagi teman-teman yang menggunakan Window Manager pasti sudah sangat familiar dengan status bar. Ada bermacam-macam nama status bar yang dapat digunakan. Salah satu yang saya gunakan terakhir kali adalah Polybar. Saya sudah pernah membahas tentang Polybar [di sini: Polybar, Bar yang Mudah Dikonfig, Praktis, dan Mudah Dikustomisasi](/blog/polybar-mudah-dikonfig-dan-praktis){:target="_blank"}.

Catatan kali ini, saya ingin membahas tentang status bar yang kita racik sendiri, dan tidak tergantung dengan status-status bar yang sudah ada.

# Permasalahan

Saya tidak menggunakan alasan bahwa status-status bar tersebut *bloated*, karena tidak semua module kita gunakan. Namun, saya ingin lebih tidak tergantung terhadap status-status bar tersebut yang bisa jadi hanya spesifik untuk sistem operasi tertentu saja. Misal untuk Polybar, sebagian besar module-module yang disediakan, tidak dapat berjalan dengan baik pada FreeBSD.

Kalau hal tersebut terjadi, maka saya yang repot. Karena harus meluangkan waktu lagi untuk melakukan riset dan membuat ulang module-module tersebut agar dapat digunakan dengan Polybar.

Selain itu, apabila saya menggunakan dwm, saya lebih baik meracik status bar saya sendiri.

# Pemecahan Masalah

Saya sudah membuatkan beberapa module yang dapat digunakan untuk membangun status bar sendiri atau digunakan oleh Polybar

<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
<p>Saya tidak banyak pengalaman dalam menulis Bash Script. Apabila ada logika yang kurang baik, boleh sekali loh dikasih saran dan dibenerin. Saya sangat terbuka dan senang sekali. Terima kasih (^_^)</p>
</div>

# Module

## CPU Temperature

{% highlight_caption cpu_temp %}
{% highlight bash linenos %}
#!/bin/sh

get_temp_cpu0=$(cat /sys/class/thermal/thermal_zone0/temp)
temp_cpu0=$(($get_temp_cpu0/1000))
echo "" $temp_cpu0"°C"
{% endhighlight %}

## Memory

{% highlight_caption memory %}
{% highlight bash linenos %}
#!/bin/sh

mem_total=$(free -m | awk 'NR%2==0 {print $2}')
mem_avail=$(free -m | awk 'NR%2==0 {print $7}')
mem_used=$(( $mem_total - $mem_avail))
mem_usage=$(( $mem_used * 100 / $mem_total ))
echo " "$mem_usage"%"
{% endhighlight %}

## File System

{% highlight_caption filesystem %}
{% highlight bash linenos %}
#!/bin/sh

cap_percentage=$(df -h --output=pcent / | awk 'NR%2==0 {print $0}')
echo ""$cap_percentage
{% endhighlight %}

## Volume

{% highlight_caption volume %}
{% highlight bash linenos %}
#!/bin/sh

ou_mute=$(pamixer --get-mute)
in_mute=$(pamixer --source 1 --get-mute)
ou_vol=$(pamixer --get-volume)
in_vol=$(pamixer --source 1 --get-volume)
jack_stat=$($HOME/.local/bin/has_headphone)

if   [ $jack_stat = "yes" ]; then
    icon_ou_on=""
    icon_ou_off=""
elif [ $jack_stat = "no"  ]; then
    icon_ou_on=""
    icon_ou_off=""
fi
icon_in_on=""
icon_in_off=""

if   [ $ou_mute = "true"  ] && [ $in_mute = "true"  ]; then
    echo $icon_ou_off "Ø" $icon_in_off "Ø"
elif [ $ou_mute = "true"  ] && [ $in_mute = "false" ]; then
    echo $icon_ou_off "Ø" $icon_in_on $in_vol"%"
elif [ $ou_mute = "false" ] && [ $in_mute = "true"  ]; then
    echo $icon_ou_on $ou_vol"%" $icon_in_off "Ø"
elif [ $ou_mute = "false" ] && [ $in_mute = "false" ]; then
    echo $icon_ou_on $ou_vol"% $icon_in_on $in_vol"%"
else
    echo " ERROR"
fi
{% endhighlight %}

{% highlight_caption $HOME/.local/bin/has_headphone %}
{% highlight bash linenos %}
#!/bin/sh

# PulseAudio
pacmd list-sinks | grep 'Headphones' | awk '{print $10}' | tr -d ')'
{% endhighlight %}

## Backlight

{% highlight_caption backlight %}
{% highlight bash linenos %}
#!/bin/sh

backlight=$(xbacklight -get | cut -d "." -f1)
echo "" $backlight"%"
{% endhighlight %}

## Network Traffic (Wifi)

{% highlight_caption network_traf_wlan %}
{% highlight bash linenos %}
#!/bin/bash

wlan_card='wlan0'

wlanmon_card=$(ip a s | grep $wlan_card'mon' | awk 'NR%1==0 {print $2}' | sed 's/://g')
if [ $wlanmon_card ]; then
    printf " MONITOR"
fi

wlan_online=$(iw $wlan_card link | grep 'Connected' | awk 'NR%1==0 {print $1}')
wlan_offline=$(iw $wlan_card link | grep 'Not' | awk 'NR%1==0 {print $1}')
internet=$(wget -qO- ifconfig.co)
internet_logo=""
if [ $internet ]; then
    internet_logo=" "
else
    internet_logo=" "
fi

if [ $wlan_online ]; then
    wlan_do=$(ifstat2 -i $wlan_card 1 1 | awk 'NR%3==0 {print $1}')
    wlan_up=$(ifstat2 -i $wlan_card 1 1 | awk 'NR%3==0 {print $2}')
    printf "$internet_logo %5s  %5s\\n" \
    $(numfmt --to=none $wlan_do) \
    $(numfmt --to=none $wlan_up)
elif [ $wlan_offline ];then
    printf " OFFLINE"
else
    printf " NOADPTR"
fi
{% endhighlight %}

## Battery Capacity

{% highlight_caption batt_capacity %}
{% highlight bash linenos %}
#!/bin/sh

cap=$(cat /sys/devices/platform/smapi/BAT0/remaining_percent)
if   [ $cap -ge 0  ] && [ $cap -le 10  ]; then
    echo "" $cap"%"
elif [ $cap -ge 11 ] && [ $cap -le 20  ]; then
    echo "" $cap"%"
elif [ $cap -ge 21 ] && [ $cap -le 30  ]; then
    echo "" $cap"%"
elif [ $cap -ge 31 ] && [ $cap -le 40  ]; then
    echo "" $cap"%"
elif [ $cap -ge 41 ] && [ $cap -le 50  ]; then
    echo "" $cap"%"
elif [ $cap -ge 51 ] && [ $cap -le 60  ]; then
    echo "" $cap"%"
elif [ $cap -ge 61 ] && [ $cap -le 70  ]; then
    echo "" $cap"%"
elif [ $cap -ge 71 ] && [ $cap -le 80  ]; then
    echo "" $cap"%"
elif [ $cap -ge 81 ] && [ $cap -le 90  ]; then
    echo "" $cap"%"
elif [ $cap -ge 91 ] && [ $cap -le 100 ]; then
    echo "" $cap"%"
else
    echo " UNKNWN"
fi
{% endhighlight %}

## Battery Status

{% highlight_caption batt_state %}
{% highlight bash linenos %}
#!/bin/sh

state=$(cat /sys/devices/platform/smapi/BAT0/state)
if   [ $state = "charging"    ]; then
    echo " " # charging
elif [ $state = "discharging" ]; then
    echo " " # discharging
elif [ $state = "idle"        ]; then
    echo " " # idle
else
    echo " " # unknown
fi
{% endhighlight %}

Selesai!

Ya, seperti ini saja yang dapat saya catat.

Mudah-mudahan dapat bermanfaat untuk teman-teman yang memerlukan.

Terima kasih.

(^_^)

