class BookingsController < ApplicationController
    before_action :set_booking, only: [:show, :update]

    def index
      @bookings = Booking.where(user_id: current_user.id, status: 'pending')
      render json: @bookings
    end
    
    def show
      render json: @booking
    end
    
    def create
      @booking = current_user.bookings.build(booking_params)
      
      if @booking.save
        render json: @booking, status: :created
      else
        render json: @booking.errors, status: :unprocessable_entity
      end
    end
    
    def update

      if @booking.update(booking_params)
        render json: @booking
      else
        render json: @booking.errors, status: :unprocessable_entity
      end
    end
    
    private

    def set_booking
        @booking = Booking.find(params[:id])
    end
    
    def booking_params
      params.require(:booking).permit(:trip_id, :user_id, :start, :end, :amount, :departure, :status)
    end
  end