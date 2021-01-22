---
layout: 'post'
title: "Pertama Kali Mencoba RSpec"
date: 2019-12-05 07:10
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Rails']
pin:
hot:
contributors: []
resume:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prerequisite

`Ruby 2.6.3` `Rails 6.0.1` `PostgreSQL 11.5` `RSpec 4.0.0.beta3`

# Prakata

Sekitar seminggu yang lalu,  di saat badan sedang meriang dan meler hebat namun kadang tersumbat, saya mencoba untuk mempelajari salah satu test atau pengujian untuk membantu kita menguji web aplikasi yang kita bangun.

RSpec, adalah salah satu test tersebut.

Selain RSpec, Ruby on Rails sendiri, sudah memiliki *built-in test*.

Keren bukan!

Test tersebut bernama MiniTest.

MiniTest ini sudah menjadi test bawaan dari Rails sejak versi 5.1.

Ini adalah bukti yang sangat bagus sekali, untuk menjelaskan bahwa dalam membuat sebuah web aplikasi, kita **sangat perlu untuk melakukan testing**.

Kalau saya tidak ngawur, konsep ngoding sambil melakukan testing itu dikenal dengan **Test Driven Development** (TDD).

# Kenapa RSpec?

Kalau Ruby on Rails sudah membawa MiniTest secara default, lantas mengapa memilih menggunakan RSpec?

Ini pendapat pribadi saya.

Menurut saya, dalam menulis spesifikasi-spesifikasi test, RSpec memiliki sintaks yang mudah untuk dibaca. Karena mudah dibaca tentunya akan mudah untuk dipahami. Bahkan untuk orang *non-technical* akan sangat mudah memahami spesifikasi test yang ditulis menggunakan RSpec.

Coba perhatikan contoh dibawah ini.

Berikut ini adalah beberapa spesifikasi list pada model Author.

{% highlight_caption spec/models/author_spec.rb %}
{% highlight ruby linenos %}
RSpec.describe Author, type: :model do
  context 'Validation Presence Tests' do
    it 'Ensures full name presence'
    it 'Ensures email presence'
    it 'Ensures password presence'
    it 'Should save successfully'
  end

  context 'Validation Length Tests' do
    it 'Ensures full name character length, more than 5'
    it 'Ensures full name character length, less than 30'
    it 'Ensures email character length, less than 50'
    it 'Ensures password character length, same or more than 8'
  end

  context 'Email Format Tests' do
    it 'Ensures email format not valid'
    it 'Ensures email format valid'
  end

  context 'Email Uniqueness Tests' do
    it 'Ensures email has uniqueness'
  end
end
{% endhighlight %}

Setiap list tersebut, nantinya akan saya *breakdown* sesuai dengan konteksnya dan judulnya.

Gimana?

Cukup dapat dimengerti kan, maksud dari list tersebut.

Nah, sekarang saya lanjutkan untuk proses memasang RSpec pada project Rails kita.

# Instalasi

Pada project baru, saya menjalankan perintah ini.

{% shell_user %}
rails new blog_rspec_test -d postgresql -T
{% endshell_user %}

Penambahan option `-T`, adalah untuk men-*disable* *built-in test* pada project yang baru kita buat.

Tujuannya tentu saja, karena saya akan menggunakan RSpec untuk melakukan testing, bukan menggunakan MiniTest.

Pada project yang sudah ada, langsung saja mengikuti langkah selanjutnya.

Kemudian, pasang gem **rspec-rails** pada block `:development` dan `:text` di `Gemfile` project.

{% highlight_caption Gemfile %}
{% highlight ruby linenos %}
# ...
# ...

group :development, :test do
  # ...
  gem 'rspec-rails', '~> 4.0.0.beta3'
end
{% endhighlight %}

Tujuan memasukkan gem ini pada group `:development` agar lebih mudah. Karen, kalau hanya pada group `:test`, kita hanya dapat mendapatkan gem ini *evinmonment test* (`RAILS_ENV=test`).

Saya menggunakan versi **4.0.0.beta3** karena terdapat test yang sudah deprecated pada versi sebelumnya, yaitu pada controller test. Karena belum begitu memahami lebih jauh tentang RSpec, saya mengikuti saja saran dari teman-teman yang sudah lebih dulumencoba versi beta ini.

Selanjutnya, seperti biasa, setiap setelah menambahkan gem baru pada `Gemfile`, kita perlu menjalankan perintah,

{% shell_user %}
bundle install
{% endshell_user %}

Setelah proses instalasi selesai, kita juga perlu meng-*generate* *boilerplate* dari konfigurasi yang sudah disediakan oleh rspec-rails.

{% shell_user %}
rails generate rspec:install
{% endshell_user %}

Hasil generate tersebut, akan membuat beberapa file konfigurasi pada direktori `rspec/`.

```
Running via Spring preloader in process 28211
      create  .rspec
      create  spec
      create  spec/spec_helper.rb
      create  spec/rails_helper.rb
```

Langkah selanjutnya ini bersifat *optional*, tapi saya memilih untuk melakukannya.

Tambahkan `--format documentation`, pada file `.rspec`.

```
--require spec_helper
--format documentation
```

Penambahan ini bertujuan untuk mengganti format default output yang ditampilkan oleh RSpec menjadi lebih mudah untuk dibaca.

Kalau tidak ingin menambahkannya sekarang, kita juga dapat menambahkannya dilain waktu.

Nah, sekarang kita dapat lanjut pada tahapan membuat spesifikasi test.

# Model Specs

Saya sependapat dengan pernyataan bahwa, "Untuk memahami apa itu test, paling mudah kita mulai dari model test."

Nah, karena alasan itu saya memulai dari spesifikasi model terlebih dahulu.

Kenapa, karena kita dapat memanfaatkan validation yang terdapat di dalam model. Hihihi.

RSpec juga sudah menyediakan *spec file generator*. Tinggal kita pergunakan saja. Enak sekali kan.

{% shell_user %}
rails generate rspec:model nama_model
{% endshell_user %}

Pada, kasus ini, saya memiliki nama model `author`.

{% shell_user %}
rails generate rspec:model author
{% endshell_user %}

Maka, rspec akan men-*generate* satu file spec untuk kita.

```
      create  spec/models/author_spec.rb
```

Untuk melihat daftar dari generator apa saja yang disediakan oleh RSpec, dapat menggunakan perintah,

{% shell_user %}
rails generate --help | grep rspec
{% endshell_user %}

Sebelum saya menjabarkan spesifikasi model test untuk model author, saya akan menunjukkan isi dari model author yang di dalamnya terdapat daftar validation dari model author.

{% highlight_caption app/models/author.rb %}
{% highlight ruby linenos %}
class Author < ApplicationRecord
  has_many :articles

  # Validations
  validates :full_name, presence: true,
                        length: {minimum: 5, maximum: 30}

  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: {case_sensitive: false},
                    length: {maximum: 50},
                    format: {with: VALID_EMAIL_REGEX }

  validates :password, presence: true,
                       length: {minimum: 8}
end
{% endhighlight %}

Nah, sekarang pasti sudah mengerti kan, kenapa untuk belajar, sangat mudah kita mulai dari model test.

Karena kita akan menguji fungsi dari validation yang sudah kita definisikan pada model author.

Oke sekarang langsung saja, saya akan menjabarkan spesifikasi untuk menguji validation untuk `presence: true` pada setiap field.

Kita dapat melihat pada validation model author tersebut, setiap field memiliki presence validation.

Saya akan mulai dari filed `full_name` terlebih dahulu.

{% highlight_caption spec/models/author_spec.rb %}
{% highlight ruby linenos %}
require 'rails_helper'

RSpec.describe Author, type: :model do
  context 'Validation Presence Tests' do
    it 'Ensures full name presence' do
      author = Author.new(
        full_name: nil,
        email: Faker::Internet.free_email,
        password: Faker::Team.name.downcase.strip.gsub(' ', '')
      ).save
      expect(author).to eq(false)
    end
  end
end
{% endhighlight %}

Pada spesifikasi ini, saya hanya membuat filed `full_name` bernilai `nil`. Dengan maksud membuat field tersebut kosong. Dan test dianggap benar, apabila hasil dari spesifikasi tersebut bernilai salah ` eq(false)`.

Mudah kan!

Nah, coba perhatikan, terdapat blok yang bernama `context`. Ini dapat kita gunakan untuk membuat konteks pada setiap spesifikasi testing yang akan kita lakukan.

Langkah selanjutnya adalah presence validation untuk field `email`, maka saya masukkan di dalam context yang sama, dan berada di di bawah spesifikasi untuk field `full_name`.

```ruby

...
    ...

    it 'Ensures email presence' do
      author = Author.new(
        full_name: Faker::Team.name.titlecase,
        email: nil,
        password: Faker::Team.name.downcase.strip.gsub(' ', '')
      ).save
      expect(author).to eq(false)
    end

    ...
...
```

Begitu seterusnya untuk presence validation pada field `password`.

Coba teman-teman buat spesifikasinya untuk presence validation pada field `password` ini.

Oh ya!

Saya menggunakan bantuan gem `faker` untuk meng-*generate* data *dummy*. Agar lebih mudah, dan tidak perlu menghabiskan waktu untuk memikirkan data secara manual.

Nah, dengan begitu, saya langsung dapat menuliskan spesifikasi untuk menguji semua spesifikasi validation yang ada pada model author.

Kira-kira seperti ini.

{% highlight_caption spec/models/author_spec.rb %}
{% highlight ruby linenos %}
require 'rails_helper'

RSpec.describe Author, type: :model do
  context 'Validation Presence Tests' do
    it 'Ensures full name presence' do
      author = Author.new(
        full_name: nil,
        email: Faker::Internet.free_email,
        password: Faker::Team.name.downcase.strip.gsub(' ', '')
      ).save
      expect(author).to eq(false)
    end

    it 'Ensures email presence' do
      author = Author.new(
        full_name: Faker::Team.name.titlecase,
        email: nil,
        password: Faker::Team.name.downcase.strip.gsub(' ', '')
      ).save
      expect(author).to eq(false)
    end

    it 'Ensures password presence' do
      author = Author.new(
        full_name: Faker::Team.name.titlecase,
        email: Faker::Internet.free_email,
        password: nil
      ).save
      expect(author).to eq(false)
    end

    it 'Should save successfully' do
      author = Author.new(
        full_name: Faker::Team.name.titlecase,
        email: Faker::Internet.free_email,
        password: Faker::Team.name.downcase.strip.gsub(' ', '')
      ).save
      expect(author).to eq(true)
    end
  end

  context 'Validation Length Tests' do
    it 'Ensures full name character length, more than 5' do
      author = Author.new(
        full_name: 'ban',
        email: Faker::Internet.free_email,
        password: Faker::Team.name.downcase.strip.gsub(' ', '')
      ).save
      expect(author).to eq(false)
    end

    it 'Ensures full name character length, less than 30' do
      author = Author.new(
        full_name: 'bandithijobandithijobandithijobandithijo',
        email: Faker::Internet.free_email,
        password: Faker::Team.name.downcase.strip.gsub(' ', '')
      ).save
      expect(author).to eq(false)
    end

    it 'Ensures email character length, less than 50' do
      author = Author.new(
        full_name: Faker::Team.name.titlecase,
        email: 'bandithijobandithijobandithijobandithijobandithijo@gmail.com',
        password: Faker::Team.name.downcase.strip.gsub(' ', '')
      ).save
      expect(author).to eq(false)
    end

    it 'Ensures password character length, same or more than 8' do
      author = Author.new(
        full_name: Faker::Team.name.titlecase,
        email: Faker::Internet.free_email,
        password: 'bandit'
      ).save
      expect(author).to eq(false)
    end
  end

  context 'Email Format Tests' do
    it 'Ensures email format not valid' do
      author = Author.new(
        full_name: Faker::Team.name.titlecase,
        email: 'bandithijo@bandithijo',
        password: Faker::Team.name.downcase.strip.gsub(' ', '')
      ).save
      expect(author).to eq(false)
    end

    it 'Ensures email format valid' do
      author = Author.new(
        full_name: Faker::Team.name.titlecase,
        email: Faker::Internet.free_email,
        password: Faker::Team.name.downcase.strip.gsub(' ', '')
      ).save
      expect(author).to eq(true)
    end
  end

  context 'Email Uniqueness Tests' do
    before do
      Author.new(
        full_name: Faker::Team.name.titlecase,
        email: 'bandithijo@gmail.com',
        password: Faker::Team.name.downcase.strip.gsub(' ', '')
      ).save
    end

    it 'Ensures email has uniqueness' do
      author = Author.new(
        full_name: Faker::Team.name.titlecase,
        email: 'bandithijo@gmail.com',
        password: Faker::Team.name.downcase.strip.gsub(' ', '')
      ).save
      expect(author).to eq(false)
    end
  end
end
{% endhighlight %}

Nah, gimana?

Mudah dipahami kan?

Nah, untuk menalankan test-nya gunakan perintah ini,

{% shell_user %}
bundle exec rspec
{% endshell_user %}

Nanti akan keluar output seperti ini.

```
Author
  Validation Presence Tests
    Ensures full name presence
    Ensures email presence
    Ensures password presence
    Should save successfully
  Validation Length Tests
    Ensures full name character length, more than 5
    Ensures full name character length, less than 30
    Ensures email character length, less than 50
    Ensures password character length, same or more than 8
  Email Format Tests
    Ensures email format not valid
    Ensures email format valid
  Email Uniqueness Tests
    Ensures email has uniqueness

Finished in 2.1 seconds (files took 8.29 seconds to load)
11 examples, 0 failures
```

Sesuai dengan jumlah spesifikasi yang kita tulis, ada 11 buah. Dan kesemuanya berhasil.

Selanjutnya untuk controller spec.

# Controller Spec

Kita gunakan lagi *spec file generator* yang sudah disediakan oleh RSpec.

{% shell_user %}
rails generate rspec:controller authors
{% endshell_user %}

Karena kita akan menguji controller, tentu saja kita mengikuti *naming convention* dari Rails, yang mengharuskan menggunakan penamaan plural pada controller. Berbeda dengan model yang menggunakan penamaan singular.

Kalau berhasil, maka akan dibuatkan file specnya seperti ini.

```
      create  spec/controllers/authors_controller_spec.rb
```

Belum banyak yang saya pahami mengenai controller spec ini, jadi langsung saja saya tulisakan sedikit contohnya mengenai pengujian untuk response dan route.

Kira-kira seperti ini.

{% highlight_caption spec/controllers/authors_controller_spec.rb %}
{% highlight ruby linenos %}
require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  context 'Get #index' do
    it 'Returns a success response' do
      get :index
      expect(response).to be_ok
    end
  end

  context 'Get #show' do
    it 'Returns a success response' do
      author = Author.create!(
        full_name: Faker::Team.name.titlecase,
        email: Faker::Internet.free_email,
        password: Faker::Team.name.downcase.strip.gsub(' ', '')
      )
      get :show, params: { id: author.to_param }
      expect(response).to be_ok
    end
  end

  context 'Proper Routes Tests' do
    it 'Should has proper index route' do
      expect(get: '/authors').to be_routable
    end

    it 'Should has proper show route' do
      expect(get: '/authors/1').to be_routable
    end

    it 'Should has proper new route' do
      expect(get: '/authors/new').to be_routable
    end

    it 'Should has proper edit route' do
      expect(get: '/authors/1/edit').to be_routable
    end

    it 'Should has proper destroy route' do
      expect(delete: '/authors/1').to be_routable
    end
  end
end
{% endhighlight %}

Wkwkwkwk.

Pengen ketawa, karena seadanya banget.

Tapi tidak mengapa, saya tetap harus menuliskan catatan mengenai proses belajar ini.

Sebagai jejak belajar yang menunjukkan bahwa saya dulu juga berawal dari belum bisa.

Okeh!

Sepertinya hanya ini saja yang ingin saya tuliskan.

Untuk referensi yang lebih lengkap seputar RSpec pada Rails, dapat dimulai dari membaca dokumentasi pada gem `rspec-rails` yang saya sertakan pada referensi di bawah.[<sup>1</sup>](#referensi)

Untuk referensi seputar RSpec dapat membaca pada dokumentasi RSpec yang disediakan di Relishapp.[<sup>3</sup>](#referensi)

Mudah-mudahan dapat sedikit banyak bermanfaat buat teman-teman yaa.

Terima kasih.

(^_^)v


# Referensi

1. [github.com/rspec/rspec-rails](https://github.com/rspec/rspec-rails){:target="_blank"}
<br>Diakses tanggal: 2019/12/05

2. [Everyday Rails Testing with RSpec : A practical approach to test-driven development by Aaron Sumner](http://leanpub.com/everydayrailsrspec){:target="_blank"}
<br>Diakses tanggal: 2019/12/05

3. [relishapp.com/rspec/rspec-rails/docs](https://relishapp.com/rspec/rspec-rails/docs){:target="_blank"}
<br>Diakses tanggal: 2019/12/05
