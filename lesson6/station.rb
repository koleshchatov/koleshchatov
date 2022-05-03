require_relative 'module_instance_counter'

class Station
  include InstanceCounter
  
  attr_reader :trains, :name

  NAME_FORMAT = /^.[а-я]{1,}$/i
  
  @@all_stations = []

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@all_stations << self
    register_instance
  end

  def valid?
    validate!
  rescue
    false
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

  protected

  def validate!
    raise "Название станции писать русскими буквами" if name !~ NAME_FORMAT
    true
  end  
end
