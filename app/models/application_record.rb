class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  include Uuid
  before_create :set_uuid
  after_initialize :set_uuid
end
