module Api
  module V1
    module Admin
      class QuestionsController < BaseController
        before_action :authenticate_user
        before_action :admin_user

        before_action :set_quiz
        before_action :set_question, only: %i[show update destroy]

        def index
          @limit = params[:limit] || PER_PAGE
          @page = params[:page] || 1

          @pagy, @records = pagy(
            @quiz.questions,
            items: @limit,
            page: @page,
          )

          json_list_response(@records, ::Admin::Courses::Quizzes::Questions::QuestionSerializer)
        end

        def show
          json_response(@question, ::Admin::Courses::Quizzes::Questions::QuestionSerializer)
        end

        def create
          @question = Question.new(question_params)

          if @question.save
            json_response(@question, ::Admin::Courses::Quizzes::Questions::QuestionSerializer)
          else
            error_response(@question.errors.to_hash(true), "Error when create quiz!")
          end
        end

        def update
          if @question.update(question_params)
            json_response(@question, ::Admin::Courses::Quizzes::Questions::QuestionSerializer)
          else
            error_response(@question.errors.to_hash(true), "Error when update quiz!")
          end
        end

        def destroy
          if @question.destroy
            json_response(@question, ::Admin::Courses::Quizzes::Questions::QuestionSerializer)
          else
            error_response(@question.errors.to_hash(true), "Error when delete quiz!")
          end
        end

        private

        def question_params
          params.permit(:content, :score, :lesson_id, :quiz_id)
        end

        def set_quiz
          @quiz = Quiz.find(params[:quiz_id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { message: "Quiz not found!" }, status: :not_found
        end

        def set_question
          @question = @quiz.questions.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { message: "Question not found!" }, status: :not_found
        end
      end
    end
  end
end
