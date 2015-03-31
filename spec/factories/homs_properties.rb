FactoryGirl.define do
  factory :homs_property do
    date        "2015-03-31"
    amount      "9.99"
    association :homs_account
  end
end