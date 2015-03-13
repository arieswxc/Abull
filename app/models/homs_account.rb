class HomsAccount < ActiveRecord::Base
	validates :title,     presence: true
  validates :password,  presence: true
  validates :fund_id,   presence: true
  belongs_to :fund
end
