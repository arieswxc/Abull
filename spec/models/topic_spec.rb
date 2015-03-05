require 'rails_helper'

RSpec.describe Topic, type: :model do
  it "is valid" do
    expect(create(:topic)).to be_valid
  end

  it "is invalid without title" do
    topic = build(:topic, title: nil)
    topic.valid?
    expect(topic).to be_invalid
    expect(topic.errors[:title]).to include(I18n.t("errors.messages.blank"))
  end

  it "is invalid without user" do
    topic = build(:topic, user_id: nil)
    topic.valid?
    expect(topic).to be_invalid
    expect(topic.errors[:user_id]).to include(I18n.t("errors.messages.blank"))
  end

  it "is valid without content" do
    expect(create(:topic, content: nil)).to be_valid
  end

  it "is valid without date" do
    expect(create(:topic, date: nil)).to be_valid
  end
end
