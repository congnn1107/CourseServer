module Api
  module V1
    module Admin
      class CoursesController < BaseController
        before_action :set_model, only: [:update, :show, :destroy]

        def index
          @limit = params[:limit] || PER_PAGE
          @page = params[:page] || 1

          @pagy, @records = pagy(
            Course.all,
            items: @limit,
            page: @page,
          )
          render json: @records,
                 each_serializer: ::Admin::Courses::CourseSerializer,
                 status: :ok,
                 adapter: :json,
                 meta: {
                   total: @pagy.count,
                   pages: @pagy.pages,
                   page: @pagy.page,
                   from: @pagy.from,
                   to: @pagy.to,
                   per: @limit.to_i,
                   count: @pagy.items,
                   kaku:{lulu:"milu"}
                 }
                
          # json_list_response(@records, ::Admin::Courses::CourseSerializer)
        end

        def create
          form = Courses::CreateForm.new(create_params)
          if form.valid?
            course = form.save

            json_response(course, ::Admin::Courses::CourseSerializer)
          else
            render json: { message: form.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def show
          json_response(@course, ::Admin::Courses::CourseSerializer)
        end

        def update
          parameters = update_params

          # handling upload file
          file = params[:cover_file]

          if file
            service = SaveFileService.call(file: file)

            if service.success?
              parameters[:cover_file] = service.result
            else
              return render json: { message: service.message }, status: :unprocessable_entity
            end
          end

          form = Courses::UpdateForm.new(parameters)
          form.course = @course

          if form.valid?
            course = form.save

            render json: course.to_json(include: :cover), status: :ok
          else
            render json: { message: form.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def destroy
          @course.destroy

          render json: { message: "Destroyed!" }, status: :ok
        end

        private

        def create_params
          params.permit(:name, :description,:category_id)
        end

        def update_params
          params.permit(:name, :description, :is_publish, :cover_url,:category_id)
        end

        def set_model
          @course = Course.includes(:cover).find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { message: "Course not found!" }, status: :not_found
        end
      end
    end
  end
end
