require_relative '../app/constructor'

library_union_loader

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
