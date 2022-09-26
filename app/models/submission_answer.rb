class SubmissionAnswer < ApplicationRecord
  belongs_to :submission_detail
  has_one :answer
  has_one :question
  

end
