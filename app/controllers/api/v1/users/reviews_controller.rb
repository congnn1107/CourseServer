module Api
    module V1
      module Users
        class ReviewsController < BaseController
          before_action :authenticate_user
          before_action :set_course
          # before_action :set_review, only: %i[update show destroy]

          def statistics
            @reviews = Review.all.where(course_id: params[:course_id])
            if @reviews.length == 0
              render json:nil
              return
            end

            stats = statisticize(@reviews)
            rating = average(@reviews)

            render json:{
              stats: stats,
              rating: rating
            }
          end

          def index
            @limit = params[:limit] || PER_PAGE
            @page = params[:page] || 1
  
            @pagy, @records = pagy(
              @course.reviews,
              items: @limit,
              page: @page,
            )
            @records = @records.reject{|x| x.user_id == @current_user.id}

            unless @records.empty?
              json_list_response(@records, ::Users::Courses::Reviews::ReviewSerializer)
            else
              render json:@records
            end
          end
  
          def show
            @review = Review.all.where(user_id: @current_user.id, course_id: params[:course_id]).take
            unless @review == nil
              json_response(@review, ::Users::Courses::Reviews::ReviewSerializer)
            else
              render json: false
            end
          end
  
          def create
            unless Review.all.where(user_id: @current_user.id, course_id: params[:course_id]).empty?
              render json: "You've already review this"
              return 0
            end
            @review = Review.new(create_params)
            puts "AAAAAAAAAAAAAAa"
            if @review.save
              json_response(@review, ::Users::Courses::Reviews::ReviewSerializer)
            else
              error_response(@review.errors.to_hash(true),"Error when create review!")
            end
          end
  
          def update
            @review=Review.where(user_id: @current_user.id,course_id: params[:course_id]).take
            if @review.update(update_params)
              json_response(@review, ::Users::Courses::Reviews::ReviewSerializer)
            else
              error_response(@review.errors.to_hash(true), "Error when update review!")
            end
          end
  
          def destroy
            @review=Review.where(user_id: @current_user.id,course_id: params[:course_id]).take
            if @review.destroy
              json_response(@review, ::Users::Courses::Reviews::ReviewSerializer)
            else
              error_response(@review.errors.to_hash(true), "Error when delete lesson!")
            end
          end
  
          private
  
          def create_params
            params.permit(:content, :stars).merge(user_id: @current_user.id,course_id: params[:course_id])
          end
  
          def update_params
            params.permit(:stars,:content)
          end
  
          def set_course
            @course = Course.find(params[:course_id])
          rescue ActiveRecord::RecordNotFound => e
            render json: { message: "Course not found" }, status: :not_found
          end

          def statisticize(reviews)
            arr = []
            (5).downto(1) do |x|
              tmp = reviews.where(stars: x).length/reviews.length.to_f
              arr << (tmp.truncate(2)*100).to_i
            end
            return arr
          end

          def average(reviews)
            average = reviews.inject(0){|sum,review| sum+review.stars}/reviews.size.to_f
            average.truncate(1)
          end
        end
      end
    end
  end
  