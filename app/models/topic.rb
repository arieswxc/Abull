class Topic < ActiveRecord::Base
  validates :user_id, presence: true
  validates :title,   presence: true
  belongs_to :user

  before_save :save_date

  acts_as_commentable

  private
    def save_date
      self.date = Time.now unless self.date
    end
end
