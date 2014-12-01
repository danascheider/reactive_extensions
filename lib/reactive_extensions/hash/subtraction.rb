require 'reactive_support/core_ext/object/deep_dup'

class Hash

  # The +#-+ method takes a single hash as an argument. It 
  # deletes the key-value pairs of the argument from the calling
  # hash. An ArgumentError is raised if the argument is not a 
  # hash or not a subset of the 
  #
  # Examples:
  #     {:foo => 'bar', :baz => :qux} - {:baz => :qux}   # => {:foo => 'bar'}
  #     {:foo => 'bar'} - {:norf => :raboo}              # => {:foo => 'bar'}
  #     {:foo => 'bar'} - {:foo => 'bar'}
  #     {:foo => 'bar'} - [1, 2, 3]                      # => ArgumentError

  def - (hash)
    raise ArgumentError.new("Hash can only be subtracted from its superset") unless superset_of? hash
    deep_dup.reject {|key, value| hash.has_key? key }
  end
end