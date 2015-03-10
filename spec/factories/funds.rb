FactoryGirl.define do
  factory :fund do
    name                  {Faker::Name.title}
    association           :user
    amount                {rand(10000)}
    collection_deadline   "2015-02-24 22:20:20"
    earning               "9.99"
    earning_rate          "9.99"
    state                 "pending"
    private_check         "private"
    minimum               "9.99"
    invest_starting_date  "2015-02-24 22:20:20"
    invest_ending_date    "2015-02-24 22:20:20"
    expected_earning_rate "10.0"
    description           "This is a fund description."
    risk_method           "This is a fund risk method."
    initial_amount        "9.99"
  end
end