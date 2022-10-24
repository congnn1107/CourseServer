module Api
    module V1
      module Admin
        class CategoriesController < BaseController
          before_action :set_model,only: [:update, :show, :destroy]
  
          def index
            @limit = params[:limit] || PER_PAGE
            @page = params[:page] || 1
  
            @pagy, @records = pagy(
              Category.all,
              items: @limit,
              page: @page,
            )     
            json_list_response(@records, ::Admin::Categories::CategorySerializer)
          end
  
          def create
            unless Category.all.where(name: params[:name]).empty?
              render json: "This category already exist"
              return 0
            end
            @category = Category.new(create_params)
  
            if @category.save
              render json: @category
            else
              error_response(@category.errors.to_hash(true),"Error when create review!")
            end
          end
  
          def show
            json_response(@course, ::Admin::Courses::CourseSerializer)
          end
  
          def update
            if @category.update(update_params)
              json_response(@category, ::Admin::Categories::CategorySerializer)
            else
              error_response(@category.errors.to_hash(true), "Error when update category!")
            end
          end
  
          def destroy
            @category.destroy
  
            render json: { message: "Destroyed!" }, status: :ok
          end
  
          private
  
          def create_params
            params.permit(:name)
          end
  
          def update_params
            params.permit(:name, :description, :is_publish, :cover_url)
          end
  
          def set_model
            @category = Category.find(params[:id])
          rescue ActiveRecord::RecordNotFound => e
            render json: { message: "Category not found!" }, status: :not_found
          end
        end
      end
    end
  end
  