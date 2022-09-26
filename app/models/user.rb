require "jwt"

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable

  TOKEN_EXPIRE = 15.days.from_now.to_i

  scope :users, -> { where(is_admin: false) }

  def create_token
    JWT.encode({ id: id, exp: TOKEN_EXPIRE }, Rails.application.secrets.secret_key_base)
  end
end
