module Api
  module V1
    module Admin
      class LessonsController < BaseController
        before_action :authenticate_user, :admin_user
        before_action :set_course
        before_action :set_lesson, only: %i[update show destroy]

        def index
          @limit = params[:limit] || PER_PAGE
          @page = params[:page] || 1

          @pagy, @records = pagy(
            Lesson.all,
            items: @limit,
            page: @page,
          )

          json_list_response(@records, ::Admin::Courses::Lessons::LessonSerializer)
        end

        def show
          json_response(@lesson, ::Admin::Courses::Lessons::LessonSerializer)
        end

        def create
          @lesson = Lesson.new(create_params)

          if @lesson.save
            json_response(@lesson, ::Admin::Courses::Lessons::LessonSerializer)
          else
            error_response(@lesson.errors.to_hash(true), "Error when create lesson!")
          end
        end

        def update
          if @lesson.update(update_params)
            json_response(@lesson, ::Admin::Courses::Lessons::LessonSerializer)
          else
            error_response(@lesson.errors.to_hash(true), "Error when update lesson!")
          end
        end

        def destroy
          if @lesson.destroy
            json_response(@lesson, ::Admin::Courses::Lessons::LessonSerializer)
          else
            error_response(@lesson.errors.to_hash(true), "Error when update lesson!")
          end
        end

        private

        def create_params
          params.permit(:course_id, :name, :description, :duration, :url)
        end

        def update_params
          params.permit(:name, :description, :duration, :url)
        end

        def set_course
          @course = Course.find(params[:course_id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { message: "Course not found!" }, status: :not_found
        end

        def set_lesson
          @lesson = @course.lessons.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { message: "Lesson not found!" }, status: :not_found
        end
      end
    end
  end
end
