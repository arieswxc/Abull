FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "foobar#{n}@example.com"}
    avatar          File.open(File.join(Rails.root, 'spec/fixtures/images/avatar.jpg')) 
    password        "morethan8"
    cell            {rand(10000000000..99999999999)}
    real_name       "foobar"
    username       "foobar"
    id_card_number  "123456789012345678"
    abstract        "Good Guy."
    level           "unverified"
  end
end