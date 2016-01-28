# XPG

XPG gem is an ORM built on the top of ActiveRecord Stack.
It allows to write any pg expression in AR way, which make it
much less stunning, than Sequel or other DSL-based ORM.
XPG also provides XQuery extension (as for 1.0.0)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'xpg'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xpg

## Usage

XPG describes 4 kinds of objects, named Queries, Resolvers, Representations
and Adapters. Built at the top of ActiveRecord, it could use any abstractions,
which acts like AR over small set of methods

### Representations
Representations are basicaly duck-typed models, representing table rows or
sets of rows. Generaly, there are two interfaces: `LModel`s and `RModel`s
`LModels` represent `lvalues` (something, could be set).
`RModels` represent table information, which allows to build expressions
Syntax:
```ruby
  XPG.select(RModel).into(LModel) # => [LModels]
```

### Adapters

Adapters is a built-in library, describing sort of interface convertors.
E.g, you want to extract table name from AR. You can write `x.table_name`,
or `Adapters.from(x).to(YourLib::ITableName).table_name`. The point is make an
well-scoped interface, which would never be overriden by mistake

Syntax:
```ruby
  Adapters.cast(x, interface) # cast `x` to `interface`
  adapter.bind(x) # use `adapter` to cast `x` to adapter's interface
  adapter.bind_instances(x) # use `adapter` to cast any instance of `x` to adapter's interface

  module M
    class_adapter adapter # use `adapter` to cast `M` to adapter's interface
    instance_adapter adapter # use `adapter` to cast any instance of `M` to adapter's interface
  end

  class IM < Adapters::Interface
    interface_method :foo # can receive #foo from adapter

    def bar
      foo.to_s # access foo
    end
  end

  IM = Adapters.build_interface(:foo) # short form

  IM.new(foo: -> { 123 }) # instance interface without adapter
  IM.interface_methods # get all interface_methods
  # This two methods define interface duck type

  class MyAdapter < Adapters::Adapter
    # Duck interface contains `.interface`, `#cast` and `.new`, taking object
    self.interface = IM # required

    def foo # If `foo` is part of interface, it would be taken. Simple as hell
      object.foo
    end

    def cast # Default implementation, not required when Adapters::Adapter inherited
      interface.new(interface.interface_methods.map { |m| [m, method(m)] }.to_h)
    end
  end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.
You can also run `bin/console` for an interactive prompt
that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jelf/xpg.
This project is intended to be a safe, welcoming space for collaboration,
and contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org) code of conduct.
