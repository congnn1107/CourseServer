module Api
  module V1
    module Users
      class CourseSubscribesController < BaseController
        before_action :set_model, only: %i[update show destroy]

        def index
          @limit = params[:limit] || PER_PAGE
          @page = params[:page] || 1

          @pagy, @records =
            pagy(CourseSubscribe.all, items: @limit, page: @page)
          json_list_response(
            @records,
            ::Users::Courses::CourseSubscribes::CourseSubscribeSerializer,
          )
        end

        def create
          # lessons = Lesson.where(course_id: params[:id])
          # lessons.each do |x|
          #   lesson = UserLesson.new(user_id: @current_user.id, lesson_id: x.id)
          #   lesson.save
          # end

          lessons = UserLesson.all
          lessons.each { |x| x.update(user_id: @current_user.id) }

          unless CourseSubscribe.where(
                   course_id: params[:id],
                   user_id: @current_user.id,
                 ).empty?
            render json: "You've already subscribed it before"
            return
          end

          subscribe =
            CourseSubscribe.new(
              course_id: params[:id],
              user_id: @current_user.id,
            )

          if subscribe
            subscribe.save
            render json: subscribe
          else
            render json: { message: "Error" }, status: :unprocessable_entity
          end
        end

        def show
          json_response(@course, ::Admin::Courses::CourseSerializer)
        end

        def update
          # handling upload file
          subscribe =
            CourseSubscribe.where(
              user_id: @current_user.id,
              course_id: params[:id],
            ).take
          subscribe.update(lessons_learned: params[:lessons_learned])
          render json: subscribe
        end

        def destroy
          @course.destroy

          render json: { message: "Destroyed!" }, status: :ok
        end

        private

        def create_params
          params.permit(:course_id)
        end

        def update_params
          params.permit(:name, :description, :is_publish, :cover_url)
        end

        def set_model
          @course = Course.includes(:cover).find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { message: "Course not found!" }, status: :not_found
        end
      end
    end
  end
end
