require_relative '../app/constructor'

library_union_class_loader

describe '#library_union_class_loader' do
  subject(:loaded_classes) { Constructor.classes.keys.size }
  subject(:rb_files) do
    Dir.new("app/classes").entries.select { |file| file[/(.+)\.rb/] }.size
  end

  it 'should load all *.rb files from classes dir' do
    expect(loaded_classes).to eq(rb_files)
  end
end
