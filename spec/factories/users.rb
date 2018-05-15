FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "test user#{n}" }
    image_url 'http://pbs.twimg.com/profile_images/982576420139364357/gXL9hPx7_normal.jpg'
  end
end
