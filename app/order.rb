class Order
  attr_reader :book, :reader, :date

  def initialize(book:, reader:, date:)
    @book, @reader, @date = book, reader, date
  end
end
