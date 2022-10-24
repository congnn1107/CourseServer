class Quiz < ApplicationRecord
  include Uuid
  before_create :set_uuid

  belongs_to :lesson

  has_many :questions, dependent: :destroy

  validates :name, presence: true
end
