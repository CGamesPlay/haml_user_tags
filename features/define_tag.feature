Feature: Define user tags
  HamlUserTags allows you to define a helper function directly in a Haml
  template. The helper function will be accessible to the template it was
  included from.

  Scenario: Basic user tags
    Given a file named "template.haml" that contains:
      """haml
      - define_tag :Tag do
        %p This is Tag.
      %Tag
      %Tag
      """
    When I render the template "template.haml"
    Then the output should be:
      """html
      <p>This is Tag.</p>
      <p>This is Tag.</p>
      """

  Scenario: User tags with attributes
    Given a file named "template.haml" that contains:
      """haml
      - define_tag :Tag do |attributes|
        %p= attributes.inspect
      %Tag{ :foo => :bar }
      %Tag#first_tag.cls
      %Tag.a{ :class => "b" }
      """
    When I render the template "template.haml"
    Then the output should be:
      """html
      <p>{"foo"=>"bar"}</p>
      <p>{"id"=>"first_tag", "class"=>"cls"}</p>
      <p>{"class"=>"a b"}</p>
      """

  Scenario: User tags with content
    Given a file named "template.haml" that contains:
      """haml
      - define_tag :Tag do |attributes, content|
        %p= content
      %Tag inline content
      %Tag
        %strong
          nested content
      """
    When I render the template "template.haml"
    Then the output should be:
      """html
      <p>inline content</p>
      <p>
        <strong>
          nested content
        </strong>
      </p>
      """

  Scenario: Lazy evaluation of content
    Given a file named "template.haml" that contains:
      """haml
      - define_tag :Tag do |attributes, content|
        - begin
          = content
        - rescue
          Caught an exception!
      %Tag
        - raise "Threw an exception!"
      """
    When I render the template "template.haml"
    Then the output should be:
      """html
      Caught an exception!
      """

  Scenario: Pass content through multiple user tags
    Given a file named "template.haml" that contains:
      """haml
      - define_tag :A do |attributes, content|
        %p= content
      - define_tag :B do |attributes, content|
        %A
          = content
      - define_tag :C do |attributes, content|
        %A= content
      %B foo
      %C bar
      """
    When I render the template "template.haml"
    Then the output should be:
      """html
      <p>foo</p>
      <p>bar</p>
      """
