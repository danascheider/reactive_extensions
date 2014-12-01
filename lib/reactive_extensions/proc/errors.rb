require 'reactive_support/core_ext/object/deep_dup'

# This file adds the #raises_error? method to a Proc object. This 
# method checks whether the proc raises an error when called with
# the given parameters.
#
# Ruby's core Proc class. See documentation for version 
# 2.1.5[http://ruby-doc.org/core-2.1.5/Proc.html],
# 2.0.0[http://ruby-doc.org/core-2.0.0/Proc.html], or 
# 1.9.3[http://ruby-doc.org/core-1.9.3/Proc.html].

class Proc

  # The +#raises_error?+ method checks whether an exception is raised
  # when the calling Proc is called with the given +*args+.
  #
  # The +#raises_error?+ method does not actually create lasting changes
  # to objects or variables; it only checks whether an exception would be
  # raised if the Proc were called with the given +*args+.
  #
  # Basic examples:
  #     proc = Proc.new {|q| 1.quo(q) }
  #     proc.raises_error?(2)       # => false
  #     proc.raises_error?(0)       # => true
  #
  # Examples with destructive proc:
  #     hash = {:foo => :bar}
  #     proc = Proc.new {|hash| hash.reject! {|k,v| k === :foo } }
  #     proc.raises_error?(hash)    # => false
  #     hash                        # => {:foo => :bar}

  def raises_error?(*args)
    (!self.call(*args.deep_dup)) rescue true
  end
end