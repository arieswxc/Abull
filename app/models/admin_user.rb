class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable,:authentication_keys => [:cell]
  validates :role, presence: true
  validates :role, inclusion: { in: ["risk_controller", "teller", "account_manager", "customer_service"] }
  def email_required?
    false
  end
end
