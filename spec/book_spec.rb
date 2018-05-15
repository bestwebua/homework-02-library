require_relative '../app/constructor'
require_relative '../app/classes/book'

describe Book do
  subject(:book) { Book.new(title: 'Test Book', author: 'Anonymous') }

  describe '#new' do
    subject(:fail_book) { Book.new }

    it 'should raise an ArgumentError error if arguments not passed' do
      expect {fail_book}.to raise_error(ArgumentError)
    end

    it 'object should be an instance of Book class' do
      expect(book).to be_an_instance_of(Book)
    end
  end

  describe '#title' do
    it "should return book's title" do
      expect(book.title).to eq('Test Book')
    end
  end

  describe '#author' do
    it 'should return author of the book' do
      expect(book.author).to eq('Anonymous')
    end
  end

  describe '#attributes' do
    it 'should return all Book attr_reader attributes as array' do
      expect(book.attributes).to eq([:title, :author])
    end
    
    it 'should return all Book attr_reader attributes in default order' do
      expect(book.attributes).to_not eq([:author, :title])
    end

    it 'should return Book attr_reader attributes only' do
      expect(book.attributes).to_not eq([:title, :author, :some_attr])
    end
  end
end
