class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
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
