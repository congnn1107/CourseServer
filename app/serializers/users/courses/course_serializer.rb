module Users
  module Courses
    class CourseSerializer < ActiveModel::Serializer
      attributes :id,:name, :description,
                 :cover_url,:is_subscribed,:reviews,:rating,:subscribes,:duration,:category,:updated_at,:stats
      has_one :cover, serializer: ::Shared::CoverSerializer
      has_many :lessons

      def rating
        arr = object.reviews
        average = arr.inject(0){|sum,review| sum+review.stars}/arr.size.to_f
        average.truncate(1)
      end

      def stats
        arr = []
        (1..5).each do |x|
          if object.reviews.length == 0
            arr << 0
          else
            tmp = object.reviews.where(stars: x).length/object.reviews.length.to_f
            arr << (tmp.truncate(2)*100).to_i
          end
        end
        return arr
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
