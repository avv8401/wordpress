#
# array_do.rb
#
module Puppet::Parser::Functions
  newfunction(:array_do, :doc => <<-EOS
When passed an array, a function name and parameters, executes the specified
function on each element of the array.

If you wish to capture output, you must use array_do_r().

This function is especially useful when combined with validate_* -- you can now
apply the validation to within your arrays.

Example:

$usernames = [ 'tom', 'jerry', 'bruno', 'pluto' ]
$regex = [ '^(tom|jerry|bruno)$'
array_do( $usernames, 'validate_re', $regex )
    EOS
  ) do |arguments|

    if arguments.size < 1 or arguments.size > 3
      raise( Puppet::ParseError,
            "array_do(): invalid arg count. must be 2 or 3." )
    end

    data = arguments[0]
    func = arguments[1]
    params = arguments[2] if arguments.size == 3

    # functions are required to pass anonymous arrays for parameters
    # so if we weren't given an array to prepend with our element
    # we'll convert it here
    if ! params.is_a?(Array)
      params = Array.new.push(params)
    end

    # Let's load our puppet function
    # TODO: validate its a good function
    Puppet::Parser::Functions.function(func)

    # iterate through each of our array elements, building our parameter
    # array and then executing our function.
    data.each do |element|
      args = params.dup.insert(0,element)
      if args.size > 2
        raise(Puppet::ParseError, args )
      end
      args.compact!
      send("function_#{func}", args)
    end
  end
end

# vim: set ts=2 sw=2 et :
