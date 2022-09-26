class Exam < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :test, optional: true

  def start
    touch(:start_at)
    update_attribute(:expire_at, start_at + test.duration.minutes)
  end
end
