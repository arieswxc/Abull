require 'rails_helper'

RSpec.describe Account, type: :model do
  it "is valid" do
    expect(create(:account)).to be_valid
  end

  it "is invalid when user is nil" do
    account = build(:account, user_id: nil)
    account.valid?
    expect(account).to be_invalid
    expect(account.errors[:user_id]).to include(I18n.t("errors.messages.blank"))
  end

  it "is invalid when balance is nil" do
    account = build(:account, balance: nil)
    account.valid?
    expect(account).to be_invalid
    expect(account.errors[:balance]).to include(I18n.t("errors.messages.blank"))
  end

  it "is invalid when balance is not a number" do
    account = build(:account, balance: "invalid")
    account.valid?
    expect(account).to be_invalid
    expect(account.errors[:balance]).to include(I18n.t("errors.messages.not_a_number"))
  end  
end
