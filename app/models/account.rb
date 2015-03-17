class Account < ActiveRecord::Base
  validates :user_id, presence: true
  validates :user, presence: true
  validates :balance, presence: true
  validates :balance, numericality: true
  belongs_to :user
end
