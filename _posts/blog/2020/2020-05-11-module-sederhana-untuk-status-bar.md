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

# Pemecahan Masalah

Saya sudah membuatkan beberapa module yang dapat digunakan untuk membangun status bar sendiri atau digunakan oleh Polybar. Module akan saya tulis dalam dua sistem operasi. Karena *backend* program yang digunakan tentu saja berbeda pada kedua sistem operasi.

<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
<p>Saya tidak banyak pengalaman dalam menulis Bash Script. Apabila ada logika yang kurang baik, boleh sekali loh dikasih saran dan dibenerin. Saya sangat terbuka dan senang sekali. Terima kasih (^_^)</p>
</div>

# Module

## CPU Temperature

**GNU/Linux**

{% highlight bash linenos %}
#!/usr/bin/env bash

get_temp_cpu0=$(cat /sys/class/thermal/thermal_zone0/temp)
temp_cpu0=$(($get_temp_cpu0/1000))
echo "" $temp_cpu0"°C"
{% endhighlight %}

**FreeBSD**

{% highlight bash linenos %}
#!/usr/local/bin/bash

temp_cpu0=$(sysctl -n dev.cpu.0.temperature | cut -d "." -f1)
echo "" $temp_cpu0"°C"
{% endhighlight %}

## Memory

**GNU/Linux**

{% highlight bash linenos %}
#!/usr/bin/env bash

mem_total=$(free | awk 'NR%2==0 {print $2}')
mem_avail=$(free | awk 'NR%2==0 {print $7}')
mem_used=$(( $mem_total - $mem_avail))
mem_usage=$(( $mem_used * 100 / $mem_total ))
echo " "$mem_usage"%"
{% endhighlight %}

**FreeBSD**

{% highlight bash linenos %}
#!/usr/local/bin/bash

mem_phys=$(sysctl -n hw.physmem)
mem_hw=$mem_phys
pagesize=$(sysctl -n hw.pagesize)
mem_inactive=$(( $(sysctl -n vm.stats.vm.v_inactive_count) * $pagesize))
mem_cache=$(( $(sysctl -n vm.stats.vm.v_cache_count) * $pagesize))
mem_free=$(( $(sysctl -n vm.stats.vm.v_free_count) * $pagesize))
mem_total=$mem_hw
mem_avail=$(( $mem_inactive + $mem_cache + $mem_free ))
mem_used=$(( $mem_total - $mem_avail ))
mem_usage=$(( $mem_used * 100 / $mem_total ))
echo "" $mem_usage"%"
{% endhighlight %}

## File System

**GNU/Linux**

{% highlight bash linenos %}
#!/usr/bin/env bash

cap_percentage=$(df -h --output=pcent / | awk 'NR%2==0 {print $0}')
echo ""$cap_percentage
{% endhighlight %}

**FreeBSD**

{% highlight bash linenos %}
#!/usr/local/bin/bash

cap_percentage=$(df -h / | tail -1 | awk '{print $(NF-1)}' | cut -d "G" -f1)
cap_avail=$(df -h / | tail -1 | awk '{print $(NF-2)}' | cut -d "G" -f1)
cap_total=$(df -h / | tail -1 | awk '{print $(NF-4)}' | cut -d "G" -f1)
echo $cap_avail"/"$cap_total"G ("$cap_percentage")"
echo ""$cap_percentage
{% endhighlight %}

## Volume

**GNU/Linux**

{% highlight bash linenos %}
#!/usr/bin/env bash

mute=$(pamixer --get-mute)
if [ $mute = "true" ]; then
    echo " MUTE"
elif [ $mute = "false" ]; then
    volume=$(pamixer --get-volume-human)
    echo "" $volume
else
    echo " ERROR"
fi
{% endhighlight %}

**FreeBSD**

{% highlight bash linenos %}
#!/usr/local/bin/bash

mute=$(sysctl -n dev.acpi_ibm.0.mute)
if [ $mute = "1" ]; then
    echo " MUTE"
elif [ $mute = "0" ]; then
    volume=`mixer vol | awk '{print $(NF)}' | cut -d ":" -f1`
    echo "" $volume
else
    echo " ERROR"
fi
{% endhighlight %}

## Backlight

**GNU/Linux**

{% highlight bash linenos %}
#!/usr/bin/env bash

backlight=$(xbacklight -get | cut -d "." -f1)
echo "" $backlight"%"
{% endhighlight %}

**FreeBSD**

{% highlight bash linenos %}
#!/usr/local/bin/bash

backlight=$(sysctl -n hw.acpi.video.lcd0.brightness | awk '{print $(NF)}')
echo "" $backlight"%"
{% endhighlight %}

## Network Traffic

**GNU/Linux** & **FreeBSD**

{% highlight bash linenos %}
#!/bin/bash

wlan_card='wls3'
wlan_do=$(ifstat2 -i $wlan_card 1 1 | awk 'NR%3==0 {print $1}')
wlan_up=$(ifstat2 -i $wlan_card 1 1 | awk 'NR%3==0 {print $2}')
echo "" $wlan_do "" $wlan_up "KB/s"
{% endhighlight %}

## Battery Capacity

**GNU/Linux**

{% highlight bash linenos %}
#!/usr/bin/env bash

cap=$(cat /sys/devices/platform/smapi/BAT0/remaining_percent)
if [ $cap -ge 0 ] && [ $cap -le 20 ]; then
    echo "" $cap"%"
elif [ $cap -ge 21 ] && [ $cap -le 40 ]; then
    echo "" $cap"%"
elif [ $cap -ge 41 ] && [ $cap -le 60 ]; then
    echo "" $cap"%"
elif [ $cap -ge 61 ] && [ $cap -le 90 ]; then
    echo "" $cap"%"
elif [ $cap -ge 91 ] && [ $cap -le 100 ]; then
    echo "" $cap"%"
else
    echo "UNKNWN"
fi
{% endhighlight %}

**FreeBSD**

{% highlight bash linenos %}
#!/usr/local/bin/bash

cap=$(sysctl -n hw.acpi.battery.life)
if [ $cap -ge 0 ] && [ $cap -le 20 ]; then
    echo "" $cap
elif [ $cap -ge 21 ] && [ $cap -le 40 ]; then
    echo "" $cap
elif [ $cap -ge 41 ] && [ $cap -le 60 ]; then
    echo "" $cap
elif [ $cap -ge 61 ] && [ $cap -le 90 ]; then
    echo "" $cap
elif [ $cap -ge 91 ] && [ $cap -le 100 ]; then
    echo "" $cap
else
    echo "UNKNWN"
fi
{% endhighlight %}

## Battery Status

**GNU/Linux**

{% highlight bash linenos %}
#!/usr/bin/env bash

state=$(cat /sys/devices/platform/smapi/BAT0/state)
if [ $state = "charging" ]; then
    echo " " # charging
elif [ $state = "discharging" ]; then
    echo " " # discharging
elif [ $state = "idle" ]; then
    echo " " # idle
else
    echo " " # unknown
fi
{% endhighlight %}

**FreeBSD**

{% highlight bash linenos %}
#!/usr/local/bin/bash

state=$(sysctl -n hw.acpi.battery.state)
if [ $state = "2" ]; then
    echo " " # charging
elif [ $state = "1" ]; then
    echo ""  # discharging
elif [ $state = "0" ]; then
    echo " " # idle
else
    echo ""  # unknown
fi
{% endhighlight %}

Selesai!

Ya, seperti ini saja yang dapat saya catat.

Mudah-mudahan dapat bermanfaat untuk teman-teman yang memerlukan.

Terima kasih.

(^_^)

