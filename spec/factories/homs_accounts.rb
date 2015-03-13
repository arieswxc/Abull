FactoryGirl.define do
  factory :homs_account do
    title       "MyString"
    password    "MyString"
    association :fund
  end
end