module Api
  module V1
    module Users
      class BaseController < ::ApplicationController
        PER_PAGE = 10
        include Concerns::Response
        include Pagy::Backend


        include Concerns::Authentication

        before_action :authenticate_user
      end
    end
  end
end
