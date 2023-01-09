# frozen_string_literal: true

require_relative 'train'

#class PassengerTrain < Train
 # def initialize(number)
  #  super(number, :passenger)
  #end
#end

class PassengerTrain < Train

  attr_accessor_with_history :number, :type, :wagon
  strong_attr_accessor :name, String

  validate :number, :presence
  validate :number, :format_number
  validate :number, :type, String

  def initialize(data = {})
   super
   @type = 'passenger'
  end
end
