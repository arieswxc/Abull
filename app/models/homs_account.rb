class HomsAccount < ActiveRecord::Base
	validates :title,    presence: true
  validates :password, presence: true
  belongs_to :fund
end
