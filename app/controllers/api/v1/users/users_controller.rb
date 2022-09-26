module Api
  module V1
    module Users
      class UsersController < BaseController
        skip_before_action :authenticate_user, only: :create

        def create
          form = UserForms::CreateForm.new(user_params)
          if form.valid?
            user = form.create
            if !!user
              render json: user, status: :ok
            else
              render json: { message: "Can not create user!" }, status: :unprocessable_entity
            end
          else
            render json: { message: form.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def show
          render json: @current_user, status: :ok
        end

        private

        def user_params
          params.permit(:name, :email, :password, :password_confirmation)
        end
      end
    end
  end
end
