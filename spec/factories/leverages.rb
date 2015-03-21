FactoryGirl.define do
  factory :leverage do
    association :user
    date        {Time.now.advance(months: 1)}
    amount      {rand(10000)}
    description "MyText"
    duration    { rand(30)}
    state       "applied"
    association :interest
  end
end