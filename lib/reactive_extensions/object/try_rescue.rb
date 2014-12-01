require 'reactive_support/core_ext/object/try'

# This file adds the +#scope+, #where, and +#where_not+ methods to the +Array+ class.
# These methods work on an array of hashes, returning hashes for which the given
# condition is true.

# Ruby's core Array class. See documentation for version 
# 2.1.5[http://ruby-doc.org/core-2.1.5/Array.html],
# 2.0.0[http://ruby-doc.org/core-2.0.0/Array.html], or 
# 1.9.3[http://ruby-doc.org/core-1.9.3/Array.html].

class Object

  # The +#try_rescue+ method extends ReactiveSupport's +#try+ method so it
  # rescues NoMethodErrors and TypeErrors as well as returning +nil+ when
  # called on a +nil+ value.
  #
  # Like the +#try+ method, +#try_rescue+ takes 1 or more arguments. The first
  # argument is the method to be called on the calling object, passed as a 
  # symbol. The others are zero or more arguments that will be passed through to 
  # that method, and +&block+ is an optional block that will be similarly passed through.
  #
  # Example of usage identical to +#try+:
  #     nil.try(:map) {|a| a.to_s }           # => nil
  #     nil.try_rescue(:map) {|a| a.to_s }    # => nil
  #     
  # Example of usage calling a method that is not defined on the calling object:
  #     10.try(:to_h)           # => TypeError
  #     10.try_rescue(:to_h)    # => nil
  #
  # Example of usage with invalid arguments:
  #     %w(foo, bar, baz).try(:join, [:hello, :world])        # => TypeError
  #     %w(foo, bar, baz).try_rescue(:join, [:hello, :world]) # => nil

  def try_rescue(*args, &block)
    self.try(*args, &block) rescue nil
  end
end

# Ruby's core NilClass. See documentation for version 
# 2.1.5[http://ruby-doc.org/core-2.1.5/NilClass.html],
# 2.0.0[http://ruby-doc.org/core-2.0.0/NilClass.html], or 
# 1.9.3[http://ruby-doc.org/core-1.9.3/NilClass.html].

class NilClass

  # The +#try_rescue+ method extends ReactiveSupport's +#try+ method so it rescues
  # NoMethodErrors and TypeErrors as well as returning +nil+ when called on a +nil+
  # value.
  # 
  # Like the +#try+ method, +#try_rescue+ takes 1 or more arguments. The first argument
  # is the method to be called on the calling object, passed as a symbol. The others
  # are zero or more arguments that will be passed through to that method, and an 
  # optional block to be likewise passed through.
  #
  # When called on NilClass, +#try_rescue+ always returns nil.
  #
  # Example:
  #     foo = nil 
  #     foo.try_rescue(:has_key?, :bar)     # => nil

  def try_rescue(*args, &block)
    nil 
  end
end