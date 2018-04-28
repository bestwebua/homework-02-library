require_relative '../constructor'

class Author < LibraryUnionClass
  attr_reader :name, :biography

  def initialize(name:, biography:)
    @name, @biography = name, biography
  end
end
