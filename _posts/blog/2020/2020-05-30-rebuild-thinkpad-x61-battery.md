---
layout: 'post'
title: "Rebuild ThinkPad X61 Battery"
date: 2020-05-30 17:49
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'ThinkPad']
pin:
hot:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Pendahuluan

Sejak memutuskan untuk membeli ThinkPad X61, saya sudah berencana untuk merakit battery sendiri karena tidak ingin tergantung terhadap battery-battery yang dijual di marketplace. Dari Oktober 2018, baru Mei 2020 ini saya berkesempatan untuk mencoba merakit battery sendiri.

Mungkin kali ini belum bisa dikatakn merakit, meskipun memang prosesnya merakit. Namun, untuk saat ini saya sebut dengan *rebuild* atau membangun ulang, karena cell battery yang saya dapatkan adalah cell battery dari bekas battery ThinkPad X260 yang berisi 6 cell yang sudah tidak dapat digunakan (persentase tidak mau naik, hanya 0%).

# Proses Perakitan

## Menggambar Skema Ala-ala

Saya mulai dengan menggambar skema wiring ala-ala, agar tidak kehilangan arah saat merakit kembali. Meskipun rangkaian battery ini meruapakan rangkaian paralel sederhana, namun karena saya tidak terbiasa dengan hal-hal seperti ini, lebih baik saya catat. Hehe.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/Gmb27184/gambar-01.jpg" onerror="imgError(this);"}
<p class="img-caption">Gambar 1 - Gambar skema wiring battery ala-ala</p>

Battery dengan cell berwarna biru ini adalah isi dari battery ThinkPad X61 yang sudah saya buka. Battery ini bukan battery original. Jujur saja saya penasaran seperti apa isi dari battery ThinkPad Original.

Battery yang saya buka ini, sudah tidak dapat bertahan lama, paling hanya 5-10 menitan kalau digunakan. Ternyata setelah dibuka dan saya periksa voltase masing-masing cell, benar saja. Hanya 1 cell yang masih 3,6V sedangkan 2 diantaranya 1,5V dan tersisa 1 yang tidak menunjukkan nilai voltase sama sekali.

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/13MzbYwJ/gambar-02.jpg" onerror="imgError(this);"}
<p class="img-caption">Gambar 2 - Cell yang ditunjuk adalah cell yang rusak (bocor)</p>

Cell ini mengeluarkan cairan, meski tidak terlihat basah namun terasa basah di tangan dan mengeluarkan bau khas bahan battery Li-ion.

## Membongkar Rangkaian Battery

Setelah cukup yakin bahwa saya mencatat semua yang saya perlukan untuk nantinya dapat saya rangkai kembali, saya mulai membongkar rangkaian. Saya mulai dari melepas kabel-kabel yang terhubung dengan battery.

![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/CLTd88wH/gambar-04.jpg" onerror="imgError(this);"}
<p class="img-caption">Gambar 3 - Rangkaian battery yang sudah saya lepas perkabelannya</p>

Pada Gambar 3, terlihat bahwa masing-masing battery terhubung dengan plat tipis. Plat ini yang saya baru paham, ditempel ke kutub-kutub battery dengan menggunakan sebuah teknik yang bernama "*Spot Welding*". Pantas saja ketika saya coba panaskan dengan solder, tidak bergeming sama sekali. Mungkin dilain kesempatan saya akan coba membuat alat *spot welder* saya sendiri. Agar memudahkan untuk perakitan battery. Sayang sekali saya tidak memiliki gambar dari battery yang dipasang plat dengan *spot welding*. Mungkin teman-teman dapat mencari saja di internet, bentuknya seperti titik-titik di kepala Kurilin. Hehe.

Selanjutnya, saya sudah menyiapkan battery ThinkPad X260 68+ (6 cell) yang benar-benar sudah tidak dapat digunakan.

![gambar_4]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/RFJV6S8D/gambar-03.jpg" onerror="imgError(this);"}
<p class="img-caption">Gambar 4 - Cell dari battery ThinkPad X260 68+</p>

Dari Gambar 4, terlihat bahwa dari 6 cell, ternyata ada 2 cell yang rusak. Padahal battery case nya masih bagus dan tidak ada menggembung atau terlihat rusak --meskipun akhirnya battery casenya rusak karena saya buka paksa. Pantas saja battery ini sudah tidak dapat digunakan. Ke empat cell yang masing bagus tersebut masih memiliki voltase sebesar 3,6V.

## Merakit Battery

Langkah selanjutnya adalah merakit battery. Karena sebenarnya proyek ini hanya uji coba, saya tidak mempersiapkan bahan-bahan dengan baik. Termasuk plat yang saya tidak punya. Lantas saya menggunakan potongan kabel kecil bekas dari kabel penyambung USB.

**Kenapa tidak menggunakan plat lama bekas battery?**

Sejujurnya saya sudah mencoba merapikan sobekan-sobekan plat tersebut, namun saya kesulitan dalam proses penyolderan antara plat dan kutub battery. Hehe. Ternyata saya baru tahu kalau plat tersebut seharusnya dipasang dengan proses yang dinamakan *spot welding*. Mungkin juga sebenarnya bisa menyolder plat ke kutub dengan telebih dahulu mengamplas mengamplas plat-plat yang akan dipasang di kutub battery. Entahlah, saya belum begitu ahli dalam menyolder.

Karena tidak memiliki alat bantu untuk memegang battery, saya mengakali dengan memanfaatkan kunci inggris dan tang. Hehe

![gambar_5]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/WbGzw43R/gambar-05.jpg" onerror="imgError(this);"}
<p class="img-caption">Gambar 5 - Kunci inggris dan tang yang diberikaret gelang sebagai battery holder</p>

Seharusnya jaraknya antara battery masih bisa lebih dekat lagi, namun saya memutuskan untuk memberi jarak terlebih dahulu. Kebetulan juga battery case ThinkPad X61 masih cukup lega, dan maih terdapat cukup ruang untuk perkabelan yang semrawut. Hehe.

Sambil dirakit, setiap blok pararelnya, jangan lupa sambil dilakukan pengukuran voltase.

***Hasilnya menyusul yaa, lupa difoto =p***


## Pengukuran Voltase

Setelah battery selesai dirakit, saatnya pengukuran voltase bagian akhir. pabila setiap battery bervoltase 3,6V dikalikan 4 cell, berarti seharusnya akan memiliki total 14,4V.

![gambar_6]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/rpPww0h4/gambar-06.jpg" onerror="imgError(this);"}
<p class="img-caption">Gambar 6 - Battery yang saya beli (abal)</p>

Loh, nilai voltase pada battery di Gambar 6 kok lebih dari 14,4V? Nah, saya juga kurang paham. Battery ini yang saya pakai, dan masih dapat bertahan sekitar 30 menitan.

Kemudian, saya mengukur battery yang saya rakit (*rebuild*).

![gambar_7]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/vmBmyLvM/gambar-07.jpg" onerror="imgError(this);"}
<p class="img-caption">Gambar 7 - Battery hasil rebuild</p>

Nah, hasil pengukuran voltasenya sebesar 14,26V. Mendekai lah yaa dengan nilai normal.

Dalam proses ini saya juga melihat dan menunggu apakah battery sudah aman dan tidak ada perubahan suhu.

Berikut ini cuplikasn videonya.

{% include youtube_embed.html id="GGiT3v6GM9w" %}

# Hasilnya

{% include youtube_embed.html id="xLnRxfz0d7I" %}

<br>
Dari video di atas, terlihat saya sedang menguji coba penggunaan battery yang sudah di rebuild ke laptop. Saya ingin melihat apakah ada indikasi *whitelisting* oleh BIOS atau tidak.

Selanjutnya adalah proses kalibrasi dengan tlp.

Saya menjalankan perintah:

<pre>
$ <b>sudo tlp recalibrate</b>
</pre>

```
Currently discharging battery BAT0:
voltage            =  14501 [mV]
remaining capacity =  14470 [mWh]
remaining percent  =     61 [%]
remaining time     =     30 [min]
power              = -16241 [mW]
state              = discharging
force discharge    = 1
Press Ctrl+C to cancel.
```

Perintah di atas akan menjalankan kalibrasi battery dimana proses bermula dari pengosongna battery (*discharging*) sampai ke 0% kemudian mengisi kembali (*charging*) hingga 100%. Kalau kita mengeset battery threshold, pada proses kalibrasi ini, threshold akan diubah ke 100%.

Berikut ini adalah grafik hasil kalibrasi battery rebuild.

![gambar_8]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/htnkVDJ5/gambar-08.png" onerror="imgError(this);"}
<p class="img-caption">Gambar 8 - Hasil pengukuran dengan Gnome Power Statistics</p>

Untuk meliahat informasi dari battery, saya juga menggunakan perintah:

<pre>
$ <b>sudo tlp-stat -b</b>
</pre>

```
--- TLP 1.3.1 --------------------------------------------

+++ Battery Features: Charge Thresholds and Recalibrate
natacpi    = inactive (ThinkPad not supported)
tpacpi-bat = inactive (ThinkPad not supported)
tp-smapi   = active (data, thresholds, recalibrate)

+++ ThinkPad Battery Status: BAT0 (Main / Internal)
/sys/devices/platform/smapi/BAT0/manufacturer               = SANYO
/sys/devices/platform/smapi/BAT0/model                      = 93P5030
/sys/devices/platform/smapi/BAT0/manufacture_date           = 2018-12-04
/sys/devices/platform/smapi/BAT0/first_use_date             = 1988-01-26
/sys/devices/platform/smapi/BAT0/cycle_count                =      4
/sys/devices/platform/smapi/BAT0/temperature                =     25 [°C]
/sys/devices/platform/smapi/BAT0/design_capacity            =  31680 [mWh]
/sys/devices/platform/smapi/BAT0/last_full_capacity         =  23810 [mWh]
/sys/devices/platform/smapi/BAT0/remaining_capacity         =  21210 [mWh]
/sys/devices/platform/smapi/BAT0/remaining_percent          =     90 [%]
/sys/devices/platform/smapi/BAT0/remaining_running_time_now = not_discharging [min]
/sys/devices/platform/smapi/BAT0/remaining_charging_time    = not_charging [min]
/sys/devices/platform/smapi/BAT0/power_now                  =      0 [mW]
/sys/devices/platform/smapi/BAT0/power_avg                  =      0 [mW]
/sys/devices/platform/smapi/BAT0/state                      = idle

/sys/devices/platform/smapi/BAT0/start_charge_thresh        =     70 [%]
/sys/devices/platform/smapi/BAT0/stop_charge_thresh         =     90 [%]
/sys/devices/platform/smapi/BAT0/force_discharge            =      0

Charge                                                      =   89.1 [%]
Capacity                                                    =   100.3 [%]
```

Terdapat beberapa kejanggalan, seperti nilai dari **first_use_date** yang tahunnya sangat janggal dan berubah-ubah.

Perhatikan grafik discharge (biru) dan charge (merah), terdapat *drop* pada saat *disharging* pada presentase sekitar 45% ke 8% dan *jump* pada saat *charging* pada presentase sekitar 70% ke 100%.

Saya kurang paham, ini perilaku dari Cell atau module controller dari battery ini yang kurang bagus. Saya akan coba dengan cell yang lain bila cell yang sekarang telah rusak. Mungkin saya akan mencoba merek yang lebih baik dengan mAh yang sedikit lebih besar. Hehe.

<br>
**Update: 2020-05-31**

![gambar_9]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/zfwwdDHb/gambar-09.png" onerror="imgError(this);"}
<p class="img-caption">Gambar 9 - Hasil discharge setelah kalibrasi kedua</p>

Pada Gambar 9, ini adalah grafik discharging yang saya laukan setelah rekalibrasi yang kedua. Saya tidak menyangka, tidak drop pada 40% namun pada 19%. Oh yaa, discharging ini juga dilakukan sambil menjalankan perintah:

<pre>
$ <b>sudo powertop --calibrate</b>
</pre>

Saya juga sedikit terkejut karena setelah dikalibrasi dengan powertop, dapat menambah efisiensi penggunaan power menjadi 30 menit lebih lama, yang awalnya hanya bertahan 30 menitan, sekarang dapat mencapai 1 jam. Padahal saya melakukan pengetesan sambil menonton YouTube.

# Pesan Penulis

Saat tulisan ini dibuat, sudah hari kedua saya mengguanakan battery ini. Dan sejauh ini tidak ada masalah sama sekali.

Sejujurnya ada sedikit perasaan yang mengganjal di hati saya. Yaitu tentang pembahasan mengenai topik "rebuild ThinkPad battery" mengapa hal ini tidak menjadi topik yang seharusnya sudah lumrah untuk dibahas di group2 chat ataupun forum ThinkPad di Indonesia?  Apalagi rebuild battery ThinkPad yang masih menggunakan battery type 18650. Sejujurnya saya merasa hal ini sangat mudah dilakukan. Apakah ada konspirasi dari pihak tertentu yang tidak ingin topik ini naik dan semua orang dapat melakukan dengna mudah? Apakah karena kepentingan pihak-pihak tertentu yang juga berjualan battery untuk ThinkPad tua? Entahlah...Yang jelas kalau tulisan ini sampai hilang, berarti asumsi-asumsi di atas, ada benarnya. Hehe. Kita tunggu saja.

Saya menyertakan beberapa referensi yang belum sempat saya baca-baca. Mungkin teman-teman memerlukannya.


# Referensi

1. [IBM Thinkpad Battery Re-Celling Battery Rebuild Tutorial](https://forum.thinkpads.com/viewtopic.php?t=121516){:target="_blank"}
<br>Diakses tanggal: 2020/05/30

2. [Rebuilding batteries](https://www.reddit.com/r/thinkpad/comments/79q22o/rebuilding_batteries/){:target="_blank"}
<br>Diakses tanggal: 2020/05/30

3. [Replacing Lenovo laptop lithium batteries](https://hackaday.io/page/247-replacing-lenovo-laptop-lithium-batteries){:target="_blank"}
<br>Diakses tanggal: 2020/05/30

4. [SMBusb - Hacking smart batteries](http://www.karosium.com/2016/08/smbusb-hacking-smart-batteries.html){:target="_blank"}
<br>Diakses tanggal: 2020/05/30

5. [Will China's 18650 Battery Beat LG, Samsung, Sony & Panasonic? Let's find out!](https://www.youtube.com/watch?v=qMZuHMlRw_0){:target="_blank"}
<br>Diakses tanggal: 2020/05/30
