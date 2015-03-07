FactoryGirl.define do
  factory :invest do
    association :user
    association :fund
    amount      {rand(10000)}
    date        "2015-02-25 12:41:01"
    payback     "9.99"
    close_day   "2015-02-25 12:41:01"
  end
end