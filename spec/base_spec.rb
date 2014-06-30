require 'haml_custom_tags'
require 'spec_helper'

module BaseSpecHelper
  def base_helper str
    return "base_helper called with '#{str}'"
  end

  def CustomTag attributes = {}, &block
    content = capture_haml &block if block
    return "{CustomTag#{attributes.map{|k, v| ", #{k} => #{v.inspect}"}.join("")}}#{content}{/CustomTag}\n"
  end

  def class_name
    "class_name"
  end
end

describe HamlCustomTags::Engine do
  it "compiles basic custom tags" do
    template = "- extend BaseSpecHelper\n%CustomTag\n"
    expect(render template).to be == "{CustomTag}{/CustomTag}\n"
  end

  it "compiles custom tags with attributes" do
    template = "- extend BaseSpecHelper\n%CustomTag#id.c1.c2{ :class => class_name, :title => 'Title' }\n"
    expect(render template).to be == "{CustomTag, id => \"id\", class => \"c1 c2 class_name\", title => \"Title\"}{/CustomTag}\n"
  end

  it "compiles custom tags with inline content" do
    template = "- extend BaseSpecHelper\n%CustomTag \"inline content\"\n"
    expect(render template).to be == "{CustomTag}\"inline content\"{/CustomTag}\n"
  end

  it "compiles custom tags with inline ruby content" do
    template = "- extend BaseSpecHelper\n%CustomTag= \"this is ruby\"\n"
    expect(render template).to be == "{CustomTag}this is ruby{/CustomTag}\n"
  end

  it "compiles custom tags with child content" do
    template = "- extend BaseSpecHelper\n%CustomTag\n  = \"ruby\"\n  and regular"
    expect(render template).to be == "{CustomTag}ruby\nand regular\n{/CustomTag}\n"
  end
end

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
