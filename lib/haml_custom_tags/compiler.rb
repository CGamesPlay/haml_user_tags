module HamlCustomTags
  class Compiler < Haml::Compiler
    def compile(node)
      if node.type == :tag and node.value[:name] =~ HamlCustomTags::TAG_NAME_REGEX
        node = convert_custom_tag_to_script node
      end
      super node
    end

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

    private
    def convert_custom_tag_to_script(node)
      t = node.value
      attributes = t[:attributes]
      attributes_hashes = t[:attributes_hashes]
      object_ref = t[:object_ref]

      if object_ref == "nil" and attributes.length == 0 and attributes_hashes.empty?
        attributes = "{}"
      else
        if attributes_hashes.empty?
          attributes_hashes = ''
        elsif attributes_hashes.size == 1
          attributes_hashes = ", #{attributes_hashes.first}"
        else
          attributes_hashes = ", #{attributes_hashes.join(", ")}"
        end
        attributes = "HamlCustomTags::Compiler.attributes_hash(#{inspect_obj(t[:attributes])}, #{object_ref}#{attributes_hashes})"
      end

      if node.children.length > 0
        contents = " do"
      elsif t[:value] and t[:parse]
        contents = " { #{t[:value]} }"
      elsif t[:value] and not t[:parse]
        contents = " { #{inspect_obj t[:value]} }"
      end

      code = "#{t[:name]}(#{attributes})#{contents}"
      script_value = t.clone.update({
        :text => code,
        :escape_html => false,
        :preserve => false,
        :keyword => nil,
        :value => nil,
        :parse => nil,
      })
      Haml::Parser::ParseNode.new(:script, node.line, script_value, node.parent, node.children)
    end
  end
end
