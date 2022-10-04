module Api
  module V1
    module Admin
      class LoginForm < BaseForm
        attr_accessor :email, :password
        validates :email, :password, presence: true

        def login
          admin = User.admins.find_by(email: email)

          if admin&.valid_password?(password)
            return admin
          else
            return false
          end
        end
      end
    end
  end
end