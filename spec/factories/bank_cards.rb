FactoryGirl.define do
  factory :bank_card do
    number      "1234567890"
    bank_name   "ICBC"
    bank_branch "Pudong"
    association :user
    state       "pending"
  end
end