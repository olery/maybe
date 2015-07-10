require 'spec_helper'

describe Maybe do
  describe '#unwrap' do
    it 'returns the wrapped object' do
      described_class.new(10).unwrap.should == 10
    end
  end

  describe '#maybe' do
    describe 'using an argument' do
      describe 'with a wrapped object defining the #[] method' do
        it 'returns a Maybe wrapping the return value' do
          initial = described_class.new([10])
          maybe   = initial.maybe(0)

          maybe.should be_an_instance_of(described_class)
          maybe.unwrap.should == 10
        end

        it 'returns a Maybe wrapping nil if nil is returned' do
          initial = described_class.new([])
          maybe   = initial.maybe(0)

          maybe.should be_an_instance_of(described_class)
          maybe.unwrap.should == nil
        end
      end

      describe 'with a wrapped object without the #[] method' do
        it 'returns a Maybe wrapping nil' do
          initial = described_class.new(Object.new)
          maybe   = initial.maybe(0)

          maybe.should be_an_instance_of(described_class)
          maybe.unwrap.should == nil
        end
      end

      describe 'with a block' do
        it 'yields the block when the argument value is not nil' do
          initial = described_class.new(:number => '10')
          maybe   = initial.maybe(:number) { |val| val.to_i }

          maybe.should be_an_instance_of(described_class)
          maybe.unwrap.should == 10
        end

        it 'does not yield the block when the argument value is nil' do
          initial = described_class.new(:number => '10')
          maybe   = initial.maybe(:numberx) { |val| val.to_i }

          maybe.should be_an_instance_of(described_class)
          maybe.unwrap.should == nil
        end
      end

      it 'returns self when the wrapped and returned values are nil' do
        initial = described_class.new(nil)

        initial.maybe(0).should === initial
      end
    end

    describe 'using a block' do
      it 'returns a Maybe wrapping the return value of the block' do
        maybe = described_class.new(10).maybe { |val| val }

        maybe.should be_an_instance_of(described_class)
        maybe.unwrap.should == 10
      end

      it 'returns a Maybe wrapping nil if the block returns nil' do
        maybe = described_class.new(10).maybe { nil  }

        maybe.should be_an_instance_of(described_class)
        maybe.unwrap.should == nil
      end

      it 'returns self when the wrapped and returned values are nil' do
        initial = described_class.new(nil)

        initial.maybe { nil }.should === initial
      end
    end
  end

  describe '#[]' do
    # Just a simple test to see if this works in the first place
    it 'is an alias for #maybe' do
      maybe = described_class.new([10, 20])[0]

      maybe.should be_an_instance_of(described_class)
      maybe.unwrap.should == 10
    end
  end

  describe '#or' do
    describe 'with a Maybe wrapping a non-nil object' do
      it 'returns the wrapped object' do
        described_class.new(10).or.should == 10
      end
    end

    describe 'with an argument and with a Maybe wrapping nil' do
      it 'returns the given argument' do
        described_class.new(nil).or(10).should == 10
      end

      it 'returns nil when the argument is nil' do
        described_class.new(nil).or(nil).should == nil
      end
    end

    describe 'without an argument and with a Maybe wrapping nil' do
      it 'yields the given block' do
        described_class.new(nil).or { 10 }.should == 10
      end
    end
  end
end
