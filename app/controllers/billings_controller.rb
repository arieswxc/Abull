require 'digest'
require 'nokogiri'
require 'net/http'
require 'active_support/all'

class BillingsController < ApplicationController
  def index
    @billings = current_user.account.billings.order(id: :desc).where.not(billing_type: ["To Frost", "From Balance", "From Frost", "To Balance", "获得投标"], state: "cancelled").paginate(:page => params[:page])
  end

  def cancel_withdraw
    billing = Billing.find(params[:id])
    account = billing.account
    billing_out = Billing.new(
      account_id: account.id,
      amount: billing.amount,
      billing_type: "From Frost")
    billing_in = Billing.new(
      account_id: account.id,
      amount: -billing.amount,
      billing_type: "To Balance")
    account.balance += billing_in.amount
    account.frost += billing_out.amount
    ActiveRecord::Base.transaction do
      billing.cancel
      billing_out.save
      billing_in.save
      billing_out.confirm
      billing_in.confirm
      account.save
    end
    redirect_to billings_path
  end

  def realtime_trade
    billing                             = Billing.find(params[:id])
    uri                                 = URI('http://180.168.127.5/direct/gateway.htm')
    hashed_params                       = Hash.new
    hashed_params[:service]             = "create_direct_pay_by_user"
    hashed_params[:partner]             = "201501131139398055"
    hashed_params[:sign_type]           = "MD5"
    hashed_params[:notify_url]          = 'http://localhost:3000/online_service'
    hashed_params[:return_url]          = 'http://localhost:3000/notify_service'
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
    @uri = uri
    render json: {url: uri.to_s}
    # res                                 = Net::HTTP.get_response(uri)
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
