require 'digest'
require 'nokogiri'
require 'net/http'
require 'active_support/all'

class AccountsController < ApplicationController
  def bankcard_charge
    @billing = Billing.new
  end

  def bankcard_charged
    @billing = current_user.account.billings.build(billing_params)
    @billing.billing_type = "充值"
    @billing.remark = "银行转账"
    if @billing.save
      redirect_to user_account_billings_path
    else
      render 'bankcard_charge'
    end
  end

  def alipay_charge
    @billing = Billing.new
  end

  def alipay_charged
    @billing = current_user.account.billings.build(billing_params)
    @billing.billing_type = "充值"
    @billing.remark = "支付宝转账"
    if @billing.save
      # redirect_to user_account_billings_path
      render json: {message: "seccess"}
    else
      render json: {message: "fail"}
    end
  end

  def third_charge
    @billing = Billing.new
  end

  def third_charged
    @billing = current_user.account.billings.build(billing_params)
    @billing.billing_type = "充值"
    @billing.remark = "第三方支付"
    if @billing.save
      render json: {url: realtime_trade(@billing).to_s}
    else
      render 'alipay_charge'
    end
  end

  def withdraw
    @billing = Billing.new
  end

  def withdrawn
    balance           = current_user.account.balance if current_user
    account           = current_user.account
    @billing_out      = account.billings.build(billing_params)
    @billing_in       = account.billings.build(billing_params)
    @billing_withdraw = account.billings.build(billing_params)
    @billing_out.billing_type       = "From Balance"
    @billing_in.billing_type        = "To Frost"
    @billing_withdraw.billing_type  = "提现"

    account.balance -= @billing_out.amount
    account.frost += @billing_out.amount
    if @billing_out.amount < balance
      ActiveRecord::Base.transaction do
        @billing_out.save
        @billing_in.save
        @billing_withdraw.save
        @billing_out.update(amount: -@billing_out.amount )
        @billing_withdraw.update(amount: -@billing_withdraw.amount)
        account.save
        @billing_out.confirm
        @billing_in.confirm
      end
      redirect_to user_account_billings_path
    else
      flash[:notice] = "没有足够余额"
      render 'withdraw'
    end
  end

  private
    def billing_params
      params.require(:billing).permit(:amount, :billing_type, :billable_id, :billable_type)
    end

    def realtime_trade(billing)
      uri                                 = URI('http://180.168.127.5/direct/gateway.htm')
      hashed_params                       = Hash.new
      hashed_params[:service]             = "create_direct_pay_by_user"
      hashed_params[:partner]             = "201501131139398055"
      hashed_params[:sign_type]           = "MD5"
      hashed_params[:notify_url]          = 'http://www.molstr.com/notify_url'
      hashed_params[:return_url]          = 'http://www.molstr.com/return_url'
      hashed_params[:error_notify_url]    = ""

      # 反钓鱼用参数
      key                                 = "2XYEF5RDNQ0U7H25WWSHM3IF8YK0YVvgyftw"
      hashed_params[:anti_phishing_key]   = get_realtime(hashed_params[:partner], key)
      hashed_params[:exter_invoke_ip]     = current_user ? current_user.current_sign_in_ip : ""

      # 易八通合作商户网站唯一订单号
      hashed_params[:out_trade_no]        = billing.billing_number
      hashed_params[:subject]             = billing.billing_type
      hashed_params[:payment_type]        = "1"

      hashed_params[:seller_email]        = ""
      hashed_params[:seller_id]           = "201501131139398055"
      hashed_params[:buyer_email]         = ""
      hashed_params[:buyer_id]            = ""
      # hashed_params[:price]               = ""
      # hashed_params[:quantity]            = ""
      hashed_params[:total_fee]           = billing.amount # price、quantity能代替total_fee。
      hashed_params[:body]                = billing.billing_type
      hashed_params[:show_url]            = ""
      hashed_params[:pay_method]          = "bankPay"
      hashed_params[:default_bank]        = ""

      hashed_params[:input_charset]       = "utf-8"
      hashed_params[:royalty_parameters]  = ""
      hashed_params[:royalty_type]        = ""

      show = true
      p_string = ""
      hashed_params.sort.each do |key, value|
        p_string = p_string + ( show ? "#{key}=#{value}" : "&#{key}=#{value}")
        show = false
      end

      hashed_params[:sign]                = Digest::MD5.hexdigest(p_string + key)
      @params = hashed_params
      uri.query                           = URI.encode_www_form(hashed_params)
      return uri
    end

    def get_realtime(partner, key)
      uri                           = URI('http://180.168.127.5/gateway.htm')
      hashed_params                 = Hash.new
      hashed_params[:service]       = "query_timestamp"
      hashed_params[:partner]       = partner
      hashed_params[:input_charset] = "utf-8"
      hashed_params[:sign_type]     = "MD5"
      key                           = key
      hashed_params[:sign]          = Digest::MD5.hexdigest(hashed_params.sort.to_h.to_param + key)

      uri.query           = URI.encode_www_form(hashed_params)
      res                 = Net::HTTP.get_response(uri)
      doc                 = res.body
      anti_phishing_key = ""

      if Nokogiri::XML(res.body).xpath("//ebatong").at_xpath("is_success").content == "T"
        anti_phishing_key = Nokogiri::XML(res.body).xpath("//ebatong").xpath("response").xpath("timestamp").at_xpath("encrypt_key").content
      end
      return anti_phishing_key
    end
end
