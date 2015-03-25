require 'rails_helper'

RSpec.describe BankCard, type: :model do
  it "is valid" do
    expect(create(:bank_card)).to be_valid
  end

  # bank_name
  it "is invalid without bank_name" do
    bank_card = build(:bank_card, bank_name: nil)
    bank_card.valid?
    expect(bank_card).to be_invalid
    expect(bank_card.errors[:bank_name]).to include(I18n.t("errors.messages.blank"))
  end

  # number
  it "is invalid without number" do
    bank_card = build(:bank_card, number: nil)
    bank_card.valid?
    expect(bank_card).to be_invalid
    expect(bank_card.errors[:number]).to include(I18n.t("errors.messages.blank"))
  end

  # user
  it "is invalid without user_id" do
    bank_card = build(:bank_card, user_id: nil)
    bank_card.valid?
    expect(bank_card).to be_invalid
    expect(bank_card.errors[:user_id]).to include(I18n.t("errors.messages.blank"))
  end

  # branch
  it "is valid without bank_branch" do
    expect(create(:bank_card, bank_branch: nil)).to be_valid
  end

  # state
  it "is invalid when state is nil" do
    bank_card = build(:bank_card, state: nil)
    bank_card.valid?
    expect(bank_card).to be_invalid
    expect(bank_card.errors[:state]).to include(I18n.t("errors.messages.invalid"))
  end

  it "is invalid when state not included" do
    bank_card = build(:bank_card, state: "invalid")
    bank_card.valid?
    expect(bank_card).to be_invalid
    expect(bank_card.errors[:state]).to include(I18n.t("errors.messages.invalid"))
  end

  it "is valid when state is included" do
    expect(create(:bank_card, state: "pending")).to be_valid
    expect(create(:bank_card, state: "approved")).to be_valid
  end
end
