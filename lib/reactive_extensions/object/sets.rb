class Hash
  
  # The +#subset_of?+ method checks whether the calling hash is a subset
  # of the given +hash+. It returns true if all key-value pairs in
  # the calling hash are also present in the hash passed as an argument.
  # If the calling hash is empty, the method returns true.
  #
  # Examples:
  #     hash = {:foo => 'bar', :bar => 'baz', :baz => 'qux'}
  #     {:baz => 'qux'}.subset_of? hash                          # => true
  #     {:bar => 'baz', :norf => 'foo'}.subset_of? hash          # => false
  #     {:norf => 'foo'}.subset_of? hash                         # => false
  #     {:foo => 'qux'}.subset_of? hash                          # => false
  #     {}.subset_of? hash                                       # => true
  #     {:foo => 'bar'}.subset_of? 'foobar'                      # => ArgumentError

  def subset_of?(hash)
    raise ArgumentError.new("Argument of #subset_of? must share the class of the calling object") unless hash.instance_of? Hash
    each {|key, value| return false unless hash[key] === value }
    true
  end

  # The +#superset_of?+ method checks whether the calling hash is a superset
  # of the given +hash+. It returns true if all key-value pairs in
  # the calling hash are also present in the hash passed as an argument.
  # If the argument hash is empty, the method returns true.
  #
  # Examples:
  #     hash = {:foo => 'bar', :bar => 'baz', :baz => 'qux'}
  #     hash.superset_of? {:baz => 'qux'}                          # => true
  #     hash.superset_of? {:bar => 'baz', :norf => 'foo'}          # => false
  #     hash.superset_of? {:norf => 'foo'}                         # => false
  #     hash.superset_of? {:foo => 'qux'}                          # => false
  #     hash.superset_of? {}                                       # => true
  #     {:foo => 'bar'}.superset_of? 'foobar'                      # => ArgumentError

  def superset_of?(hash)
    raise ArgumentError.new("Argument of Hash#superset_of? must be a hash") unless hash.instance_of? Hash
    hash.subset_of? self
  end
end

class Array

  # The +#subset_of?+ method checks whether the calling array is a subset
  # of the given +array+. It returns true if all objects in the calling 
  # array are also present in the hash passed as an argument, regardless 
  # of order. If the calling array is empty, the method returns true.
  #
  # Examples:
  #     array = [1, 2, 3, 4]
  #     [1, 3].subset_of? array                   # => true
  #     [1, 6].subset_of? array                   # => false
  #     [].subset_of? array                       # => true
  #     array.subset_of? 'foobar'                 # => ArgumentError

  def subset_of?(array)
    raise ArgumentError.new("Argument of Array#subset_of? must be an array") unless array.instance_of? Array
    each {|i| return false unless array.include? i }
    true
  end

  # The +#superset_of?+ method checks whether the calling array is a superset
  # of the given +array+. It returns true if all objects in the calling array
  # are also present in the array passed as an argument. If the argument array 
  # is empty, the method returns true.
  #
  # Examples:
  #     array = [1, 2, 3, 4]
  #     array.superset_of? [1, 2]                          # => true
  #     array.superset_of? [1, 2, 3, 4]                    # => true
  #     array.superset_of? [3, 6]                          # => false
  #     array.superset_of? []                              # => true
  #     array.superset_of? {}                              # => ArgumentError

  def superset_of?(array)
    raise ArgumentError.new("Argument of Array#superset_of? must be an array") unless array.instance_of? Array
    array.subset_of? self
  end
end