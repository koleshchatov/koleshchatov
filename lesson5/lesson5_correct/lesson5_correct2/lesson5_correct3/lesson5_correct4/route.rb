class Route
  attr_reader :stations, :intermediate_stations

  def initialize(starting_station, end_station)
    @starting_station = starting_station
    @end_station = end_station
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
