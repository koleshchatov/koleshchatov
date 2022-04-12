
class Train
  attr_reader :wagon, :number, :type
  
  def initialize(number, type)
    @speed = 0
    @number = number
    @type = type
    @wagon = []
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
    else
      puts "Остановите поезд или поменяйте тип вагона"
    end
  end

  def minus_wagon(wagon)
    if @speed == 0
      @wagon.delete_at(wagon)
    else
      puts "Stop train"
    end
  end

  def train_route(route)
    super
    @route_train << route
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
    @route.station[@index + 1]
  end

  def previous_station
    if @index > 0
      @route.station[@index - 1]
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
