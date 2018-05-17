User.create!(name: 'admin',
          uid: '919909356879036413',
          provider: 'twitter',
          profile: '管理者です',
          blog_url: 'https://programmer-symbol.com',
          admin: true)

99.times do |n|
  name = Faker::Japanese::Name.name
  uid = (919905356179036413 + n).to_s
  provider = 'twitter'
  profile = Faker::Lorem.sentence(2)
  User.create!(name: name,
              uid: uid,
              provider: provider,
              profile: profile,
              blog_url: '')
end

users = User.order(:id).take(61)
31.times do |n|
  users.each do |user|
    date = (Date.today - n)
    working_total = rand(10..400)
    working_hours = rand(0..23)
    working_minutes = rand(0..59)
    memo = '記事更新　リライト'
    user.posts.create!(date: date, working_total: working_total,
              working_hours: working_hours, working_minutes: working_minutes,
              memo: memo)
  end
end
