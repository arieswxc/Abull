FactoryGirl.define do
  factory :admin_user do
    sequence(:email) { |n| "foobar#{n}@example.com"}
    password          "12345678"
    role              "customer_service"
  end
end