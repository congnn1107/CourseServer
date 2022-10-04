module Api
  module V1
    module Admin
      class SessionsController < BaseController
        skip_before_action :authenticate_user
        skip_before_action :admin_user

        def create
          # login admin
          form = LoginForm.new(login_params)

          if form.valid?
            user = form.login

            if user
              token = user.create_token

              render json: { token: token }, status: :ok
            else
              render json: { message: "Invalid information!" }, status: :unauthorized
            end
          else
            render json: { message: form.errors.full_messages }, status: :unprocessable_entity
          end
        end

        private

        def login_params
          params.permit(:email, :password)
        end
      end
    end
  end
end
