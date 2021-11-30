---
layout: 'post'
title: "Berkontribusi di Fedora Kernel Test Days 5.15"
date: 2021-11-24 06:07
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Fedora', 'Event']
pin:
hot:
contributors: []
description: "Serunya menggunakan distribusi sistem operasi GNU/Linux, kita dapat kesempatan untuk dapat berkontribusi. Terdapat cukup banyak ruang untuk berkontribusi. Fedora adalah salah satu distribusi yang memberikan ruang yang cukup banyak untuk berkontribusi serta dipandu dengan dokumentasi yang sangat baik. Salah satu bentuk kontribusi yang dapat kamu berikan adalah mengikuti Kernel Test Days event. Berikut ini adalah catatan saya dalam mengukuti kegiatan ini."
---

{% box_perhatian %}
<p markdown=1>Saya, sebagai penulis, **tidak bertanggung jawab** atas segala bentuk kejadian buruk yang menimpa sistem kalian.</p>
<p markdown=1>Apabila kalian mengikuti catatan ini, berarti kalian **telah menyetujui** bahwa **segala bentuk risiko atas masalah** yang terjadi karena mengikuti catatan ini, adalah **tanggung jawab kalian sepenuhnya**.</p>
<p markdown=1>Happy Testing!</p>
{% endbox_perhatian %}

# Latar Belakang

## Apa itu Kernel Test Days?

Kernel Test Days adalah kegiatan di mana siapa pun dapat membantu memastikan perubahan di Fedora dapat berfungsi dengan baik pada rilis mendatang. Anggota komunitas Fedora sering ikut berpartisipasi, dan menyambut baik acara ini. Jika kamu belum pernah berkontribusi sebelumnya, *event* ini adalah cara sempurna untuk memulai kontribusi pertama kamu.

Apabila kamu berhasil mengikuti *event* ini, kamu akan diberikan *reward* berupa *badge* seperti ini,

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://badges.fedoraproject.org/pngs/kernel-tester.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 1 - Science (Kernel Tester I): You completed a run of the kernel regression test suite</p>

Di dalam *badge* ini terdapat angkat, artinya *badge* ini bersifat *continue*. Setiap kelipatan 5 kali test, kamu akan mendapatkan *badge* ini dengan angka yang bertambah.

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://badges.fedoraproject.org/pngs/kernel_tester_5.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 2 - Science (Kernel Tester II): You completed 5 runs of the kernel regression test suite</p>

![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://badges.fedoraproject.org/pngs/kernel_tester_10.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 3 - Science (Kernel Tester III): You completed 10 runs of the kernel regression test suite</p>

Dan begitu seterusnya.

# Dari mana saya dapat informasi tentang Kernel Test Days?

Fedora Community memiliki beberapa portal informasi yang dapat kamu ikuti. Salah satu yang sering saya kunjungi adalah [Fedora Magazine](https://fedoramagazine.org){:target="_blank"}. Biasanya, apabila ada informasi terkait *event*, akan diberitakan di Fedora Magazine. Biar tidak ketinggalan *event* atau artikel terbaru, kamu juga bisa berlangganan via email.

Biasanya, pemberitahuan terkait Kernel Test Days akan diberitakan 2-4 hari sebelum *event* diselenggarakan.

## Bagaimana cara kerja Kernel Test Days ini?

Sangat mudah. Untuk berkontribusi dalam *event* ini, kita hanya perlu melakukan hal-hal berikut:

1. Unduh materi uji, yang menyertakan beberapa file besar
2. Baca dan ikuti petunjuk langkah demi langkah

Setiap Kernel Test Days, biasanya memiliki panduan yang didokumentasikan pada halaman wiki yang spesifik untuk kegiatan ini.

Contohnya, untuk kegiatan Kernel Test Days 5.15 kali ini, [**Test Day:2021-11-14 Kernel 5.15 Test Week**](https://fedoraproject.org/wiki/Test_Day:2021-11-14_Kernel_5.15_Test_Week){:target="_blank"}.

Jadi, pastikan bahwa kamu mengikuti panduan wiki yang sesuai.

## Apakah media yang digunakan untuk melakukan Kernel test?

Terdapat beberapa media yang dapat kamu pilih untuk melakukan Kernel test. Pilih yang sesuai dan tidak beresiko untuk sistem kamu.

1. [F35 test day image](https://jforbes.fedorapeople.org/testweek/){:target="_blank"} atau Fedora 34/35 Workstation/Server installation, yang akan dipasangkan pada bare metal atau VM, pastikan tidak terdapat data-data penting
2. Sistem dengan Kernel 5.15, yang dapat dipasang dari [F35 Koji](https://koji.fedoraproject.org/koji/buildinfo?buildID=1855177){:target="_blank"} atau [Kernel-Stabilization Copr](https://copr.fedorainfracloud.org/coprs/jforbes/kernel-stabilization/){:target="_blank"}
3. Fedora Silverblue dan Kinoite dapat melakukan test menggunakan Koji Kernel (cara nomor 2)

Dari ketiga pilihan tersebut, untuk catatan kali ini, saya memberanikan diri untuk mengambil pilihan kedua, yaitu langsung memasang Kernel 5.15 pada sistem yang sudah terpadang Fedora 35. Saya akan ambil Kernel 5.15 dari Koji.

# Persiapkan Bahan Pengujian

## Pasang paket Koji

*Koji is a system for building and tracking RPMS.*

Karena saya memilih menggunakan Kernel 5.15 dari Koji, terlebih dahulu harus memasang paket Koji.

{% shell_term $ %}
sudo dnf install koji
{% endshell_term %}

## Melihat daftar Kernel builds yang tersedia

Untuk melihat daftar dari Kernel builds yang tersedia. Gunakan flag `--after=`, lalu isi dengan format tanggal YYYY-MM-DD.

{% shell_term $ %}
koji list-builds --package=kernel --after="2021-11-12" | grep "5.15"
{% endshell_term %}

```
kernel-5.15.2-200.fc35                                   jforbes           COMPLETE
kernel-5.15.3-200.fc35                                   jforbes           COMPLETE
```

## Download Kernel builds

Saya pilih yang paling bawah dari daftar Kernel 5.15 yang tersedia untuk di download.

{% shell_term $ %}
koji download-build --arch=x86_64 kernel-5.15.3-200.fc35
{% endshell_term %}

{% box_perhatian %}
<p markdown=1>Perhatikan pada bagian *release version* `.fc35`, pastikan kamu memilih *release version* yang sesuai dengan versi Fedora yang sedang digunakan. Biasanya juga terdapat versi Fedora sebelumnya `.fc34`.</p>
{% endbox_perhatian %}

Perintah di atas akan mendownload semua paket terkait `kernel-5.15.3-200.fc35`,

```
SIZE PACKAGES
 14K kernel-5.15.3-200.fc35.x86_64.rpm
 35M kernel-core-5.15.3-200.fc35.x86_64.rpm
 14K kernel-debug-5.15.3-200.fc35.x86_64.rpm
 37M kernel-debug-core-5.15.3-200.fc35.x86_64.rpm
 15M kernel-debug-devel-5.15.3-200.fc35.x86_64.rpm
 14K kernel-debug-devel-matched-5.15.3-200.fc35.x86_64.rpm
 34M kernel-debug-modules-5.15.3-200.fc35.x86_64.rpm
2,1M kernel-debug-modules-extra-5.15.3-200.fc35.x86_64.rpm
282K kernel-debug-modules-internal-5.15.3-200.fc35.x86_64.rpm
8,0M kernel-devel-5.15.3-200.fc35.x86_64.rpm
 14K kernel-devel-matched-5.15.3-200.fc35.x86_64.rpm
 33M kernel-modules-5.15.3-200.fc35.x86_64.rpm
2,0M kernel-modules-extra-5.15.3-200.fc35.x86_64.rpm
254K kernel-modules-internal-5.15.3-200.fc35.x86_64.rpm
```

## Update kernel

Setelah proses download selesai, saatnya mengupdate kernel.

{% shell_term $ %}
sudo dnf update kernel-*.rpm
{% endshell_term %}

{% box_perhatian %}
<p markdown=1>Pastikan! kita menjalankan perintah di atas pada direktori tempat paket-paket kernel tersebut berada.</p>
{% endbox_perhatian %}

```
===============================================================================================
 Package                     Architecture  Version                   Repository           Size
===============================================================================================
Installing:
 kernel                      x86_64        5.15.3-200.fc35           @commandline         14 k
 kernel-modules              x86_64        5.15.3-200.fc35           @commandline         32 M
 kernel-modules-extra        x86_64        5.15.3-200.fc35           @commandline        2.0 M
Installing dependencies:
 kernel-core                 x86_64        5.15.3-200.fc35           @commandline         35 M
Installing weak dependencies:
 kernel-devel                x86_64        5.15.3-200.fc35           @commandline         15 M

Transaction Summary
===============================================================================================
Install  5 Packages

Total size: 84 M
Installed size: 171 M
Is this ok [y/N]:
```

tekan <kbd>Y</kbd> dan <kbd>Enter</kbd>.

```
Downloading Packages:
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                       1/1
  Installing       : kernel-core-5.15.3-200.fc35.x86_64                                    0/5
  Running scriptlet: kernel-core-5.15.3-200.fc35.x86_64                                    0/5
  Installing       : kernel-modules-5.15.3-200.fc35.x86_64                                 2/5
  Running scriptlet: kernel-modules-5.15.3-200.fc35.x86_64                                 2/5
  Installing       : kernel-5.15.3-200.fc35.x86_64                                         3/5
  Installing       : kernel-modules-extra-5.15.3-200.fc35.x86_64                           4/5
  Running scriptlet: kernel-modules-extra-5.15.3-200.fc35.x86_64                           4/5
  Installing       : kernel-devel-5.15.3-200.fc35.x86_64                                   5/5
  Running scriptlet: kernel-devel-5.15.3-200.fc35.x86_64                                   5/5
  Running scriptlet: kernel-core-5.15.3-200.fc35.x86_64                                    5/5
  Running scriptlet: kernel-devel-5.15.3-200.fc35.x86_64                                   5/5
  Verifying        : kernel-5.15.3-200.fc35.x86_64                                         0/5
  Verifying        : kernel-core-5.15.3-200.fc35.x86_64                                    2/5
  Verifying        : kernel-devel-5.15.3-200.fc35.x86_64                                   3/5
  Verifying        : kernel-modules-5.15.3-200.fc35.x86_64                                 4/5
  Verifying        : kernel-modules-extra-5.15.3-200.fc35.x86_64                           5/5

Installed:
  kernel-5.15.3-200.fc35.x86_64                     kernel-core-5.15.3-200.fc35.x86_64
  kernel-devel-5.15.3-200.fc35.x86_64               kernel-modules-5.05.3-200.fc35.x86_64
  kernel-modules-extra-5.15.3-200.fc35.x86_64

Complete!
```

Setelah kernel berhasil dipasang, saatnya **reboot**.

# Persiapan Alat Pengujian

## Pasang paket yang diperlukan

Pastikan paket `gcc`, `git`, dan `python3-fedora` sudah terpasang.

{% shell_term $ %}
sudo dnf install gcc git python3-fedora
{% endshell_term %}

Paket `python3-fedora` diperlukan untuk mengirimkan hasil pengujian.

Kita juga memerlukan paket-paket di bawah ini untuk menjalankan test.

{% shell_term $ %}
sudo dnf install make libtirpc libtirpc-devel policycoreutils-python-utils
{% endshell_term %}

## Clone kernel-tests tools dari repositori

{% shell_term $ %}
git clone https://pagure.io/kernel-tests.git
{% endshell_term %}

Masuk ke dalam direktori `kernel-tests`.

{% shell_term $ %}
cd kernel-tests
{% endshell_term %}

```
 kernel-tests/
│  default/
│  destructive/
│  include/
│  minimal/
│  performance/
│  secureboot/
│  stress/
│  thirdparty/
│  utils/
│  config.example
│  documentation.txt
│  fedora_submit.py
│  LICENSE
└  runtests.sh
```

## Allow SELinux permission untuk heap execution

Before running tests, we need to allow the testsuite to make their heap memory executable with this command,

{% shell_term $ %}
sudo semanage boolean -m --on selinuxuser_execheap
{% endshell_term %}

\* Setelah proses pengujian selesai, kita akan me-nonaktifkan-nya kembali.

## Buat salinan konfigurasi

Salin contoh konfigurasi default, karena kita akan membuat konfigurasi kita sendiri.

{% shell_term $ %}
cp config.example .config
{% endshell_term %}

\* **Perhatikan!** terdapat tanda titik di depan nama `.config`.

## Edit file konfigurasi

Kita akan mengedif file `.config` untuk memasukkan beberapa nilai-nilai credential seperti username dan password FAS kita.

Ubah isi dari beberapa bagian, seperti yang saya contohkan di bawah.

{% highlight_caption .config %}
{% highlight shell linenos %}
# ...

# submit=none
# submit=anonymous
submit=authenticated

# ...
{% endhighlight %}

Kita akan menggunakan metode submit authenticated.

Isi juga username dan password pada bagian di bawahnya.

{% highlight_caption .config %}
{% highlight shell linenos %}
# ...

# FAS User credentials.
# Storing your FAS password here is technically possible, but is not
# advisable for security reasons.

username='your-username-FAS'
password='your-password-FAS'

# ...
{% endhighlight %}

{% box_perhatian %}
<p markdown=1>File `.config` ini sudah masuk ke dalam `.gitignore`.</p>
<p markdown=1>Setelah pengujian selesai, jangan lupa untuk membersihkan/mengoosongkan/menghapus file `.config` untuk tujuan keamanan data *credential*.</p>
{% endbox_perhatian %}

{% box_info %}
<p markdown=1>Optionally, if you use the proprietary Nvidia driver, look for the line "thirdparty=y" and uncomment it.</p>
{% endbox_info %}

# Pengujian

Di dalam file `runtests.sh` terdapat fungsi yang menunjukkan beberapa macam jenis test yang dapat kita lakukan, seperti: minimal, default, stress, destructive, performance test.

Yang benar-benar dibutuhkan hanya menjalankan default test.

Namun, sesuai dokumentasi yang ditulis [QA:Testcase kernel regression](https://fedoraproject.org/wiki/QA:Testcase_kernel_regression){:target="_blank"}, dicontohkan melakukan 2 test. 1 default test dan 1 optional test, dalam wiki tersebut disebutkan performance test.

## Default test

{% shell_term $ %}
sudo ./runtests.sh
{% endshell_term %}

<details markdown="1" style="width:100%;">
  <summary style="cursor:pointer;">Default test result</summary>

  ```
Date: Sun Nov 14 06:20:01 PM WITA 2021
Test set: default
Kernel: 5.15.3-200.fc35.x86_64
Release: Fedora release 35 (Thirty Five)
Result: PASS
Failed Tests: None
Warned Tests: None
============================================================
Starting test ./default/modsign
Successfully loaded signed module
Successfully loaded unsigned module
Starting test ./default/stack-randomness
Starting test ./default/timer-overhead
memfd: CREATE
memfd: BASIC
memfd: SEAL-WRITE
memfd: SEAL-SHRINK
memfd: SEAL-GROW
memfd: SEAL-RESIZE
memfd: SHARE-DUP
memfd: SHARE-MMAP
memfd: SHARE-OPEN
memfd: SHARE-FORK
memfd: SHARE-DUP (shared file-table)
memfd: SHARE-MMAP (shared file-table)
memfd: SHARE-OPEN (shared file-table)
memfd: SHARE-FORK (shared file-table)
memfd: DONE
Starting test ./default/insert_leap_second
Setting time to speed up testing
Running for 1 iterations. Press ctrl-c to stop

Setting time to Mon Nov 15 07:59:50 2021
Scheduling leap second for Mon Nov 15 08:00:00 2021
Mon Nov 15 07:59:57 2021 +     88 us (37)	TIME_INS
Mon Nov 15 07:59:57 2021 + 500275 us (37)	TIME_INS
Mon Nov 15 07:59:58 2021 +    392 us (37)	TIME_INS
Mon Nov 15 07:59:58 2021 + 500491 us (37)	TIME_INS
Mon Nov 15 07:59:59 2021 +    638 us (37)	TIME_INS
Mon Nov 15 07:59:59 2021 + 500792 us (37)	TIME_INS
Mon Nov 15 07:59:59 2021 +   2443 us (38)	TIME_OOP
Mon Nov 15 07:59:59 2021 + 502593 us (38)	TIME_OOP
Mon Nov 15 08:00:00 2021 +   2702 us (38)	TIME_WAIT
Mon Nov 15 08:00:00 2021 + 502818 us (38)	TIME_WAIT
Mon Nov 15 08:00:01 2021 +   2938 us (38)	TIME_WAIT
Mon Nov 15 08:00:01 2021 + 503111 us (38)	TIME_WAIT
Mon Nov 15 08:00:02 2021 +   3257 us (38)	TIME_WAIT
Leap complete

Starting test ./default/paxtest
Starting test ./default/mq-memory-corruption
Test PASSED 
Test PASSED 
Test PASSED 
Test PASSED 
Test PASSED 
Test PASSED 
Test PASSED 
Test PASSED 
Test PASSED 
Test PASSED 
Starting test ./default/posix_timers
Testing posix timers. False negative may happen on CPU execution 
based timers if other threads run on the CPU...
Check itimer virtual... [OK]
Check itimer prof... [OK]
Check itimer real... [OK]
Check timer_create() per thread... [OK]
Check timer_create() per process... [OK]
Starting test ./default/libhugetlbfs
Starting test ./default/cachedrop
100+0 records in
100+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 0.0360544 s, 2.9 GB/s
10+0 records in
10+0 records out
10485760 bytes (10 MB, 10 MiB) copied, 0.00400567 s, 2.6 GB/s
TestPASS: /proc/sys/vm/drop_caches PASS
Starting test ./default/sysfs-perms
  ```

</details>

## Performance test (optional)

{% shell_term $ %}
sudo ./runtests.sh -t performance
{% endshell_term %}

<details markdown="1" style="width:100%;">
  <summary style="cursor:pointer;">Performance test result</summary>

  ```
Date: Sun Nov 14 06:21:51 PM WITA 2021
Test set: performance
Kernel: 5.15.3-200.fc35.x86_64
Release: Fedora release 35 (Thirty Five)
Result: PASS
Failed Tests: None
Warned Tests: None
============================================================
Starting test ./performance/lmbench3
cd src && make
make[1]: Entering directory '/home/bandithijo/Fedora/kernel-tests/performance/lmbench3/src'
gmake[2]: Entering directory '/home/bandithijo/Fedora/kernel-tests/performance/lmbench3/src'
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -c lib_tcp.c -o ../bin/x86_64-linux-gnu/lib_tcp.o
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -c lib_udp.c -o ../bin/x86_64-linux-gnu/lib_udp.o
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -c lib_unix.c -o ../bin/x86_64-linux-gnu/lib_unix.o
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -c lib_timing.c -o ../bin/x86_64-linux-gnu/lib_timing.o
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -c lib_mem.c -o ../bin/x86_64-linux-gnu/lib_mem.o
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -c lib_stats.c -o ../bin/x86_64-linux-gnu/lib_stats.o
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -c lib_debug.c -o ../bin/x86_64-linux-gnu/lib_debug.o
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -c getopt.c -o ../bin/x86_64-linux-gnu/getopt.o
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -c lib_sched.c -o ../bin/x86_64-linux-gnu/lib_sched.o
/bin/rm -f ../bin/x86_64-linux-gnu/lmbench.a
ar cr ../bin/x86_64-linux-gnu/lmbench.a ../bin/x86_64-linux-gnu/lib_tcp.o ../bin/x86_64-linux-gnu/lib_udp.o ../bin/x86_64-linux-gnu/lib_unix.o ../bin/x86_64-linux-gnu/lib_timing.o ../bin/x86_64-linux-gnu/lib_mem.o ../bin/x86_64-linux-gnu/lib_stats.o ../bin/x86_64-linux-gnu/lib_debug.o ../bin/x86_64-linux-gnu/getopt.o ../bin/x86_64-linux-gnu/lib_sched.o
ranlib ../bin/x86_64-linux-gnu/lmbench.a
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/bw_file_rd bw_file_rd.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/bw_mem bw_mem.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/bw_mmap_rd bw_mmap_rd.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/bw_pipe bw_pipe.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/bw_tcp bw_tcp.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/bw_unix bw_unix.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/hello hello.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_select lat_select.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_pipe lat_pipe.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_rpc lat_rpc.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_syscall lat_syscall.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_tcp lat_tcp.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_udp lat_udp.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_mmap lat_mmap.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/mhz mhz.c ../bin/x86_64-linux-gnu/lmbench.a -lm -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_proc lat_proc.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_pagefault lat_pagefault.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_connect lat_connect.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_fs lat_fs.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_sig lat_sig.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_mem_rd lat_mem_rd.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_ctx lat_ctx.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_sem lat_sem.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/memsize memsize.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_unix lat_unix.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lmdd lmdd.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/timing_o timing_o.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/enough enough.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/msleep msleep.c
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/loop_o loop_o.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_fifo lat_fifo.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lmhttp lmhttp.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_http lat_http.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_fcntl lat_fcntl.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/disk disk.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_unix_connect lat_unix_connect.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -DMAIN -o ../bin/x86_64-linux-gnu/flushdisk flushdisk.c
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_ops lat_ops.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/line line.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/tlb tlb.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/par_mem par_mem.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/par_ops par_ops.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/stream stream.c ../bin/x86_64-linux-gnu/lmbench.a -lm
rm -f ../bin/x86_64-linux-gnu/lmbench
sed -e "s/<version>/`cat bk.ver`/g" < ../scripts/lmbench > ../bin/x86_64-linux-gnu/lmbench
chmod +x ../bin/x86_64-linux-gnu/lmbench
gmake[2]: Leaving directory '/home/bandithijo/Fedora/kernel-tests/performance/lmbench3/src'
gmake[2]: Entering directory '/home/bandithijo/Fedora/kernel-tests/performance/lmbench3/src'
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/cache cache.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_dram_page lat_dram_page.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_pmake lat_pmake.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_rand lat_rand.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_usleep lat_usleep.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gcc -O -I/usr/include/tirpc -DRUSAGE -DHAVE_uint=1 -DHAVE_int64_t=1 -DHAVE_DRAND48 -DHAVE_SCHED_SETAFFINITY=1  -ltirpc -o ../bin/x86_64-linux-gnu/lat_cmd lat_cmd.c ../bin/x86_64-linux-gnu/lmbench.a -lm
gmake[2]: Leaving directory '/home/bandithijo/Fedora/kernel-tests/performance/lmbench3/src'
make[1]: Leaving directory '/home/bandithijo/Fedora/kernel-tests/performance/lmbench3/src'
cd src && make results
make[1]: Entering directory '/home/bandithijo/Fedora/kernel-tests/performance/lmbench3/src'
gmake[2]: Entering directory '/home/bandithijo/Fedora/kernel-tests/performance/lmbench3/src'
gmake[2]: Nothing to be done for 'all'.
gmake[2]: Leaving directory '/home/bandithijo/Fedora/kernel-tests/performance/lmbench3/src'
gmake[2]: Entering directory '/home/bandithijo/Fedora/kernel-tests/performance/lmbench3/src'
gmake[2]: Nothing to be done for 'opt'.
gmake[2]: Leaving directory '/home/bandithijo/Fedora/kernel-tests/performance/lmbench3/src'
=====================================================================

		L M B E N C H   C ON F I G U R A T I O N
		----------------------------------------

You need to configure some parameters to lmbench.  Once you have configured
these parameters, you may do multiple runs by saying

	"make rerun"

in the src subdirectory.

NOTICE: please do not have any other activity on the system if you can
help it.  Things like the second hand on your xclock or X perfmeters
are not so good when benchmarking.  In fact, X is not so good when
benchmarking.

=====================================================================

Hang on, we are calculating your timing granularity.
OK, it looks like you can time stuff down to 5000 usec resolution.

Hang on, we are calculating your timing overhead.
OK, it looks like your gettimeofday() costs 0 usecs.

Hang on, we are calculating your loop overhead.
OK, it looks like your benchmark loop costs 0.00000004 usecs.

=====================================================================

If you are running on an MP machine and you want to try running
multiple copies of lmbench in parallel, you can specify how many here.

Using this option will make the benchmark run 100x slower (sorry).

NOTE:  WARNING! This feature is experimental and many results are 
	known to be incorrect or random!

MULTIPLE COPIES [default 1] Options to control job placement
1) Allow scheduler to place jobs
2) Assign each benchmark process with any attendent child processes
   to its own processor
3) Assign each benchmark process with any attendent child processes
   to its own processor, except that it will be as far as possible
   from other processes
4) Assign each benchmark and attendent processes to their own
   processors
5) Assign each benchmark and attendent processes to their own
   processors, except that they will be as far as possible from
   each other and other processes
6) Custom placement: you assign each benchmark process with attendent
   child processes to processors
7) Custom placement: you assign each benchmark and attendent
   processes to processors

Note: some benchmarks, such as bw_pipe, create attendent child
processes for each benchmark process.  For example, bw_pipe
needs a second process to send data down the pipe to be read
by the benchmark process.  If you have three copies of the
benchmark process running, then you actually have six processes;
three attendent child processes sending data down the pipes and 
three benchmark processes reading data and doing the measurements.

Job placement selection: =====================================================================

Several benchmarks operate on a range of memory.  This memory should be
sized such that it is at least 4 times as big as the external cache[s]
on your system.   It should be no more than 80% of your physical memory.

The bigger the range, the more accurate the results, but larger sizes
take somewhat longer to run the benchmark.

MB [default 5456] Checking to see if you have 5456 MB; please wait for a moment...
Hang on, we are calculating your cache line size.
OK, it looks like your cache line is  bytes.

=====================================================================

lmbench measures a wide variety of system performance, and the full suite
of benchmarks can take a long time on some platforms.  Consequently, we
offer the capability to run only predefined subsets of benchmarks, one
for operating system specific benchmarks and one for hardware specific
benchmarks.  We also offer the option of running only selected benchmarks
which is useful during operating system development.

Please remember that if you intend to publish the results you either need
to do a full run or one of the predefined OS or hardware subsets.

SUBSET (ALL|HARWARE|OS|DEVELOPMENT) [default all] =====================================================================

This benchmark measures, by default, file system latency.  That can
take a long time on systems with old style file systems (i.e., UFS,
FFS, etc.).  Linux' ext2fs and Sun's tmpfs are fast enough that this
test is not painful.

If you are planning on sending in these results, please don't do a fast
run.

If you want to skip the file system latency tests, answer "yes" below.

SLOWFS [default no] =====================================================================

If you are running on an idle network and there are other, identically
configured systems, on the same wire (no gateway between you and them),
and you have rsh access to them, then you should run the network part
of the benchmarks to them.  Please specify any such systems as a space
separated list such as: ether-host fddi-host hippi-host.

REMOTE [default none] =====================================================================

Calculating mhz, please wait for a moment...
I think your CPU mhz is 

	-1 System too busy
	
but I am frequently wrong.  If that is the wrong Mhz, type in your
best guess as to your processor speed.  It doesn't have to be exact,
but if you know it is around 800, say 800.  

Please note that some processors, such as the P4, have a core which
is double-clocked, so on those processors the reported clock speed
will be roughly double the advertised clock rate.  For example, a
1.8GHz P4 may be reported as a 3592MHz processor.

Processor mhz [default -1 System too busy] =====================================================================

We need a place to store a 5456 Mbyte file as well as create and delete a
large number of small files.  We default to /usr/tmp.  If /usr/tmp is a
memory resident file system (i.e., tmpfs), pick a different place.
Please specify a directory that has enough space and is a local file
system.

FSDIR [default /usr/tmp] =====================================================================

lmbench outputs status information as it runs various benchmarks.
By default this output is sent to /dev/tty, but you may redirect
it to any file you wish (such as /dev/null...).

Status output file [default /dev/tty] =====================================================================

There is a database of benchmark results that is shipped with new
releases of lmbench.  Your results can be included in the database
if you wish.  The more results the better, especially if they include
remote networking.  If your results are interesting, i.e., for a new
fast box, they may be made available on the lmbench web page, which is

	http://www.bitmover.com/lmbench

Mail results [default yes] OK, no results mailed.
=====================================================================

Confguration done, thanks.

There is a mailing list for discussing lmbench hosted at BitMover. 
Send mail to majordomo@bitmover.com to join the list.

make[1]: Leaving directory '/home/bandithijo/Fedora/kernel-tests/performance/lmbench3/src'

                 L M B E N C H  3 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)


Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------------
Host                 OS  Mhz null null      open slct sig  sig  fork exec sh  
                             call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
fedora-th Linux 5.15.3-   -1 0.46 0.60 1.50 2.76 5.61 0.54 1.26 400. 1853 2851

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------
Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ------ ------ ------ ------ ------ ------- -------
fedora-th Linux 5.15.3- 2.6000 2.6200 2.8800 3.3300 3.6700 3.55000 3.89000

*Local* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
fedora-th Linux 5.15.3- 2.600 7.860 10.9  14.9        18.0        40.

File & VM system latencies in microseconds - smaller is better
-------------------------------------------------------------------------------
Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
                        Create Delete Create Delete Latency Fault  Fault  selct
--------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
fedora-th Linux 5.15.3-   11.1 6.7300   20.8   10.5   44.3K 0.884 0.06010 1.533

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
fedora-th Linux 5.15.3- 2925 5304 1707 4933.3  11.8K 6614.1 4496.1 10.K 6313.
  ```

</details>

# Submission Test Result

Kalau kita sudah mengkonfigurasi FAS akun pada file `.config`, setiap selesai melakukan *test*, hasil akan otomatis di submit ke [Fedora Kernel Test Results](https://apps.fedoraproject.org/kerneltest/){:target="_blank"}.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/XvhXwZpF/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}

Untuk melihat hasil pengujian kita, pilih nama kernel yang sesuai dengan yang kita test.

Hasil pengujian kita akan berada di dalam daftar (gambar di bawah). Coba buka saja satu persatu. Salah satunya pasti milik kalian. Yang paling baru, berada di paling atas.

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/1tqXM9qd/gambar-02.png" onerror="imgError(this);"}{:class="myImg"}

# Turn SELinux boolean selinuxuser_execheap back to default state

{% shell_term $ %}
sudo semanage boolean -m --off selinuxuser_execheap
{% endshell_term %}

# Upload Hasil Kernel Regression Test

Setiap Kernel Test Days event, akan ada thread tersendiri untuk melakukan submit test result.

Kita bisa lihat daftar event tersebut pada halaman [Fedora Testdays: Upcoming & Current Events](https://testdays.fedoraproject.org/events){:target="_blank"}

Kita akan melihat event paling baru, yaitu berkenaan dengan Kernel Test Week.

Kalau kita buka, akan ketemu halaman seperti ini.

![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/CMbdqxYB/gambar-03.png" onerror="imgError(this);"}{:class="myImg"}

Contoh submission datanya seperti di bawah ini.

![gambar_4]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/ZnLTD0Kw/gambar-04.png" onerror="imgError(this);"}{:class="myImg"}

Dengan ini proses Kernel Regression Test sudah selesai.

Kamu akan mendapatkan email pemberitahuan, bahwa kamu telah menyelesaikan Kernel Test Regression.

```
Date: Tue, 16 Nov 2021 11:49:04 +0000 (GMT)
From: notifications@fedoraproject.org
To: bandithijo@gmail.com
Subject: bandithijo ran a test of 5.15.3-200.fc35.x86_64 (PASS)

Notification time stamped 2021-11-14 10:21:18 UTC

bandithijo ran a test of 5.15.3-200.fc35.x86_64 (PASS)
        https://apps.fedoraproject.org/kerneltest/kernel/5.15.3-200.fc35.x86_64
```

Kamu juga akan mendapatkan email pemberitahuan, bahwa kamu telah mendapatkan Badge.

```
Date: Tue, 16 Nov 2021 11:49:05 +0000 (GMT)
From: notifications@fedoraproject.org
To: bandithijo@gmail.com
Subject: bandithijo has been awarded the "Science (Kernel Tester I)" badge

Notification time stamped 2021-11-14 10:21:20 UTC

You completed a run of the kernel regression test suite
        https://badges.fedoraproject.org/user/bandithijo
```

# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)


# Referensi

1. [https://fedoramagazine.org/contribute-at-the-fedora-linux-36-test-week-for-kernel-5-15/](https://fedoramagazine.org/contribute-at-the-fedora-linux-36-test-week-for-kernel-5-15/){:target="_blank"}
<br>Diakses tanggal: 2021/11/24

2. [https://fedoraproject.org/wiki/Test_Day:2021-11-14_Kernel_5.15_Test_Week](https://fedoraproject.org/wiki/Test_Day:2021-11-14_Kernel_5.15_Test_Week){:target="_blank"}
<br>Diakses tanggal: 2021/11/24

3. [https://fedoraproject.org/wiki/QA:Testcase_kernel_regression](https://fedoraproject.org/wiki/QA:Testcase_kernel_regression){:target="_blank"}
<br>Diakses tanggal: 2021/11/24

4. [https://docs.fedoraproject.org/en-US/quick-docs/kernel/howto-kernel-testday/](https://docs.fedoraproject.org/en-US/quick-docs/kernel/howto-kernel-testday/){:target="_blank"}
<br>Diakses tanggal: 2021/11/24
