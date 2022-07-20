class MapsController < ApplicationController
    before_action :authenticate_user!
    def index
        @map = Map.new
        @maps = Map.all
        
        @place = Place.all
        gon.place = @place
        @hash = Gmaps4rails.build_markers(@place) do |place, marker|
            marker.lat place.latitude
            marker.lng place.longitude
            marker.infowindow render_to_string( partial: "maps/infowindow",
                                          locals: {place:place} )
        end
    end
    
    def create
        @map = Map.new(map_params)
        if @map.save
            redirect_to maps_url
        else
            @maps = Map.all
            render 'maps/index'
        end
    end

     
    private
    
    # ストロングパラメーター
    def map_params
        params.require(:map).permit(:name, :address, :description, :latitude, :longitude)
    end
end