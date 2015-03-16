FactoryGirl.define do
  factory :account do
    association :user
    balance     { rand(100)}
  end
end
