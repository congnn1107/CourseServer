module Users
  module Courses
    module Lessons
      class LessonSerializer < ActiveModel::Serializer
        attributes :id, :uuid, :name, :duration, :description, :is_done, :url, :view_count, :course_id

        def is_done
          if object.user_lessons.length==0
        end

      end
    end
  end
end
