module Api
  module V1
    module Users
      class CoursesController < BaseController
        before_action :set_model, only: [:show]

        def index
          @limit = params[:limit] || PER_PAGE
          @page = params[:page] || 1

          @pagy, @records = pagy(
            Course.all,
            items: @limit,
            page: @page,
          )
          # render json: :Users::Courses::CourseSerializer.new(
          #   Area.all, 
          #   { params: { paginate: paginate(pagy), current_user: @current_user } }
          #     )
          # render json: @subscribes
          # render json: @records, each_serializer: ::Users::Courses::CourseSerializer, current_user: @current_user
          json_list_response(@records, ::Users::Courses::CourseSerializer)
        end

        def show
          json_response(@course, ::Users::Courses::CourseSerializer)
        end


        private

        def set_model
          @course = Course.includes(:cover).find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { message: "Course not found !" }, status: :not_found
        end
      end
    end
  end
end
