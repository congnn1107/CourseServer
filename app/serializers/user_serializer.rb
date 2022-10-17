class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name,
             :date_of_birth
end
