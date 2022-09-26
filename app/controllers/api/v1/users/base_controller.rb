module Api
  module V1
    module Users
      class BaseController < ::ApplicationController
        include Concerns::Authentication

        before_action :authenticate_user
      end
    end
  end
end
