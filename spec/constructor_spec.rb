require_relative '../app/constructor'

describe 'LibraryUnionClass' do
  specify { expect(defined?(LibraryUnionClass)).to eq('constant') }
end

describe Constructor do
  before(:context) do
    copied_files, filename_pattern = [], /(.+)\/(.+\.rb)\z/

    classes_dir = "#{File.expand_path('../app/classes', File.dirname(__FILE__))}"
    test_classes_dir = "#{File.expand_path('./test_classes/.', File.dirname(__FILE__))}"
    test_classes_files = Dir.glob("#{test_classes_dir}/*.rb")

    test_classes_files.each do |file|
      FileUtils.cp(file, classes_dir)
      copied_files << file
    end

    copied_files.map! { |file| file[/#{filename_pattern}/,2] }

    @files_to_del = Dir.glob("#{classes_dir}/*.rb").select do |file|
      copied_files.include?(file[/#{filename_pattern}/,2])
    end
  end

  after(:context) do
    @files_to_del.each { |file| File.delete(file) }
  end

  subject(:constructor) { Constructor }

  describe '.library_union_loader' do
    let(:modules_files)  { Dir.new('app/modules').entries.select { |file| file[/(.+)\.rb/] }.size }
    let(:classes_files)  { Dir.new('app/classes').entries.select { |file| file[/(.+)\.rb/] }.size }
    let(:loaded_modules) { Constructor.modules.size }
    let(:loaded_classes) { Constructor.classes.keys.size }

    it 'should load all *.rb files from modules dir' do
      expect(modules_files).to eq(loaded_modules)
    end

    it 'should load all *.rb files from classes dir' do
      expect(classes_files).to eq(loaded_classes)
    end
  end

  describe '.build' do
    let(:build) { constructor.build }

    it 'should be a hash' do
      expect(build).to be_an_instance_of(Hash)
    end

    it 'should be a string' do
      expect(build.keys.all? { |i| i.is_a?(String)}).to eq(true)
    end

    it 'should be an array' do
      expect(build.values.all? { |i| i.is_a?(Array)}).to eq(true)
    end

    it "should include string 'classes' as a key" do
      expect(build).to have_key('classes')
    end

    it "should return an array by 'classes' key" do
      expect(build['classes']).to be_an_instance_of(Array)
    end

    it "should include string 'test' by 'classes' key" do
      expect(build['classes'].include?('test')).to eq(true)
    end
  end

  describe '.attributes' do
    let(:attributes) { constructor.attributes }

    it 'should be an array' do
      expect(attributes).to be_an_instance_of(Array)
    end

    it 'should include :tests' do
      expect(attributes.include?(:tests)).to eq(true)
    end
  end

  describe '.classes' do
    let(:classes) { constructor.classes }

    it 'should be a hash' do
      expect(classes).to be_an_instance_of(Hash)
    end

    it "should include string 'Test' as a key" do
      expect(classes).to have_key('Test')
    end

    it "should return an array by 'Test' key" do
      expect(classes['Test']).to be_an_instance_of(Array)
    end

    it "should include :test_attr by 'Test' key" do
      expect(classes['Test'].include?(:test_attr)).to eq(true)
    end
  end

  describe '.instance_variable' do
    let(:instance_variable) { constructor.instance_variable('Test') }
    let(:fail_target)       { constructor.instance_variable('Someconst') }

    it 'should be a string' do
      expect(instance_variable).to be_an_instance_of(String)
    end

    it "should return '@tests' value by 'Test' key" do
      expect(instance_variable).to eq('@tests')
    end

    it 'should raise an TypeError error' do
      expect {fail_target}.to raise_error(TypeError)
    end
  end

  describe '.modules' do
    let(:modules) { constructor.modules.sort }
    let(:modules_files) do
      Dir.new('app/modules').entries.map { |file| file[/(.+)\.rb/,1] }.compact.map(&:capitalize).sort
    end

    it 'should be an array' do
      expect(modules).to be_an_instance_of(Array)
    end

    it 'should be equal to real files' do
      expect(modules).to eq(modules_files)
    end
  end
end
