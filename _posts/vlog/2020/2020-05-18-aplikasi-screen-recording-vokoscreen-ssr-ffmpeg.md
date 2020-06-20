---
layout: 'post'
title: '(Ngomong Panjang) Aplikasi Screen Recording Vokoscreen, SimpleScreenRecorder, & FFMPEG'
date: 2020-05-18
permalink: '/vlog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'vlog'
tags: ['Tips']
pin:
voice: true
---

<div style="margin-top:30px;"></div>

{% include youtube_embed.html id="Xn7hcP_W3q4" %}

# Deskripsi

Pada video log kali ini, saya bercerita mengenai beberapa aplikasi screen recorder yang pernah saya gunakan dan yang saat ini saya gunakan.

**Untuk Screncast (Video+Audio)**

<pre>
$ <b>ffmpeg -y -f x11grab -draw_mouse 1 -framerate 30 -s $(xdpyinfo | grep dimensions | awk '{print $2;}') -i :0.0+0,0 -f pulse -i default -c:a aac  -c:v libx264rgb -pix_fmt rgb24 -preset veryfast -threads 0 "$HOME/screencast-$(date '+%y%m%d-%H%M-%S').mp4"</b>
</pre>

<br>
**Untuk Video only**

<pre>
$ <b>ffmpeg -f x11grab -draw_mouse 1 -framerate 30 -s $(xdpyinfo | grep dimensions | awk '{print $2;}') -i :0.0+0,0 -c:v libx264 -pix_fmt yuv420p -preset veryfast -q:v 1 -threads 0 "$HOME/video-$(date '+%y%m%d-%H%M-%S').mp4"</b>
</pre>
