class BookingsController < ApplicationController
    before_action :set_booking, only: [:show, :update, :bookings_on_trip]

    def index
      @bookings = Booking.where(user_id: current_user.id).where.not(status: ['completed', 'cancelled'])
      render json: @bookings
    end

    def history
      @bookings = Booking.where(user_id: current_user.id).where(status: ['completed', 'cancelled'])
      render json: @bookings
    end

    def bookings_on_trip
      @trip = Trip.find(params[:id])
      @booking = Booking.where(trip_id: @trip.id).where(status: ['pending', 'ongoing'])
      render json: @booking
    end
    
    def show
      external_data = fetch_data_from_external_api
      if @booking.status == 'ongoing'
        render json: { trip: @trip, external_data: external_data}
      else
        render json: { trip: @trip, external_data: nil }
      end
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

    def fetch_data_from_external_api

    end
  end