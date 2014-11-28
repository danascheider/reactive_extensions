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
    modify_keys {|key| key.to_sym }
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
    modify_keys! {|key| key.to_sym }
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
    modify_keys {|key| key.to_s }
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
    modify_keys! {|key| key.to_s }
  end

  private

    # The private +#modify_keys+ method iterates through the calling hash,
    # returning a duplicate with keys modified according to a given +block+.
    # This is a non-destructive method; it returns a duplicate of the calling
    # hash, leaving the original as-is.

    def modify_keys(&block) 
      dup = {}
      self.each {|k,v| dup[yield k] = v }
      dup
    end

    # The private +#modify_keys!+ method iterates through the calling hash, 
    # modifying its keys in place according to a given +block+. It returns 
    # the original hash. This is a destructive method; the hash will no 
    # longer be available in its original form after +#modify_keys!+ is called.

    def modify_keys!(&block)
      keys.each do |key|
        self[(yield(key) rescue key) || key] = delete(key)
      end
      self
    end
end