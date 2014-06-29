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
  it "compiles custom tags" do
    template = "- extend BaseSpecHelper\n%CustomTag\n"
    expect(render template).to be == "{CustomTag}{/CustomTag}\n"
  end

  it "compiles custom tags with attributes" do
    template = "- extend BaseSpecHelper\n%CustomTag#id.c1.c2{ :class => class_name, :title => 'Title' }\n"
    expect(render template).to be == "{CustomTag, id => \"id\", class => \"c1 c2 class_name\", title => \"Title\"}{/CustomTag}\n"
  end

  it "compiles custom tags with content" do
    template = "- extend BaseSpecHelper\n%CustomTag inline content\n"
    expect(render template).to be == "{CustomTag}inline content\n{/CustomTag}\n"
  end
end
