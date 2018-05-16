require_relative '../app/constructor'
require_relative '../app/classes/author'

describe Author do
  let(:valid_author) { Author.new(name: 'Test Author', biography: 'Awesome Bio') }

  describe '#new' do
    it 'should raise an ArgumentError error if arguments not passed' do
      expect {subject}.to raise_error(ArgumentError)
    end

    it 'object should be an instance of Author class' do
      expect(valid_author).to be_an_instance_of(Author)
    end
  end

  describe '#name' do
    it "should return author's name" do
      expect(valid_author.name).to eq('Test Author')
    end
  end

  describe '#biography' do
    it "should return author's biography" do
      expect(valid_author.biography).to eq('Awesome Bio')
    end
  end

  describe '#attributes' do
    it 'should return all Author attr_reader attributes as array' do
      expect(valid_author.attributes).to eq(%i[name biography])
    end
  end
end
