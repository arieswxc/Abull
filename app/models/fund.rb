class Fund < ActiveRecord::Base
  validates :name,                presence: true
  validates :user_id,             presence: true
  validates :amount,              presence: true
  validates :amount,              numericality: true
  validates :collection_deadline, presence: true
  validates :earning,             numericality: true
  validates :state,               presence: true
  validates :state,               inclusion: { in: ["on", "off"] }
  validates :private_check,       inclusion: { in: [true, false] }
  validates :invest_starting_date, presence: true
  validates :invest_ending_date,  presence: true
  belongs_to  :user
  has_many    :invests
end
