require 'haml_custom_tags'
require 'spec_helper'

module EngineSpecHelper
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
    template = "- extend EngineSpecHelper\n%CustomTag\n"
    expect(render template).to be == "{CustomTag}{/CustomTag}\n"
  end

  it "compiles custom tags with attributes" do
    template = "- extend EngineSpecHelper\n%CustomTag#id.c1.c2{ :class => class_name, :title => 'Title' }\n"
    expect(render template).to be == "{CustomTag, id => \"id\", class => \"c1 c2 class_name\", title => \"Title\"}{/CustomTag}\n"
  end

  it "compiles custom tags with inline content" do
    template = "- extend EngineSpecHelper\n%CustomTag \"inline content\"\n"
    expect(render template).to be == "{CustomTag}\"inline content\"{/CustomTag}\n"
  end

  it "compiles custom tags with inline ruby content" do
    template = "- extend EngineSpecHelper\n%CustomTag= \"this is ruby\"\n"
    expect(render template).to be == "{CustomTag}this is ruby{/CustomTag}\n"
  end

  it "compiles custom tags with child content" do
    template = "- extend EngineSpecHelper\n%CustomTag\n  = \"ruby\"\n  and regular"
    expect(render template).to be == "{CustomTag}ruby\nand regular\n{/CustomTag}\n"
  end
end
