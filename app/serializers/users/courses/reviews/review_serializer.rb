class Users::Courses::Reviews::ReviewSerializer < ActiveModel::Serializer
  attributes :id,:content, :course_id, :user_id, :stars

  has_one :user
end
