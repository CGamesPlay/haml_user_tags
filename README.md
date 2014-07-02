# HamlCustomTags

Goals:

- Define custom tags from Rails helpers
- Define custom tags directly in Haml files
- Import custom tags from other Haml files

## Installation

Add this line to your application's Gemfile:

    gem 'haml_custom_tags'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install haml_custom_tags

## Usage

TODO: Write usage instructions here

## Ideas

### Augment links with tracking in emails

In your email template, simply replace your links with this tag to have them
augmented with a tracking URL, utm parameters, etc.

```haml
- define_tag :EmailLink do |attributes, content|
  - attributes["href"] = email_tracking_link_for(attributes["href"])
  %a{attributes}= content
%EmailLink{ :href => url_for(foo) } Click me!
```

### Pooled JS script tags at end of body

This technique will allow you to write custom tags with JavaScript bindings and
have the JavaScript automatically consolidated in one script tag at the end of
the document. If you give the JS element an ID, the JS will only be included
once (for example, if you simply need to initialize a jQuery plugin).

```ruby
def JS(attributes, &block)
  if id = attributes["id"]
    return if @included_scripts[id]
    @included_scripts[id] = true
  end
  content_for(:javascript, &block)
end
```
```haml
%JS#SomeComponent
  :plain
    $(document).InstallSomething();

-# Later, in your layout somewhere
= yield :javascript
```

## TODO

- Verify it works on Ruby 1.9.7 / Rails 3.2.9
- Find best use cases inside SI code and bring in
- Changing haml file after import_tags doesn't cause rails to reload haml file

## Contributing

1. Fork it ( https://github.com/[my-github-username]/haml_custom_tags/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
