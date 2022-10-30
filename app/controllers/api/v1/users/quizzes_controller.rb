module Api
  module V1
    module Users
      class QuizzesController < BaseController
        before_action :authenticate_user

        before_action :set_course
        before_action :set_quiz, only: %i[show update destroy]


        def submit
          submission = Submission.find(params[:submission_id])
          if Time.now-submission.created_at > 60
            render json: "Time out, cannot submit"
            return   
          end 
          questions = Quiz.find(params[:quiz_id]).questions
          arr = []
          a = 0
          questions.each do |ques|
            ques.answers.each do |ans|
              if ans.correct == true
                arr << ans.id
              end
            end
          end
          arr.each_with_index do |x,index|
            if x == params[:solutions][index]
              a=a+10
            end
          end

          submission = Submission.find(params[:submission_id])
          submission.update(score: a)
          render json:{
            score:a,
            solutions:arr
          }
        end 

        def start
          submission = Submission.where(quiz_id: params[:quiz_id],user_id: @current_user.id).take
          if submission !=nil
            submission.update(created_at: Time.now)
            render json:submission
            return
          end

          submission = Submission.new(quiz_id: params[:quiz_id],user_id: @current_user.id)
          if submission.save
            render json:submission
          end
        end

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
