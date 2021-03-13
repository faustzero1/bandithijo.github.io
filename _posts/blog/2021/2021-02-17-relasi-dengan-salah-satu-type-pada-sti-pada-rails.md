---
layout: 'post'
title: "Membuat Relasi dengan Hanya Salah Satu Type pada Single Table Inheritance Model di Rails"
date: 2021-02-17 20:52
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
description: "Menyambung catatan tentang Single Table Inheritance, namun kali ini mengenai relasi salah satu type dari model yang dipasang STI."
---

# Requirements

`Ruby 3.0.0` `Rails 6.1.2.1`

# Latar Belakang Masalah

Catatan kali ini, saya akan membahas Ruby on Rails dari sisi back-end.

Melanjutkan catatan mengenai Single Table Inheritance sebelumnya, yaitu tentang [**Mengenal Single Table Inheritance dengan Devise pada Rails (Contoh 2)**](/blog/rails-single-table-inheritance-dengan-devise-contoh-2){:target="_blank"}.

Sekarang saya akan lanjutkan dengan relasi antar type, namun catatan kali ini mencontohkan salah satu type saja.

Misalkan saya memilik model **User** yang memiliki dua type user, yaitu **Developer** dan **Copywriter**.

<br>
**users**

|----|--------------------|------------|
| id | email              | type       |
|----|--------------------|------------|
| 1  | bayuyuba@gmail.com | Developer  |
| 2  | bololoba@gmail.com | Copywriter |
|----|--------------------|------------|

<br>
**news**

|-------|---------|---------|
| title | content | user_id |
|-------|---------|---------|
| ...   | ...     | 2       |
|-------|---------|---------|

<br>
Sudah dapat ditebak yaa, tabel news tentu memiliki relasi one to many dengan tabel users.

Karena saya menggunakan STI pada tabel Users, maka saya juga perlu membuat model untuk masing-masing type user (developer dan copywriter).

{% highlight_caption app/models/developer.rb %}
{% highlight ruby linenos %}
class Developer < User
end
{% endhighlight %}

{% highlight_caption app/models/copywriter.rb %}
{% highlight ruby linenos %}
class Copywriter < User
end
{% endhighlight %}

<br>
Kita akan mencoba meletakkan method association-nya pada model **User** dan juga model **News**.

{% highlight_caption app/models/user.rb %}
{% highlight ruby linenos %}
class User < ApplicationRecord
  has_many :news, dependent: :destroy
end
{% endhighlight %}

{% highlight_caption app/models/news.rb %}
{% highlight ruby linenos %}
class News < ApplicationRecord
  belongs_to :user
end
{% endhighlight %}

<br>
Kalau asosiasinya seperti di atas, maka user **Developer** juga dapat membuat **News**.

```ruby
irb(main)> user_developer = Developer.first
=> #<Developer id: 1, email: "bayuyuba@gmail.com", ...

irb(main)> user_developer.news
=> #<ActiveRecord::Associations::CollectionProxy []>
```

Sedangkan, yang kita inginkan adalah hanya user **Copywriter** yang dapat membuat News.

```ruby
irb(main)> user_copywriter = Copywriter.first
=> #<Copywriter id: 2, email: "bololoba@gmail.com", ...

irb(main)> user_copywriter.news
=> #<ActiveRecord::Associations::CollectionProxy []>
```

<br>
Developer juga dapat membuat News karena kita meletakkan association-nya pada model User (`has_many :news`) dan pada model News (`belongs_to :user`). Sedangkan pada model User, terdapat dua type user, yaitu Developer dan Copywriter. Tentu saja kedua type user tersebut jadi memiliki association terhadap model News.

# Pemecahan Masalah

Sudah dapat ditebak yaa, seharusnya kita meletakkan associationnya pada model **Copywriter**, bukan pada model **User**.

Maka, kita perlu menghapus association yang ada pada model **User** dan memindahkannya ke model **Copywriter**.

{% highlight_caption app/models/copywriter.rb %}
{% highlight ruby linenos %}
class Copywriter < User
  has_many :news, dependent: :destroy, foreign_key: :user_id
end
{% endhighlight %}

Sedangkan association pada model **News** kita akan ganti objectnya ke model **Copywriter**.

{% highlight_caption app/models/news.rb %}
{% highlight ruby linenos %}
class News < ApplicationRecord
  belongs_to :copywriter, foreign_key: :user_id
end
{% endhighlight %}

<br>
Yang menjadi kunci dari association antara model **Copywriter** dengan model **News** di atas adalah `foreign_key: :user_id`.

Sangat perlu untuk didefinisikan, karena model News sebenarnya tidak mengetahui siapa itu Copywriter. Model News hanya mengenal User, nanti model User yang akan memberitahu, bahwa yang si News cari adalah salah satu type user yang dimiliki oleh model User, yaitu Copywriter. 😅

Hal ini karena secara skematik, pada tabel News, kita merelasikan dengan tabel Users. Sedangkan Copywriter tidak memiliki tabel.

{% highlight_caption db/schema.rb %}
{% highlight ruby linenos %}
# ...

  create_table "news", force: :cascade do |t|
    t.string   "title"
    t.bigint   "user_id",    null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index    ["user_id"],  name: "index_news_on_user_id"
  end

# ...
{% endhighlight %}

# Pengujian

Kita akan mulai dari Copywriter.

```ruby
irb(main)> user_copywriter = Copywriter.first
=> #<Copywriter id: 2, email: "bololoba@gmail.com", ...

irb(main)> user_developer.news
=> #<ActiveRecord::Associations::CollectionProxy []>
```

Nah, copywriter masih memiliki berasosiasi dengan model News.


<br>
Seharusnya model Developer, sudah tidak dapat membuat News.

```ruby
irb(main)> user_developer = Developer.first
=> #<Developer id: 1, email: "bayuyuba@gmail.com", ...

irb(main)> user_copywriter.news
NoMethodError (undefined method `news' for #<Developer id: 1, email: "bayuyuba@gmail.com", ...">)
```

Oke, mantap! Developer sudah tidak dapat membuat News.





<br>
# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Selanjutnya, saya serahkan kepada imajinasi dan kreatifitas teman-teman. Hehe.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)




# Referensi

1. [guides.rubyonrails.org/association_basics.html#single-table-inheritance-sti](https://guides.rubyonrails.org/association_basics.html#single-table-inheritance-sti){:target="_blank"}
<br>Diakses tanggal: 2021/02/17
