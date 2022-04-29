require_relative 'module_company'
require_relative 'module_instance_counter'

class Train
  include Company
  include InstanceCounter

  attr_reader :wagon, :number, :type
  
  def self.show
    @@all_train
  end

  @@all_train = []

  def self.find(number)
    train_by_number = @@all_train.select { |train| train.number == number }
    puts train_by_number if train_by_number
  end

  def initialize(number, type)
    @speed = 0
    @number = number
    @type = type
    @wagon = []
    @@all_train << self
    register_instance 
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
    @route_train << route
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

#перенес этот метод в секцию  protected , так как по заданию нужно было перенести какой нибудь метод
#Теперь , в моей программе, на объектах класса Train(Passenger/Cargo) нельзя вызвать метод current_station
#чтобы узнать текущую станцию. 
  protected

  def current_station
    @route.station[@index]
  end
end
