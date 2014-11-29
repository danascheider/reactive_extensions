require 'spec_helper'

describe Object do 
  describe '#try_rescue method' do 
    context 'called on nil' do 
      it 'returns nil' do 
        expect(nil.try_rescue(:collect) {|i| i + 2 }).to eql nil
      end
    end

    context 'when the method can be executed successfully' do 
      it 'calls the method' do 
        expect('foo'.try_rescue(:upcase)).to eql 'FOO'
      end

      context 'called on the Object base class' do 
        it 'calls the method' do 
          expect((Object.new).try_rescue(:class)).to eql Object
        end
      end
    end

    context 'when a NoMethodError is raised' do 
      it 'returns nil' do 
        expect(('foo').try_rescue(:bar)).to eql nil
      end

      context 'when called on the Object base class' do 
        it 'returns nil' do 
          expect((Object.new).try_rescue(:foo)).to eql nil
        end
      end
    end
  end
end