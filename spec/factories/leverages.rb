FactoryGirl.define do
  factory :leverage do
    association :user
    date        "2015-02-26 14:53:04"
    number      {rand(10000)}
    description "MyText"
    deadline    Time.now + 1.days
    state       "applied"
  end
end