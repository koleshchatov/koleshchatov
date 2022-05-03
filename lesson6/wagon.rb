class Wagon
  attr_reader :type

  def initialize(type)
    @type = type
    validate!
  end

  def valid?
    validate!
  rescue
    true
  end    

  protected

  def validate!
    raise "Вагон должен быть 'cargo' или 'passenger'" if type != "cargo" && type != "passenger"
    true
  end    
end
