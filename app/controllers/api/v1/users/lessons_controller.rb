module Api
  module V1
    module Users
      class LessonsController < BaseController
        before_action :authenticate_user
        before_action :set_lesson

        def update
          if @lesson.update(view_count: @lesson.view_count + 1)
            json_response(@lesson, ::Admin::Courses::Lessons::LessonSerializer)
          else
            error_response(
              @lesson.errors.to_hash(true),
              "Error when update lesson!",
            )
          end
        end

        private

        def set_lesson
          @lesson = Lesson.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { message: "Lesson not found!" }, status: :not_found
        end
      end
    end
  end
end
