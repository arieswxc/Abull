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

  #TODO password should be send with salt and hashed. Can the backend get the raw password?
  it "is invalid if password too short: invalid" do
    expect(build(:user, password: "111111")).to be_invalid
  end

  it "is invalid if password too short: minimum is 8 characters" do
    user = build(:user, password: "111111")
    user.valid?
    expect(user.errors[:password]).to include(I18n.t('errors.messages.too_short.other', count: 8))
  end

  it "should contian both characters and numbers (@ken pls check the case first)" do
    #TODO pls check the case first
    user = build(:user, password:"1234abcd")
    expect(user).to be_valid
    user = build(:user, password:"121334545")
    expect(user).to be_invalid
    #TODO @ken add some assert
  end

  # cell
  it "is valid without cell" do
    expect(build(:user, cell: nil)).to be_valid
  end

  # real_name
  it "is valid without real_name" do
    expect(build(:user, real_name: nil)).to be_valid
  end



  # nick_name
  it "is valid without nick_name" do
    expect(build(:user, nick_name: nil)).to be_valid
  end
end
