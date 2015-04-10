class WelcomeController < ApplicationController
require 'number_to_cn'

  def index
    # @last_ten_funds   = Fund.last(10)
    @last_ten_funds   = Fund.where("state = 'gathering' or state = 'reached'").order(state: :asc, created_at: :desc).last(10)
    # @funds            = Fund.order(id: :desc)
    @last_ten_news    = News.last(10)
    @last_ten_topics  = Topic.last(10)
  end

  def funds
    
  end

  def notify_url
    @billing = Billing.find_by_billing_number(params[:out_trade_no])
    if (@billing.amount == params[:total_fee].to_f) && (params[:is_success] == "T") && (@billing.state == "pending")
      account = @billing.account
      account.balance += @billing.amount
      ActiveRecord::Base.transaction do
        @billing.confirm
        account.save
      end
      render json: {is_success: "T"}
    else
      render json: {is_success: "F"}
    end

  end

  def return_url
    @billing = Billing.find_by_billing_number(params[:out_trade_no])
    if (@billing.amount == params[:total_fee].to_f) && (params[:is_success] == "T") && (@billing.state == "pending")
      account = @billing.account
      account.balance += @billing.amount
      ActiveRecord::Base.transaction do
        @billing.confirm
        account.save
      end
    end
  end

  def entrusted_operation
    @invest = Invest.find(params[:invest_id])
    @fund = @invest.fund
    @fund_user = @fund.user
    @current_user = current_user
    @amount = @invest.amount.to_f.to_cn_words 
    @management_fee = @fund.management_fee.to_f.to_cn_words
    render "entrusted_operation", layout: false
  end

  def trader_agreement
    @fund = Fund.find(params[:fund_id])
    @fund_user = current_user
    @raised_amount = @fund.raised_amount.to_f.to_cn_words
    @management_fee = @fund.management_fee.to_f.to_cn_words 
    render "trader_agreement", layout: false
  end

end
