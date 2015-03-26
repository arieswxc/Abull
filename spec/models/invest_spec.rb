require 'rails_helper'

RSpec.describe Invest, type: :model do
  # user
  it "is invalid when user is nil" do
    expect(create(:invest, user: nil)).to be_valid
  end

  # fund
  it "is invalid when fund is nil" do
    expect(build(:invest, fund: nil)).to be_invalid
  end

  # date
  it "is invalid when date is nil" do
    expect(build(:invest, date: nil)).to be_invalid
  end

  # amount
  it "is invalid when amount is nil" do
    expect(build(:invest, amount: nil)).to be_invalid
  end

  it "is invalid when amount is not a number" do
    invest = build(:invest, amount: "invalid")
    invest.valid?
    expect(invest).to be_invalid
    expect(invest.errors[:amount]).to include(I18n.t('errors.messages.not_a_number'))
  end
end
