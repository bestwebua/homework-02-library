class Test < LibraryUnionClass
  attr_reader :test_attr

  def initialize(test_attr:)
    @test_attr = test_attr
  end
end
