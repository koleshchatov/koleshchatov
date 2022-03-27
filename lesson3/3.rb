class Train
  def initialize(number_train, type_train, number_cars)
    @number_train = number_train
    @type_train = type_train
    @number_cars = number_cars
    @speed = 0
  end

  def up_speed(speed = 50)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def set_up_number_cars
    @number_cars += 1 if @speed == 0
  end

  def set_down_number_cars
    @number_cars -= 1 if @speed == 0
  end

  def get_route(route)
    @route = route
    @current_station = route.start_station
  end

  def next_station
    @route.stations[@route.stations.index(@current_station) + 1] if @current_station != @route.end_station
  end

  def prev_station
    @route.stations[@route.stations.index(@current_station) - 1] if @current_station != @route.start_station
  end

  def go_next
    @current_station.send_train(self)
    up_speed
    @current_station = next_station if next_station
    stop
    @current_station.set_train(self)
  end

  def go_prev
    @current_station.send_train(self)
    up_speed
    @current_station = prev_station if prev_station
    stop
    @current_station.set_train(self)
  end
end
