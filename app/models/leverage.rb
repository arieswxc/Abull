class Leverage < ActiveRecord::Base
  validates :user_id,   presence: true
  validates :date,      presence: true
  validates :number,    presence: true
  validates :number,    numericality: true
  validates :deadline,  presence: true
  validate  :valid_deadline
  validates :state,     presence: true
  validates :state,     inclusion: { in: ["applied", "confirmed", "closed"] }
  belongs_to :user



  private
    def valid_deadline
      if deadline && deadline <= Time.now
        self.errors.add :deadline, I18n.t('invalid_date')
      end
    end
end