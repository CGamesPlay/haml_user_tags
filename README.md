[![Gem Version](https://badge.fury.io/rb/haml_user_tags.svg)](https://badge.fury.io/rb/haml_user_tags)
[![CircleCI](https://circleci.com/gh/CGamesPlay/haml_user_tags/tree/master.svg?style=shield)](https://circleci.com/gh/CGamesPlay/haml_user_tags/tree/master)

# HamlUserTags

Define reusable functions in Haml that can be called with native Haml syntax.

## Features

- Native Haml syntax for calling helper functions
- Ability to define helper functions using Haml
- Ability to include user tags from one Haml file in another

## Project Status

The latest version of the gem, `0.10.3`, includes all of the commit to the repository up to this point. The original author, [CGamesPlay](https://github.com/CGamesPlay), no longer uses this project in any production applications and so has no capacity to maintain it. If you are interested in adopting this project, or hiring me to do the modernization, please reach out.

- The current implementation is incompatible with the latest Haml and Rails versions.
- The CircleCI test pipeline is no longer functional due to changes by CircleCI.

## Installation

Add this line to your application's Gemfile:

    gem 'haml_user_tags'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install haml_user_tags

## Usage

The [Tutorial](http://cgamesplay.github.io/haml_user_tags/tutorial.html) will guide you through how to create an use user tags. Briefly:

```haml
- define_tag :MyHamlHelper do |attributes, content|
  %samp MyHelper called with #{attributes.inspect} and #{content.inspect}
  %br

%MyHamlHelper.cls helper defined in Haml directly
```

## Motivation

Guy Steele's [Growing a Language](http://www.cs.virginia.edu/~evans/cs655/readings/steele.pdf) ([Video](https://www.youtube.com/watch?v=_ahvzDzKdB0)) gives a great demonstration of why user tags in Haml are an essential feature.

## Contributing

1. Fork it (<https://github.com/CGamesPlay/haml_user_tags/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Releasing

1. `rake features`
2. `rake release`
3. Increment `VERSION` and `LATEST_STABLE_VERSION`
3. `rake site:publish`
4. `git push`
