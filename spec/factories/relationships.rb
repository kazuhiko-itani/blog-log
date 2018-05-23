FactoryGirl.define do
  factory :relationship do
    follower_id 1
    followed_id 2
    association :follower, factory: [:user, :admin]
    association :followed, factory: :user
  end
end
