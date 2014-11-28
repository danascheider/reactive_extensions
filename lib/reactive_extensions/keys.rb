# This file adds the +#stringify_keys+, +#stringify_keys!+, +#symbolize_keys+,
# and +#symbolize_keys!+ methods to the core +Hash+ class. These methods
# enable hash keys to be easily converted from symbols to strings and 
# vice versa.

# Ruby's core Hash class. See documentation for version 
# 2.1.5[http://ruby-doc.org/core-2.1.5/Hash.html],
# 2.0.0[http://ruby-doc.org/core-2.0.0/Hash.html], or 
# 1.9.3[http://ruby-doc.org/core-1.9.3/Hash.html].

class Hash

  # The +#symbolize_keys+ method returns a hash identical to the calling
  # hash but with string keys turned into symbols. It is non-destructive;
  # the original hash is still available after it is called.
  #
  # Although this method was formerly a part of ActiveSupport, it was 
  # already deprecated by the time ReactiveSupport was introduced. For
  # that reason, it is being included as part of ReactiveExtensions.
  #
  # Examples:
  #     orig = { 'foo' => 'bar' }
  #     dup = orig.symbolize_keys
  #
  #     orig      #=> { 'foo' => 'bar' }
  #     dup       #=> { :foo => 'bar' }

  def symbolize_keys
    dup = {}
    self.each {|k, v| dup[k.to_sym] = v }
    dup
  end

  # The +#symbolize_keys!+ method converts string hash keys into symbols.
  # It is a destructive method; the original hash is changed when this
  # method is called.
  #
  # Although this method was formerly a part of ActiveSupport, it was already
  # deprecated by the time ReactiveSupport was introduced. For that reason,
  # it is being included as part of ReactiveExtensions.
  #
  # Examples:
  #     orig = { 'foo' => 'bar' }
  #     orig.symbolize_keys!
  #
  #     orig      #=> { :foo => 'bar' }

  def symbolize_keys!
    keys.each do |key|
      self[(key.to_sym rescue key) || key] = delete(key)
    end

    self
  end

  # The +#stringify_keys+ method returns a hash identical to the calling
  # hash, but with symbol keys turned into strings. It is non-destructive;
  # the original hash is still available after it is called.
  #
  # Although this method was formerly a part of ActiveSupport, it was
  # already deprected by the time ReactiveSupport was introduced. For
  # that reason, it is being included as part of ReactiveExtensions.
  #
  # Examples: 
  #     orig = { :foo => 'bar' }
  #     dup = orig.stringify_keys
  # 
  #     orig      #=> { :foo => 'bar' }
  #     dup       #=> { 'foo' => 'bar' }

  def stringify_keys
    dup = {}
    self.each {|k, v| dup[k.to_s] = v }
    dup
  end

  # The +#stringify_keys!+ method converts symbol hash keys into strings.
  # It is a destructive method; the original hash is changed when this
  # method is called.
  #
  # Although this method was formerly a part of ActiveSupport, it was already
  # deprecated by the time ReactiveSupport was introduced. For that reason,
  # it is being included as part of ReactiveExtensions.
  #
  # Examples:
  #     orig = { :foo => 'bar' }
  #     orig.symbolize_keys!
  #
  #     orig      #=> { 'foo' => 'bar' }

  def stringify_keys!
    keys.each do |key|
      self[(key.to_s rescue key) || key] = delete(key)
    end

    self
  end
end