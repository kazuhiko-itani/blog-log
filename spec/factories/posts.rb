FactoryGirl.define do
  factory :post do
    date Date.today
    memo "Test memo"
    working_total 90
    working_hours 1
    working_minutes 30
    association :user

    trait :date_yesterday do
      date Date.today - 1
    end

    trait :date_tomorrow do
      date Date.today + 1
    end

    trait :other_user_post do
      association :other_user
    end
  end
end
