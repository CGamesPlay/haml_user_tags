require 'haml_user_tags'
require 'rspec/expectations'
require 'fakefs/safe'

World(RSpec::Matchers)

Before do
  module CucumberHelper
  end
  FakeFS.activate!
end

After do
  Object.send(:remove_const, :CucumberHelper)
  FakeFS.deactivate!
end

Given(/^a helper module that contains:$/) do |string|
  CucumberHelper.module_eval string
end

Given(/^a file named "(.*?)" that contains:$/) do |name, content|
  File.write(name, content)
end

When(/^I render the template "(.*?)"$/) do |filename|
  template = "- extend CucumberHelper\n#{File.read(filename)}"
  @output = HamlUserTags::Engine.new(template, :filename => filename, :line => 0).to_html
end

When(/^I evaluate the ruby code:$/) do |string|
  @output = eval(string).to_s
end

Then(/^the output should be:$/) do |string|
  expect(@output).to be == "#{string}\n"
end
