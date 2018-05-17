FactoryGirl.define do
  factory :post do
    date '2018-05-05'
    memo "Test memo"
    working_total 90
    working_hours 1
    working_minutes 30
    association :user

    trait :date_yesterday do
      date '2018-05-04'
    end

    trait :date_tomorrow do
      date '2018-05-06'
    end

    trait :date_today do
      date Date.today
    end

    trait :other_user_post do
      association :other_user
    end
  end
end
