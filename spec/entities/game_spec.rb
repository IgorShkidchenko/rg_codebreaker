# frozen_string_literal: true

RSpec.describe Game do
  let(:subject) { described_class.new(15, 2) }

  describe '.new' do
    it { expect(subject.attempts).to eq(15) }
    it { expect(subject.hints).to eq(2) }
  end

  describe '#hint' do
    context 'check_hint_including_in_code' do
      it { expect(subject.breaker_numbers).to include(subject.hint) }
    end

    context 'check_hints_decrease' do
      it { expect { subject.hint }.to change { subject.hints }.by(-1) }
    end

    context 'check_hints_return_nil_with_zero_hints' do
      it do
        subject.instance_variable_set(:@hints, 0)
        expect(subject.hint).to eq(nil)
      end
    end
  end

  describe 'check_attempts_decrease' do
    it { expect { subject.start_round([1, 1, 1, 1]) }.to change { subject.attempts }.by(-1) }
  end

  describe '#lose?' do
    before do
      subject.instance_variable_set(:@breaker_numbers, [6, 6, 6, 6])
      subject.instance_variable_set(:@attempts, 1)
    end

    context 'lose_eq_false' do
      it { expect(subject.lose?).to eq false }
    end

    context 'lose_eq_true' do
      it do
        subject.start_round([1, 2, 3, 4])
        expect(subject.lose?).to eq true
      end
    end
  end

  describe '#win?' do
    let(:guess) { [1, 2, 3, 4] }
    let(:numbers_for_lose) { [1, 1, 1, 1] }

    before { subject.instance_variable_set(:@breaker_numbers, [1, 2, 3, 4]) }

    context 'win_eq_all_guessed' do
      it { expect(guess).to eq subject.breaker_numbers }
    end

    context 'win_eq_true' do
      it { expect(subject.win?(guess)).to eq true }
    end

    context 'win_eq_false' do
      it { expect(subject.win?(numbers_for_lose)).to eq false }
    end
  end

  describe '#check_start_round_with_[1, 2, 3, 4]' do
    before { subject.instance_variable_set(:@breaker_numbers, [1, 2, 3, 4]) }

    it do
      guess = [3, 1, 2, 4]
      result = subject.start_round(guess)
      expect(result).to eq ['+', '-', '-', '-']
    end

    it do
      guess = [1, 5, 2, 4]
      result = subject.start_round(guess)
      expect(result).to eq ['+', '+', '-']
    end
  end

  describe '#check_start_round_with_[6, 5, 4, 3]' do
    before { subject.instance_variable_set(:@breaker_numbers, [6, 5, 4, 3]) }

    context 'with_pluses' do
      it do
        guess = [5, 6, 4, 3]
        result = subject.start_round(guess)
        expect(result).to eq ['+', '+', '-', '-']
      end

      it do
        guess = [6, 4, 1, 1]
        result = subject.start_round(guess)
        expect(result).to eq ['+', '-']
      end

      it do
        guess = [6, 5, 4, 4]
        result = subject.start_round(guess)
        expect(result).to eq ['+', '+', '+']
      end

      it do
        guess = [6, 6, 6, 6]
        result = subject.start_round(guess)
        expect(result).to eq ['+']
      end
    end

    context 'with_minuses' do
      it do
        guess = [3, 4, 5, 6]
        result = subject.start_round(guess)
        expect(result).to eq ['-', '-', '-', '-']
      end

      it do
        guess = [3, 4, 5, 6]
        result = subject.start_round(guess)
        expect(result).to eq ['-', '-', '-', '-']
      end

      it do
        guess = [2, 6, 6, 6]
        result = subject.start_round(guess)
        expect(result).to eq ['-']
      end

      it do
        guess = [2, 2, 2, 2]
        result = subject.start_round(guess)
        expect(result).to eq []
      end
    end
  end

  describe '#check_start_round_with_[6, 6, 6, 6]' do
    it do
      subject.instance_variable_set(:@breaker_numbers, [6, 6, 6, 6])
      guess = [1, 6, 6, 1]
      result = subject.start_round(guess)
      expect(result).to eq ['+', '+']
    end
  end

  describe 'ruby_garage_tests' do
    [
      [[6, 5, 4, 1], [6, 5, 4, 1], ['+', '+', '+', '+']],
      [[1, 2, 2, 1], [2, 1, 1, 2], ['-', '-', '-', '-']],
      [[6, 2, 3, 5], [2, 3, 6, 5], ['+', '-', '-', '-']],
      [[1, 2, 3, 4], [4, 3, 2, 1], ['-', '-', '-', '-']],
      [[1, 2, 3, 4], [1, 2, 3, 5], ['+', '+', '+']],
      [[1, 2, 3, 4], [5, 4, 3, 1], ['+', '-', '-']],
      [[1, 2, 3, 4], [1, 5, 2, 4], ['+', '+', '-']],
      [[1, 2, 3, 4], [4, 3, 2, 6], ['-', '-', '-']],
      [[1, 2, 3, 4], [3, 5, 2, 5], ['-', '-']],
      [[1, 2, 3, 4], [5, 6, 1, 2], ['-', '-']],
      [[5, 5, 6, 6], [5, 6, 0, 0], ['+', '-']],
      [[1, 2, 3, 4], [6, 2, 5, 4], ['+', '+']],
      [[1, 2, 3, 1], [1, 1, 1, 1], ['+', '+']],
      [[1, 1, 1, 5], [1, 2, 3, 1], ['+', '-']],
      [[1, 2, 3, 4], [4, 2, 5, 5], ['+', '-']],
      [[1, 2, 3, 4], [5, 6, 3, 5], ['+']],
      [[1, 2, 3, 4], [6, 6, 6, 6], []],
      [[1, 2, 3, 4], [2, 5, 5, 2], ['-']]
    ].each do |item|
      it "should return #{item[2]} if code is - #{item[0]}, atttempt_code is #{item[1]}" do
        subject.instance_variable_set(:@breaker_numbers, item[0])
        guess = item[1]
        result = subject.start_round(guess)
        expect(result).to eq item[2]
      end
    end
  end
end
