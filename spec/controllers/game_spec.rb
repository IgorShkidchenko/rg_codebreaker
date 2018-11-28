# frozen_string_literal: true

RSpec.describe Console do
  let(:subject) { described_class.new }

  describe 'check_game_module' do
    it 'check_hint' do
      result = subject.hint([1, 2, 3, 4])
      expect([1, 2, 3, 4]).to include(result)
    end

    context 'check_start_with_[1, 2, 3, 4]' do
      let(:breaker_numbers) { [1, 2, 3, 4] }

      it do
        guess = '3124'
        result = subject.start(guess, breaker_numbers)
        expect(result).to eq ['+', '-', '-', '-']
      end

      it do
        guess = '1524'
        result = subject.start(guess, breaker_numbers)
        expect(result).to eq ['+', '+', '-']
      end

      it do
        guess = '1234'
        result = subject.start(guess, breaker_numbers)
        expect(result).to eq ['+', '+', '+', '+']
      end
    end

    context 'check_start_with_[6, 5, 4, 3]' do
      let(:breaker_numbers) { [6, 5, 4, 3] }

      it do
        guess = '5643'
        result = subject.start(guess, breaker_numbers)
        expect(result).to eq ['+', '+', '-', '-']
      end

      it do
        guess = '6411'
        result = subject.start(guess, breaker_numbers)
        expect(result).to eq ['+', '-']
      end

      it do
        guess = '6544'
        result = subject.start(guess, breaker_numbers)
        expect(result).to eq ['+', '+', '+']
      end

      it do
        guess = '3456'
        result = subject.start(guess, breaker_numbers)
        expect(result).to eq ['-', '-', '-', '-']
      end

      it do
        guess = '6666'
        result = subject.start(guess, breaker_numbers)
        expect(result).to eq ['+']
      end

      it do
        guess = '3456'
        result = subject.start(guess, breaker_numbers)
        expect(result).to eq ['-', '-', '-', '-']
      end

      it do
        guess = '2666'
        result = subject.start(guess, breaker_numbers)
        expect(result).to eq ['-']
      end

      it do
        guess = '2222'
        result = subject.start(guess, breaker_numbers)
        expect(result).to eq []
      end
    end

    context 'check_start_with_[6, 6, 6, 6]' do
      let(:breaker_numbers) { [6, 6, 6, 6] }

      it do
        guess = '1661'
        result = subject.start(guess, breaker_numbers)
        expect(result).to eq ['+', '+']
      end
    end
  end
end
