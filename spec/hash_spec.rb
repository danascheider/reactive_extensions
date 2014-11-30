require 'spec_helper' 

describe Hash do 
  let(:hash) { { :foo => 'bar', :baz => 'qux' } }

  describe '+' do 
    context 'when argument is a hash' do 
      it 'adds the second hash\'s keys to the first hash' do 
        new_hash = {:foo => :bar} + {:baz => :qux}
        expect(new_hash).to eql({:foo => :bar, :baz => :qux})
      end
    end

    context 'when argument is not a hash' do 
      it 'raises an error' do 
        expect{ {:foo => :bar} + Time.now }.to raise_error
      end
    end
  end

  describe 'clean' do 
    it 'removes specified keys' do 
      expect(hash.clean(:baz)).to eql({:foo => 'bar'})
    end

    it 'is non-destructive' do 
      expect{ hash.clean(:baz) }.not_to change(hash, :length)
    end

    it 'ignores absent keys' do 
      expect{ hash.clean(:raboof) }.not_to raise_error
    end

    it 'accepts multiple arguments' do 
      expect(hash.clean(:baz, :raboof, :norf)).to eql({:foo => 'bar'})
    end

    context 'when all keys are bad' do 
      it 'returns an empty hash' do 
        expect(hash.clean(:foo, :baz)).to eql({})
      end
    end
  end

  describe 'clean!' do 
    it 'removes specified keys' do 
      expect(hash.clean!(:baz)).to eql({:foo => 'bar'})
    end

    it 'is destructive' do 
      expect{ hash.clean!(:baz) }.to change(hash, :length)
    end

    it 'ignores absent keys' do 
      expect{ hash.clean!(:raboof) }.not_to raise_error
    end

    it 'accepts multiple arguments' do 
      expect(hash.clean!(:baz, :raboof, :norf)).to eql({:foo => 'bar'})
    end

    context 'when all keys are bad' do 
      it 'returns an empty hash' do 
        expect(hash.clean!(:foo, :baz)).to eql({})
      end
    end
  end

  describe 'only' do 
    it 'retains only listed keys' do 
      expect(hash.only(:foo)).to eql({:foo => 'bar'})
    end

    it 'is non-destructive' do 
      expect{ hash.only(:foo) }.not_to change(hash, :length)
    end

    it 'accepts multiple arguments' do 
      expect(hash.only(:foo, :baz)).to eql({:foo => 'bar', :baz => 'qux'})
    end

    context 'when no keys are allowed' do 
      it 'returns an empty hash' do 
        expect(hash.only(:raboof)).to eql({})
      end

      it 'doesn\'t raise an error' do 
        expect{ hash.only(:raboof) }.not_to raise_error
      end
    end
  end

  describe 'only!' do 
    it 'retains only listed keys' do 
      expect(hash.only!(:foo)).to eql({:foo => 'bar'})
    end

    it 'is destructive' do 
      expect{ hash.only!(:foo) }.to change(hash, :keys)
    end

    it 'accepts multiple arguments' do 
      expect(hash.only!(:foo, :baz, :norf)).to eql({:foo => 'bar', :baz => 'qux'})
    end

    context 'when no keys are allowed' do 
      it 'empties the hash' do 
        expect(hash.only!(:raboof)).to eql({})
      end

      it 'doesn\'t raise an error' do 
        expect{ hash.only!(:raboof) }.not_to raise_error
      end
    end
  end

  describe 'standardize' do 
    let(:hash) { { :foo => 'bar', :bar => 'baz', :baz => 'qux' } }

    it 'is non-destructive' do 
      expect{ hash.standardize(:foo, :bar) }.not_to change(hash, :keys)
    end

    context 'exact match' do 
      it 'returns the hash as-is' do 
        expect(hash.standardize(:foo, :bar, :baz)).to eql hash 
      end
    end

    context 'keys removed' do 
      it 'removes keys not given in args' do 
        expect(hash.standardize(:foo, :baz)).to eql({:foo => 'bar', :baz => 'qux'})
      end
    end

    context 'args include keys not present in hash' do 
      let(:with_nil) { {:foo => 'bar', :bar => 'baz', :baz => 'qux', :norf => nil } }

      context 'default' do 
        it 'populates with nil values' do 
          expect(hash.standardize(:foo, :bar, :baz, :norf)).to eql(with_nil)
        end

        it 'doesn\'t raise an error' do 
          expect{ hash.standardize(:foo, :bar, :baz, :norf) }.not_to raise_error
        end
      end

      context 'with errors option set to false' do 
        it 'populates with nil values' do 
          expect(hash.standardize(:foo, :bar, :baz, :norf, :errors => false)).to eql(with_nil)
        end

        it 'doesn\'t raise an error' do 
          expect{ hash.standardize(:foo, :bar, :baz, :norf, :errors => false) }.not_to raise_error
        end
      end

      context 'with errors option set to true' do 
        it 'raises an error' do 
          expect{ hash.standardize(:foo, :bar, :baz, :norf, :errors => true) }.to raise_error(ArgumentError)
        end
      end
    end
  end

  describe 'standardize!' do 
    let(:hash) { { :foo => 'bar', :bar => 'baz', :baz => 'qux' } }

    it 'is destructive' do 
      expect{ hash.standardize!(:foo, :bar) }.to change(hash, :keys)
    end

    context 'exact match' do 
      it 'returns the hash as-is' do 
        expect(hash.standardize!(:foo, :bar, :baz)).to eql hash 
      end
    end

    context 'keys removed' do 
      it 'removes keys not given in args' do 
        expect(hash.standardize!(:foo, :baz)).to eql({:foo => 'bar', :baz => 'qux'})
      end
    end

    context 'args include keys not present in hash' do 
      let(:with_nil) { {:foo => 'bar', :bar => 'baz', :baz => 'qux', :norf => nil } }

      context 'default' do 
        it 'populates with nil values' do 
          expect(hash.standardize!(:foo, :bar, :baz, :norf)).to eql(with_nil)
        end

        it 'doesn\'t raise an error' do 
          expect{ hash.standardize!(:foo, :bar, :baz, :norf) }.not_to raise_error
        end
      end

      context 'with errors option set to false' do 
        it 'populates with nil values' do 
          expect(hash.standardize!(:foo, :bar, :baz, :norf, :errors => false)).to eql(with_nil)
        end

        it 'doesn\'t raise an error' do 
          expect{ hash.standardize!(:foo, :bar, :baz, :norf, :errors => false) }.not_to raise_error
        end
      end

      context 'wtih errors option set to true' do 
        it 'raises an error' do 
          expect{ hash.standardize!(:foo, :bar, :baz, :norf, :errors => true) }.to raise_error(ArgumentError)
        end
      end
    end
  end
end