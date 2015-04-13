class FundAccount < ActiveRecord::Base
  validates :fund_id, presence: true
  validates :balance, presence: true
  validates :balance, numericality: {greater_than_or_equal_to: 0}
  belongs_to :fund
end
