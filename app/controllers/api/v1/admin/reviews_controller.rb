module Api
    module V1
      module Admin
        class ReviewsController < BaseController
          before_action :authenticate_user, :admin_user
          before_action :set_course
          before_action :set_review, only: %i[update show destroy]

          def index
            @limit = params[:limit] || PER_PAGE
            @page = params[:page] || 1
  
            @pagy, @records = pagy(
              @course.reviews,
              items: @limit,
              page: @page,
            )
  
            json_list_response(@records, ::Admin::Courses::Reviews::ReviewSerializer)
          end
  
          def show
            json_response(@lesson, ::Admin::Courses::Reviews::ReviewSerializer)
          end
  
          def create
            @review = Review.new(create_params)
  
            if @review.save
              json_response(@review, ::Admin::Courses::Reviews::ReviewSerializer)
            else
              error_response(@review.errors.to_hash(true),"Error when create review!")
            end
          end
  
          def update
            if @review.update(update_params)
              json_response(@review, ::Admin::Courses::Reviews::ReviewSerializer)
            else
              error_response(@review.errors.to_hash(true), "Error when update review!")
            end
          end
  
          def destroy
            if @review.destroy
              json_response(@review, ::Admin::Courses::Reviews::ReviewSerializer)
            else
              error_response(@review.errors.to_hash(true), "Error when delete lesson!")
            end
          end
  
          private
  
          def create_params
            params.permit(:course_id, :content, :stars, :user_id)
          end
  
          def update_params
            params.permit(:stars,:content)
          end
  
          def set_course
            @course = Course.find(params[:course_id])
          rescue ActiveRecord::RecordNotFound => e
            render json: { message: @current_user }, status: :not_found
          end
  
          def set_review
            @review = @course.reviews.find(params[:id])
          rescue ActiveRecord::RecordNotFound => e
            render json: { message: @current_user}, status: :not_found
          end
        end
      end
    end
  end
  