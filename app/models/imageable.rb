class Imageable < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :target, polymorphic: true

  has_one_attached :file, dependent: :destroy

  def file_url
    return if file.blank?
    url_for(file)
  end
end
