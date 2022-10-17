module Api
  module V1
    module Admin
      class UsersController < BaseController
        before_action :set_model, only: %i[update show destroy]

        def index
          @limit = params[:limit] || PER_PAGE
          @page = params[:page] || 1

          @pagy, @records = pagy(
            User.users,
            items: @limit,
            page: @page
          )

          json_list_response(@records, UserSerializer)
        end

        def show
          json_response(@user, UserSerializer)
        end

        def create
          @user = User.users.new(create_params)

          if @user.save
            json_response(@user, UserSerializer)
          else
            error_response(@user.errors.to_hash(true), 'Error when create user')
          end
        end

        def update
          if @user.update(update_params)
            json_response(@user, UserSerializer)
          else
            error_response(@user.errors.to_hash(true), 'Error when update user')
          end
        end

        def destroy
          if @user.destroy
            json_response(message: 'ok')
          else
            error_response(@user.errors.to_hash(true), 'Error when destroy user')
          end
        end

        private

        def create_params
          params.permit(:email, :password, :date_of_birth, :name)
        end

        def update_params
          params.permit(:name, :date_of_birth)
        end

        def set_model
          @user = User.users.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { message: 'User not found!' }, status: :not_found
        end
      end
    end
  end
end
