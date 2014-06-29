module HamlCustomTags
  class Compiler < Haml::Compiler
    def compile(node)
      if node.type == :tag and node.value[:name] =~ HamlCustomTags::TAG_NAME_REGEX
        puts node.inspect
        node = convert_custom_tag_to_script node
        puts node.inspect
      end
      super node
    end

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

      if attributes_hashes.empty?
        attributes_hashes = ''
      elsif attributes_hashes.size == 1
        attributes_hashes = ", #{attributes_hashes.first}"
      else
        attributes_hashes = ", #{attributes_hashes.join(", ")}"
      end

      attributes = "HamlCustomTags::Compiler.attributes_hash(#{inspect_obj(t[:attributes])}, #{object_ref}#{attributes_hashes})"

      code = "#{t[:name]}(#{attributes})#{node.children.length > 0 ? " do" : ""}"
      script_value = {
        :text => code,
        :escape_html => false,
        :preserve => false,
        :keyword => nil,
      }
      Haml::Parser::ParseNode.new(:script, node.line, script_value, node.parent, node.children)
    end
  end
end
