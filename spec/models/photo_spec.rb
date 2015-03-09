require 'rails_helper'

RSpec.describe Photo, type: :model do
  # normal
  it "is valid" do
    expect(create(:photo)).to be_valid
  end

  it "is invalid without title" do
    photo = build(:photo, title: nil)
    photo.valid?
    expect(photo).to be_invalid
    expect(photo.errors[:title]).to include(I18n.t("errors.messages.blank"))
  end

  it "is invalid without photo" do
    photo = build(:photo, photo: nil)
    photo.valid?
    expect(photo).to be_invalid
    expect(photo.errors[:photo]).to include(I18n.t("errors.messages.blank"))
  end
end
