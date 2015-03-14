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
end