class Fund < ActiveRecord::Base
  # validates :name,                presence: true
  # validates :user_id,             presence: true
  validates :amount,              presence: true
  validates :amount,              numericality: true
  validates :ending_days,         numericality: true
  validates :earning,             numericality: true
  validates :state,               presence: true
  validates :state,               inclusion: { in: ["pending", "applied", "gathering", "reached", "opened", "running", "finished", "closed", "denied"] }
  validates :private_check,       inclusion: { in: ["private", "public"] }
  validates :duration,  presence: true
  validates :expected_earning_rate, presence: true
  validates :expected_earning_rate, numericality: true
  belongs_to  :user
  has_many    :invests
  has_many    :fund_verify_photos, :class_name => "Photo", as: :imageable, dependent: :destroy
  has_one     :fund_account
  
  before_validation :generate_fundname, on: :create
  acts_as_commentable
  accepts_nested_attributes_for :fund_verify_photos, allow_destroy: true

  state_machine :state, :initial => :pending do
    event :apply do
      transition [:pending, :denied]  => :applied
    end

    event :approve do
      transition :applied => :gathering
    end

    event :deny do
      transition :applied => :denied
    end

    event :reach do
      transition :gathering => :reached
    end

    event :open_homs do
      transition :reached => :opened
    end

    event :run do
      transition :opened => :running
    end

    event :finish do
      transition :running => :finished
    end

    event :close do
      transition all => :closed
    end

    event :reset do
      transition :closed => :pending
    end
  end

  has_one :homs_account

  def send_sms(mobile, type, params)
    SMSGateway.render_then_send(mobile, type, params)
  end

  #虚拟属性
  def invest_ending_date
    # self.invest_starting_date.advance(days: self.duration)
    self.invest_starting_date.nil? ? nil : self.invest_starting_date.advance(months: self.duration, days: -1)
  end

  def collection_deadline
    self.created_at.advance(days: self.ending_days)
  end

  def raised_amount
    invests.sum(:amount) || 0
  end

  #类方法
  # def self.search_by_conditions(duration, amount, expected_earning_rate, private_check)
  #   duration = 0 if duration.blank?
  #   amount = 0 if amount.blank?
  #   expected_earning_rate = 0 if expected_earning_rate.blank?
  #   if private_check.blank?
  #     funds = Fund.where("duration > ? and amount > ? and expected_earning_rate > ?", duration, amount, expected_earning_rate)
  #   else
  #     funds = Fund.where("duration > ? and amount > ? and expected_earning_rate > ? and private_check = ?", duration, amount, expected_earning_rate, private_check)
  #   end
  # end

  def self.search_by_conditions(duration, amount, expected_earning_rate, private_check)
    duration = 0 if duration.blank?
    amount = 0 if amount.blank?
    expected_earning_rate = 0 if expected_earning_rate.blank?
    amount_begin, amount_end, rate_begin, rate_end = match_condition(amount.to_i, expected_earning_rate.to_i)
    if private_check.blank?
      funds = Fund.where("duration > ? and amount > ? and amount < ? and expected_earning_rate > ? and expected_earning_rate < ?", duration, amount_begin, amount_end, rate_begin, rate_end)
    else
      funds = Fund.where("duration > ? and amount > ? and amount < ? and expected_earning_rate > ? and expected_earning_rate < ? and private_check = ?", duration, amount_begin, amount_end, rate_begin, rate_end, private_check)
    end
  end


  private
  def generate_fundname
    if self.name.blank?
      record = true
      while record
        random = rand(1000000000).to_s.rjust(9, '0')
        record = Fund.where(name: random).first
      end
      self.name = random
    end
    self.name
  end

  def self.match_condition(amount_mark, rate_mark)
    case amount_mark
    when 0
      amount_begin = 0
      amount_end = 10_0000_0000
    when 1
      amount_begin = 0
      amount_end = 10_0000
    when 2
      amount_begin = 10_0000
      amount_end = 300_0000
    when 3
      amount_begin = 300_0000
      amount_end = 500_0000
    when 4
      amount_begin = 500_0000
      amount_end = 10_0000_0000
    end

    case rate_mark
    when 0
      rate_begin = 0
      rate_end = 10000
    when 1
      rate_begin = 1
      rate_end = 20
    when 2
      rate_begin = 20
      rate_end = 50
    when 3
      rate_begin = 50
      rate_end = 100
    when 4
      rate_begin = 100
      rate_end = 10000
    end

    [amount_begin, amount_end, rate_begin, rate_end]
  end
       
      
end
