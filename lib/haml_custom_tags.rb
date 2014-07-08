require "haml"
require "haml_custom_tags/version"
require "haml_custom_tags/compiler"
require "haml_custom_tags/engine"
require "haml_custom_tags/helpers"

module HamlCustomTags
  TAG_NAME_REGEX = /^[A-Z][a-zA-Z]+$/
end

if defined? ActiveSupport
  require 'haml_custom_tags/rails/helpers'
  require "haml_custom_tags/rails/reloader"

  # Set up Haml to use HamlCustomTags by default
  Haml::Template.options[:compiler_class] = HamlCustomTags::Compiler
end
