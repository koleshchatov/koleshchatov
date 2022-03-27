class Route
  def initialize (start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @stations = [start_station, end_station]
  end

  def set_way_station(way_station)
    @stations.insert(-2, way_station)
  end

  def delete_station(del_station)
    @stations.delete_if { |name| name == del_station }
  end
end
