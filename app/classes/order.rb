class Order < LibraryUnionClass
  @@id = 1

  attr_reader :book, :reader, :date, :id

  def initialize(book:, reader:, date:)
    @book, @reader, @date, @id = book, reader, date, @@id
    @@id = @@id.next
  end
end
