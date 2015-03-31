require 'net/http'

class SMSGateway
  SMS_GATEWAY_URL = 'http://222.73.117.158:80/msg/HttpBatchSendSM'
  SMS_GATEWAY_USERNAME = 'zxnicv'
  SMS_GATEWAY_PASSWORD = 'Txb123456'
  # SMS_GATEWAY_ENABLED = Rails.env.development?
  
  def self.send(phone, message)
    # unless SMS_GATEWAY_ENABLED
    #   puts "Send SMS to #{phone}: #{message}"
    #   return true
    # end   
    post(phone, message)
  end

  def self.render_then_send(phone, name, params)
    message = render(name, params).strip
    send(phone, message)
  end

  protected

  def self.render(name, params)
    view = ActionView::Base.new(ActionController::Base.view_paths, {})
    view.render(file: "sms/#{name}", locals: params)
  end

  def self.post(cell, msg)
    begin
      uri       = URI.parse(SMS_GATEWAY_URL)
      res = Net::HTTP.post_form(uri, account: SMS_GATEWAY_USERNAME, pswd: SMS_GATEWAY_PASSWORD, mobile: cell, msg: msg, needstatus: true)
      batch_code  = res.body.split[1]
      return !batch_code.nil?
      rescue
        return false
      end
  end

end