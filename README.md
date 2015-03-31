# Maybe.rb

> I had a grey horse called maybe, we could not decide what to call her and the
> US exchange student kept saying "ahh maybe" when we suggested names.

A gem providing a very simple Maybe monad for Ruby, minus all the other
functional programming features often seen in other libraries (such as `bind`).

So why would one want to use a Maybe monad? Well, maybe you're writing Ruby, and
maybe you've got code like this:

    number = some_array[0]['some_hash_key'] || 0

This code however is not guaranteed to always work. For example, if `some_array`
contains the result of a database query then it might be empty. In such a case
you'll get the dreaded nil error:

    NoMethodError: undefined method `[]' for nil:NilClass

There are a few ways you can work around this, for example using an `if`
statement:

    if some_array[0]
      number = some_array[0]['some_hash_key']
    else
      number = 0
    end

This can be shortened a bit using the ternary operator:

    number = some_array[0] ? some_array[0]['some_hash_key'] : 0

Alternatively you can take the Ostrich approach and just bury your head in the
sand:

    number = some_array[0]['some_hash_key'] rescue 0

Ostrich based programming however has its problems. Because in the above case we
rescue _all_ errors we could potentially rescue too much and introduce bugs as a
result. For example, if `some_array` were a method returning data from an API,
and said API would raise an authentication error we'd never know.

Another problem of the statement based solution is code duplication. Even when
using the ternary operator we have to repeat some part of the code we're trying
to access (`some_array[0]` in the above example).

Using this particular Gem we can write the above code as following:

    number = Maybe.new(some_array)[0]['some_hash_key'].or(0)

This particular syntax can be made a bit shorter by loading the `maybe/pollute`
file which adds `Object#maybe`, allowing you to write the following instead:

    number = some_array.maybe[0]['some_hash_key'].or(0)

This is disabled by default and the `Maybe` class itself doesn't rely on it and
because it's not too pleasant for a library to implicitly patch built-in Ruby
classes.

## Installation

Because both "maybe" and "ruby-maybe" were already taken this Gem is
conveniently called "maybe.rb" on RubyGems, this means you'll need to install it
as following:

    gem install maybe.rb

Or if you're using Bundler:

    gem 'maybe.rb'

## Usage

Load the Gem:

    require 'maybe'

Optionally pollute `Object` so you can just call `maybe` on any object:

    require 'maybe/polluate'

Wrap a value using the `Maybe` class directly:

    numbers = [10]

    Maybe.new(numbers)[1].or(20) # => 20

Using `Object#maybe`:

    numbers = [10]

    numbers.maybe[1].or(20) # => 20

The Maybe class also allows you to use a block instead of the `[]` method (which
is just an alias for `Maybe#maybe`):

    numbers = [10, 20, 30]

    numbers.maybe(0) { |value| value * 10 }.or(1) # => 100
    numbers.maybe(3) { |value| value * 10 }.or(1) # => 1

Calling `Maybe#maybe` also works without an argument, in which case the
currently wrapped value is yielded to the block (if there is any value to
yield):

    numbers[0].maybe { |value| value.to_s }.or('1') # => '10'

For more examples, see the documentation (and source code) of
[lib/maybe/maybe.rb](lib/maybe/maybe.rb).

## What is this magic?

The way this Monad works is that any non `nil` value is yielded to a supplied
block or returned as a new Maybe instance. The moment you call `Maybe#or` this
method will verify the currently wrapped value and decide what to return.

If the wrapped value is not nil it's simply returned. If the value is nil and a
block is given then said block is yielded. If the value is nil and _no_ block is
given the method will simply return its argument (`nil` by default).

Some examples (using `Object#maybe` for better readability):

    10.maybe.or(20)    # => 10
    10.maybe.or { 20 } # => 10
    10.maybe.or        # => 10

    nil.maybe.or(20)    # => 20
    nil.maybe.or { 20 } # => 20
    nil.maybe.or        # => nil, since the default return value is nil

## Requirements

* Ruby

## License

All source code in this repository is licensed under the MIT license unless
specified otherwise. A copy of this license can be found in the file "LICENSE"
in the root directory of this repository.
