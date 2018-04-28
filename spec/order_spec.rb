require_relative '../app/constructor'
require_relative '../app/classes/order'

describe Order do
  subject(:order) { Order.new(book: 'Book', reader: 'Reader', date: 'Date') }

  describe '#new' do
    subject(:fail_order) { Order.new }

    it 'should raise an ArgumentError error if arguments not passed' do
      expect {fail_order}.to raise_error(ArgumentError)
    end

    it 'object should be an instance of Order class' do
      expect(order).to be_an_instance_of(Order)
    end
  end

  describe '#book' do
    it "should return book from the order" do
      expect(order.book).to eq('Book')
    end
  end

  describe '#reader' do
    it 'should return reader from the order' do
      expect(order.reader).to eq('Reader')
    end
  end

  describe '#date' do
    it 'should return date from the order' do
      expect(order.date).to eq('Date')
    end
  end
end