class Place < ApplicationRecord
    belongs_to :plan

    validates :address, presence: true
    validates :latitude, presence: true
    validates :longitude, presence: true
    validates :departure_time, presence: true
    validates :arrival_time, presence: true
    
    geocoded_by :address
    after_validation :geocode
end
