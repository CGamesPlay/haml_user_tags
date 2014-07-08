require "haml"
require "haml_user_tags/version"
require "haml_user_tags/compiler"
require "haml_user_tags/engine"
require "haml_user_tags/helpers"

module HamlUserTags
  TAG_NAME_REGEX = /^[A-Z][a-zA-Z]+$/
end

if defined? ActiveSupport
  require 'haml_user_tags/rails/helpers'
  require "haml_user_tags/rails/reloader"

  # Set up Haml to use HamlUserTags by default
  Haml::Template.options[:compiler_class] = HamlUserTags::Compiler
end
