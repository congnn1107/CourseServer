class Admin::Courses::Quizzes::Questions::Answers::AnswerSerializer < ActiveModel::Serializer
  attributes :id,:content,:question_id
end
