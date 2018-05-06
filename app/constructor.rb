class LibraryUnionClass
  def self.attr_reader(*attrs)
    @attributes ||= []
    @attributes += attrs
    super
  end

  def self.attributes
    @attributes
  end

  def attributes
    self.class.attributes
  end
end

class Constructor
  def self.build
    self.library_union_loader

    path = "#{File.expand_path(File.dirname(__FILE__))}"
    files = Dir.glob("#{path}/*/*")
    pattern = /.+\/app\/(.+)\/(.+).rb\z/

    files.group_by { |i| i[/#{pattern}/,1] }.map do |type, files|
      [type, files.map { |file| file[/#{pattern}/,2] }]
    end.to_h
  end

  def self.attributes
    @attributes ||= self.build['classes'].map { |attribute| (attribute + 's').to_sym }
  end

  def self.classes
    @classes ||=
      self.build['classes'].map do |classe|
        classe.capitalize!
        [classe, eval("#{classe}").attributes]
      end.to_h
  end

  def self.instance_variable(target)
    @vars ||= self.classes.keys.zip(self.attributes.map { |item| '@' + item.to_s }).to_h
    @vars[target]
  end

  def self.modules
    @modules ||= self.build['modules'].map(&:capitalize)
  end

  private

  def self.library_union_loader
    app_root = "#{File.expand_path(File.dirname(__FILE__))}"
    Dir.glob("#{app_root}/*/*").each { |file| require file }
  end
end
