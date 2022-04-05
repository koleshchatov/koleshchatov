class CargoTrain < Train
  attr_reader :route_train

  def initialize(number, type = "cargo")
    @speed = 0
    @number = number
    @type = type
    @wagon = []
    @route_train = []
  end

  def plus_wagon(wagon)
    if @speed == 0 && wagon.class == CargoWagon
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
end
