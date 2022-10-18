module Admin
  module Courses
    module Quizzes
      class QuizSerializer < ActiveModel::Serializer
        attributes :id, :uuid, :name, :description, :time, :course_id, :lesson_id
      end
    end
  end
end
