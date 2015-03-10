require 'rails_helper'

RSpec.describe FundsController, type: :controller do
  describe "GET #index" do
    it "assigns all funds as @funds" do
      20.times {create(:fund)}
      get :index
      expect(assigns(:funds).count).to      eq 20
    end
  end

  describe "GET #show" do
    it "assigns the requested fund      as @fund,
        assigns the requested user      as @user,
        assigns the requested private   as @private,
        assigns the requested comments as @comments" do
      user    = create(:user)
      fund    = create(:fund, user_id: user.id)
      comment = create(:comment, commentable: fund, user_id: fund.user.id)
      get :show, {id: fund.to_param, user_id: user.to_param}
      expect(assigns(:fund)).to eq fund
      expect(assigns(:private)).to eq fund.private_check
      expect(assigns(:user)).to eq user
      expect(assigns(:comments).first).to eq comment
    end
  end

  describe "GET #new" do
    it "assigns the requested fund  as @fund" do
      user = create(:user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
      get :new
      expect(assigns(:fund)).to   be_a_new Fund
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "create a new fund" do
        user = create(:user)
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in user
        expect {
          post :create, {fund: build(:fund).attributes.symbolize_keys}
        }.to change(Fund, :count).by(1)
      end

      it "assigns a newly created fund as @fund,
          redirect to fund" do
        user = create(:user)
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in user
        post :create, {fund: build(:fund).attributes.symbolize_keys}
        expect(assigns(:fund)).to   be_a Fund
        expect(response).to         redirect_to(Fund.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved fund as @fund,
          re-render the 'new' template" do
        user = create(:user)
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in user
        invalid_attributes          = build(:fund).attributes.symbolize_keys
        invalid_attributes[:state]  = "invalid_state"

        post :create, {fund: invalid_attributes}
        expect(assigns(:fund)).to be_a_new Fund
        expect(response).to       render_template("new")
      end
    end
  end

  describe "GET #edit" do
    it "assigns the requested fund as @fund" do
      user = create(:user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user

      fund = create(:fund, user_id: user.id)
      get :edit, {id: fund.to_param}
      expect(assigns(:fund)).to eq fund
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "update the requested fund,
          assigns the requested fund as @fund,
          redirect to the fund" do
        user = create(:user)
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in user

        fund = create(:fund, state: "pending", user_id: user.id)
        put :update, {id: fund.to_param, fund: {state: "applied"}}
        fund.reload
        expect(fund.state).to eq "applied"
        expect(assigns(:fund)).to eq fund
        expect(response).to redirect_to fund
      end
    end

    context "with invalid params" do
      it "assigns the requested fund as @fund,
          re-render the 'edit' template" do
        user = create(:user)
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in user

        fund = create(:fund, state: "pending", user_id: user.id)
        put :update, {id: fund.to_param, fund: {state: "invalid_state"}}
        fund.reload
        expect(assigns(:fund)).to eq fund
        expect(response).to render_template "edit"
      end
    end
  end
end