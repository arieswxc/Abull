FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "foobar#{n}@example.com"}
    avatar File.open(File.join(Rails.root, 'spec/fixtures/images/avatar.jpg')) 
    password "moretheneight"
    cell "12345678901"
    real_name "foobar"
    nick_name "foobar"
  end
end