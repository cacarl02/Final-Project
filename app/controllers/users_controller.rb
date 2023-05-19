class UsersController < ApplicationController
    before_action :set_user, only: [:index, :show, :update]
  
    def index
      if @user.role === 'admin'
        @users = User.all
        render json: @users.where.not(role: 'admin')
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
    def update
      amount = params[:amount]
      @user.top_up(amount) #top-up balance 

      if @user.update(user_params)
        render json: @user
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
  