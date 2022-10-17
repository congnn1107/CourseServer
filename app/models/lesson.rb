class Lesson < ApplicationRecord
  include Uuid
  before_create :set_uuid

  belongs_to :course

  validates :name, presence: true
end
