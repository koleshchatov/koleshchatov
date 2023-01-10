# frozen_string_literal: true

require_relative 'module_instance_counter'
require_relative 'module_accessors'
require_relative 'module_validation'

class Station
  
  extend Accessors
  include Validation
  include InstanceCounter

  attr_accessor_with_history :trains, :name
  strong_attr_accessor :trains, Array

  validate :name, :presence
  validate :name, :format_name
  validate :name, :type, String

  @@all_stations = []

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@all_stations << self
    register_instance
  end

  def add_train(train)
    @trains << train
  end

  def train_by_type(type)
    @trains.select { |x| x.type == type }
  end

  def start(train)
    @trains.delete(train)
  end

  def iterate_trains(&block)
    @trains.each(&block)
  end
end
