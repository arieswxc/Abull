require 'rails_helper'

RSpec.describe HomsAccount, type: :model do
  it "is valid" do
    expect(create(:homs_account)).to be_valid
  end

  it "is invalid without title" do
    homs_account = build(:homs_account, title: nil)
    homs_account.valid?
    expect(homs_account).to be_invalid
    expect(homs_account.errors[:title]).to include(I18n.t('errors.messages.blank'))
  end

  it "is valid without password" do
    expect(create(:homs_account, password: nil)).to be_valid
  end

  it "is invalid without fund_id" do
    homs_account = build(:homs_account, fund_id: nil)
    homs_account.valid?
    expect(homs_account).to be_invalid
    expect(homs_account.errors[:fund_id]).to include(I18n.t('errors.messages.blank'))
  end

  # amount
  it "is invalid without amount" do
    homs_account = build(:homs_account, amount: nil)
    homs_account.valid?
    expect(homs_account).to be_invalid
    expect(homs_account.errors[:amount]).to include(I18n.t('errors.messages.blank'))
  end

  it "is invalid when amount is not a number" do
    homs_account = build(:homs_account, amount: "invalid")
    homs_account.valid?
    expect(homs_account).to be_invalid
    expect(homs_account.errors[:amount]).to include(I18n.t('errors.messages.not_a_number'))
  end
end
