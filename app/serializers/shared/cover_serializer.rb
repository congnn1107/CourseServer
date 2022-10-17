module Shared
  class CoverSerializer < ActiveModel::Serializer
    attributes :id, :created_at, :updated_at, :file_url
  end
end
