require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  # normal
  it "is valid" do
    expect(create(:admin_user)).to be_valid
  end
end