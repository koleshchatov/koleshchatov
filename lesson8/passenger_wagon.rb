class PassengerWagon < Wagon
  def initialize(places, type = :passenger)
    @places = places
    @occupied_places = 0
    super(type)
  end

  def take_seats
    if @occupied_places < @places
      @occupied_places += 1
    else
      puts 'В этом вагоне закончились свободные места'
    end
  end

  def occupited_places
    @occupied_places
  end

  def free_seats
    places - @occupied_places
  end
end
