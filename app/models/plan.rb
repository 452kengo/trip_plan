class Plan < ApplicationRecord
    belongs_to :user
    has_many :places, -> { order("done ASC, position ASC").includes(:plan) }, dependent: :destroy
 
    validates :title, presence: true
end
