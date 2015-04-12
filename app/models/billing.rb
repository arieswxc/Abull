class Billing < ActiveRecord::Base
  validates :account_id,    presence: true
  validates :account,       presence: true
  validates :amount,        presence: true
  validates :amount,        numericality: true
  validates :billing_number, uniqueness: true
  # validates :billable_id,   presence: true
  validates :billing_type,  presence: true
  belongs_to :account
  belongs_to :billable, polymorphic: true

  state_machine :state, :initial => :pending do
    event :confirm do
      transition :pending => :confirmed
    end

    event :deny do
      transition :pending => :denied
    end

    event :cancel do
      transition :pending => :cancelled
    end
  end

  after_save do
    update_column(:billing_number, (DateTime.now.strftime(" %Y%m%d%H%M%S%L") + self.id.to_s)) if self.billing_number.nil?
  end
end
