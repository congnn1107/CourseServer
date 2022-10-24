class Course < ApplicationRecord
  attr_accessor :flag
  include Uuid

  before_create :set_uuid

  has_one :course_category, dependent: :destroy
  has_one :cover, as: :target, dependent: :destroy, class_name: :Imageable

  has_many :lessons, dependent: :destroy
  has_many :quizzes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :course_subscribes, dependent: :destroy
end
