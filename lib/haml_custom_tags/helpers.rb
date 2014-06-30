module HamlCustomTags
  module Helpers
    def define_tag name, &tag
      unless name =~ HamlCustomTags::TAG_NAME_REGEX
        raise "define_tag: #{name.inspect} is not a valid custom tag name. It must match #{HamlCustomTags::TAG_NAME_REGEX}"
      end
      define_singleton_method name do |attributes, &contents|
        capture_haml do
          eval "_hamlout = @haml_buffer", tag.binding
          contents = capture_haml(&contents) if contents
          tag.call attributes, contents
        end
      end
    end
  end
end

module Haml
  module Helpers
    include HamlCustomTags::Helpers
  end
end
