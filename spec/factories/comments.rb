FactoryGirl.define do
  factory :comment do
    title   {Faker::Name.title}
    comment {Faker::Lorem.paragraph}
    association :user
  end
end