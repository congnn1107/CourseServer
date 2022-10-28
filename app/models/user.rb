require 'jwt'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable

  validates :email, :name, :date_of_birth, presence: true, unless: -> { new_record? }
  validates :password, presence: true, if: -> { new_record? }
  validates :email, uniqueness: true

  TOKEN_EXPIRE = 15.days.from_now.to_i

  scope :users, -> { }
  scope :admins, -> { where(is_admin: true) }

  def create_token
    JWT.encode({ id:, exp: TOKEN_EXPIRE }, Rails.application.secrets.secret_key_base)
  end
  has_many :reviews, dependent: :destroy
  has_many :course_subscribes, dependent: :destroy
end
