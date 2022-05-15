# frozen_string_literal: true

class Wagon
  attr_reader :type, :all_volume, :places

  def initialize(type)
    @type = type
    validate!
  end

  def valid?
    validate!
  rescue StandardError
    true
  end

  protected

  def validate!
    raise "Вагон должен быть 'cargo' или 'passenger'" if type != :cargo && type != :passenger

    true
  end
end
