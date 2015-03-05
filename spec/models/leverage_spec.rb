require 'rails_helper'

RSpec.describe Leverage, type: :model do
  # normal
  it "is valid" do
    expect(create(:leverage)).to be_valid
  end

  # user
  it "is invalid without user_id" do
    leverage = build(:leverage, user_id: nil)
    leverage.valid?
    expect(leverage).to be_invalid
    expect(leverage.errors[:user_id]).to include(I18n.t('errors.messages.blank'))
  end

  # date
  it "is invalid without date" do
    leverage = build(:leverage, date: nil)
    leverage.valid?
    expect(leverage).to be_invalid
    expect(leverage.errors[:date]).to include(I18n.t('errors.messages.blank'))
  end

  # number
  it "is invalid without number" do
    leverage = build(:leverage, number: nil)
    leverage.valid?
    expect(leverage).to be_invalid
    expect(leverage.errors[:number]).to include(I18n.t('errors.messages.blank'))
  end

  it "is invalid when number not a number" do
    leverage = build(:leverage, number: "invalid")
    leverage.valid?
    expect(leverage).to be_invalid
    expect(leverage.errors[:number]).to include(I18n.t('errors.messages.not_a_number'))
  end

  # deadline
  it "is invalid when deadline is nil" do
    leverage = build(:leverage, deadline: nil)
    leverage.valid?
    expect(leverage).to be_invalid
    expect(leverage.errors[:deadline]).to include(I18n.t('errors.messages.blank'))
  end

  it "should be invalid when deadline is before date" do
    leverage = build(:leverage, deadline: Time.now - 1.day)
    expect(leverage).to be_invalid
    expect(leverage.errors[:deadline]).to include(I18n.t('invalid_date'))
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