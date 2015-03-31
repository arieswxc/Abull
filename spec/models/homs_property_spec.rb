require 'rails_helper'

RSpec.describe HomsProperty, type: :model do
  it "is valid" do
    expect(create(:homs_property)).to be_valid
  end

  # date
  it "is invalid without date" do
    homs_property = build(:homs_property, date: nil)
    homs_property.valid?
    expect(homs_property).to be_invalid
    expect(homs_property.errors[:date]).to include(I18n.t("errors.messages.blank"))
  end

  # amount
  it "is invalid without amount" do
    homs_property = build(:homs_property, amount: nil)
    homs_property.valid?
    expect(homs_property).to be_invalid
    expect(homs_property.errors[:amount]).to include(I18n.t("errors.messages.blank"))
  end

  it "is invalid when amount not a number" do
    homs_property = build(:homs_property, amount: "invalid")
    homs_property.valid?
    expect(homs_property).to be_invalid
    expect(homs_property.errors[:amount]).to include(I18n.t("errors.messages.not_a_number"))
  end

   # homs_account
  it "is invalid without homs_account" do
    homs_property = build(:homs_property, homs_account: nil)
    homs_property.valid?
    expect(homs_property).to be_invalid
    expect(homs_property.errors[:homs_account]).to include(I18n.t("errors.messages.blank"))
  end
end
