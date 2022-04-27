require_relative 'module_instance'

class Station
  include InstanceCounter
  
  attr_reader :trains, :name
  
  @@all_stations = []

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << self
    register_instance
  end

  def add_train(train)
    @trains << train
  end
  
  def train_by_type(type)
    @trains.select {|x| x.type == type}
  end

  def start(train)
    @trains.delete(train)
  end
end
