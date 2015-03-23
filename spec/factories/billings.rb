FactoryGirl.define do
  factory :billing do
    association   :account
    amount        "9.99"
    billing_type  "MyString"
    association   :billable, factory: :invest
  end
end