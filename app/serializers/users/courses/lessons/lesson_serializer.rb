module Users
  module Courses
    module Lessons
      class LessonSerializer < ActiveModel::Serializer
        attributes :id, :uuid, :name, :duration, :description, :url, :view_count, :course_id
      end
    end
  end
end
