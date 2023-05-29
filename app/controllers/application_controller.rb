
class ApplicationController < ActionController::API
  before_action :authenticate_user!, unless: -> { request.format.json? }
  before_action :check_verification_status!, unless: -> { request.format.json? || controller_name == 'users' }
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end

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

  def check_verification_status!
    return if current_user&.is_verified?
    render json: { error: 'Your account is under verification process. Please try again later.'}
  end
end
