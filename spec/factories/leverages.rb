FactoryGirl.define do
  factory :leverage do
    association :user
    date              {Time.now.advance(months: 1)}
    amount            {rand(10000)}
    description       "MyText"
    duration          { rand(30)}
    association       :interest
    loss_warning_line {rand(300)}
    loss_making_line  {rand(300)}
    rate              {rand(10)}
    total_interests   {rand(100)}
    deposit           {rand(100)}
    leverage_amount   { rand(100)}
  end
end