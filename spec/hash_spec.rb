require 'spec_helper'

describe Hash do 
  describe 'manipulating keys' do 
    describe 'symbolize_keys' do 
      it 'turns string keys into symbols' do 
        expect({'foo' => 'bar'}.symbolize_keys).to eql({:foo => 'bar'})
      end

      it 'maintains the original hash' do 
        hash = { 'foo' => 'bar' }
        expect { hash.symbolize_keys }.not_to change(hash, :keys)
      end
    end

    describe 'symbolize_keys!' do 
      it 'turns string keys into symbols' do 
        expect({'foo' => 'bar'}.symbolize_keys!).to eql({:foo => 'bar'})
      end

      it 'overwrites the original hash' do
        hash = { 'foo' => 'bar' }
        expect { hash.symbolize_keys! }.to change(hash, :keys)
      end
    end

    describe 'stringify_keys' do 
      it 'turns symbol keys into strings' do 
        expect({foo: 'bar'}.stringify_keys).to eql({'foo' => 'bar'})
      end

      it 'maintains the original hash' do 
        hash = { foo: 'bar' }
        expect { hash.stringify_keys }.not_to change(hash, :keys)
      end
    end

    describe 'stringify_keys!' do 
      it 'turns symbol keys into strings' do 
        expect({foo: 'bar'}.stringify_keys!).to eql({'foo' => 'bar'})
      end

      it 'overwrites the original hash' do
        hash = { foo: 'bar' }
        expect { hash.stringify_keys! }.to change(hash, :keys)
      end
    end
  end
end