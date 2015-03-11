FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "foobar#{n}@example.com"}
    avatar          File.open(File.join(Rails.root, 'spec/fixtures/images/avatar.jpg')) 
    password        "morethan8"
    cell            "12345678901"
    real_name       "foobar"
    nick_name       "foobar"
    id_card_number  "123456789012345678"
    abstract        "Good Guy."
    level           "unverified"
  end
end