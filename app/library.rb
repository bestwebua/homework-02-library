require_relative 'constructor'

class Library

  @@constructor = Constructor

  def initialize
    @@constructor.attributes.each do |attribute|
      self.class.class_eval { attr_accessor attribute }
      self.instance_variable_set("@#{attribute}", [])
    end
  end

end
