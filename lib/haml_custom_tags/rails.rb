module HamlCustomTags
  module Helpers
    # Override the base import_tags to take advantage of Rails' template
    # location features
    def import_tags path
      view_paths = ActionController::Base._view_paths
      lookup_context = ActionView::LookupContext.new(view_paths, {}, [])
      template = nil
      source = lookup_context.disable_cache do
        lookup_context.find_template(path).source
      end

      HamlCustomTags::Engine.new(source).extend_object self
      nil
    end

    class << self
      def attributes_hash_with_indifference *args
        ActiveSupport::HashWithIndifferentAccess.new attributes_hash_without_indifference *args
      end
      alias_method_chain :attributes_hash, :indifference
    end
  end
end

# Set up Haml to use HamlCustomTags for Rails
Haml::Template.options[:compiler_class] = HamlCustomTags::Compiler
