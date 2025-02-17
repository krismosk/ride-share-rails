class PassengersController < ApplicationController

  def index
    @passengers = Passenger.all
  end
  
  def show
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)
    
    if @passenger.nil?
      head :not_found
      return
    end
  end
  
  def new
    @passenger = Passenger.new
  end
  
  def edit
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      head :not_found
      return
    end
  end
  
  def create
    @passenger = Passenger.new(passenger_params)
    
    respond_to do |format|
      if @passenger.save
        format.html { redirect_to @passenger, notice: 'Passenger was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end
  
  def update
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      head :not_found
      return
    end

    respond_to do |format|
      if @passenger.update(passenger_params)
        format.html { redirect_to @passenger, notice: 'Passenger was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end
  
  def destroy
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      head :not_found
      return
    end
    @passenger.destroy
    respond_to do |format|
      format.html { redirect_to passengers_url, notice: 'Passenger was successfully destroyed.' }
    end
  end
  
  def create_new_trip
    @passenger = Passenger.find(params[:id])
    if @passenger.nil?
      redirect_to passengers_path
      return
    end 

    trip_info = {
      trip: {   
        driver_id: Driver.find_available_driver,
        passenger_id: @passenger.id,
        date: Time.now,
        rating: nil,
        cost: 100,}
      }
      new_trip = Trip.new(trip_info[:trip])
      new_trip.save
      
      if new_trip.save == true
        flash[:success] = "Trip successfully created." 
        new_trip.driver.active = false 
      else 
        flash[:error] = "Uh Oh! Something went wrong."
      end

      redirect_to passenger_path(@passenger)
  end
  
  private
  
  def passenger_params
    params.require(:passenger).permit(:name, :phone_num)
  end
end
