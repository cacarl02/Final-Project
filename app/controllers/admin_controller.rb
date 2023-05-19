class AdminController < ApplicationController
    before_action :set_user
    before_action :authorize_admin
  
    def show
      render json: @user
    end
  
    def verify_user
      @user.update(is_verified: !@user.is_verified)
      render json: { message: "User #{@user.email} has been verified." }
    end
  
    private
  
    def authorize_admin
      unless current_user.role == 'admin'
        render json: { error: "Access denied. Admin privileges required." }, status: :unauthorized
      end
    end

    def set_user
        @user = User.find(params[:id])
    end
  end
  