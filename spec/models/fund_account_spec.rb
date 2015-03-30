require 'rails_helper'

RSpec.describe FundAccount, type: :model do
  it "is valid" do
    expect(create(:fund_account)).to be_valid
  end

  it "is invalid when fund is nil" do
    fund_account = build(:fund_account, fund_id: nil)
    fund_account.valid?
    expect(fund_account).to be_invalid
    expect(fund_account.errors[:fund_id]).to include(I18n.t("errors.messages.blank"))
  end

  it "is invalid when balance is nil" do
    fund_account = build(:fund_account, balance: nil)
    fund_account.valid?
    expect(fund_account).to be_invalid
    expect(fund_account.errors[:balance]).to include(I18n.t("errors.messages.blank"))
  end

  it "is invalid when balance is not a number" do
    fund_account = build(:fund_account, balance: "invalid")
    fund_account.valid?
    expect(fund_account).to be_invalid
    expect(fund_account.errors[:balance]).to include(I18n.t("errors.messages.not_a_number"))
  end  
end
