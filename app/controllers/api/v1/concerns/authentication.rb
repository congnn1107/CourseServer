require "jwt"

module Api
  module V1
    module Concerns
      module Authentication
        extend ActiveSupport::Concern

        def authenticate_user
          if !request.headers["Authorization"]
            render json: { message: "You must login!" }, status: :unauthorized
          else
            begin
              token = request.headers["Authorization"].split.last
              decoded = JWT.decode(token, Rails.application.secrets.secret_key_base).first
              user = User.find(decoded["id"])

              @current_user = user
            rescue JWT::ExpiredSignature => e
              json_response({ error: "Session has expired, you must login again!" }, :unauthorized)
            end
          end
        end

        def admin_user
          json_response({ error: "Permission denied!" }, :forbidden) unless @current_user.is_admin
        end
      end
    end
  end
end
