require_relative 'constructor'

class Library

  @@constructor = Constructor

  def initialize
    @@constructor.attributes.each do |attribute|
      self.class.class_eval { attr_accessor attribute }
      self.instance_variable_set("@#{attribute}", [])
    end
  end

  def add(target, **args)
    target.capitalize!
      accessor = eval(@@constructor.instance_variable(target))
      new_object = Object.const_get(target).new(args)
    accessor << new_object
  end

  def delete(target, **query)
    target.capitalize!
      accessor = eval(@@constructor.instance_variable(target))
      attribute, value = query.keys.first, query.values.first
    accessor.delete_if { |object| object.send(attribute) == value }
  end

end
