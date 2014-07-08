module HamlUserTags
  class Engine < Haml::Engine
    def initialize(template, options = {})
      options = options.clone.update(:compiler_class => HamlUserTags::Compiler)
      super template, options
    end

    # Defines a method for each custom tag in the template that renders the tag
    # and returns the result as a string.
    def extend_object obj
      mod = Module.new
      mod.send :include, Haml::Helpers
      render mod
      method = obj.is_a?(Module) ? :include : :extend
      obj.send method, mod
    end
  end
end
