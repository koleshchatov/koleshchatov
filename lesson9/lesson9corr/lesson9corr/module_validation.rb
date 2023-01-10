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
      @validations ||= [] 
      @validations << [attr, validate_type, arg] 
    end

    def test_method
      @validations
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
            raise "Введите #{attr}" if instance_variable_get("@#{attr}".to_sym) == nil
          elsif validate_type == :format
            raise "#{attr} вводить только цифрами" if  instance_variable_get("@#{attr}".to_sym) !~ FORMAT
          elsif validate_type == :format_number
            raise "#{attr} должен быть в формате ***-**(*символ или буква, дефис не обязателен)" if instance_variable_get("@#{attr}".to_sym) !~ NUMBER_FORMAT
          elsif validate_type == :format_name
            raise "#{attr} писать только на русском языке" if instance_variable_get("@#{attr}".to_sym) !~ NAME_FORMAT
          elsif validate_type == :type
            raise "Не подходит тип #{attr}" if instance_variable_get("@#{attr}".to_sym).class != arg               
          end
      end
      true
    end     
  end
end
