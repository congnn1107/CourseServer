module Api
  module V1
    module Admin
      class CoursesController < BaseController
        before_action :set_model, only: [:update, :show, :destroy]

        def index
          render json: Course.all, status: :ok
        end

        def create
          form = Courses::CreateForm.new(create_params)
          if form.valid?
            course = form.save
            render json: course, status: :ok
          else
            render json: { message: form.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def show
          render json: @course, status: :ok
        end

        def update
          form = Courses::UpdateForm.new(update_params)
          form.course = @course
          if form.valid?
            course = form.save
            render json: course, status: :ok
          else
            render json: { message: form.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def destroy
          @course.destroy
          render json: { message: "Destroyed!" }, status: :ok
        end

        private

        def create_params
          params.permit(:name, :description)
        end

        def update_params
          params.permit(:name, :description, :is_publish)
        end

        def set_model
          @course = Course.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { message: "Course not found!" }, status: :not_found
        end
      end
    end
  end
end
