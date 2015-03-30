require 'rails_helper'

RSpec.describe Billing, type: :model do
  it "is valid" do
    expect(create(:billing)).to be_valid
  end

  # amount
  it "is invalid without amount" do
    billing = build(:billing, amount: nil)
    billing.valid?
    expect(billing).to be_invalid
    expect(billing.errors[:amount]).to include(I18n.t("errors.messages.blank"))
  end

  it "is invalid when amount not a number" do
    billing = build(:billing, amount: "invalid")
    billing.valid?
    expect(billing).to be_invalid
    expect(billing.errors[:amount]).to include(I18n.t("errors.messages.not_a_number"))
  end

  # account
  it "is invalid without account" do
    billing = build(:billing, account_id: nil)
    billing.valid?
    expect(billing).to be_invalid
    expect(billing.errors[:account_id]).to include(I18n.t("errors.messages.blank"))
  end

  # billing_type
  it "is invalid without billing_type" do
    billing = build(:billing, billing_type: nil)
    billing.valid?
    expect(billing).to be_invalid
    expect(billing.errors[:billing_type]).to include(I18n.t("errors.messages.blank"))
  end

  # billable
  it "is valid without billable" do
    expect(build(:billing, billable_id: nil)).to be_valid
  end

  # state
  it "is invalid without state" do
    billing = build(:billing, state: nil)
    billing.valid?
    expect(billing).to be_invalid
    expect(billing.errors[:state]).to include(I18n.t("errors.messages.invalid"))
  end

  it "is invalid if state is not included" do
    billing = build(:billing, state: "invalid")
    billing.valid?
    expect(billing).to be_invalid
    expect(billing.errors[:state]).to include(I18n.t("errors.messages.invalid"))
  end

  it "is valid if state is included" do
    expect(create(:billing, state: "pending")).to be_valid
    expect(create(:billing, state: "confirmed")).to be_valid
  end
end
