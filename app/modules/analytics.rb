 module Analytics
  def top_reader
    top_orders_by(:reader).first
  end

  def top_book
    top_orders_by(:book).first
  end

  def count_readers_of_bestsellers_top_3
    top_orders_by(:book, 3).flatten.select { |object| object.is_a?(Order) }.uniq(&:reader).size
  end

  private

  def top_orders_by(attribute, top_of=nil)
    return [] unless @orders
    self.orders.group_by(&attribute).max_by(top_of) { |k,v| v.size } || []
  end
end
