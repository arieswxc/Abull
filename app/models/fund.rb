class Fund < ActiveRecord::Base
  # validates :name,                presence: true
  validates :user_id,             presence: true
  validates :amount,              presence: true
  validates :amount,              numericality: true
  validates :collection_deadline, presence: true
  validates :earning,             numericality: true
  validates :state,               presence: true
  validates :state,               inclusion: { in: ["pending", "applied", "gathering", "reached", "opened", "running", "finished", "closed", "denied"] }
  validates :private_check,       inclusion: { in: ["private", "public"] }
  validates :invest_starting_date, presence: true
  validates :invest_ending_date,  presence: true
  belongs_to  :user
  has_many    :invests

  before_validation :generate_fundname, on: :create
  acts_as_commentable

  state_machine :state, :initial => :pending do
    event :apply do
      transition [:pending, :denied]  => :applied
    end

    event :approve do
      transition :applied => :gathering
    end

    event :deny do
      transition :applied => :denied
    end

    event :reach do
      transition :gathering => :reached
    end

    event :open_homs do
      transition :reached => :opened
    end

    event :run do
      transition :opened => :running
    end

    event :finish do
      transition :running => :finished
    end

    event :close do
      transition all => :closed
    end

    event :reset do
      transition :closed => :pending
    end
  end

  has_one :homs_account

  def invest_ending_date
    self.invest_starting_date.advance(days: self.duration)
  end

  private
  def generate_fundname
    if self.name.blank?
      record = true
      while record
        random = rand(1000000000).to_s.rjust(9, '0')
        record = Fund.where(name: random).first
      end
      self.name = random
    end
    self.name
  end

end
