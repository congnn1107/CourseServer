module Api
  module V1
    module Concerns
      module Response
        PER_PAGE = 10

        def json_list_response(data, serializer_klass)
          render json: data,
                 each_serializer: serializer_klass,
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
        end

        def json_response(datum, serializer_klass = nil)
          if serializer_klass
            render json: datum, serializer: serializer_klass
          else
            render json: datum
          end
        end

        def error_response(errors, message = 'Error', status = :unprocessable_entity)
          render json: { errors:, message: }, status:
        end
      end
    end
  end
end
