module Api
  module V1
    module Users
      class CoursesController < BaseController
        before_action :set_model, only: [:show]

        def search
          @category = Category.where(name: params[:category].titleize).take
          @search_results = Course.where(category_id: @category.id)

          # render json: CourseSubscribe.where(user_id: @current_user.id)
          # return

          if params[:criteria] == "New"
            @search_results = @search_results.order("created_at desc")
          end

          @limit = params[:limit] || PER_PAGE
          @page = params[:page] || 1

          @pagy, @records = pagy(
            @search_results,
            items: @limit,
            page: @page,
          )

          @records.each do |x|
            if CourseSubscribe.where(user_id: @current_user.id,course_id: x.id).empty?
              x.is_subscribed =false
            else
              x.is_subscribed =true
            end
          end

          render json: @records,
                 each_serializer: ::Users::Courses::CourseSerializer,
                 status: :ok,
                 adapter: :json,
                 meta: {
                   total: @pagy.count,
                   pages: @pagy.pages,
                   page: @pagy.page,
                   from: @pagy.from,
                   to: @pagy.to,
                   per: @limit.to_i,
                   count: @pagy.items
                 }
                
          # json_list_response(@records, ::Admin::Courses::CourseSerializer)
        end

        def index
          @limit = params[:limit] || PER_PAGE
          @page = params[:page] || 1

          @pagy, @records = pagy(
            Course.all,
            items: @limit,
            page: @page,
          )
          # render json: :Users::Courses::CourseSerializer.new(
          #   Area.all, 
          #   { params: { paginate: paginate(pagy), current_user: @current_user } }
          #     )
          # render json: @subscribes
          # render json: @records, each_serializer: ::Users::Courses::CourseSerializer, current_user: @current_user
          json_list_response(@records, ::Users::Courses::CourseSerializer)
        end

        def show
          unless CourseSubscribe.where(user_id: @current_user.id,course_id: @course.id).empty?
            @course.is_subscribed = true
          else
            @course.is_subscribed = false
          end
          json_response(@course, ::Users::Courses::CourseSerializer)
        end


        private

        def set_model
          @course = Course.includes(:cover).find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { message: "Course not found !" }, status: :not_found
        end
      end
    end
  end
end
