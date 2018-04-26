require_relative '../app/book'

describe Book do
  describe 'new instance of class Book' do
    subject(:fail_book) { Book.new }
    subject(:book) { Book.new('Test Book', 'Anonymous') }

    it 'should raise an ArgumentError error if arguments not passed' do
      expect {fail_book}.to raise_error(ArgumentError)
    end

    it 'object should be an instance of Book class' do
      expect(book).to be_an_instance_of(Book)
    end
  end
end