require_relative '../app/constructor'
require_relative '../app/classes/reader'

describe Reader do
  subject(:reader) { Reader.new(name: 'Name', email: 'email@email.com', city: 'City', street: 'Street', house: 'House') }

  describe '#new' do
    subject(:fail_reader) { Reader.new }

    it 'should raise an ArgumentError error if arguments not passed' do
      expect {fail_reader}.to raise_error(ArgumentError)
    end

    it 'object should be an instance of Reader class' do
      expect(reader).to be_an_instance_of(Reader)
    end
  end

  describe '#name' do
    it "should return reader's name" do
      expect(reader.name).to eq('Name')
    end
  end

  describe '#email' do
    it "should return reader's email" do
      expect(reader.email).to eq('email@email.com')
    end
  end

  describe '#city' do
    it "should return reader's city" do
      expect(reader.city).to eq('City')
    end
  end

  describe '#street' do
    it "should return reader's street" do
      expect(reader.street).to eq('Street')
    end
  end

  describe '#house' do
    it "should return reader's house" do
      expect(reader.house).to eq('House')
    end
  end

  describe '#attributes' do
    it 'should return all Reader attr_reader attributes as array' do
      expect(reader.attributes).to eq([:name, :email, :city, :street, :house])
    end

    it 'should return all Reader attr_reader attributes in default order' do
      expect(reader.attributes).to_not eq([:email, :name, :city, :street, :house])
    end

    it 'should return Reader attr_reader attributes only' do
      expect(reader.attributes).to_not eq([:name, :email, :city, :street, :house, :some_attr])
    end
  end
end
