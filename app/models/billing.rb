class Billing < ActiveRecord::Base
  validates :account_id,    presence: true
  validates :amount,        presence: true
  validates :amount,        numericality: true
  validates :billable_id,   presence: true
  validates :billing_type,  presence: true
  belongs_to :account
  belongs_to :billable, polymorphic: true
end
