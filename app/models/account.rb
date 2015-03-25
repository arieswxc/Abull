class Account < ActiveRecord::Base
  validates :user_id, presence: true
  validates :user, presence: true
  validates :balance, presence: true
  validates :balance, numericality: true
  belongs_to :user
  has_many :billings
  # def send_zhifubao_sms(mobile, params) 
  #   SMSGateway.render_then_send(mobile, 'zhifubao', params)
  # end

  # def send_offline_sms(mobile, params)
  #   SMSGateway.render_then_send(mobile, 'offline', params)    
  # end

  def send_sms(mobile, type, params)
    SMSGateway.render_then_send(mobile, type, params)
  end
  
end
