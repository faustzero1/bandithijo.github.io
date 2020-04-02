---
layout: 'post'
title: 'Berpindah dan Melompat antar Window Container dalam i3wm'
date: 2018-12-23 15:00
permalink: '/vlog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'vlog'
tags: ['I3WM', 'Tips']
pin:
voice:
---

<div style="margin-top:30px;"></div>

{% include youtube_embed.html id="UlEik7nYkLE" %}

# Deskripsi

Dalam menggunakan i3wm, terkadang kita harus berpindah antar Window Container. Lantas bagaimana apabila kita ingin melompati satu Window Container? Apakah bisa?

Untuk dapat melakukan hal tersebut, i3wm menyediakan fitur yang bernama [**Focus Parent**](https://i3wm.org/docs/userguide.html#_focus_parent){:target="_blank"}.

Saya memberikan tiga contoh kemungkinan yang sering saya alami selama menggunakan dan memanfaatkan window container.

**Contoh 1**

```
# 2 Container
[1] | [2,3,4,5]
```
```
# Berpindah Fokus dari:
[5] ke [1]
[4] ke [1]
[3] ke [1]
[2] ke [1]
```

**Contoh 2**

```
# 3 Container
[1] | [2,3,4] | [5]
```
```
# Berpindah Fokus dari:
[1] ke [2] ke [5]
[1] ke [3] ke [5]
[1] ke [4] ke [5]
```

**Contoh 3**

```
# Membuat Kontainer Baru
[1,2] | <new_target>
```

<br>
Background music:

[高橋優「プライド」（アニメ「メジャーセカンド」EDバージョン）](https://youtu.be/tf61cA6a-N0){:target="_blank"}
