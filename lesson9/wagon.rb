# frozen_string_literal: true

require_relative 'module_company'
require_relative 'module_accessors'
require_relative 'module_validation'

class Wagon
  extend Accessors
  include Validation
  include Company

  attr_accessor_with_history :type
  strong_attr_accessor :type, String

  def initialize(type)
    @type = type
  end
end
