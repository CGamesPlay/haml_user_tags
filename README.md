# HamlUserTags

Define reusable functions in Haml that can be called with native Haml syntax.

## Features

- Native Haml syntax for calling helper functions
- Ability to define helper functions using Haml
- Ability to include user tags from one Haml file in another

## Installation

Add this line to your application's Gemfile:

    gem 'haml_user_tags'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install haml_user_tags

## Usage

TODO: Write usage instructions here

## TODO

- Verify it works on Ruby 1.9.7 / Rails 3.2.9
- Find best use cases inside SI code and bring in
- Explain the lazy evaluation of content
- Document how to migrate from partials
- Create a wrapper around render :partial to set it as a custom tag.

It should ensure that tags in the partial don't get included. Potentially use
Haml::to_method or whatever to do the defining.

## Motivation

Guy Steele's [Growing a Language](http://www.cs.virginia.edu/~evans/cs655/readings/steele.pdf) ([Video](https://www.youtube.com/watch?v=_ahvzDzKdB0)) gives a great demonstration of why user tags in Haml are an essential feature.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/haml_user_tags/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
