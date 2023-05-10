class BookingsController < ApplicationController
    def index
      @bookings = Booking.all
      render json: @bookings
    end
    
    def show
      render json: @booking
    end
    
    def create
      @booking = Booking.new(booking_params)
      
      if @booking.save
        render json: @booking, status: :created
      else
        render json: @booking.errors, status: :unprocessable_entity
      end
    end
    
    def edit
      @booking = Booking.find(params[:id])
    end
    
    def update
      
      if @booking.update(booking_params)
        redirect_to @booking
      else
        render :edit
      end
    end
    
    private

    def set_booking
        @booking = Booking.find(params[:id])
    end
    
    def booking_params
      params.require(:booking).permit(:trip_id, :user_id, :start_date, :end_date)
    end
  end
  