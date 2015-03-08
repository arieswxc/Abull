require 'rails_helper'

RSpec.describe InvestsController, type: :controller do

  let(:valid_attributes) { build(:invest).attributes.symbolize_keys}

  describe "GET #index" do
    it "assigns fund         as @fund,
        assigns all invests  as @invests,
        assigns fund_balance as @fund_balance" do
      fund = create(:fund)
      20.times {create(:invest, fund_id: fund.to_param)}
      fund_balance = fund.amount - fund.invests.sum(:amount)
      get :index, {fund_id: fund.to_param}
      expect(assigns(:invests).count).to  eq 20
      expect(assigns(:fund)).to           eq fund
      expect(assigns(:fund_balance)).to   eq fund_balance
    end
  end

  describe "GET #new" do
    it "assigns new invest          as @invest,
        assigns the requested fund  as @fund" do
      fund    = create(:fund)
      get :new, {fund_id: fund.to_param}
      expect(assigns(:invest)).to be_a_new(Invest)
      expect(assigns(:fund)).to   eq fund
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "create a new Invest" do
        fund                        = create(:fund)
        valid_attributes[:fund_id]  = fund.id
        expect {
          post :create, {invest: valid_attributes, fund_id: fund.to_param}
          }.to change(Invest, :count).by(1)
      end

      it "assigns a newly created invest as @invest,
      redirect to fund" do
        fund                        = create(:fund)
        valid_attributes[:fund_id]  = fund.id
        post :create, {invest: valid_attributes, fund_id: fund.to_param}
        expect(assigns(:fund)).to   eq fund
        expect(assigns(:invest)).to be_a Invest
        expect(assigns(:invest)).to be_persisted
        expect(response).to         redirect_to(fund)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved invest as @invest,
          re-render the 'new' template" do
        fund                        = create(:fund)
        valid_attributes[:fund_id]  = fund.id
        valid_attributes[:amount]   = "invalid"
        post :create, {invest: valid_attributes, fund_id: fund.to_param}
        expect(assigns(:invest)).to be_a_new Invest
        expect(response).to         render_template("new")
      end
    end
  end
end