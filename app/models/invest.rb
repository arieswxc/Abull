class Invest < ActiveRecord::Base
  validates :user_id, presence: true
  validates :fund_id, presence: true
  validates :date,    presence: true
  validates :number,  presence: true
  validates :number,  numericality: true
  belongs_to :user
  belongs_to :fund
end
