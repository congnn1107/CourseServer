module Users
  module Courses
    module CourseSubscribes
      class CourseSubscribeSerializer < ActiveModel::Serializer
        attributes :id,:course_id,:user_id
      end
    end
  end
end
