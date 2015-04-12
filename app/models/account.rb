class Account < ActiveRecord::Base
  validates :user_id, presence: true
  validates :user, presence: true
  validates :balance, presence: true
  validates :balance, numericality: {greater_than_or_equal_to: 0}
  belongs_to :user
  has_many :billings

  def send_sms(mobile, type, params)
    SMSGateway.render_then_send(mobile, type, params)
  end
  
end
