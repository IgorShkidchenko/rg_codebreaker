# frozen_string_literal: true

RSpec.describe Guess do
  let(:guess) { Guess.new('1111') }

  describe '.new' do
    it { expect(guess.input).to eq('1111') }
  end

  describe '#validate' do
    context 'valid' do
      it { expect(guess.validate).to eq(nil) }

      it do
        guess.instance_variable_set(:@input, Guess::HINT)
        expect(guess.validate).to eq(nil)
      end
    end

    context 'invalid' do
      it do
        guess.instance_variable_set(:@input, '')
        expect { guess.validate }.to raise_error(Errors::SizeError)
      end

      it do
        guess.instance_variable_set(:@input, '7777')
        expect { guess.validate }.to raise_error(Errors::IncludeError)
      end
    end
  end

  describe '#make_array_of_numbers' do
    it do
      guess.instance_variable_set(:@input, '7777')
      expect(guess.make_array_of_numbers).to eq([7, 7, 7, 7])
    end
  end
end
