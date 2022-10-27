module Api
    module V1
      module Users
        class CategoriesController < BaseController
  
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
        end
      end
    end
  end
  