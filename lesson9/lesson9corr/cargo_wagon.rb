# frozen_string_literal: true

require_relative 'wagon'

class CargoWagon < Wagon

  attr_accessor_with_history :type, :all_volume, :occupited_volume
  strong_attr_accessor :type, String

  validate :all_volume, :presence
  validate :all_volume, :format
  validate :all_volume, :type, Integer

  def initialize(all_volume, type = 'cargo')
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
