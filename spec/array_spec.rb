require 'spec_helper'
require 'reactive_support/core_ext/hash/keys'
require 'reactive_support/core_ext/array/extract_options'

describe Array do 
  describe 'array scoping' do 
    let(:sartre) { { 'name' => 'Jean-Paul Sartre', 'nationality' => 'French' } }
    let(:russell) { { 'name' => 'Bertrand Russell', 'nationality' => 'English' } }
    let(:wittgenstein) { { 'name' => 'Ludwig Wittgenstein', 'nationality' => 'Austrian' } }
    let(:camus) { { 'name' => 'Albert Camus', 'nationality' => 'French' } }
    let(:array) { [sartre, russell, wittgenstein, camus] }

    describe 'scope' do 
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

    describe 'where_not' do 
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

  describe 'sets' do 
    describe 'subset_of?' do 
      context 'when the argument is a strict superset of the subject' do 
        it 'returns true' do 
          expect([1, 2].subset_of? [1, 2, 3, 4]).to be true
        end
      end

      context 'when the argument is equal to the subject' do 
        it 'returns true' do 
          expect([1, 2].subset_of? [1, 2]).to be true
        end
      end

      context 'when the calling array is empty' do 
        it 'returns true' do 
          expect([].subset_of?(['foo', 'bar', 'baz'])).to be true 
        end
      end

      context 'when the elements are not consecutive' do 
        it 'returns true' do 
          expect([2, 4].subset_of? [1, 2, 3, 4]).to be true
        end
      end

      context 'when the calling object is inside the argument' do 
        it 'returns false' do 
          expect([1, 2].subset_of? [[1, 2], 3, 4]).to be false
        end
      end

      context 'when the argument is not an array' do 
        it 'raises an error' do 
          expect{[1, 2].subset_of? {}}.to raise_error(ArgumentError)
        end
      end
    end

    describe 'superset_of?' do 
      context 'when the argument is a strict subset of the subject' do 
        it 'returns true' do 
          expect([1, 2, 3, 4].superset_of? [1, 2]).to be true
        end
      end

      context 'when the argument is equal to the subject' do 
        it 'returns true' do 
          expect([1, 2].superset_of? [1, 2]).to be true
        end
      end

      context 'when the argument array is empty' do 
        it 'returns true' do 
          expect(['foo', 'bar', 'baz'].superset_of?([])).to be true 
        end
      end

      context 'when the elements are not consecutive' do 
        it 'returns true' do 
          expect([1, 2, 3, 4].superset_of? [1, 4]).to be true
        end
      end

      context 'when the argument is a single index' do 
        it 'returns false' do 
          expect([[1, 2], 3, 4].superset_of? [1, 2]).to be false
        end
      end

      context 'when the argument is not an array' do 
        it 'raises an error' do 
          expect{[1, 2].superset_of? 427}.to raise_error(ArgumentError)
        end
      end
    end
  end
end