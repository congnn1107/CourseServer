module Users
  module Courses
    class CourseSerializer < ActiveModel::Serializer
      attributes :id,:name, :description,
                 :cover_url,:is_subscribed,:reviews,:subscribes,:duration,:category,:updated_at
      has_one :cover, serializer: ::Shared::CoverSerializer
      has_many :lessons,  serializer: Lessons::LessonSerializer

      def duration
        object.lessons.inject(0) {|sum,lesson| sum+lesson.duration}
      end

      def subscribes
        return object.course_subscribes.length
      end

      def reviews
        object.reviews.length
      end

      def category
        if object.category_id == nil
          return ""
        else
          return Category.find(object.category_id).name
        end
      end
    end
  end
end
