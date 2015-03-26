require 'rails_helper'

RSpec.describe Leverage, type: :model do
  # normal
  it "is valid" do
    expect(create(:leverage)).to be_valid
  end

  # user
  it "is invalid without user_id" do
    expect(create(:leverage, user_id: nil)).to be_valid
  end

  # date
  it "is valid without date" do
    expect(create(:leverage, date: nil)).to be_valid
  end

  # amount
  it "is invalid without amount" do
    leverage = build(:leverage, amount: nil)
    leverage.valid?
    expect(leverage).to be_invalid
    expect(leverage.errors[:amount]).to include(I18n.t('errors.messages.blank'))
  end

  it "is invalid when amount not a number" do
    leverage = build(:leverage, amount: "invalid")
    leverage.valid?
    expect(leverage).to be_invalid
    expect(leverage.errors[:amount]).to include(I18n.t('errors.messages.not_a_number'))
  end

  # duration
  it "is invalid when duration is nil" do
    leverage = build(:leverage, duration: nil)
    leverage.valid?
    expect(leverage).to be_invalid
    expect(leverage.errors[:duration]).to include(I18n.t('errors.messages.blank'))
  end
    
  # state
  it "is invalid when state is nil" do
    leverage = build(:leverage, state: nil)
    leverage.valid?
    expect(leverage).to be_invalid
    expect(leverage.errors[:state]).to include(I18n.t('errors.messages.blank'))
  end

  it "is invalid when state is not included" do
    leverage = build(:leverage, state: "invalid")
    leverage.valid?
    expect(leverage).to be_invalid
    expect(leverage.errors[:state]).to include(I18n.t('errors.messages.inclusion'))
  end

  it "is valid when state is included" do
    expect(create(:leverage, state: "applied")).to be_valid
    expect(create(:leverage, state: "confirmed")).to be_valid
    expect(create(:leverage, state: "closed")).to be_valid
  end

  # description
  it "is valid without description" do
    expect(create(:leverage, description: nil)).to be_valid
  end
end
