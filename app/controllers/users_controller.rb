class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :topup_balance]
  
    def index
      if current_user.role === 'admin'
        @users = User.all
        render json: @users.where(role: ['operator', 'commuter', nil])
      else
        render json: {error: "Access denied. Admin privileges required."}, status: 401
      end
    end
  
    def show
      render json: @user
    end
  
    def create
      @user = User.new(user_params)
  
      if @user.save
        render json: @user, status: :created, location: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /users/1
    def topup_balance
      amount = params[:amount]
      if @user.top_up(amount)
        if @user.update(user_params)
          render json: { user: @user, message: 'Balance updated successfully.'}
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      else
        render json: { error: @user.errors.full_messages.first }, status: :unprocessable_entity
      end
    end

    def update
      if @user.update(user_params)
        render json: { user: @user, message: 'User updated successfully.'}
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    private

    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.permit(:firstname, :lastname, :balance, :photo_data, :role)
    end
  end
  