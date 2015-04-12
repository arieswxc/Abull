class HomsAccount < ActiveRecord::Base
	validates :title,     presence: true
  # validates :password,  presence: true
  validates :fund_id,   presence: true
  validates :amount,    presence: true
  validates :amount,    numericality: {greater_than_or_equal_to: 0}
  belongs_to :fund
  has_many :homs_properties
end
