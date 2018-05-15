User.create!(name: 'admin',
          uid: '919909356879036413',
          provider: 'twitter',
          admin: true)

99.times do |n|
  name = Faker::Japanese::Name.name
  uid = (919905356179036413 + n).to_s
  provider = 'twitter'
  User.create!(name: name,
              uid: uid,
              provider: provider)
end

users = User.order(:id).take(20)
users.each do |user|
  date = Date.today
  working_total = rand(10..400)
  working_hours = rand(0..23)
  working_minutes = rand(0..59)
  memo = Faker::Lorem.sentence(2)
  user.posts.create!(date: date, working_total: working_total,
            working_hours: working_hours, working_minutes: working_minutes,
            memo: memo)
end
