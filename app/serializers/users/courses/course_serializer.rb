module Users
  module Courses
    class CourseSerializer < ActiveModel::Serializer
      attributes :id,:name, :description,
                 :cover_url,:is_subscribed,:reviews
      has_one :cover, serializer: ::Shared::CoverSerializer
      
      def reviews
        object.reviews.length
      end
      def is_subscribed
        object.course_subscribes.empty? ? false :true
      end
    end
  end
end
