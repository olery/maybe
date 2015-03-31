class Object
  ##
  # Wraps the current object in a Maybe instance, optionally calling
  # {Maybe#maybe} if an argument or block is given.
  #
  # @example
  #  [10, 20, 30].maybe(0).or(50)               # => 10
  #  [10, 20, 30].maybe { |arr| arr[3] }.or(50) # => 50
  #
  # @see [Maybe#get]
  #
  def maybe(*args)
    retval = Maybe.new(self)

    if !args.empty?
      retval = retval.maybe(*args)
    elsif block_given?
      retval = retval.maybe(&Proc.new)
    end

    return retval
  end
end # Object
