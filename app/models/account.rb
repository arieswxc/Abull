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

  def self.username_list
    username_list = Array.new
    Account.all.each do |account|
      username_list << [account.user.username, account.user_id]
    end
    return username_list.sort!
  end
end
