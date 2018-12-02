# frozen_string_literal: true

RSpec.describe Game do
  let(:game) { Game.new(hints: 2, attempts: 15) }

  context '.check_creation' do
    it { expect(game.attempts).to eq(15) }
    it { expect(game.hints).to eq(2) }
  end

  context '#check_hint' do
    it { expect(game.breaker_numbers).to include(game.hint) }
    it { expect { game.hint }.to change { game.hints }.by(-1) }
  end

  context 'check_attempts_decrease' do
    it { expect { game.start([1, 1, 1, 1]) }.to change { game.attempts }.by(-1) }
  end

  context '#check_start_with_[1, 2, 3, 4]' do
    before { game.instance_variable_set(:@breaker_numbers, [1, 2, 3, 4]) }

    it do
      guess = [3, 1, 2, 4]
      result = game.start(guess)
      expect(result).to eq ['+', '-', '-', '-']
    end

    it do
      guess = [1, 5, 2, 4]
      result = game.start(guess)
      expect(result).to eq ['+', '+', '-']
    end

    it do
      guess = [1, 2, 3, 4]
      result = game.start(guess)
      expect(result).to eq :win
    end
  end

  context '#check_start_with_[6, 5, 4, 3]' do
    before { game.instance_variable_set(:@breaker_numbers, [6, 5, 4, 3]) }

    it do
      guess = [5, 6, 4, 3]
      result = game.start(guess)
      expect(result).to eq ['+', '+', '-', '-']
    end

    it do
      guess = [6, 4, 1, 1]
      result = game.start(guess)
      expect(result).to eq ['+', '-']
    end

    it do
      guess = [6, 5, 4, 4]
      result = game.start(guess)
      expect(result).to eq ['+', '+', '+']
    end

    it do
      guess = [3, 4, 5, 6]
      result = game.start(guess)
      expect(result).to eq ['-', '-', '-', '-']
    end

    it do
      guess = [6, 6, 6, 6]
      result = game.start(guess)
      expect(result).to eq ['+']
    end

    it do
      guess = [3, 4, 5, 6]
      result = game.start(guess)
      expect(result).to eq ['-', '-', '-', '-']
    end

    it do
      guess = [2, 6, 6, 6]
      result = game.start(guess)
      expect(result).to eq ['-']
    end

    it do
      guess = [2, 2, 2, 2]
      result = game.start(guess)
      expect(result).to eq []
    end
  end

  it '#check_start_with_[6, 6, 6, 6]' do
    game.instance_variable_set(:@breaker_numbers, [6, 6, 6, 6])
    guess = [1, 6, 6, 1]
    result = game.start(guess)
    expect(result).to eq ['+', '+']
  end
end
