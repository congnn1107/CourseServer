module Admin
  module Courses
    module Lessons
      class LessonSerializer < ActiveModel::Serializer
        attributes :id, :uuid, :duration, :description, :url, :view_count, :course_id
      end
    end
  end
end
