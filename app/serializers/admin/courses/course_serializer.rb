module Admin
  module Courses
    class CourseSerializer < ActiveModel::Serializer
      attributes :id, :uuid, :name, :description,
                 :cover_url, :status, :is_publish, :published_at,
                 :created_at, :updated_at,:category,:category_id
      has_one :cover, serializer: ::Shared::CoverSerializer
      has_many :lessons, serializer: Lessons::LessonSerializer
      has_many :quizzes, each_serializer: Quizzes::QuizSerializer
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
