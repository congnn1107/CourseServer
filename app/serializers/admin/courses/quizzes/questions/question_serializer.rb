class Admin::Courses::Quizzes::Questions::QuestionSerializer < ActiveModel::Serializer
  attributes :id,:content
  has_many :answers
end
