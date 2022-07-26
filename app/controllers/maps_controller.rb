class MapsController < ApplicationController
    before_action :authenticate_user!
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
    
    def create
        @place = Place.new(place_params)
        if @place.save
            address = params[:name][:map][:address]
            latitude = params[:name][:map][:latitude]
            longitude = params[:name][:map][:longitude]
            unless latitude.empty && longitude.empty?
              @map = @place.build_map(
                address: address,
                latitude: latitude,
                longitude: longitude
              )
              @map.save
            end
            redirect_to maps_index_path
        else
            @places = Place.all
            render 'maps/index'
        end
    end

     
    private
    
    # ストロングパラメーター
    def place_params
        params.require(:place).permit(:name, :address, :latitude, :longitude)
    end
end