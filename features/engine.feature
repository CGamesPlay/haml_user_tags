Feature: Call functions from Haml
  HamlUserTags allows you to call helper functions that have a special signature using standard Haml tag syntax.

  Background:
    Given a helper module that contains:
      """ruby
      def CustomTag attributes, &block
        content = capture_haml &block if block
        "CustomTag called with #{attributes.inspect}, #{content.inspect}"
      end

      def class_name
        "class_name"
      end
      """

  Scenario: Basic user tags
    Given a file named "template.haml" that contains:
      """haml
      %CustomTag
      """
    When I render the template "template.haml"
    Then the output should be:
      """html
      CustomTag called with {}, ""
      """

  Scenario: User tags with attribute
    Given a file named "template.haml" that contains:
      """haml
      %CustomTag#id.c1.c2{ :class => class_name, :title => 'Title' }
      """
    When I render the template "template.haml"
    Then the output should be:
      """html
      CustomTag called with {"id"=>"id", "class"=>"c1 c2 class_name", "title"=>"Title"}, ""
      """

  Scenario: User tags with content
    Given a file named "template.haml" that contains:
      """haml
      %CustomTag inline content
      %CustomTag= "Ruby content"
      %CustomTag
        = "Ruby"
        and normal
      """
    When I render the template "template.haml"
    Then the output should be:
      """html
      CustomTag called with {}, "inline content"
      CustomTag called with {}, "Ruby content"
      CustomTag called with {}, "Ruby\nand normal\n"
      """
