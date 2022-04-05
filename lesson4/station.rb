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
    @train.select {|x| puts x.type == type}
  end

  def start(train)
    @trains.delete(train)
  end
end
