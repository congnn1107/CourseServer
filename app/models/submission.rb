class Submission < ApplicationRecord
  belongs_to :quiz
  belongs_to :user, optional: true

  has_many :submission_details, dependent: :destroy
  has_many :submission_answers, through: :submission_details
  
end
