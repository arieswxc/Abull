class Interest < ActiveRecord::Base
  validates :leverage_time, presence: true
  validates :leverage_time, numericality: true
  validates :amount, presence: true
  validates :amount, numericality: true
  validates :duration, presence: true
  validates :duration, numericality: true
  validates :interest_rate, presence: true
  validates :interest_rate, numericality: true
  validates :managerment_fee, numericality: true
  validates :show, presence: true
  validates :show, inclusion: {in: ["true", "false"]}

  has_many :leverages
  
  def self.query(amount, leverage_time, duration)
    amount_array = Interest.where(show: "true").order(amount: :desc)
    amount_array.each do |item|
      if amount.to_f >= item.amount
        amount = item.amount
        break
      end
    end
    
    Interest.where("amount = ? and leverage_time = ? and duration = ?", amount, leverage_time, duration).where(show: "true").first
  end



end