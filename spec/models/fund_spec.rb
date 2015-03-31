require 'rails_helper'

RSpec.describe Fund, type: :model do
  # normal
  it "is invalid without user" do
    expect(build(:fund)).to be_valid
  end

  # name
  it "is valid without name" do
    expect(create(:fund, name: nil)).to be_valid
  end

  # user
  it "is valid without user_id" do
    expect(create(:fund, user_id: nil)).to be_valid
  end

  # amount
  it "is invalid without amount" do
    expect(build(:fund, amount: nil)).to be_invalid
  end

  it "is invalid without amount: should be a number" do
    fund = build(:fund, amount: "invalid")
    fund.valid?
    expect(fund).to be_invalid
    expect(fund.errors[:amount]).to include(I18n.t('errors.messages.not_a_number'))
  end

  # ending_days
  it "is invalid without ending_days" do
    expect(build(:fund, ending_days: nil)).to be_invalid
  end

  # earning
  it "is invalid without earning: be a number" do
    fund = build(:fund, earning: nil)
    fund.valid?
    expect(fund).to be_invalid
    expect(fund.errors[:earning]).to include(I18n.t('errors.messages.not_a_number'))
  end

  # state
  it "is invalid without state" do
    fund = build(:fund, state: nil)
    expect(fund).to be_invalid
    expect(fund.errors[:state]).to include(I18n.t('errors.messages.blank'))
  end

  it "is invalid when state not included" do
    fund = build(:fund, state: "invalid")
    fund.valid?
    expect(fund).to be_invalid
    expect(fund.errors[:state]).to include(I18n.t('errors.messages.inclusion'))
  end

  it "is valid when state is included " do
    expect(build(:fund, state: "pending")).to be_valid
    expect(build(:fund, state: "applied")).to be_valid
    expect(build(:fund, state: "gathering")).to be_valid
    expect(build(:fund, state: "reached")).to be_valid
    expect(build(:fund, state: "opened")).to be_valid
    expect(build(:fund, state: "running")).to be_valid
    expect(build(:fund, state: "finished")).to be_valid
    expect(build(:fund, state: "closed")).to be_valid
  end

  # private_check
  it "is invalid when private_check is nil" do
    fund = build(:fund, private_check: nil)
    fund.valid?
    expect(fund).to be_invalid
    expect(fund.errors[:private_check]).to include(I18n.t('errors.messages.inclusion'))
  end

  # minimum
  it "is valid when minimum is nil" do
    fund = build(:fund, minimum: nil)
    fund.valid?
    expect(fund).to be_valid
  end

  it "is valid when invest_starting_date is nil" do
    expect(build(:fund, invest_starting_date: nil)).to be_valid
  end

  it "is invalid when duration is nil" do
    expect(build(:fund, duration: nil)).to be_invalid
  end

  # management_fee
  it "is invalid without management_fee" do
    fund = build(:fund, management_fee: nil)
    expect(fund).to be_invalid
    expect(fund.errors[:management_fee]).to include(I18n.t('errors.messages.blank'))
  end

  it "is invalid when management_fee not a number" do
    fund = build(:fund, management_fee: "invalid")
    expect(fund).to be_invalid
    expect(fund.errors[:management_fee]).to include(I18n.t('errors.messages.not_a_number'))
  end
end