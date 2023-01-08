# frozen_string_literal: true

require_relative 'module_company'
require_relative 'module_instance_counter'
require_relative 'module_accessors'
require_relative 'module_validation'

class Train
  extend Accessors
  include Validation
  include Company
  include InstanceCounter

  attr_accessor_with_history :number, :type, :wagon, :speed
  strong_attr_accessor :name, String

#  NUMBER_FORMAT = /^[0-9а-яa-z]{3}\p{P}*[0-9а-яa-z]{2}$/i.freeze

  validate :number, :presence
  validate :number, :format_number
  validate :number, :type, String

  @@all_train = []

  def self.find(number)
    @@all_train.find { |train| train.number == number }
  end

  def initialize(data = {})
    @speed = 0
    @number = data[:number]
    @type = data[:type]
    @wagon = []
    validate!
    @@all_train << self
    register_instance
  end

  def go_speed(speed)
    @speed += speed
  end

  def stop_speed(speed)
    @stop_speed -= speed
    @speed = 0 if @speed.negative?
  end

  def plus_wagon(wagon)
    @wagon << wagon if @speed.zero? && @type == wagon.type
  end

  def minus_wagon(wagon)
    @wagon.delete_at(wagon) if @speed.zero?
  end

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
    @route.stations[@index + 1]
  end

  def previous_station
    @route.stations[@index - 1] if @index.positive?
  end

  def current_station
    @route.station[@index]
  end

  def iterate_wagons(&block)
    @wagon.each.with_index(1, &block)
  end
end
