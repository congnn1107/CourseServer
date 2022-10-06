class Course < ApplicationRecord
  before_create :set_uuid

  has_one :cover, as: :target, dependent: :destroy, class_name: :Imageable

  private

  def set_uuid
    self.uuid = UUIDTools::UUID.timestamp_create.to_s
  end
end
