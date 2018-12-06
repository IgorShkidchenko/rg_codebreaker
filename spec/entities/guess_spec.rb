# frozen_string_literal: true

RSpec.describe Guess do
  let(:guess) { Guess.new('1111') }

  describe '.new' do
    it { expect(guess.input).to eq('1111') }
  end

  describe '#validate_guess' do
    context 'valid' do
      it { expect(guess.validate_guess).to eq(true) }

      it do
        guess.instance_variable_set(:@input, Guess::HINT)
        expect(guess.validate_guess).to eq(true)
      end
    end

    context 'invalid' do
      it do
        guess.instance_variable_set(:@input, '')
        expect(guess.validate_guess).to eq(nil)
      end

      it do
        guess.instance_variable_set(:@input, '7777')
        expect(guess.validate_guess).to eq(nil)
      end
    end
  end
end
