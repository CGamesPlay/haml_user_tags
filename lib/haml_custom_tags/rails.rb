module HamlCustomTags
  module Helpers
    def import_tags path
      view_paths = ActionController::Base._view_paths
      lookup_context = ActionView::LookupContext.new(view_paths, {}, [])
      template = nil
      lookup_context.disable_cache do
        template = lookup_context.find_template path
      end
      # Render the template with self and discard the output. Now self has all
      # of the singleton methods defined on it and @defined_tags is populated.
      template.render self, {}
      # If we are a template, we're done.
      return if is_haml?
      # If we're a helper, we need to create instance methods for all of the
      # tags in @defined_tags, because the singleton methods don't carry over
      # beyond the module.
      @defined_tags.each do |name, tag|
        define_method name do |attributes, &contents|
          capture_haml do
            begin
              $__haml_custom_tag_leaked_global = @haml_buffer
              eval "_hamlout = $__haml_custom_tag_leaked_global", tag.binding
            ensure
              $__haml_custom_tag_leaked_global = nil
            end
            contents = capture_haml(&contents) if contents
            self.instance_exec attributes, contents, &tag
          end
        end
      end
    end
  end
end

# Set up Haml to use HamlCustomTags for Rails
Haml::Template.options[:compiler_class] = HamlCustomTags::Compiler
