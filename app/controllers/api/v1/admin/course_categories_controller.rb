module Api
    module V1
      module Admin
        class CourseCategoriesController < BaseController
          before_action :set_model,only: [:update, :show, :destroy]
  
          def index
            @limit = params[:limit] || PER_PAGE
            @page = params[:page] || 1
  
            @pagy, @records = pagy(
              CourseCategory.all,
              items: @limit,
              page: @page,
            )     
            json_list_response(@records, ::Admin::CourseCategories::CourseCategorySerializer)
          end
  
          def create
            unless CourseCategory.where(course_id: params[:course_id]).empty?
              render json: " this assign already exist"
              return 0
            end
            @course_category = CourseCategory.new(create_params)
  
            if @course_category.save
              render json: @course_category
            else
              error_response(@course_category.errors.to_hash(true),"Error when create review!")
            end
          end
  
          def show
            json_response(@course_category, ::Admin::CourseCategories::CourseCategorySerializer)
          end
  
          def update
            if @course_category.update(update_params)
              json_response(@course_category, ::Admin::CourseCategories::CourseCategorySerializer)
            else
              error_response(@course_category.errors.to_hash(true), "Error when update category!")
            end
          end
  
          def destroy
            @course_category.destroy
  
            render json: { message: "Destroyed!" }, status: :ok
          end
  
          private
  
          def create_params
            params.permit(:course_id,:category_id)
          end
  
          def update_params
            params.permit(:category_id,:course_id)
          end
  
          def set_model
            @course_category = CourseCategory.where(course_id: params[:id]).take
          rescue ActiveRecord::RecordNotFound => e
            render json: { message: "CourseCategories not found!" }, status: :not_found
          end
        end
      end
    end
  end
  