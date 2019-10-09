class PassengersController < ApplicationController

  # GET /passengers
  def index
    @passengers = Passenger.all
  end

  # GET /passengers/1
  def show
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)
    
    if @passenger.nil?
      head :not_found
      return
    end
  end

  # GET /passengers/new
  def new
    @passenger = Passenger.new
  end

  # GET /passengers/1/edit
  def edit
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      head :not_found
      return
    end
  end

  # POST /passengers
  # POST /passengers.json
  def create
    @passenger = Passenger.new(passenger_params)

    respond_to do |format|
      if @passenger.save
        format.html { redirect_to @passenger, notice: 'Passenger was successfully created.' }
        format.json { render :show, status: :created, location: @passenger }
      else
        format.html { render :new }
        format.json { render json: @passenger.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /passengers/1
  # PATCH/PUT /passengers/1.json
  def update
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      head :not_found
      return
    end

    respond_to do |format|
      if @passenger.update(passenger_params)
        format.html { redirect_to @passenger, notice: 'Passenger was successfully updated.' }
        format.json { render :show, status: :ok, location: @passenger }
      else
        format.html { render :edit }
        format.json { render json: @passenger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /passengers/1
  # DELETE /passengers/1.json
  def destroy
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      head :not_found
      return
    end
    @passenger.destroy
    respond_to do |format|
      format.html { redirect_to passengers_url, notice: 'Passenger was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def passenger_params
      params.require(:passenger).permit(:name, :phone_num)
    end
end
