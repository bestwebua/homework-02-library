def library_union_class_loader
  path = "#{File.expand_path(File.dirname(__FILE__))}"
  Dir["#{path}/classes/*.rb"].each { |file| require file }
end

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

library_union_class_loader

class Constructor
  def self.build
    path = "#{File.expand_path(File.dirname(__FILE__))}/classes"
    Dir.new(path).entries
  end

  def self.files
    @files ||= self.dir.select { |file| file[/(.+)\.rb/] }
  end

  def self.attributes
    @attributes ||= self.files.map { |attribute| (attribute[/(.+)\./,1] + 's').to_sym }
  end

  def self.classes
    @classes ||=
      self.files.map do |classe|
        classe = classe[/(.+)\./,1].capitalize
        [classe, eval("#{classe}").attributes]
      end.to_h
  end

  class << self

    protected
    def dir
      @dir ||= self.build
    end
  end
end
