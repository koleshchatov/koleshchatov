# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train

  attr_accessor_with_history :number, :type, :wagon
  strong_attr_accessor :name, String

  validate :number, :presence
  validate :number, :format_number
  validate :number, :type, String

  def initialize(data = {})
   super
   @type = 'cargo'
  end
end

