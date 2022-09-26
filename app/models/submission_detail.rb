class SubmissionDetail < ApplicationRecord
  belongs_to :submission
  has_one :question
end
