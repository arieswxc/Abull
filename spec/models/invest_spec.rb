require 'rails_helper'

RSpec.describe Invest, type: :model do
  # user
  it "is invalid when user is nil" do
    expect(build(:invest, user: nil)).to be_invalid
  end

  # fund
  it "is invalid when fund is nil" do
    expect(build(:invest, fund: nil)).to be_invalid
  end

  # date
  it "is invalid when date is nil" do
    expect(build(:invest, date: nil)).to be_invalid
  end

  # number
  it "is invalid when number is nil" do
    expect(build(:invest, number: nil)).to be_invalid
  end

  it "is invalid when number is not a number" do
    invest = build(:invest, number: "invalid")
    invest.valid?
    expect(invest).to be_invalid
    expect(invest.errors[:number]).to include("is not a number")
  end
end
