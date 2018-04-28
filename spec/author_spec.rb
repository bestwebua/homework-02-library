require_relative '../app/constructor'
require_relative '../app/classes/author'

describe Author do
  subject(:author) { Author.new(name: 'Test Author', biography: 'Awesome Bio') }

  describe '#new' do
    subject(:fail_author) { Author.new }

    it 'should raise an ArgumentError error if arguments not passed' do
      expect {fail_author}.to raise_error(ArgumentError)
    end

    it 'object should be an instance of Author class' do
      expect(author).to be_an_instance_of(Author)
    end
  end

  describe '#name' do
    it "should return author's name" do
      expect(author.name).to eq('Test Author')
    end
  end

  describe '#biography' do
    it "should return author's biography" do
      expect(author.biography).to eq('Awesome Bio')
    end
  end
end