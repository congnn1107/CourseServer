class QuestionType < ApplicationRecord
  has_many :questions, dependent: :nullify
end
