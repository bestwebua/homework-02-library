require_relative '../app/constructor'
require_relative '../app/classes/book'

describe Book do
  let(:valid_book) { Book.new(title: 'Test Book', author: 'Anonymous') }

  describe '#new' do
    it 'should raise an ArgumentError error if arguments not passed' do
      expect {subject}.to raise_error(ArgumentError)
    end

    it 'object should be an instance of Book class' do
      expect(valid_book).to be_an_instance_of(Book)
    end
  end

  describe '#title' do
    it "should return book's title" do
      expect(valid_book.title).to eq('Test Book')
    end
  end

  describe '#author' do
    it 'should return author of the book' do
      expect(valid_book.author).to eq('Anonymous')
    end
  end

  describe '#attributes' do
    it 'should return all Book attr_reader attributes as array' do
      expect(valid_book.attributes).to eq(%i[title author])
    end
  end
end
