module Users
  module Courses
    class CourseSerializer < ActiveModel::Serializer
      attributes :id,
                 :name,
                 :description,
                 :cover_url,
                 :is_subscribed,
                 :reviews,
                 :subscribes,
                 :duration,
                 :category,
                 :updated_at,
                 :lessons_learned,
                 :view_count,
                 :rating,
                 :stats
      has_one :cover, serializer: ::Shared::CoverSerializer
      has_many :lessons, serializer: Lessons::LessonSerializer

      def duration
        object.lessons.inject(0) { |sum, lesson| sum + lesson.duration }
      end

      def subscribes
        return object.course_subscribes.length
      end

      def reviews
        object.reviews.length
      end

      def view_count
        object.lessons.inject(0) { |sum, x| sum + x.view_count }
      end

      def category
        if object.category_id == nil
          return ""
        else
          return Category.find(object.category_id).name
        end
      end

      def stats
        reviews = object.reviews
        arr = []
        return 0, 0, 0, 0, 0 if reviews.length == 0
        (5).downto(1) do |x|
          tmp = reviews.where(stars: x).length / reviews.length.to_f
          arr << (tmp.truncate(2) * 100).to_i
        end
        return arr
      end

      def rating
        average =
          object.reviews.inject(0) { |sum, review| sum + review.stars } / object.reviews.size.to_f
          average.truncate(1)
      end
      
      def lessons_learned
        tmp = object.course_subscribes.where(user_id: object.user_id).take
        if tmp == nil
          return "[]"
        else
          return tmp.lessons_learned
        end
      end
    end
  end
end
