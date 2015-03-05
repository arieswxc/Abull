FactoryGirl.define do
  factory :topic do
    title       "MyString"
    content     "MyText"
    date        "2015-03-05 13:01:57"
    association :user
  end
end