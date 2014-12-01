require 'reactive_support/core_ext/object/deep_dup'
require 'reactive_support/core_ext/array/extract_options'

# This file adds the +#clean+, +#clean!+, +#only+, +#only!+, +#standardize+,
# and +#standardize!+ methods to Ruby's core Hash class. These methods enable
# the user to easily add or remove particular keys from a hash.

# Ruby's core Has class. See documentation for version 
# 2.1.5[http://ruby-doc.org/core-2.1.5/Hash.html],
# 2.0.0[http://ruby-doc.org/core-2.0.0/Hash.html], or 
# 1.9.3[http://ruby-doc.org/core-1.9.3/Hash.html].

class Hash

  # The +#clean+ method returns a duplicate of the calling hash with the 
  # specified +*bad_keys+, if present, removed. If none of the bad keys
  # are present, +#clean+ will simply return a duplicate hash. 
  #
  # +#clean+ is a non-destructive method. The original hash will still be
  # unchanged after it is called.
  #
  # +#clean+ may also be called by the aliases +#not+ and +#except+.
  #
  # Examples:
  #     hash = {:foo => 'bar', :bar => 'baz'}
  #     hash.clean(:foo)                        # => {:bar => 'baz'}
  #     hash.not(:foo, :bar)                    # => {}
  #     hash.except(:bar, :norf)                # => {:foo => 'bar'}
  #     hash.clean(:norf)                       # => {:foo => 'bar', :bar => 'baz'}
  #     hash                                    # => {:foo => bar', :bar => 'baz'}

  def clean(*bad_keys)
    dup = self.reject {|key, value| bad_keys.flatten.include?(key) }
    dup
  end

  alias_method :not, :clean
  alias_method :except, :clean

  # The +#clean!+ method returns a duplicate of the calling hash with the 
  # specified +*bad_keys+, if present, removed. If none of the bad keys
  # are present, +#clean!+ will simply return a duplicate hash. 
  #
  # +#clean!+ is a non-destructive method. The original hash will still be
  # unchanged after it is called.
  #
  # +#clean!+ may also be called by the aliases +#not!+ and +#except!+.
  #
  # Examples:
  #     hash = {:foo => 'bar', :bar => 'baz'}
  #     hash.clean!(:foo)                       # => {:bar => 'baz'}
  #     hash                                    # => {:bar => 'baz'}
  # 
  #     hash.not!(:foo, :bar)                   # => {}
  #     hash                                    # => {}
  # 
  #     hash = {:foo => 'bar', :bar => 'baz'}
  #     hash.except!(:bar, :norf)               # => {:foo => 'bar'}
  #     hash                                    # => {:foo => 'bar'}

  def clean!(*bad_keys)
    reject! {|key, value| bad_keys.flatten.include?(key) }
    self
  end

  alias_method :not!, :clean!
  alias_method :except!, :clean!

  # The +#only+ method returns a duplicate of the calling hash with only the 
  # specified +*good_keys+, if present. If none of the good keys
  # are present, +#only+ will simply return an empty hash. 
  #
  # +#only+ is a non-destructive method. The original hash will still be
  # unchanged after it is called.
  #
  # Examples:
  #     hash = {:foo => 'bar', :bar => 'baz'}
  #     hash.only(:foo)                         # => {:foo => 'bar'}
  #     hash.only(:qux)                         # => {}
  #     hash                                    # => {:foo => 'bar', :bar => 'baz'}

  def only(*good_keys)
    dup = self.select {|key, value| good_keys.flatten.include?(key) }
  end

  # The +#only!+ method returns a duplicate of the calling hash with only the 
  # specified +*good_keys+, if present. If none of the good keys
  # are present, +#only!+ will simply return an empty hash. 
  #
  # +#only!+ is a destructive method. The original hash will be changed in place
  # when it is called.
  #
  # Examples:
  #     hash = {:foo => 'bar', :bar => 'baz'}
  #     hash.only!(:foo)                         # => {:foo => 'bar'}
  #     hash.only!(:qux)                         # => {}
  #     hash                                     # => {}

  def only!(*good_keys)
    select! {|key, value| good_keys.flatten.include?(key) }
    self
  end

  # The +#standardize+ method returns a duplicate of the calling hash with
  # the +*keys+ specified as arguments. Any other keys in the hash will be 
  # removed. Behavior when adding keys depends on whether the +:errors+
  # option is set to +true+ or +false+ (default). 
  #
  # If the +:errors+ option is set to +false+, the method will add any missing
  # keys to the hash, populating them with +nil+ values. If +:errors+ is set to 
  # +true+, then an +ArgumentError+ will be raised unless all values are 
  # present in the hash already.
  #
  # Examples with +:errors => false+:
  #     hash = {:foo => 'bar', :bar => 'baz'}
  #     hash.standardize(:foo)                  # => {:foo => 'bar'}
  #     hash.standardize(:foo, :qux)            # => {:foo => 'bar', :qux => nil}
  #     hash                                    # => {:foo => 'bar', :bar => 'baz'}
  #
  # Examples with +:errors => true+:
  #     hash = {:foo => 'bar', :bar 'baz'}
  #     hash.standardize(:foo, :errors => true)           # => {:foo => 'bar'}
  #     hash.standardize(:foo, :qux, :errors => true)     # => ArgumentError

  def standardize(*kees)
    options = kees.extract_options!
    dup     = deep_dup.only(kees)

    kees.each do |key| 
      unless dup.has_key? key
        raise ArgumentError.new("#{self} is missing required key #{key}") if options[:errors]
        dup[key] = nil
      end
    end

    dup
  end

  # The +#standardize!+ method modifies the calling hash such that its 
  # keys match the +*kees+ specified as arguments. Any other keys in the hash 
  # will be removed. If passed +:errors => true+, an +ArgumentError+ will be
  # raised in the event keys present in the arguments are not present in the
  # calling hash. Otherwise, any such keys will be added to the hash and 
  # populated with nil values.
  #
  # +#standardize!+ is a destructive method; the calling hash will be changed
  # in place when it is called.
  #
  # Examples with +:errors => false+:
  #     hash = {:foo => 'bar', :bar => 'baz'}
  #     hash.standardize!(:foo, :qux)            # => {:foo => 'bar', :qux => nil}
  #     hash.standardize!(:foo)                  # => {:foo => 'bar'}
  #     hash                                     # => {:foo => 'bar'}
  #
  # Examples with +:errors => true+:
  #     hash = {:foo => 'bar', :bar 'baz'}
  #     hash.standardize!(:foo, :errors => true)           # => {:foo => 'bar'}
  #     hash.standardize!(:foo, :qux, :errors => true)     # => ArgumentError
  #     hash                                               # => {:foo => 'bar'}

  def standardize!(*kees)
    options = kees.extract_options!

    kees.each do |key|
      unless only!(kees).has_key? key
        raise ArgumentError.new("#{self} is missing required key #{key}") if options[:errors]
        self[key] = nil
      end
    end

    self
  end
end