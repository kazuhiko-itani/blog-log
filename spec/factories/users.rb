FactoryGirl.define do
  factory :user do
    name 'test user'
    email 'test@gmail.com'
    password 'password'
    password_confirmation 'password'
  end
end
