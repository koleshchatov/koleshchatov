# frozen_string_literal: true

require_relative 'station'
require_relative 'module_instance_counter'
require_relative 'module_accessors'
require_relative 'module_validation'

class Route

  extend Accessors
  include Validation
  include InstanceCounter

  attr_accessor_with_history :stations, :intermediate_stations, :starting_station, :end_station
  strong_attr_accessor :long, Integer

  validate :starting_station, :presence
  validate :starting_station, :format_name
  validate :starting_station, :type, String

  def initialize(stations = {})
    @starting_station = stations[:starting_station]
    @end_station = stations[:end_station]
    @intermediate_stations = []
    @stations = [@starting_station, @end_station]
  end

  def add_station(name)
    @stations.insert(-2, name)
    @intermediate_stations << name
  end

  def delete_stations(name)
    @stations.delete_at(name + 1)
    @intermediate_stations.delete_at(name)
  end
end
