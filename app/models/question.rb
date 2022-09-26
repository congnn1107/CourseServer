class Question < ApplicationRecord
  belongs_to :question_type, optional: true
  has_and_belongs_to_many :tests
  has_many :answers
end
