module Api
  module V1
    module Admin
      module Courses
        class UpdateForm < BaseForm
          attr_accessor :name, :description, :is_publish, :course

          validates :name, :description, presence: true

          def save
            course.name = name
            course.description = description
            if is_publish.present?
              course.is_publish = is_publish
              course.touch("published_at")
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
