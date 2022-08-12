class PlacesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_plan
  before_action :set_place, only: %i[ show edit update destroy sort ]
  
  # GET /places or /places.json
  def index
    @place = @plan.places.new
    @places = @plan.places.all.order("departureTime")
    gon.place = @places
    @hash = Gmaps4rails.build_markers(@places) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.infowindow render_to_string( partial: "places/infowindow",
                                          locals: {place:place} )
    end
  end

  # GET /places/1 or /places/1.json
  def show
  end

  # GET /places/new
  def new
    @place = @plan.places.new
  end

  # GET /places/1/edit
  def edit
    @places = @plan.places.all.order("departureTime")
  end

  # POST /places or /places.json
  def create
    @place = @plan.places.new(place_params)
      respond_to do |format|
        if @place.save
          format.json { render :show, status: :created, location: @place }
          format.js { @status = "success"}
          name = params[:name]
          address = params[:address]
          latitude = params[:latitude]
          longitude = params[:longitude]
          departureTime = params[:departureTime]
          arrivalTime = params[:arrivalTime]
          unless latitude.empty && longitude.empty?
            @map = @place.build_map(
              address: address,
              latitude: latitude,
              longitude: longitude,
              departureTime: departureTime,
              arrivalTime: arrivalTime
            )
            @map.save
          end
        else
          format.html { redirect_to plan_places_path(@place.plan, @place), notice: "※場所・住所・到着時間・出発時間を全て入力してください！" }
          format.json { render json: @place.errors, status: :unprocessable_entity }
          format.js { @status = "fail" }
          @places = @plan.places.all
        end
      end
  end

  # PATCH/PUT /places/1 or /places/1.json
  def update
    respond_to do |format|
      if @place.update(place_params)
        @status = true
        format.json { render :show, status: :ok, location: @place }
      else
        @status = false
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1 or /places/1.json
  def destroy
    @place = @plan.places.find_by(id: params[:id])
    @place.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = current_user.plans.find_by(id: params[:plan_id])
    end
    
    def set_place
      @place = @plan.places.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def place_params
      params.require(:place).permit(:name, :address, :latitude, :longitude, :departureTime, :arrivalTime, :plan_id, :position, :done, map_attributes: [:plan_id, :latitude, :longitude])
    end
end
