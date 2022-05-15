# frozen_string_literal: true

class CargoWagon < Wagon
  def initialize(all_volume, type = :cargo)
    @all_volume = all_volume
    @occupited_volume = 0
    super(type)
  end

  def occupited_volume(occupited_volume)
    if @occupited_volume + occupited_volume < @all_volume
      @occupited_volume += occupited_volume
    else
      puts 'В этом вагоне не хватает объема'
    end
  end

  def all_occupited_volume
    @occupited_volume
  end

  def free_volume
    all_volume - @occupited_volume
  end
end
