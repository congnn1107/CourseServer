class Course < ApplicationRecord
  include Uuid

  before_create :set_uuid

  has_one :cover, as: :target, dependent: :destroy, class_name: :Imageable

  has_many :lessons, dependent: :destroy
end
