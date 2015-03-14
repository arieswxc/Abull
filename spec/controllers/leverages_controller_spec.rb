require 'rails_helper'

RSpec.describe LeveragesController, type: :controller do
  describe "GET #show" do
    it "assigns the requested leverage  as @leverage,
        assigns the requested user      as @user,
        assigns the requested comments  as @comments" do
      user          = create(:user)
      leverage      = create(:leverage, user_id: user.id)
      comment       = create(:comment, commentable: leverage, user_id: leverage.user.id)
      3.times { create(:interest)}
      2.times { create(:interest, show: "true")}
      get :show, {id: leverage.to_param, user_id: user.to_param}
      expect(assigns(:leverage)).to         eq leverage
      expect(assigns(:user)).to             eq user
      expect(assigns(:comments).first).to   eq comment
      expect(assigns(:interests).count).to  eq 2
    end
  end

  describe "GET #new" do
    it "assigns the requested leverage  as @leverage" do
      user = create(:user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
      get :new
      expect(assigns(:leverage)).to   be_a_new Leverage
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "create a new leverage" do
        user = create(:user)
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in user
        expect {
          post :create, {leverage: build(:leverage).attributes.symbolize_keys}
        }.to change(Leverage, :count).by(1)
      end

      it "assigns a newly created leverage as @leverage,
          redirect to leverage" do
        user = create(:user)
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in user
        post :create, {leverage: build(:leverage).attributes.symbolize_keys}
        expect(assigns(:leverage)).to   be_a Leverage
        expect(response).to         redirect_to(Leverage.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved leverage as @leverage,
          re-render the 'new' template" do
        user = create(:user)
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in user
        invalid_attributes          = build(:leverage).attributes.symbolize_keys
        invalid_attributes[:state]  = "invalid_state"

        post :create, {leverage: invalid_attributes}
        expect(assigns(:leverage)).to be_a_new Leverage
        expect(response).to       render_template("new")
      end
    end
  end

  describe "GET #edit" do
    it "assigns the requested leverage as @leverage" do
      user = create(:user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user

      leverage = create(:leverage, user_id: user.id)
      get :edit, {id: leverage.to_param}
      expect(assigns(:leverage)).to eq leverage
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "update the requested leverage,
          assigns the requested leverage as @leverage,
          redirect to the leverage" do
        user = create(:user)
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in user

        leverage = create(:leverage, state: "applied", user_id: user.id)
        put :update, {id: leverage.to_param, leverage: {state: "confirmed"}}
        leverage.reload
        expect(leverage.state).to eq "confirmed"
        expect(assigns(:leverage)).to eq leverage
        expect(response).to redirect_to leverage
      end
    end

    context "with invalid params" do
      it "assigns the requested leverage as @leverage,
          re-render the 'edit' template" do
        user = create(:user)
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in user

        leverage = create(:leverage, state: "applied", user_id: user.id)
        put :update, {id: leverage.to_param, leverage: {state: "invalid_state"}}
        leverage.reload
        expect(assigns(:leverage)).to eq leverage
        expect(response).to render_template "edit"
      end
    end
  end
end