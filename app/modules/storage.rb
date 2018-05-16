require 'yaml'

module Storage
  attr_reader :filename
  
  def load(filename)
    
    begin
      file = File.open("#{File.absolute_path('data')}/#{filename}.yml", 'r')
    rescue
      raise ArgumentError, 'File not found'
    end

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
    autoname = "data-#{Time.now.strftime('%Y%m%d-%H%M%S')}"
    was_opened = @filename && custom_filename.nil?

    filename = case
      when was_opened then @filename
      when was_opened || custom_filename.nil? then autoname
      else custom_filename
    end

    @filename = filename

    File.open("#{path}/#{filename}.yml", 'w') { |file| file.write(YAML.dump(self)) }
  end
end
