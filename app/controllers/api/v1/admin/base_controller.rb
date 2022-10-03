module Api
  module V1
    module Admin
      class BaseController < ApplicationController
        include Concern::Authentication

        before_action :authenticate_user
        before_action :admin_user
      end
    end
  end
end