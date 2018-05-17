require_relative '../app/constructor'
require_relative '../app/classes/reader'

describe Reader do
  let(:valid_reader) do
    Reader.new(name: 'Name', email: 'email@email.com', city: 'City', street: 'Street', house: 'House')
  end

  describe '#new' do
    it 'should raise an ArgumentError error if arguments not passed' do
      expect {subject}.to raise_error(ArgumentError)
    end

    it 'object should be an instance of Reader class' do
      expect(valid_reader).to be_an_instance_of(Reader)
    end
  end

  describe '#name' do
    it "should return reader's name" do
      expect(valid_reader.name).to eq('Name')
    end
  end

  describe '#email' do
    it "should return reader's email" do
      expect(valid_reader.email).to eq('email@email.com')
    end
  end

  describe '#city' do
    it "should return reader's city" do
      expect(valid_reader.city).to eq('City')
    end
  end

  describe '#street' do
    it "should return reader's street" do
      expect(valid_reader.street).to eq('Street')
    end
  end

  describe '#house' do
    it "should return reader's house" do
      expect(valid_reader.house).to eq('House')
    end
  end

  describe '#attributes' do
    it 'should return all Reader attr_reader attributes as array' do
      expect(valid_reader.attributes).to eq(%i[name email city street house])
    end
  end
end
