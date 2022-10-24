module Users
  module Courses
    class CourseSerializer < ActiveModel::Serializer
      attributes :id,:name, :description,
                 :cover_url,:is_subscribe
      has_one :cover, serializer: ::Shared::CoverSerializer
      
      def is_subscribe
        return object.flag
      end
    end
  end
end
