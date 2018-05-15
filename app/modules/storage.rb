require 'yaml'

module Storage
  attr_reader :filename
  
  def load(filename)
    return 'File not found' unless File.exist?("#{File.absolute_path('data')}/#{filename}.yml")
    
    file = File.new("#{File.absolute_path('data')}/#{filename}.yml", 'r')
    import = YAML.load(file)
    
    self.instance_variables.each do |inst_var|
      import_var = import.instance_eval { eval("#{inst_var}") }
      instance_variable_set(inst_var, import_var)
    end

    @filename = filename

    'Data import was completed successfully!'
  end

  def save(custom_filename=nil)
    path = "#{File.absolute_path('data')}"
    autoname = ('data-' + Time.now.strftime('%Y%m%d-%H%M%S'))

    filename = case
      when @filename && custom_filename.nil? then @filename
      when (@filename && custom_filename.nil?) || custom_filename.nil? then autoname
      else custom_filename
    end

    @filename = filename

    File.open("#{path}/#{filename}.yml", 'w') { |file| file.write(YAML.dump(self)) }
  end
end
