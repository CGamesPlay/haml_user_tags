module HamlUserTags
  module Helpers
    module AttributesWithIndifference
      def attributes_hash *args
        ActiveSupport::HashWithIndifferentAccess.new super(*args)
      end
    end
    singleton_class.prepend AttributesWithIndifference

    alias_method :include_tags_without_rails, :include_tags
    # Override the base include_tags to take advantage of Rails' template
    # location features
    def include_tags path
      view_paths = ActionController::Base._view_paths
      lookup_context = ActionView::LookupContext.new(view_paths, {}, [])
      template = lookup_context.find_template(path, [], true)
      HamlUserTags::Engine.new(template.source, :filename => template.identifier).extend_object self
      nil
    end
  end
end
