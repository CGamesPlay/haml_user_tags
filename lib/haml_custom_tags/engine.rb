module HamlCustomTags
  class Engine < Haml::Engine
    def initialize(template, options = {})
      options = options.clone.update(:compiler_class => HamlCustomTags::Compiler)
      super template, options
    end
  end
end
