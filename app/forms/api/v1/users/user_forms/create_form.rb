module Api
  module V1
    module Users
      module UserForms
        class CreateForm < BaseForm
          attr_accessor :name, :email, :password, :password_confirmation

          validates :name, :email, :password, :password_confirmation, presence: true
          validates :name, length: { minimum: 5, maximum: 256 }
          validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
          validates :password, length: { minimum: 8 }
          validates_confirmation_of :password
          validate :uniqueness_email

          def create
            if valid?
              user = User.new(attributes)
              if user.save
                return user
              else
                return false
              end
            end
          end

          private

          def attributes
            {
              name: name,
              email: email,
              password: password,
              password_confirmation: password_confirmation
            }
          end

          def uniqueness_email
            errors.add(:email, "is already taken!") if User.exists?(email: email)
          end
        end
      end
    end
  end
end
