require_relative '../app/constructor'
require_relative '../app/classes/order'

describe Order do
  let(:valid_order)      { Order.new(book: 'Book', reader: 'Reader', date: 'Date') }
  let(:next_valid_order) { Order.new(book: 'Book', reader: 'Reader', date: 'Date') }

  describe '#new' do
    it 'should raise an ArgumentError error if arguments not passed' do
      expect {subject}.to raise_error(ArgumentError)
    end

    it 'object should be an instance of Order class' do
      expect(valid_order).to be_an_instance_of(Order)
    end
  end

  describe '#book' do
    it 'should return book from the order' do
      expect(valid_order.book).to eq('Book')
    end
  end

  describe '#reader' do
    it 'should return reader from the order' do
      expect(valid_order.reader).to eq('Reader')
    end
  end

  describe '#date' do
    it 'should return date from the order' do
      expect(valid_order.date).to eq('Date')
    end
  end

  describe '#id' do
    it 'should return unique order id' do
      expect(valid_order.id).to_not eq(next_valid_order.id)
    end
  end

  describe '#attributes' do
    it 'should return all Order attr_reader attributes as array' do
      expect(valid_order.attributes).to eq(%i[book reader date id])
    end
  end
end
