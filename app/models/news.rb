class News < ActiveRecord::Base
  validates :title, presence: true
  before_validation :save_date

  private
    def save_date
      self.date = Time.now
    end
end
