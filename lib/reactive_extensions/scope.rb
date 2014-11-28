require 'reactive_support/core_ext/object/inclusion'

# This file adds the +#scope+, #where, and +#where_not+ methods to the +Array+ class.
# These methods work on an array of hashes, returning hashes for which the given
# condition is true.

# Ruby's core Array class. See documentation for version 
# 2.1.5[http://ruby-doc.org/core-2.1.5/Array.html],
# 2.0.0[http://ruby-doc.org/core-2.0.0/Array.html], or 
# 1.9.3[http://ruby-doc.org/core-1.9.3/Array.html].

class Array
  
  # The +#scope+ method is called on an array of hashes. It returns a sub-array
  # including only hashes for which the value at a given +key+ is among the given +values+.
  # The +#scope+ method is non-destructive; the original array will remain intact
  # after it is called. The +#scope+ method is known to work for string or symbol
  # keys. It should work for other data type keys as well.
  #
  # Example:
  #     array = [
  #       { name: 'Jean-Paul Sartre', nationality: 'French' },
  #       { name: 'Bertrand Russell', nationality: 'English' },
  #       { name: 'Ludwig Wittgenstein', nationality: 'Austrian' },
  #       { name: 'Albert Camus', nationality: 'French' }
  #     ]
  # 
  #     array.scope(:nationality, 'French')
  #       # => [
  #              { name: 'Jean-Paul Sartre', nationality: 'French' },
  #              { name: 'Albert Camus', nationality: 'French' }
  #            ]

  def scope(key, *values)
    self.select {|hash| hash[key].in?(values) }
  end

  # The +#where_not+ method is called on an array of hashes. It returns a sub-array
  # including only hashes for which the value at a given +key+ is not among the
  # given +values+. It is the inverse of the +#scope+ method. The +#where_not+ method 
  # is non-destructive; the original array will remain intact after it is called. The
  # +#where_not+ method is known to work for string or symbol keys. It should work for
  # other data types as well.
  #
  # Example:
  #     array = [
  #       { name: 'Jean-Paul Sartre', nationality: 'French' },
  #       { name: 'Bertrand Russell', nationality: 'English' },
  #       { name: 'Ludwig Wittgenstein', nationality: 'Austrian' },
  #       { name: 'Albert Camus', nationality: 'French' }
  #     ]
  # 
  #     array.where_not(:nationality, 'French')
  #       # => [
  #              { name: 'Bertrand Russell', nationality: 'English' },
  #              { name: 'Ludwig Wittgenstein', nationality: 'English' }
  #            ]

  def where_not(key, *values)
    self.reject {|hash| hash[key].in?(values) }
  end
end