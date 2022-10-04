module Api
  module V1
    module Users
      class LoginForm < BaseForm
        attr_accessor :email, :password
        validates :email, :password, presence: true

        def login
          user = User.find_by(email: email)

          if user&.valid_password?(password)
            return user
          else
            return false
          end
        end
      end
    end
  end
end
