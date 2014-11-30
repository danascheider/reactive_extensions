class Hash
  
  # The +#\++ method takes a single hash as an argument. It 
  # appends the key-value pairs of the argument to the calling
  # hash. 
  #
  # If the argument is not a hash object, an Argument Error will
  # be raised.
  #
  # Examples:
  #     {:foo => 'bar'} + {:baz => :qux}   # => {:foo => 'bar', :baz => :qux}
  #     {:foo => 'bar'} + 'Hello'          # => ArgumentError

  def +(hash)
    dup = deep_dup
    hash.each {|key, value| dup[key] = value}
    dup
  end
end