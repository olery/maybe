##
# The Maybe class is a very simple implemention of the maybe monad/option type
# often found in functional programming languages. To explain the use of this
# class, lets take at the following code:
#
#     pairs = [{:a => 10}]
#
#     number = pairs[0][:a]
#
# While this code is very simple, there are already a few problems that can
# arise:
#
# 1. If the pairs Array is empty we'll get an "undefined method [] for nil"
#    error as pairs[0] in this case returns nil.
# 2. If the :a key is not set we'll again end up with a nil value, which might
#    break code later on.
#
# So lets add some code to take care of this, ensuring we _always_ have a
# number:
#
#     pairs = [{:a => 10}]
#
#     number = pairs[0] ? pairs[0][:a] || 0 : 0
#
# Alternatively:
#
#     pairs = [{:a => 10}]
#
#     number = (pairs[0] ? pairs[0][:a] : nil) || 0
#
# Both cases are quite messy. Using the Maybe class we can write this as
# following instead:
#
#     pairs = [{:a => 10}]
#
#     numbers = Maybe.new(pairs[0]).maybe(:a).or(0)
#
# If we use the patch for Object (adding `Object#maybe`) we can write this as
# following:
#
#     pairs = [{:a => 10}]
#
#     numbers = pairs[0].maybe(:a).or(0)
#
# Or even better:
#
#     pairs = [{:a => 10}]
#
#     numbers = pairs.maybe[0][:a].or(0)
#
# Boom, we no longer need to rely on ternaries or the `||` operator to ensure we
# always have a default value.
#
class Maybe
  ##
  # @param [Mixed] wrapped
  #
  def initialize(wrapped)
    @wrapped = wrapped
  end

  ##
  # @return [Mixed]
  #
  def unwrap
    return @wrapped
  end

  ##
  # Retrieves a value from the wrapped object. This method can be used in two
  # ways:
  #
  # 1. Using a member (e.g. Array index or Hash key) in case the underlying
  #    object defines a "[]" method.
  #
  # 2. Using a block which takes the wrapped value as its argument.
  #
  # For example, to get index 0 from an Array and return it as a Maybe:
  #
  #     Maybe.new([10, 20, 30]).maybe(0) # => #<Maybe:0x0...>
  #
  # To get a Hash key:
  #
  #     Maybe.new({:a => 10}).maybe(:a) # => #<Maybe:0x00...>
  #
  # Using a block:
  #
  #     Maybe.new([10, 20, 30]).maybe { |array| array[0] }
  #
  # The block is only evaluated if the current Maybe wraps a non-nil value. The
  # return value of the block is wrapped in a new Maybe instance.
  #
  # This method is aliased as `[]` allowing usage such as the following:
  #
  #     maybe = Maybe.new([{'foo' => 10}])
  #
  #     maybe[0]['foo'].or(20)
  #
  # If both arguments and a block are given the supplied block is called with
  # the value returned by the `#[]` method of the wrapped object. For example:
  #
  #     maybe = Maybe.new(:number => '10')
  #
  #     maybe.maybe(:number) { |number| number.to_i } # => 10
  #
  # The block in this case is _only_ called when the `#[]` method returns a non
  # nil value.
  #
  # @param [Array] args
  #
  # @yieldparam [Mixed] wrapped The wrapped value
  #
  # @return [Maybe]
  #
  def maybe(*args)
    if !args.empty?
      value = brackets? ? @wrapped[*args] : nil

      if block_given? and value
        value = yield value
      end
    elsif @wrapped
      value = yield @wrapped
    end

    if value.nil? and @wrapped.nil?
      # No point in allocating a new Maybe for this.
      return self
    else
      return Maybe.new(value)
    end
  end

  alias_method :[], :maybe

  ##
  # Returns the wrapped value or returns a default value, specified as either an
  # argument to this method or in the provided block.
  #
  # A simple example:
  #
  #     Maybe.new([10, 20]).maybe(0).or(9000)
  #
  # And using a block:
  #
  #     Maybe.new([10, 20]).maybe(0).or { 9000 }
  #
  # @param [Mixed] default
  # @return [Mixed]
  #
  def or(default = nil)
    return @wrapped unless @wrapped.nil?

    if block_given?
      return yield
    else
      return default
    end
  end

  private

  ##
  # @return [TrueClass|FalseClass]
  #
  def brackets?
    return @wrapped.respond_to?(:[])
  end
end # Maybe
