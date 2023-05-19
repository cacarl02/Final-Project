class TripsController < ApplicationController
    before_action :set_trip, only: [:show, :update]
    
    def index
        @trips = Trip.where(user_id: current_user.id).where.not(status: ['completed', 'cancelled'])
        render json: @trips
    end
    
    def show
        render json: @trip
    end
    
    def create
        @trip = current_user.trips.build(trip_params)
        
        if @trip.save
            render json: @trip, status: :created
        else
            render json: @trip.errors, status: :unprocessable_entity
        end
    end
    
    def update
        if @trip.update(trip_params)
            render json: @trip
        else
            render json: @trip.errors, status: :unprocessable_entity
        end
    end

    def update_location
        @trip = Trip.find(params[:id])
        
    end

    private
      
    def set_trip
        @trip = Trip.find(params[:id])
    end
    
    def trip_params
        params.require(:trip).permit(:start, :end, :departure, :capacity, :status, :location)
    end
end