module Api
  module V1
    module Admin
      module Courses
        class UpdateForm < BaseForm
          attr_accessor :name, :description, :is_publish, :cover_file, :cover_url, :course

          validates :name, :description, presence: true

          def save
            course.name = name
            course.description = description
            course.cover_url = cover_url

            if cover_file.present?
              cover = Imageable.new(
                target_type: "Course",
              )

              cover.file.attach(cover_file)
              course.cover = cover
            end

            if is_publish.present?
              course.is_publish = is_publish
              course.touch("published_at") if is_publish
            end

            course.save

            return course
          end

          private

          def attributes
            {
              name: name,
              description: description,
            }
          end
        end
      end
    end
  end
end
