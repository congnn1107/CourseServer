module Api
  module V1
    module Admin
      module Courses
        class CreateForm < BaseForm
          attr_accessor :name, :description, :category

          validates :name, :description, presence: true

          def save
            course = Course.new(attributes)
            course.save
            return course
          end

          private

          def attributes
            {
              name: name,
              description: description,
              category:category
            }
          end
        end
      end
    end
  end
end
