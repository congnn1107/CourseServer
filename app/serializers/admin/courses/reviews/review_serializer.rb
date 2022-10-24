class Admin::Courses::Reviews::ReviewSerializer < ActiveModel::Serializer
  attributes :id,:content, :stars
  has_one :user
  def user
    return 2
  end
end
