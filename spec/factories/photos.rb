FactoryGirl.define do
  factory :photo do
    title       {Faker::Name.title}
    photo       File.open(File.join(Rails.root, 'spec/fixtures/images/avatar.jpg')) 
    association :user
  end

end
