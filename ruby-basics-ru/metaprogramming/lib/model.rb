# frozen_string_literal: true

# BEGIN
require 'date'
module Model

  def self.included(base)
    base.extend(ClassMethods)
  end

  def initialize(attributes = {})
    attributes.each do |key, value|
      if self.respond_to?(key) && type = self.class.get_saved_attribute_types[key]
        try_to_set_attribute(key, value)
      end
    end
  end
  
  def attributes
    self.class.get_saved_attribute_types.reduce({}) do |memo, (key,val)|
      memo[key] = instance_variable_get "@#{key}"
      memo
    end
  end

  def try_to_set_attribute(name, value)
    saved_type = self.class.get_saved_attribute_types[name]
    normalized_saved_type = self.class.get_normalized_attribute_type(saved_type)
    kernel_types = self.class.get_kernel_types

    if value.kind_of?(normalized_saved_type)
      #the same type
      instance_variable_set "@#{name}", value
      return
    elsif kernel_types.include?(value.class.name) && kernel_types.include?(normalized_saved_type.name)
      #type can be casted by kernel
      instance_variable_set "@#{name}", Kernel.send(normalized_saved_type.name,value)
      return
    elsif saved_type == :datetime
      instance_variable_set "@#{name}", DateTime.parse(value)
      return
    elsif saved_type == :boolean && (value.kind_of?(TrueClass) || value.kind_of?(FalseClass) || value.kind_of?(NilClass))
      instance_variable_set "@#{name}", value
      return
    else
      raise ArgumentError, "Invalid type: #{value.class.name}"
      return
    end
  end#try_to_set_attribute
    
  module ClassMethods
    class Boolean end
    @@kernel_types = %w|String Integer Float Hash Array|
    
    def get_normalized_attribute_type(type)
      case type.to_s.capitalize
        when 'Boolean'
        return Boolean
        when 'Datetime'
        return DateTime
        else
        return Kernel.const_get(type.to_s.capitalize)
      end
    end
        
    def attribute(name, options = {})
      if att_type = options[:type]
        @saved_attribute_types ||= {}
        @saved_attribute_types[name] = att_type
        
        instance_variable_set "@#{name}", nil
        
        define_method "#{name}".to_sym do
          instance_variable_get "@#{name}"
        end
        
        define_method "#{name}=" do |value|
          try_to_set_attribute(name, value)
        end
      end
    end
    
    def get_saved_attribute_types
      @saved_attribute_types
    end
    
    def get_kernel_types
      @@kernel_types
    end
    
  end
end
# END
