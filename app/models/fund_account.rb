class FundAccount < ActiveRecord::Base
  validates :fund_id, presence: true
  validates :balance, presence: true
  validates :balance, numericality: true
  belongs_to :fund
end
