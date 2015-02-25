FactoryGirl.define do
  factory :invest do
    association :user
    association :fund
    number      "9.99"
    date        "2015-02-25 12:41:01"
  end
end