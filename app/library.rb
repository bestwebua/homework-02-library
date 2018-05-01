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

  def top_reader
    reader = top_orders_by(:reader)
    reader.nil? ? nil : reader.first
  end

  def top_book
    book = top_orders_by(:book)
    book.nil? ? nil : book.first
  end

  def count_readers_of_bestsellers_top3
    top3 = top_orders_by(:book, 3)
    top3.flatten.select { |object| object.is_a?(Order) }.uniq(&:reader).size
  end

  private

  def top_orders_by(attribute, top_of=nil)
    self.orders.group_by(&attribute).max_by(top_of) { |k,v| v.size }
  end
end
