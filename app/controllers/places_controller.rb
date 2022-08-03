class PlacesController < ApplicationController
  before_action :authenticate_user!, :set_place, only: %i[ show edit update destroy ]

  # GET /places or /places.json
  def index
    @place = Place.new
    @places = Place.all
    gon.place = @places
    @hash = Gmaps4rails.build_markers(@places) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.infowindow render_to_string( partial: "maps/infowindow",
                                          locals: {place:place} )
    end
  end

  # GET /places/1 or /places/1.json
  def show
  end

  # GET /places/new
  def new
    @place = Place.new
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places or /places.json
  def create
    @place = Place.new(place_params)

    respond_to do |format|
      if @place.save
        format.html { redirect_to maps_index_path }
        format.json { render :show, status: :created, location: @place }
        format.js { @status = "success"}
        address = params[:address]
        latitude = params[:latitude]
        longitude = params[:longitude]
      else
        format.html { redirect_to maps_index_path, notice: "※場所・住所・到着時間・出発時間が未入力です！" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
        format.js { @status = "fail" }
        @places = Place.all
      end
    end
  end

  # PATCH/PUT /places/1 or /places/1.json
  def update
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to place_url(@place) }
        format.json { render :show, status: :ok, location: @place }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1 or /places/1.json
  def destroy
    @place.destroy

    respond_to do |format|
      format.html { redirect_to maps_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def place_params
      params.require(:place).permit(:name, :address, :latitude, :longitude, :departureTime, :arrivalTime)
    end
end
