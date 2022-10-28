class Lesson < ApplicationRecord
  include Uuid
  before_create :set_uuid
  belongs_to :course

  has_many :user_lessons

  validates :name, presence: true
end
