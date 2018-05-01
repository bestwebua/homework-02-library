 module Analytics
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
    return nil if @orders.nil?
    self.orders.group_by(&attribute).max_by(top_of) { |k,v| v.size }
  end
end