# frozen_string_literal: true

module Validation

  NUMBER_FORMAT = /^[0-9а-яa-z]{3}\p{P}*[0-9а-яa-z]{2}$/i.freeze
  NAME_FORMAT = /^[а-я]{1,}$/i.freeze
  FORMAT = /^[0-9]{1,}$/i.freeze


  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods

    def validate(attr, validate_type, arg = nil)
      @a ||= [] 
      c = []
      c << attr
      c << validate_type
      c << arg
      @a.push(c)     
    end

    def test_method
      @a
    end
  end

  module InstanceMethods
   
    def valid?
      validate!
      rescue StandardError => e
      false               
    end

    def validate!
      self.class.test_method.each do |attr, validate_type, arg| 
          if validate_type == :presence
            raise "Не может быть пустым" if instance_variable_get("@#{attr}".to_sym) == nil
          elsif validate_type == :format
            raise "Не подходит формат" if  instance_variable_get("@#{attr}".to_sym) !~ FORMAT
          elsif validate_type == :format_number
            raise "Не подходит формат" if instance_variable_get("@#{attr}".to_sym) !~ NUMBER_FORMAT
          elsif validate_type == :format_name
            raise "Не подходит формат" if instance_variable_get("@#{attr}".to_sym) !~ NAME_FORMAT
          elsif validate_type == :type
            raise "Не подходит тип" if instance_variable_get("@#{attr}".to_sym).class != arg               
          end
      end
      true
    end     
  end
end
