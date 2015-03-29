FactoryGirl.define do
  factory :billing do
    association   :account
    amount        "9.99"
    billing_type  "MyString"
    state         "pending"
    association   :billable, factory: :invest
  end
end