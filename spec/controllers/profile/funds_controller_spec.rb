require 'rails_helper'

RSpec.describe Profile::FundsController, type: :controller do
  describe "GET #index" do
    it "assigns user                as @user,
        assigns all funds         as @funds,
        assigns total fund value  as @total_fund_value" do
      user = create(:user)
      20.times do
        create(:fund, user_id: user.id)
      end
      get :index, {user_id: user.to_param}
      expect(assigns(:user)).to               eq user
      expect(assigns(:funds).count).to      eq 20
      expect(assigns(:total_fund_value)).to eq user.funds.sum(:amount)
    end
  end
end