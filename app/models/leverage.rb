class Leverage < ActiveRecord::Base
  validates :user_id,       presence: true
  validates :amount,        presence: true
  validates :amount,        numericality: true
  validates :duration,      presence: true
  validates :state,         presence: true
  validates :state,         inclusion: { in: ["applied", "confirmed", "denied", "closed"] }
  validates :interest_id,   presence: true
  belongs_to :user
  belongs_to :interest

  acts_as_commentable

  state_machine :state, :initial => :applied do
    event :confirm do
      transition :applied => :confirmed
    end
    event :deny do
      transition :applied  => :denied
    end
    event :close do 
      transition :confirmed => :closed
    end
  end

  def send_sms(mobile, type, params)
    SMSGateway.render_then_send(mobile, type, params)
  end

  def deadline 
    self.date.advance(months: self.duration, days: -1) if date
  end

  def save_interest
    interest = self.interest
    self.duration = interest.duration
    self.rate = interest.interest_rate
    self.leverage_amount = self.amount * interest.leverage_time
    self.total_interests = self.leverage_amount * self.duration * self.rate / 100
    self.save
  end


  private
    def valid_deadline
      if deadline && deadline <= Time.now
        self.errors.add :deadline, I18n.t('invalid_date')
      end
    end
end
