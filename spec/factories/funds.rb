FactoryGirl.define do
  factory :fund do
    name                  {Faker::Name.title}
    association           :user
    amount                {rand(10000)}
    earning               "9.99"
    earning_rate          "9.99"
    state                 "pending"
    private_check         "private"
    minimum               "9.99"
    invest_starting_date  "2015-02-24 22:20:20"
    duration              {rand(10000)}
    expected_earning_rate "10.0"
    ending_days           {rand(30)}
    description           "This is a fund description."
    frontend_risk_method  "This is a fund risk method."
    initial_amount        "9.99"
  end
end