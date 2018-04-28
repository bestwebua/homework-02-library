require_relative '../constructor'

class Book < LibraryUnionClass
  attr_reader :title, :author

  def initialize(title:, author:)
    @title, @author = title, author
  end
end
