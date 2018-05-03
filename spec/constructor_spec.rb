require 'fileutils'
require_relative '../app/constructor'

describe 'LibraryUnionClass' do
  it 'return true' do
    expect(defined?(LibraryUnionClass)).to eq('constant')
  end
end

describe '#library_union_loader' do

  subject(:modules_files) do
    Dir.new('app/modules').entries.select { |file| file[/(.+)\.rb/] }.size
  end
  subject(:classes_files) do
    Dir.new('app/classes').entries.select { |file| file[/(.+)\.rb/] }.size
  end
  subject(:loaded_modules) { Constructor.modules.size }
  subject(:loaded_classes) { Constructor.classes.keys.size }

  it 'should load all *.rb files from modules dir' do
    expect(modules_files).to eq(loaded_modules)
  end

  it 'should load all *.rb files from classes dir' do
    expect(classes_files).to eq(loaded_classes)
  end
end

describe Constructor do

# How to load it before Constructor class run?
  let!(:load_test_classes) do
    classes_dir = "#{File.expand_path('../app/classes', File.dirname(__FILE__))}"
    test_classes_dir = "#{File.expand_path('./test_classes/.', File.dirname(__FILE__))}"
    test_classes_files = Dir.glob("#{test_classes_dir}/*.rb")
    test_classes_files.each { |file| FileUtils.cp(file, classes_dir) }
  end

  subject(:constructor) { Constructor }

=begin
# How do this code after finish all Constructor class tests
  let(:delete_test_classes) do
    classes_dir = "#{File.expand_path('../app/classes', File.dirname(__FILE__))}"
    classes_files = Dir.glob("#{classes_dir}/*.rb")
    test_classes_dir = "#{File.expand_path('./test_classes/.', File.dirname(__FILE__))}"
    test_classes_files = Dir.glob("#{test_classes_dir}/*.rb")
    files_to_delete = (classes_files & test_classes_files)
    files_to_delete.each { |file| remove_file(file, force = false) }
  end
=end

  describe '.build' do
    subject(:build) { constructor.build }

    it 'should be a hash' do
      expect(build.is_a?(Hash)).to eq(true)
    end

    it 'should be a string' do
      expect(build.keys.all? { |i| i.is_a?(String)}).to eq(true)
    end

    it 'should be an array' do
      expect(build.values.all? { |i| i.is_a?(Array)}).to eq(true)
    end

    it "should include string 'classes' as a key" do
      expect(build.has_key?('classes')).to eq(true)
    end

    it "should return an array by 'classes' key" do
      expect(build['classes'].is_a?(Array)).to eq(true)
    end

    it "should include string 'test' by 'classes' key" do
      expect(build['classes'].include?('test'))
    end
  end

  describe '.attributes' do
    subject(:attributes) { constructor.attributes }

    it 'should be an array' do
      expect(attributes.is_a?(Array)).to eq(true)
    end

    it 'should include :tests' do
      expect(attributes.include?(:tests)).to eq(true)
    end
  end

  describe '.classes' do
    subject(:classes) { constructor.classes }

    it 'should be a hash' do
      expect(classes.is_a?(Hash)).to eq(true)
    end

    it "should include string 'Test' as a key" do
      expect(classes.has_key?('Test')).to eq(true)
    end

    it "should return an array by 'Test' key" do
      expect(classes['Test'].is_a?(Array)).to eq(true)
    end

    it "should include :test_attr by 'Test' key" do
      expect(classes['Test'].include?(:test_attr)).to eq(true)
    end
  end

=begin
  # `instance_variable` is not available on an example group... How test it?
  describe '.instance_variable' do
    subject(:instance_variable) { constructor.instance_variable('Test') }

    puts instance_variable
  end

  # `modules` is not available on an example group... How test it?
  describe '.modules' do
  subject(:modules) { constructor.modules }

    puts modules
  end
=end

end