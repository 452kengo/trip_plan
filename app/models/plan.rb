class Plan < ApplicationRecord
    belongs_to :user
    has_many :places, dependent: :destroy
 
    validates :title, presence: true
end
