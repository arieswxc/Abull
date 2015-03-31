class HomsAccount < ActiveRecord::Base
	validates :title,     presence: true
  # validates :password,  presence: true
  validates :fund_id,   presence: true
  validates :amount,    presence: true
  validates :amount,    numericality: true
  belongs_to :fund
end
