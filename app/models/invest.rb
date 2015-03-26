class Invest < ActiveRecord::Base
  # validates :user_id, presence: true
  validates :fund_id, presence: true
  validates :date,    presence: true
  validates :amount,  presence: true
  validates :amount,  numericality: true
  belongs_to :user
  belongs_to :fund

  def send_sms(mobile, type, params)
    SMSGateway.render_then_send(mobile, type, params)
  end

  def check_reached
    fund = self.fund
    if fund.raised_amount == fund.amount 
      fund.reach 
    end
  end
end
