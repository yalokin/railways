class Train < ApplicationRecord
  belongs_to :route
  belongs_to :current_station, class_name: 'RailwayStation', foreign_key: :current_station_id
  has_many :tickets
  has_many :carriages

  validates :number, presence: true
  validates :head_sort, presence: true

  scope :station_on_route, ->(station) { joins(route: :railway_stations).where("railway_station_id = ?", station) }

  def count_seats(carriage_type, seats_type)
    carriages.where(type: carriage_type).sum(seats_type)
  end

  def sorted_carriages
    head_sort ? carriages.sorted_up : carriages.sorted_down
  end

  def self.search(start_station, end_station)
    Train.station_on_route(start_station) & Train.station_on_route(end_station)
  end
end
