class Station
  def initialize(name_station)
    @name_station = name_station
    @trains = []
  end

  def train
    @num_train
  end

  def set_train(train)
    @trains << train
  end  

  def send_train(train)
    @trains.delete(train)
  end  

  def get_type_trains(type)
    @trains.select { |train| train.type == type }
  end
end  
