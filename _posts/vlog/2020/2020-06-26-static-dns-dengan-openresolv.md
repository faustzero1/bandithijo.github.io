---
layout: 'post'
title: "Static DNS dengan Openresolv"
date: 2020-06-26
permalink: '/vlog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'vlog'
tags: ['Tips', 'Arch Linux']
pin:
voice:
---

<div style="margin-top:30px;"></div>

{% youtube 1zf1Dpyzq84 %}

# Deskripsi

Although openresolv is most known for allowing multiple applications to modify /etc/resolv.conf, it is currently the only standard way to implement:
1. dynamic control of a DNS resolver (other than glibc),
2. dynamic conditional forwarding.

Sumber:

[Arch Wiki - openresolv](https://wiki.archlinux.org/index.php/Openresolv){:target="_blank"}
