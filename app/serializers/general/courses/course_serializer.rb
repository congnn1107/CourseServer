module General
  module Courses
    class CourseSerializer < ActiveModel::Serializer
      attributes :id,:name, :description,
                 :cover_url,:is_subscribed,:reviews,:rating,:subscribes,:duration,:category,:updated_at
      has_one :cover, serializer: ::Shared::CoverSerializer

      def rating
        arr = object.reviews
        average = arr.inject(0){|sum,review| sum+review.stars}/arr.size.to_f
        average.truncate(1)
      end

      def duration
        object.lessons.inject(0) {|sum,lesson| sum+lesson.duration}
      end

      def subscribes
        return object.course_subscribes.length
      end

      def reviews
        object.reviews.length
      end

      def is_subscribed
        object.course_subscribes.empty? ? false :true
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
