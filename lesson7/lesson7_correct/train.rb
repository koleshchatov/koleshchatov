require_relative 'module_company'
require_relative 'module_instance_counter'

class Train
  include Company
  include InstanceCounter

  attr_reader :wagon, :number, :type
  
  NUMBER_FORMAT = /^[0-9а-яa-z]{3}\p{P}*[0-9а-яa-z]{2}$/i

  def self.show
    @@all_train
  end

  @@all_train = []

  def self.find(number)
    @@all_train.find { |train| train.number == number }
  end

  def initialize(number, type)
    @speed = 0
    @number = number
    @type = type
    @wagon = []
    validate!
    @@all_train << self
    register_instance 
  end

  def valid?
    validate!
  rescue
    false
  end

  def go_speed(speed) 
    @speed += speed
  end

  def stop_speed(speed)
    @stop_speed -= speed
    if @speed < 0
      @speed = 0
    end
  end

  def plus_wagon(wagon)
    if @speed == 0 && @type == wagon.type
      @wagon << wagon
    end
  end

  def minus_wagon(wagon)
    if @speed == 0
      @wagon.delete_at(wagon)
    end
  end

  # def plus_wagon
  #   if @speed == 0 
  #     @wagon += 1
  #   else
  #     puts "Stop train"
  #   end
  # end

  # def minus_wagon
  #   if speed == 0
  #     @wagon -= 1
  #   else
  #     puts "Stop train"
  #   end
  # end

  def train_route(route)
    @route = route
    @index = 0
    @route.stations[@index].add_train(self)
  end

  def forward_train
    @route.stations[@index].start(self)
    @index += 1
    @route.stations[@index].add_train(self)
  end

  def back_train
    @route.stations[@index].start(self)
    @index -= 1
    @route.stations[@index].add_train(self)     
  end

  def next_station
    @route.stations[@index + 1]
  end

  def previous_station
    if @index > 0
      @route.stations[@index - 1]
    end
  end

  def current_station
    @route.station[@index]
  end

  # def block_train(&block_train)
  #   block_train.call(wagon)
  # end

  def iterate_wagons
    @wagon.each.with_index(1) { |wagon, wagon_number| yield wagon, wagon_number }
  end

  protected

  def validate!
    raise "Поезд должен быть в формате ***-**(*символ или буква, дефис не обязателен)" if number !~ NUMBER_FORMAT
    raise "Поезд должен быть 'cargo' или 'passenger'" if type != :cargo && type != :passenger
    true
  end  
end
