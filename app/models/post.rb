class Post < ApplicationRecord

  belongs_to :user
  default_scope -> { order(date: :desc) }
  attr_accessor :working_hours, :working_minutes

  validates :date, presence: true, uniqueness: { scope: :user_id }
  validates :memo, length: { maximum: 40 }
  validates :working_total, presence: true
  validates :working_hours, presence: true,
                            numericality: { only_integer: true,
                                    greater_than_or_equal_to: 0,
                                    less_than_or_equal_to: 23 }
  validates :working_minutes, presence: true,
                              numericality:  { only_integer: true,
                                    greater_than_or_equal_to: 0,
                                    less_than_or_equal_to: 59 }

  # working_hoursを「分」単位に変換し、working_minutesと足し算してworking_totalを算出する
  def caluculate_working_total
    self.working_total = (working_hours.to_i * 60) + working_minutes.to_i
  end

  # working_totalをworking_hoursとworking_minutesに分解する
  def convert_working_total
    self.working_hours = working_total / 60
    self.working_minutes = working_total % 60
  end
end
