require 'pygments'

Haml::Options.defaults[:compiler_class] = HamlUserTags::Compiler
layout 'layout.html.haml'
ignore /\/_.*/
helpers do
  extend HamlUserTags::Helpers
  include_tags "_bootstrap.html.haml"
  include_tags "_haml_user_tags.html.haml"

  def link_to content, options
    "<a href=\"#\">#{content}</a>"
  end
end
