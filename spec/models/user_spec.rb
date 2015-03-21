require 'rails_helper'

RSpec.describe User, type: :model do
  # normal
  it "is valid with email and password" do
    expect(create(:user)).to be_valid
  end

  # email: duplicate
  it "is invalid with duplicate email: invalid" do
    user = create(:user)
    expect(build(:user, email: user.email)).to be_invalid
  end

  it "is invalid with duplicate email: error message" do
    user = create(:user)
    duplicate_email_user = build(:user, email: user.email)
    duplicate_email_user.valid?
    expect(duplicate_email_user.errors[:email]).to include(I18n.t('errors.messages.taken'))
  end

  # avatar
  it "is valid without avatar: could add later" do
    expect(build(:user, avatar: nil)).to be_valid
  end

  # password
  it "is invalid if password too short: invalid" do
    expect(build(:user, password: "111111")).to be_invalid
  end

  it "is invalid if password too short: minimum is 8 characters" do
    user = build(:user, password: "111111")
    user.valid?
    expect(user.errors[:password]).to include(I18n.t('errors.messages.too_short.other', count: 8))
  end

  it "should contian both characters and numbers" do
    user = build(:user, password:"1234abcd")
    expect(user).to be_valid
    user = build(:user, password:"123456789")
    user.valid?
    expect(user).to be_invalid
    expect(user.errors[:password]).to include(I18n.t("errors.messages.invalid"))
  end

  # cell
  it "is invalid without cell" do
    user = build(:user, cell: nil)
    user.valid?
    expect(user).to be_invalid
    expect(user.errors[:cell]).to include(I18n.t("errors.messages.blank"))
  end

  it "is invalid when cell is taken" do
    user = create(:user)
    duplicate_cell_user = build(:user, cell: user.cell)
    duplicate_cell_user.valid?
    expect(duplicate_cell_user.errors[:cell]).to include(I18n.t('errors.messages.taken'))
  end

  # real_name
  it "is valid without real_name" do
    expect(create(:user, real_name: nil)).to be_valid
  end

  # username
  it "is valid without username" do
    expect(create(:user, username: nil)).to be_valid
  end

  # id_card_number
  it "is valid without id_card_number" do
    expect(create(:user, id_card_number: nil)).to be_valid
  end

  # abstract
  it "is valid without abstract" do
    expect(create(:user, abstract: nil)).to be_valid
  end

  # level
  it "is valid without level" do
    expect(build(:user, level: nil)).to be_invalid
  end

  # photos
  it "has many photos" do
    user  = create(:user)
    photo = create(:photo, user_id: user.id)
    expect(user.photos.first).to eq photo
  end

  it "has unique photo title" do
    user    = create(:user)
    photo   = create(:photo, user_id: user.id, title: "id card")
    photo1  = build(:photo, user_id: user.id, title: "id card")
    expect(photo1).to be_invalid
    expect(photo1.errors[:title]).to include(I18n.t("errors.messages.taken"))
  end

  # funds
  it "has many funds" do
    user  = create(:user)
    fund  = create(:fund, user_id: user.id)
    expect(user.funds.first).to eq fund
  end

  # invests
  it "has many invests" do
    user    = create(:user)
    invest  = create(:invest, user_id: user.id)
    expect(user.invests.first).to eq invest
  end

  # leverages
  it "has many leverages" do
    user      = create(:user)
    leverage  = create(:leverage, user_id: user.id)
    expect(user.leverages.first).to eq leverage
  end

  # following_users
  it "has many following_users" do
    follwer = create(:user)
    user    = create(:user)
    follwer.follow(user)
    expect(follwer.following_users.first).to eq user
  end

  # topics
  it "has many topics" do
    user  = create(:user)
    topic = create(:topic, user_id: user.id)
    expect(user.topics.first).to eq topic
  end

  # account
  it "has one account" do
    user    = create(:user)
    account = user.create_account
    expect(user.account).to eq account
  end
end
