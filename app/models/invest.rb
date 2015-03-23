class Invest < ActiveRecord::Base
  # validates :user_id, presence: true
  validates :fund_id, presence: true
  validates :date,    presence: true
  validates :amount,  presence: true
  validates :amount,  numericality: true
  belongs_to :user
  belongs_to :fund
end
