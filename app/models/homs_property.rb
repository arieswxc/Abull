class HomsProperty < ActiveRecord::Base
  validates :date, presence: true
  validates :date, uniqueness: { scope: :homs_account }
  validates :amount, presence: true
  validates :amount, numericality: true
  validates :homs_account, presence: true
  belongs_to :homs_account

  after_save do
    self.homs_account.update(amount: self.amount)
  end
end
