module Admin
  module Courses
    class CourseSerializer < ActiveModel::Serializer
      attributes :id, :uuid, :name, :description,
                 :cover_url, :status, :is_publish, :published_at,
                 :created_at, :updated_at
      has_one :cover, serializer: ::Shared::CoverSerializer
      has_many :lessons, each_serializer: Lessons::LessonSerializer
      has_many :quizzes, each_serializer: Quizzes::QuizSerializer
    end
  end
end
