require 'digest'
require 'nokogiri'
require 'net/http'
require 'active_support/all'

ActiveAdmin.register Billing do
  permit_params :account_id, :amount, :billing_type, :billable_type, :billable_id, :state, :billing_number, :remark

  controller do
    def order_result_query(billing)
      uri                           = URI('http://180.168.127.5/gateway.htm')
      hashed_params                 = Hash.new
      hashed_params[:service]       = "single_direct_query"
      hashed_params[:sign_type]     = "MD5"
      hashed_params[:input_charset] = "utf-8"
      hashed_params[:partner]       = "201501131139398055"
      hashed_params[:out_trade_no]  = billing.billing_number
      key                           = "2XYEF5RDNQ0U7H25WWSHM3IF8YK0YVvgyftw"
      hashed_params[:sign]          = Digest::MD5.hexdigest(hashed_params.sort.to_h.to_param + key)
      uri.query                     = URI.encode_www_form(hashed_params)
      res                           = Net::HTTP.get_response(uri)
      doc                           = res.body
      state                         = false
      if (Nokogiri::XML(res.body).xpath("//orderQuery").at_xpath("status").content == "SUCCESS") && (Nokogiri::XML(res.body).xpath("//result").at_xpath("tradeStatus").content == "TRADE_FINISHED")
        status      = "SUCCESS"
        charset     = Nokogiri::XML(res.body).xpath("//orderQuery").at_xpath("charset").content
        outTradeNo  = Nokogiri::XML(res.body).xpath("//result").at_xpath("outTradeNo").content
        subject     = Nokogiri::XML(res.body).xpath("//result").at_xpath("subject").content
        tradeNo     = Nokogiri::XML(res.body).xpath("//result").at_xpath("tradeNo").content
        tradeStatus = Nokogiri::XML(res.body).xpath("//result").at_xpath("tradeStatus").content
        totalFee    = Nokogiri::XML(res.body).xpath("//result").at_xpath("totalFee").content
        sign        = Digest::MD5.hexdigest(status + charset + outTradeNo + subject + tradeNo + tradeStatus + totalFee + key)
        if sign == Nokogiri::XML(res.body).at_xpath("//sign").content
          state = true
        end
      end
      return state
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

  show do |billing|
    attributes_table do
      row :id
      row :billing_number
      row :account_id do |billing|
        billing.account.user.username
      end
      row :amount
      row :billing_type
      row :billable_type
      row :billable_id
      row :state do |billing|
        t(billing.state)
      end
      row :remark
    end
  end

  sidebar "状态", only: :show do
    attributes_table_for billing do
      row :state do
        t(billing.state)
      end
      row(t('confirm'))  do 
          link_to t('Confirm'), confirm_admin_billing_path(billing), :method => :put, :class => 'button' 
      end
      row(t('deny'))  do 
          link_to t('Deny'), deny_admin_billing_path(billing), :method => :put, :class => 'button' 
      end
    end
  end

  sidebar "第三方支付收款", only: :show do
    attributes_table_for billing do
      row('收款')  do 
          link_to '收款', confirm_thirdpay_admin_billing_path(billing), :method => :put, :class => 'button' 
      end
    end
  end

  member_action :confirm, :method => :put do
    billing = Billing.find(params[:id])
    account = billing.account
    if billing.billing_type == "Withdraw"
      account.frost += billing.amount
    else
      account.balance += billing.amount
    end
    ActiveRecord::Base.transaction do
      billing.confirm
      account.save
    end
    redirect_to admin_billing_path(billing)
  end

  member_action :deny, :method => :put do
    billing = Billing.find(params[:id])
    billing.deny
    redirect_to admin_billing_path(billing)
  end

  member_action :confirm_thirdpay, :method => :put do
    billing = Billing.find(params[:id])
    if order_result_query(billing) && billing.state == "pending"
      account = billing.account
      account.balance += billing.amount
      ActiveRecord::Base.transaction do
        billing.confirm
        account.save
      end
    end
    redirect_to admin_billing_path(billing)
  end
end