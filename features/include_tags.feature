Feature: Include tags in Haml templates
  Once you have created a template that defines some tags in Haml, those tags can be imported into other templates and reused.

  Background:
    Given a file named "helper.haml" that contains:
      """haml
      - define_tag :RemoteTag do
        %p Remote tag

      Output from the helper file is discarded
      """

  Scenario: Importing directly into a template
    Given a file named "template.haml" that contains:
      """haml
      - include_tags "helper.haml"
      %RemoteTag
      %RemoteTag
      """
    When I render the template "template.haml"
    Then the output should be:
      """html
      <p>Remote tag</p>
      <p>Remote tag</p>
      """

  Scenario: Importing into a helper
    Given a helper module that contains:
      """ruby
      extend HamlUserTags::Helpers
      include_tags "helper.haml"
      """
    And a file named "template.haml" that contains:
      """haml
      %RemoteTag
      %RemoteTag
      """
    When I render the template "template.haml"
    Then the output should be:
      """html
      <p>Remote tag</p>
      <p>Remote tag</p>
      """

  Scenario: Calling user tags from outside Haml
    Given a helper module that contains:
      """ruby
      extend HamlUserTags::Helpers
      include_tags "helper.haml"
      """
    When I evaluate the ruby code:
      """ruby
      foo = Class.new do
        include CucumberHelper
      end.new
      foo.RemoteTag
      """
    Then the output should be:
      """html
      <p>Remote tag</p>
      """

  Scenario: Binding to the importing context
    Given a file named "helper.haml" that contains:
      """haml
      - define_tag :DebugSelf do |attributes|
        = (attributes["target"].equal?(self)).inspect
      """
    And a file named "template.haml" that contains:
      """haml
      - include_tags "helper.haml"
      %DebugSelf{ "target" => self }
      """
    When I render the template "template.haml"
    Then the output should be:
      """
      true
      """

