require 'rails_helper'

RSpec.describe Profile::InvestsController, type: :controller do
  describe "GET #index" do
    it "assigns user                as @user,
        assigns all invests         as @invests,
        assigns total invest value  as @total_invest_value" do
      user = create(:user)
      20.times do
        create(:invest, user_id: user.id)
      end
      get :index, {user_id: user.to_param}
      expect(assigns(:user)).to               eq user
      expect(assigns(:invests).count).to      eq 20
      expect(assigns(:total_invest_value)).to eq user.invests.sum(:amount)
    end
  end
end