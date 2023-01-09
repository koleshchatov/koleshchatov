# frozen_string_literal: true

require_relative 'wagon'

class PassengerWagon < Wagon

  attr_accessor_with_history :type, :places, :occupied_places
  strong_attr_accessor :type, String

  validate :places, :presence
  validate :places, :format
  validate :places, :type, Integer

  def initialize(places, type = 'passenger')
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
