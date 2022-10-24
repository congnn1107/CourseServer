module Api
  module V1
    module Admin
      class AnswersController < BaseController
        before_action :authenticate_user
        before_action :admin_user

        before_action :set_question
        before_action :set_answer, only: %i[show update destroy]

        def index
          @limit = params[:limit] || PER_PAGE
          @page = params[:page] || 1

          @pagy, @records = pagy(
            @question.answers,
            items: @limit,
            page: @page,
          )

          json_list_response(@records, ::Admin::Courses::Quizzes::Questions::Answers::AnswerSerializer)
        end

        def show
          json_response(@question, ::Admin::Courses::Quizzes::Questions::Answers::AnswerSerializer)
        end

        def create
          @answer = Answer.new(answer_params)

          if @answer.save
            json_response(@answer, ::Admin::Courses::Quizzes::Questions::Answers::AnswerSerializer)
          else
            error_response(@answer.errors.to_hash(true), "Error when create answer!")
          end
        end

        def update
          if @answer.update(answer_params)
            json_response(@answer, ::Admin::Courses::Quizzes::Questions::Answers::AnswerSerializer)
          else
            error_response(@answer.errors.to_hash(true), "Error when update quiz!")
          end
        end

        def destroy
          if @answer.destroy
            json_response(@answer, ::Admin::Courses::Quizzes::Questions::Answers::AnswerSerializer)
          else
            error_response(@answer.errors.to_hash(true), "Error when delete quiz!")
          end
        end

        private

        def answer_params
          params.permit(:content, :correct, :question_id)
        end

        def set_question
          @question = Question.find(params[:question_id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { message: "Quiz not found!" }, status: :not_found
        end

        def set_answer
          @answer = @question.answers.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { message: "Question not found!" }, status: :not_found
        end
      end
    end
  end
end
