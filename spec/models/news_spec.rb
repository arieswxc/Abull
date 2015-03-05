require 'rails_helper'

RSpec.describe News, type: :model do
  it "is valid" do
    expect(create(:news)).to be_valid
  end

  it "is invalid without title" do
    news = build(:news, title: nil)
    news.valid?
    expect(news).to be_invalid
    expect(news.errors[:title]).to include(I18n.t("errors.messages.blank"))
  end

  it "is valid without content" do
    expect(create(:news, content: nil)).to be_valid
  end

  it "is valid without date" do
    expect(create(:news, date: nil)).to be_valid
  end
end
