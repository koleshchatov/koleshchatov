# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      atr = "@#{name}".to_sym
      define_method(name.to_sym) do
        instance_variable_get(atr)
      end
      history = []
      define_method("#{name.to_sym}=") do |value|
        instance_variable_set(atr, value); history << value
      end
      define_method("#{name.to_sym}_history") do
        history
      end
    end
  end

  def strong_attr_accessor(name, class_name)
    atr = "@#{name}".to_sym
    define_method(name.to_sym) do
      instance_variable_get(atr)
    end
    define_method("#{name.to_sym}=") do |value|
      raise 'Error. Тип не тот' if class_name != value.class

      instance_variable_set(atr, value)
    end
  end
end