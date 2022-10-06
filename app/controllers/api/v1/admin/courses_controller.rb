module Api
  module V1
    module Admin
      class CoursesController < BaseController
        before_action :set_model, only: [:update, :show, :destroy]

        def index
          courses = Course.all
          jsons_courses = courses.map { |course| export_json(course) }

          render json: jsons_courses, status: :ok
        end

        def create
          form = Courses::CreateForm.new(create_params)
          if form.valid?
            course = form.save

            render json: export_json(course), status: :ok
          else
            render json: { message: form.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def show
          render json: export_json(@course), status: :ok
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

        def export_json(course)
          course.as_json(include: { cover: { include: [:file_blob], methods: :file_url } })
        end

        def create_params
          params.permit(:name, :description)
        end

        def update_params
          params.permit(:name, :description, :is_publish, :cover_url)
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
