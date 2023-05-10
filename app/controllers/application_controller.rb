
class ApplicationController < ActionController::API
    before_action :authenticate_user!, unless: -> { request.format.json? }

    def render_jsonapi_response(resource)
      
      if resource.errors.empty?
        render json: UserSerializer.new(resource)
      else
        render json: resource.errors, status: 400
      end
    end

  private

    def authenticate_user!
      return if user_signed_in?
  
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
end
