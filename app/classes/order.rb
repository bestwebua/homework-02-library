require_relative '../constructor'

class Order < LibraryUnionClass
  attr_reader :book, :reader, :date

  def initialize(book:, reader:, date:)
    @book, @reader, @date = book, reader, date
  end
end
