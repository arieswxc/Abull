require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  # normal
  it "is valid" do
    expect(create(:admin_user)).to be_valid
  end

  # role
  it "is invalid without role" do
    admin_user = build(:admin_user, role: nil)

    admin_user.valid?
    expect(admin_user).to be_invalid
    expect(admin_user.errors[:role]).to include(I18n.t('errors.messages.blank'))
  end

  it "is invalid when role is not included" do
    admin_user = build(:admin_user, role: "invalid")
    admin_user.valid?
    expect(admin_user).to be_invalid
    expect(admin_user.errors[:role]).to include(I18n.t('errors.messages.inclusion'))
  end

  it "is valid when role is included" do
    expect(create(:admin_user, role: "risk_controller")).to be_valid
    expect(create(:admin_user, role: "teller")).to be_valid
    expect(create(:admin_user, role: "account_manager")).to be_valid
    expect(create(:admin_user, role: "customer_service")).to be_valid
  end
end