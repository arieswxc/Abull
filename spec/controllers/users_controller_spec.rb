require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #investor_apply" do
    it "assigns all funds as @users" do
      user = create(:user)
      get :investor_apply, {id: user.to_param}
      expect(assigns(:user)).to eq user
    end
  end


  describe "PUT #investor_applied" do
    context "with valid params" do
      it "updates the requested user with real_name,
          assgin the requested user as @user,
          redirect_to the user" do
        user = create(:user)
        put :investor_applied, {id: user.to_param, user: {real_name: "new_real_name", password: user.password}}
        user.reload
        expect(user.real_name).to eq "new_real_name"
        expect(assigns(:user)).to eq user
        expect(response).to       redirect_to user
      end
    end

    context "with invalid params" do
      it "assigns the user as @user,
          re_renders the 'edit' template" do
        user = create(:user)
        put :investor_applied, {id: user.to_param, user: {real_name: nil, password: "wrongpassword"}}
        expect(assigns(:user)).to eq user
        expect(response).to       render_template("investor_apply")
      end
    end
  end

  describe "GET #show" do
    it "assigns the requested user            as @user,
        assigns the requested funds           as @funds,
        assigns the requested invests         as @invests,
        assigns the requested leverages       as @leverages,
        assigns the requested topics          as @topics,
        assigns the requested recommend_funds as @recommend_funds" do
      
      user = create(:user)
      10.times do 
        create(:fund, user_id: user.id)
        create(:invest, user_id: user.id)
        create(:leverage, user_id: user.id)
      end

      # following
      following       = create(:user)
      topic           = create(:topic, user_id: following.id)
      recommend_fund  = create(:fund, user_id: following.id)
      user.follow(following)

      get :show, {id: user.to_param}
      expect(assigns(:user)).to                   eq user
      expect(assigns(:funds).count).to            eq 10
      expect(assigns(:invests).count).to          eq 10
      expect(assigns(:leverages).count).to        eq 10
      expect(assigns(:topics).first).to           eq topic
      expect(assigns(:recommend_funds).first).to  eq recommend_fund
    end
  end
end