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
    describe '#authors' do
      let(:add_author) { library.add('author', name: 'Test Author', biography: 'Bio') }

      it 'size should be changed if new author was added' do
        expect { add_author }.to change { library.authors.size }.from(0).to(1)
      end

      it 'return true' do
        expect(add_author.last).to be_an_instance_of(Author)
      end
    end

    describe '#books' do
      let(:add_book) { library.add('book', title: 'Test Book', author: library.authors.last) }

      it 'size should be changed if new book was added' do
        expect { add_book }.to change { library.books.size }.from(0).to(1)
      end

      it 'return true' do
        expect(add_book.last).to be_an_instance_of(Book)
      end
    end

    describe '#readers' do
      let(:add_reader) do
        library.add('reader', name: 'John Doe', email: 'john_doe@domain.com', city: 'City', street: 'Street', house: '42')
      end

      it 'size should be changed if new book was added' do
        expect { add_reader }.to change { library.readers.size }.from(0).to(1)
      end

      it 'return true' do
        expect(add_reader.last).to be_an_instance_of(Reader)
      end
    end

    describe '#orders' do
      let(:add_order) do
        library.add('order', book: library.books.last, reader: library.readers.last, date: Time.now.strftime('%d.%m.%y'))
      end

      it 'size should be changed if new order was added' do
        expect { add_order }.to change { library.orders.size }.from(0).to(1)
      end

      it 'return true' do
        expect(add_order.last).to be_an_instance_of(Order)
      end
    end
  end

  describe '#delete' do
    let(:library_with_data) { library.load('test'); library }
    
    describe '#authors' do
      let(:remove_authors) do
        library_with_data.delete('author', name: 'Test Author')
      end

      it 'size should be changed if author was found and deleted' do
        expect { remove_authors }.to change { library_with_data.authors.size }.from(1).to(0)
      end
    end

    describe '#books' do
      let(:remove_books) do
        library_with_data.delete('book', title: 'Test Book 0')
      end

      it 'size should be changed if book was found and deleted' do
        expect { remove_books }.to change { library_with_data.books.size }.from(1).to(0)
      end
    end

    describe '#readers' do
      let(:remove_readers) do
        library.delete('reader', name: 'John Doe')
      end

      it 'size should be changed if book was found and deleted' do
        expect { remove_readers }.to change { library_with_data.readers.size }.from(2).to(1)
      end
    end

    describe '#orders' do
      let(:remove_order) do
        library.delete('order', id: 1)
      end

      it 'size should be changed if order was found and deleted' do
        expect { remove_order }.to change { library_with_data.orders.size }.from(1).to(0)
      end
    end
  end

  describe '#top_reader' do
    before           { library.load('rspec') }
    let(:top_reader) { library.top_reader }

    context 'without orders' do
      it 'return nil' do
        allow(library).to receive(:orders) { [] }
        expect(top_reader).to be_nil
      end
    end

    context 'with orders' do
      it 'should equal to most active reader' do
        expect(top_reader.name).to eq('John Doe')
      end
    end
  end

  describe '#top_book' do
    before         { library.load('rspec') }
    let(:top_book) { library.top_book }

    context 'without orders' do
      it 'return nil' do
        allow(library).to receive(:orders) { [] }
        expect(top_book).to be_nil
      end
    end

    context 'with orders' do
      it 'should equal to most popular book' do
        expect(top_book.title).to eq('Test Book 0')
      end
    end
  end

  describe '#count_readers_of_bestsellers_top_3' do
    before        { library.load('rspec') }
    let(:get_top) { library.count_readers_of_bestsellers_top_3 }

    context 'without orders' do
      it 'return 0' do
        allow(library).to receive(:orders) { [] }
        expect(get_top).to be_zero
      end
    end

    context 'with orders' do
      it 'return count for uniq readers only' do
        expect(get_top).to eq(1)
      end
    end
  end

  describe '#load' do
    let(:without_filename) { library.load }
    let(:nonexistent_file) { library.load('nonexistent_file') }
    let(:existing_file)    { library.load('rspec') }
    let(:successful_load)  { library.load('rspec'); library.filename }

    it 'raise an ArgumentError error' do
      expect { without_filename }.to raise_error(ArgumentError)
    end

    it "return 'File not found'" do
      expect { nonexistent_file }.to raise_error(ArgumentError, 'File not found')
    end

    it "return 'Data import was completed successfully!'" do
      expect(existing_file).to eq('Data import was completed successfully!')
    end

    it 'return source file name which data was loaded' do
      expect(successful_load).to eq('rspec')
    end
  end

  describe '#save' do
    let(:load_and_save_without_filename) do
      library.load('rspec')
      library.add('author', name: 'TestName', biography: 'Bio')
      library.save
      library.load('rspec')
      library.authors.last.name
    end

    let(:load_and_save_with_new_name) do
      library.load('rspec')
      library.delete('author', name: 'TestName')
      library.save('rspec')
      library.load('rspec')
      library.authors.last.name
    end

    let(:save_without_filename) do
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
