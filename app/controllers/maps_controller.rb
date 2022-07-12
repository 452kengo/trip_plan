class MapsController < ApplicationController
    def index
        @places = Place.all
        gon.place = @places
        @hash = Gmaps4rails.build_markers(@places) do |place, marker|
            marker.lat place.latitude
            marker.lng place.longitude
            marker.infowindow render_to_string( partial: "maps/infowindow",
                                          locals: {place:place} )
        end
    end
end