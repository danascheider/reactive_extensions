require 'spec_helper'

describe Proc do 
  describe '#raises_error?' do
    let(:proc) { Proc.new {|quotient| 1.quo(quotient) } }

    context 'when an error is raised' do 
      it 'returns true' do 
        expect(proc.raises_error?(0)).to be true
      end

      it 'handles the exception' do 
        expect{ proc.raises_error?(0) }.not_to raise_error
      end
    end

    context 'when no error is raised' do 
      it 'returns false' do 
        expect(proc.raises_error?(2)).to be false
      end

      it 'doesn\'t change objects' do 
        h, p = {:foo => :bar}, Proc.new {|hash| hash.reject! {|k,v| k === :foo } }
        expect{ p.raises_error?(h) }.not_to change(h, :length)
      end
    end
  end
end