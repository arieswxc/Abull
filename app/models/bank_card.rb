class BankCard < ActiveRecord::Base
  validates :number,    presence: true
  validates :bank_name, presence: true
  validates :user_id,   presence: true
  belongs_to :user

  state_machine :state, initial: :pending do
    event :approve do
      transition :pending => :approved
    end

    event :update_card do
      transition :approved => :pending
    end
  end
end
