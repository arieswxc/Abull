FactoryGirl.define do
  factory :news do
    title   {Faker::Name.title}
    content {Faker::Lorem.paragraph}
    date    {Faker::Time.between(2.days.ago, Time.now)}
  end
end