FactoryGirl.define do
  factory :leverage do
    association :user
    date        "2015-02-26 14:53:04"
    amount      {rand(10000)}
    description "MyText"
    duration    { rand(100)}
    state       "applied"
    association :interest
  end
end