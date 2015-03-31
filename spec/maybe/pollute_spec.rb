require 'spec_helper'

describe Object do
  describe '#maybe' do
    describe 'without an argument' do
      it 'returns a Maybe' do
        obj = described_class.new

        obj.maybe.should be_an_instance_of(Maybe)
      end
    end

    describe 'with an argument' do
      it 'returns a Maybe wrapping the return value of Maybe#maybe' do
        maybe = [10].maybe(0)

        maybe.should be_an_instance_of(Maybe)
        maybe.unwrap.should == 10
      end
    end

    describe 'with a block' do
      it 'returns a Maybe wrapping the return value of the block' do
        maybe = [10].maybe { |array| array[0] }

        maybe.should be_an_instance_of(Maybe)
        maybe.unwrap.should == 10
      end
    end
  end
end
