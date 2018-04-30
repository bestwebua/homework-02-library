require_relative '../app/library'

describe 'Constructor class loader' do
  subject(:was_constructor_loaded?) { defined?(Constructor) == 'constant' }

  it 'should return true' do
    expect(was_constructor_loaded?).to eq(true)
  end
end

describe Library do
  subject(:library) { Library.new }

  describe '#new' do
    it 'object should be an instance of Library class' do
      expect(subject).to be_an_instance_of(Library)
    end

    describe 'attr_accessor' do
      subject(:accessors) do
        library.instance_variables.map { |acc| acc[/[^@]+/].to_sym }
      end

      it 'attribute accessors should created dynamically' do
        expect(accessors).to eq(Constructor.attributes)
      end
    end
  end

  describe '#add' do
    describe '#subject.authors' do
      subject(:authors) do
        library.add('author', name: 'Test Author', biography: 'Bio')
      end

      it 'should equal to 1 if new author was added' do
        expect(authors.size).to eq(1)
      end

      it "should return true if item is an object of Author's class" do
        expect(authors.last.is_a?(Author)).to eq(true)
      end
    end

    describe '#subject.books' do
      subject(:books) do
        library.add('book', title: 'Test Book', author: library.authors.last)
      end

      it 'should equal to 1 if new book was added' do
        expect(books.size).to eq(1)
      end

      it "should return true if item is an object of Book's class" do
        expect(books.last.is_a?(Book)).to eq(true)
      end
    end

    describe '#subject.readers' do
      subject(:readers) do
        library.add('reader', name: 'John Doe', email: 'john_doe@domain.com', city: 'City', street: 'Street', house: '42')
      end

      it 'should equal to 1 if new reader was added' do
        expect(readers.size).to eq(1)
      end

      it "should return true if item is an object of Reader's class" do
        expect(readers.last.is_a?(Reader)).to eq(true)
      end
    end

    describe '#subject.orders' do
      subject(:orders) do
        library.add('order', book: library.books.last, reader: library.readers.last, date: Time.now.strftime('%d.%m.%y'))
      end

      it 'should equal to 1 if new order was added' do
        expect(orders.size).to eq(1)
      end

      it "should return true if item is an object of Order's class" do
        expect(orders.last.is_a?(Order)).to eq(true)
      end
    end

  end

  describe '#delete' do
    describe '#subject.authors' do
      subject(:authors) do
        library.delete('author', name: 'Test Author')
      end

      it 'should equal to 0 if author was found and deleted' do
        expect(authors.size).to eq(0)
      end
    end

    describe '#subject.books' do
      subject(:books) do
        library.delete('book', title: 'Test Book')
      end

      it 'should equal to 0 if book was found and deleted' do
        expect(books.size).to eq(0)
      end
    end

    describe '#subject.readers' do
      subject(:readers) do
        library.delete('reader', name: 'John Doe')
      end

      it 'should equal to 0 if book was found and deleted' do
        expect(readers.size).to eq(0)
      end
    end

    describe '#subject.orders' do
      subject(:orders) do
        library.delete('order', id: '00001')
      end

      it 'should equal to 0 if order was found and deleted' do
        expect(orders.size).to eq(0)
      end
    end
  end

end