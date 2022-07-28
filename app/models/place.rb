class Place < ApplicationRecord
    validates :address, presence: true
    validates :latitude, presence: true
    validates :longitude, presence: true
    
    geocoded_by :address
    after_validation :geocode
end
