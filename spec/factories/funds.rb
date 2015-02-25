FactoryGirl.define do
  factory :fund do
    name "MyString"
    association :user
    amount "9.99"
    colleciton_deadline "2015-02-24 22:20:20"
    earning "9.99"
    earning_rate "9.99"
    state "on"
    private_check "false"
    minimum "9.99"
    invest_starting_date "2015-02-24 22:20:20"
    invest_ending_date "2015-02-24 22:20:20"
  end
end