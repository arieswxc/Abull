class Leverage < ActiveRecord::Base
  validates :user_id,   presence: true
  validates :date,      presence: true
  validates :number,    presence: true
  validates :number,    numericality: true
  validates :deadline,  presence: true
  validates :state,     presence: true
  validates :state,     inclusion: { in: ["applied", "confirmed", "closed"] }
  belongs_to :user
end
