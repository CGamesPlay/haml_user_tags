require 'haml_custom_tags'
require 'spec_helper'

EXTERNAL_HAML_FILE = "#{File.dirname(__FILE__)}/haml/external.haml"

module HelperSpecHelper
  extend Haml::Helpers

  import_tags EXTERNAL_HAML_FILE
end

describe HamlCustomTags::Helpers do
  describe "#define_tag" do
    it "renders a basic tag" do
      template = <<EOF
- define_tag :MyTag do |attributes|
  %p content
%MyTag
%MyTag
EOF
      expect(render template).to be == "<p>content</p>\n<p>content</p>\n"
    end

    it "can transfer attributes" do
      template = <<EOF
- define_tag :MyTag do |attributes|
  %p{attributes} content
%MyTag.a
EOF
      expect(render template).to be == "<p class='a'>content</p>\n"
    end

    it "can yield to content" do
      template = <<EOF
- define_tag :MyTag do |attributes, content|
  %p= content
%MyTag content
EOF
      expect(render template).to be == "<p>content</p>\n"
    end
  end

  describe "#import_tags" do
    it "imports into a template" do
      template = "- import_tags '#{EXTERNAL_HAML_FILE}'\n%RemoteTag\n"
      expect(render template).to be == "<p>Remote tag</p>\n"
    end

    it "imports into a helper" do
      obj = Object.new
      obj.extend HelperSpecHelper
      expect(obj.RemoteTag({})).to be == "<p>Remote tag</p>\n"
    end

    it "transfers the binding into the target" do
      template = "- import_tags '#{EXTERNAL_HAML_FILE}'\n%CheckSelfEqual{ :target => self }\n"
      expect(render template).to be == "true\n"
    end

    it "transfers the binding in ruby" do
      obj = Object.new
      obj.extend HelperSpecHelper
      expect(obj.CheckSelfEqual({ "target" => obj })).to be == "true\n"
    end
  end
end
