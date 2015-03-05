FactoryGirl.define do
  factory :topic do
    title       {Faker::Name.title}
    content     {Faker::Lorem.paragraph}
    date        {Faker::Time.between(2.days.ago, Time.now)}
    association :user
  end
end