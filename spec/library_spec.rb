require_relative '../app/library'

describe 'Constructor class loader' do
  subject(:was_constructor_loaded?) { defined?(Constructor) == 'constant' }

  it 'should return true' do
    expect(was_constructor_loaded?).to eq(true)
  end
end

describe Library do
  describe '#new' do
    it 'object should be an instance of Library class' do
      expect(subject).to be_an_instance_of(Library)
    end

    describe 'attr_accessor' do
      subject(:accessors) do
        Library.new.instance_variables.map { |acc| acc[/[^@]+/].to_sym }
      end

      it 'attribute accessors should created dynamically' do
        expect(accessors).to eq(Constructor.attributes)
      end
    end
  end

  
end