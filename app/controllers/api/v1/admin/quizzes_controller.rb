module Api
  module V1
    module Admin
      class QuizzesController < BaseController
        before_action :authenticate_user
        before_action :admin_user

        before_action :set_course
        before_action :set_quiz, only: %i[show update destroy]

        def index
          @limit = params[:limit] || PER_PAGE
          @page = params[:page] || 1

          @pagy, @records = pagy(
            @course.quizzes,
            items: @limit,
            page: @page,
          )

          json_list_response(@records, ::Admin::Courses::Quizzes::QuizSerializer)
        end

        def show
          json_response(@quiz, ::Admin::Courses::Quizzes::QuizSerializer)
        end

        def create
          @quiz = Quiz.new(quiz_params)

          if @quiz.save
            json_response(@quiz, ::Admin::Courses::Quizzes::QuizSerializer)
          else
            error_response(@quiz.errors.to_hash(true), "Error when create quiz!")
          end
        end

        def update
          if @quiz.update(quiz_params)
            json_response(@quiz, ::Admin::Courses::Quizzes::QuizSerializer)
          else
            error_response(@quiz.errors.to_hash(true), "Error when update quiz!")
          end
        end

        def destroy
          if @quiz.destroy
            json_response(@quiz, ::Admin::Courses::Quizzes::QuizSerializer)
          else
            error_response(@quiz.errors.to_hash(true), "Error when delete quiz!")
          end
        end

        private

        def quiz_params
          params.permit(:name, :description, :time, :course_id, :lesson_id, :id)
        end

        def set_course
          @course = Course.find(params[:course_id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { message: "Course not found!" }, status: :not_found
        end

        def set_quiz
          @quiz = @course.quizzes.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { message: "Quiz not found!" }, status: :not_found
        end
      end
    end
  end
end
