FactoryGirl.define do
  factory :fund_account do
	  association :fund
	  balance "9.99"
  end
end