require 'reactive_support/core_ext/object/duplicable'
require 'reactive_support/core_ext/object/deep_dup'
require 'reactive_support/core_ext/object/try'

Dir['./lib/reactive_extensions/**/*.rb'].each {|f| require f }

# The ReactiveExtensions module adds useful methods to core Ruby classes. You
# can use these methods by adding +require 'reactive_extensions'+ to your project.
# Then, ReactiveExtensions methods can be called on any Ruby object just like the 
# object's own methods. Easy peasy!
# 
# In this example, ReactiveExtension's #try_rescue method is called on an array:
#     require 'reactive_extensions'   
#     arr = %w(foo, bar, baz)
#     bad = Math.pi
#     arr.try_rescue(:join, '.')   # => 'foo.bar.baz'
#     nil.try_rescue(:join, '.')   # => nil

module ReactiveExtensions
end