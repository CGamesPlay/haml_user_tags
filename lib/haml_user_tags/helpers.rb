require 'delegate'

module HamlUserTags
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
      unless name =~ HamlUserTags::TAG_NAME_REGEX
        raise "define_tag: #{name.inspect} is not a valid custom tag name. It must match #{HamlUserTags::TAG_NAME_REGEX}"
      end

      func = proc do |attributes = {}, &contents|
        @haml_buffer ||= Haml::Buffer.new(nil, Haml::Options.defaults)
        tag.binding.eval("proc { |v| _hamlout = v }").call @haml_buffer
        # Use a proxy String class that will only evaluate its contents once
        # it is referenced. This make the behavior similar to how "yield"
        # would be in a ruby helper.
        content_getter = LazyContents.new { capture_haml &contents } if contents
        capture_haml { instance_exec attributes, content_getter, &tag }
      end

      define_singleton_method name, &func
      if self.is_a?(Module)
        define_method name, &func
      end
    end

    def import_tags path
      source = File.read path
      HamlUserTags::Engine.new(source).extend_object self
      nil
    end
  end

  class LazyContents < DelegateClass(String)
    def initialize(&generator)
      @generator = generator
    end

    def __getobj__
      unless @results
        @results, @generator = @generator.call, nil
      end
      @results
    end
  end
end

module Haml
  module Helpers
    include HamlUserTags::Helpers
  end
end
