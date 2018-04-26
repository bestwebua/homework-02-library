require_relative 'author'
require_relative 'book'
require_relative 'order'
require_relative 'reader'

class Library
  attr_accessor :authors, :books, :oders, :readers

  def initialize(authors: [], books: [], orders: [], readers: [], **args)
    @authors = authors
    @books = books
    @orders = orders
    @readers = readers
  end
end
