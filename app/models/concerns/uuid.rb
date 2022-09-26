module Uuid
  extend ActiveSupport::Concern
  def set_uuid
    self.uuid ||= UUIDTools::UUID.timestamp_create.to_s if self.respond_to? :uuid
  end
end