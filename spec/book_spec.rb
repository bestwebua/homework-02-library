require_relative '../app/book'

describe Book do
  subject(:book) { Book.new('Test Book', 'Anonymous') }

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
end