module Api
    module V1
      module Admin
        class BillboardsController < BaseController
          before_action :set_model,only: [:update, :show, :destroy]
  
          def index
            @limit = params[:limit] || PER_PAGE
            @page = params[:page] || 1
  
            @pagy, @records = pagy(
              Billboard.all,
              items: @limit,
              page: @page,
            )     
            json_list_response(@records, ::Admin::Billboards::BillboardSerializer)
          end
  
          def create
            unless Billboard.all.where(name: params[:name]).empty?
              render json: "This billboard already exist"
              return 0
            end
            @billboard = Billboard.new(create_params)
  
            if @billboard.save
              render json: @billboard
            else
              error_response(@billboard.errors.to_hash(true),"Error when create review!")
            end
          end
  
          def show
            json_response(@course, ::Admin::Courses::CourseSerializer)
          end
  
          def update
            if @billboard.update(update_params)
              json_response(@billboard, ::Admin::Billboards::BillboardSerializer)
            else
              error_response(@billboard.errors.to_hash(true), "Error when update billboard!")
            end
          end
  
          def destroy
            @billboard.destroy
  
            render json: { message: "Destroyed!" }, status: :ok
          end
  
          private
  
          def create_params
            params.permit(:name,:title,:content,:image)
          end
  
          def update_params
            params.permit(:name,:title,:content,:image)
          end
  
          def set_model
            @billboard = Billboard.find(params[:id])
          rescue ActiveRecord::RecordNotFound => e
            render json: { message: "Billboard not found!" }, status: :not_found
          end
        end
      end
    end
  end
  