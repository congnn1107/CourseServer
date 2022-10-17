module Api
  module V1
    module Admin
      class BaseController < ::ApplicationController
        PER_PAGE = 10

        include Concerns::Authentication
        include Concerns::Response
        include Pagy::Backend

        before_action :authenticate_user
        before_action :admin_user
      end
    end
  end
end
