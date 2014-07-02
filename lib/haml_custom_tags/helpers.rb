module HamlCustomTags
  module Helpers
    # Same as Haml::Buffer.attributes, but returns the hash instead of writing
    # the attributes to the buffer.
    def self.attributes_hash(class_id, obj_ref, *attributes_hashes)
      attributes = class_id
      attributes_hashes.each do |old|
        Haml::Buffer.merge_attrs(attributes, Hash[old.map {|k, v| [k.to_s, v]}])
      end
      Haml::Buffer.merge_attrs(attributes, Haml::Buffer.new.parse_object_ref(obj_ref)) if obj_ref
      attributes
    end

    def define_tag name, &tag
      unless name =~ HamlCustomTags::TAG_NAME_REGEX
        raise "define_tag: #{name.inspect} is not a valid custom tag name. It must match #{HamlCustomTags::TAG_NAME_REGEX}"
      end

      func = proc do |attributes, &contents|
        @haml_buffer ||= Haml::Buffer.new(nil, Haml::Options.defaults)
        contents = capture_haml(&contents) if contents
        tag.binding.eval("proc { |v| _hamlout = v }").call @haml_buffer
        capture_haml do
          instance_exec attributes, contents, &tag
        end
      end

      define_singleton_method name, &func
      if self.is_a?(Module)
        define_method name, &func
      end
    end

    def import_tags path
      source = File.read path
      HamlCustomTags::Engine.new(source).extend_object self
      nil
    end
  end
end

module Haml
  module Helpers
    include HamlCustomTags::Helpers
  end
end
