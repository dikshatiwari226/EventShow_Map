class Event < ApplicationRecord
	belongs_to :category,  optional: true

	validates :title, :description, :category, :start_date, :end_date, presence: true
end
