require 'spec_helper'
require 'reactive_support/core_ext/hash/keys'

describe Array do 
  describe 'array scoping' do 
    let(:sartre) { { 'name' => 'Jean-Paul Sartre', 'nationality' => 'French' } }
    let(:russell) { { 'name' => 'Bertrand Russell', 'nationality' => 'English' } }
    let(:wittgenstein) { { 'name' => 'Ludwig Wittgenstein', 'nationality' => 'Austrian' } }
    let(:camus) { { 'name' => 'Albert Camus', 'nationality' => 'French' } }
    let(:array) { [sartre, russell, wittgenstein, camus] }

    describe 'array #scope method' do 
      context 'symbol keys' do
        context 'single value' do 
          it 'returns scoped hashes' do 
            array.each {|hash| hash.symbolize_keys! }
            expect(array.scope(:nationality, 'French')).to eql([sartre, camus])
          end
        end

        context 'multiple values' do 
          it 'returns scoped hashes' do 
            array.each {|hash| hash.symbolize_keys! }
            expect(array.scope(:nationality, 'French', 'English')).to eql([sartre, russell, camus])
          end
        end
      end

      context 'string keys' do
        context 'single value' do 
          it 'returns scoped hashes' do 
            expect(array.scope('nationality', 'French')).to eql([sartre, camus])
          end
        end

        context 'multiple values' do 
          it 'returns scoped hashes' do 
            expect(array.scope('nationality', 'French', 'English')).to eql([sartre, russell, camus])
          end
        end
      end
    end

    describe 'array #where_not method' do 
      context 'symbol keys' do 
        context 'single value' do 
          it 'returns scoped hashes' do 
            array.each {|hash| hash.symbolize_keys! }
            expect(array.where_not(:nationality, 'French')).to eql([russell, wittgenstein])
          end
        end

        context 'multiple values' do 
          it 'returns scoped hashes' do 
            array.each {|hash| hash.symbolize_keys! }
            expect(array.where_not(:nationality, 'French', 'English')).to eql([wittgenstein])
          end
        end
      end

      context 'string keys' do
        context 'single value' do 
          it 'returns scoped hashes' do 
            expect(array.where_not('nationality', 'French')).to eql([russell, wittgenstein])
          end
        end

        context 'multiple values' do 
          it 'returns scoped hashes' do 
            expect(array.where_not('nationality', 'French', 'English')).to eql([wittgenstein])
          end
        end
      end
    end
  end
end