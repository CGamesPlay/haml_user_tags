require 'haml_custom_tags'
require 'spec_helper'

describe HamlCustomTags::Helpers, "#define_tag" do
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
