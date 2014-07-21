= Feature Flags Gem

A simple, opinionated library that adds feature flags to a user model.

== Install

```ruby
gem 'feature_flags', github: 'measurence/gem-feature-flags'
```

== Usage

In your model:

```ruby

class User < ActiveRecord::Base

  serialize :features

  manage_features :awesome_feature, :other_feature

end

```

In your templates or controllers:

```ruby

current_user.enable_awesome_feature!

if current_user.awesome_feature_enabled?
  ...
end

```

= License

This project rocks and uses MIT-LICENSE.