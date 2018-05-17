FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "test user#{n}" }
    profile 'Test profile'
    blog_url 'http://test-blog.com'
    image 'http://pbs.twimg.com/profile_images/982576420139364357/gXL9hPx7_normal.jpg'
    admin false

    trait :admin do
      name 'admin'
      image 'http://pbs.twimg.com/profile_images/982576420139364357/gXL9hPx7_normal.jpg'
      admin true
    end
  end
end
