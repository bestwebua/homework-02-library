require_relative '../app/library'

describe 'Constructor class loader' do
  subject(:was_constructor_loaded?) { defined?(Constructor) == 'constant' }

  it 'return true' do
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

      it 'attribute accessors should be created dynamically' do
        expect(accessors).to eq(Constructor.attributes)
      end
    end
  end

  describe '#add' do
    describe '#subject.authors' do
      subject(:authors) do
        library.add('author', name: 'Test Author', biography: 'Bio')
      end

      it 'equal to 1 if new author was added' do
        expect(authors.size).to eq(1)
      end

      it "return true if item is an object of Author's class" do
        expect(authors.last.is_a?(Author)).to eq(true)
      end
    end

    describe '#subject.books' do
      subject(:books) do
        library.add('book', title: 'Test Book', author: library.authors.last)
      end

      it 'equal to 1 if new book was added' do
        expect(books.size).to eq(1)
      end

      it "return true if item is an object of Book's class" do
        expect(books.last.is_a?(Book)).to eq(true)
      end
    end

    describe '#subject.readers' do
      subject(:readers) do
        library.add('reader', name: 'John Doe', email: 'john_doe@domain.com', city: 'City', street: 'Street', house: '42')
      end

      it 'equal to 1 if new reader was added' do
        expect(readers.size).to eq(1)
      end

      it "return true if item is an object of Reader's class" do
        expect(readers.last.is_a?(Reader)).to eq(true)
      end
    end

    describe '#subject.orders' do
      subject(:orders) do
        library.add('order', book: library.books.last, reader: library.readers.last, date: Time.now.strftime('%d.%m.%y'))
      end

      it 'equal to 1 if new order was added' do
        expect(orders.size).to eq(1)
      end

      it "return true if item is an object of Order's class" do
        expect(orders.last.is_a?(Order)).to eq(true)
      end
    end

  end

  describe '#delete' do
    describe '#subject.authors' do
      subject(:authors) do
        library.delete('author', name: 'Test Author')
      end

      it 'equal to 0 if author was found and deleted' do
        expect(authors.size).to eq(0)
      end
    end

    describe '#subject.books' do
      subject(:books) do
        library.delete('book', title: 'Test Book')
      end

      it 'equal to 0 if book was found and deleted' do
        expect(books.size).to eq(0)
      end
    end

    describe '#subject.readers' do
      subject(:readers) do
        library.delete('reader', name: 'John Doe')
      end

      it 'equal to 0 if book was found and deleted' do
        expect(readers.size).to eq(0)
      end
    end

    describe '#subject.orders' do
      subject(:orders) do
        library.delete('order', id: '00001')
      end

      it 'equal to 0 if order was found and deleted' do
        expect(orders.size).to eq(0)
      end
    end
  end

  describe '#top_reader' do
    subject(:fail_top_reader) { library.top_reader }
    subject(:top_reader) do
      library.load('rspec')
      library.top_reader
    end

    it 'return nil if nothing found' do
      expect(fail_top_reader).to eq(nil)
    end

    it 'should equal to most active reader' do
      expect(top_reader.name).to eq('John Doe')
    end
  end

  describe '#top_book' do
    subject(:fail_top_book) { library.top_book }
    subject(:top_book) do
      library.load('rspec')
      library.top_book
    end

    it 'return nil if nothing found' do
      expect(fail_top_book).to eq(nil)
    end

    it 'should equal to most popular book' do
      expect(top_book.title).to eq('Test Book 0')
    end
  end

  describe '#count_readers_of_bestsellers_top3' do
    subject(:empty_top) { library.count_readers_of_bestsellers_top3 }
    subject(:top3_books_uniq_readers) do
      library.load('rspec')
      library.count_readers_of_bestsellers_top3
    end

    it 'return 0 if readers of top3 was not found' do
      expect(empty_top).to eq(0)
    end

    it 'return count for uniq readers only' do
      expect(top3_books_uniq_readers).to eq(1)
    end
  end

  describe '#load' do
    subject(:without_filename) { library.load }
    subject(:nonexistent_file) { library.load('nonexistent_file') }
    subject(:existing_file)    { library.load('rspec') }
    subject(:successful_load)  { library.load('rspec') and library.filename }

    it 'raise an ArgumentError error' do
      expect { without_filename }.to raise_error(ArgumentError)
    end

    it "return 'File not found'" do
      expect(nonexistent_file).to eq('File not found')
    end

    it "return 'Data import was completed successfully!'" do
      expect(existing_file).to eq('Data import was completed successfully!')
    end

    it 'return source file name which data was loaded' do
      expect(successful_load).to eq('rspec')
    end
  end

  describe '#save' do
    subject(:load_and_save_without_filename) do
      library.load('rspec')
      library.add('author', name: 'TestName', biography: 'Bio')
      library.save
      library.load('rspec')
      library.authors.last.name
    end

    subject(:load_and_save_with_new_name) do
      library.load('rspec')
      library.delete('author', name: 'TestName')
      library.save('rspec')
      library.load('rspec')
      library.authors.last.name
    end

    subject(:save_without_filename) do
      new_library = Library.new
      new_library.add('author', name: 'TestName', biography: 'Bio')
      new_library.save
      autonamed_file = new_library.filename
    end

    it 'return true' do
      expect(load_and_save_without_filename).to eq('TestName')
    end

    it 'return true' do
      expect(load_and_save_with_new_name).to_not eq('TestName')
    end

    it 'return true' do
      file = "#{File.expand_path('../data/.', File.dirname(__FILE__))}/#{save_without_filename}.yml"
      expect(File.exist?(file)).to eq(true)
      File.delete(file)
    end
  end
end
