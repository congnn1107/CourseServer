module Api
    module V1
      module Users
        class BillboardsController < BaseController
  
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
        end 
    end
  end
end
  