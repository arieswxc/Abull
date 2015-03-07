require 'rails_helper'

RSpec.describe LeveragesController, type: :controller do
  describe "GET #index" do
    it "assigns user                as @user,
        assigns all leverages         as @leverages,
        assigns total leverage value  as @total_leverage_value" do
      user = create(:user)
      20.times do
        create(:leverage, user_id: user.id)
      end
      get :index, {user_id: user.to_param}
      expect(assigns(:user)).to               eq user
      expect(assigns(:leverages).count).to      eq 20
      expect(assigns(:total_leverage_value)).to eq user.leverages.sum(:amount)
    end
  end
end