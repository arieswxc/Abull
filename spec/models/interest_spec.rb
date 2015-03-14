require 'rails_helper'

RSpec.describe Interest, type: :model do
  it "is valid" do
    expect(create(:interest)).to be_valid
  end

  it "is invalid when leverage_time is nil " do
    interest = build(:interest, leverage_time: nil)
    interest.valid?
    expect(interest).to be_invalid
    expect(interest.errors[:leverage_time]).to include(I18n.t("errors.messages.blank"))
  end

  it "is invalid when leverage_time is not a number " do
    interest = build(:interest, leverage_time: "invalid")
    interest.valid?
    expect(interest).to be_invalid
    expect(interest.errors[:leverage_time]).to include(I18n.t("errors.messages.not_a_number"))
  end

  it "is invalid when amount is nil " do
    interest = build(:interest, amount: nil)
    interest.valid?
    expect(interest).to be_invalid
    expect(interest.errors[:amount]).to include(I18n.t("errors.messages.blank"))
  end

  it "is invalid when amount is not a number " do
    interest = build(:interest, amount: "invalid")
    interest.valid?
    expect(interest).to be_invalid
    expect(interest.errors[:amount]).to include(I18n.t("errors.messages.not_a_number"))
  end

  it "is invalid when duration is nil " do
    interest = build(:interest, duration: nil)
    interest.valid?
    expect(interest).to be_invalid
    expect(interest.errors[:duration]).to include(I18n.t("errors.messages.blank"))
  end

  it "is invalid when duration is not a number " do
    interest = build(:interest, duration: "invalid")
    interest.valid?
    expect(interest).to be_invalid
    expect(interest.errors[:duration]).to include(I18n.t("errors.messages.not_a_number"))
  end

  it "is invalid when interest_rate is nil " do
    interest = build(:interest, interest_rate: nil)
    interest.valid?
    expect(interest).to be_invalid
    expect(interest.errors[:interest_rate]).to include(I18n.t("errors.messages.blank"))
  end

  it "is invalid when interest_rate is not a number " do
    interest = build(:interest, interest_rate: "invalid")
    interest.valid?
    expect(interest).to be_invalid
    expect(interest.errors[:interest_rate]).to include(I18n.t("errors.messages.not_a_number"))
  end

  it "is invalid when managerment_fee is not a number " do
    interest = build(:interest, managerment_fee: "invalid")
    interest.valid?
    expect(interest).to be_invalid
    expect(interest.errors[:managerment_fee]).to include(I18n.t("errors.messages.not_a_number"))
  end
end