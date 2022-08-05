class Place < ApplicationRecord
    belongs_to :plan
    acts_as_list scope: [:plan_id]
    
    validates :done, inclusion: { in: [true, false] }
    
    validates :address, presence: true
    validates :latitude, presence: true
    validates :longitude, presence: true
    validates :departureTime, presence: true
    validates :arrivalTime, presence: true
    
    after_initialize :set_default, if: :new_record?
    
    geocoded_by :address
    after_validation :geocode
end
