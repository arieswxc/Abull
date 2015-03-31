class HomsProperty < ActiveRecord::Base
  validates :date, presence: true
  validates :amount, presence: true
  validates :amount, numericality: true
  validates :homs_account, presence: true
  belongs_to :homs_account
end
